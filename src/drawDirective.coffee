###globals angular, L###
directiveName = 'lfDraw'
angular.module('ui-leaflet')
.config ($provide) ->
  #Extend root leaflet directive
  $provide.decorator 'leafletDirective', ($delegate) ->
    directive = $delegate[0]
    directive.scope[directiveName] = '=?' #angular1.2.x, 1.4.10+
    #angular^1.3, https://github.com/angular/angular.js/issues/10149
    directive.$$isolateBindings?[directiveName] =
      attrName: directiveName
      mode: '='
      optional: true

    $delegate

.directive directiveName, [
  'leafletLogger', 'leafletData', 'leafletHelpers', 'leafletIterators', 'leafletDrawEvents', '$timeout', '$q',
  (leafletLogger, leafletData, leafletHelpers, leafletIterators, leafletDrawEvents, $timeout, $q) ->
    $log = leafletLogger
    isDefined = leafletHelpers.isDefined
    errorHeader = leafletHelpers.errorHeader

    restrict: 'A'
    scope: false
    replace: false
    require: ['leaflet']
    controller: ['$scope', ($scope) ->
      @_deferredDrawTool = $q.defer()
      @getDrawTool = ->
        @_deferredDrawTool.promise
      @getScope = ->
        $scope
    ]

    link: (scope, element, attrs, controller) ->
      mapController = controller[0]
      leafletScope = mapController.getLeafletScope()
      _featureGroup = undefined
      _optionsEditedInDirective = false
      _deferred = undefined

      leafletScope.$watchCollection directiveName, ->
        if !_deferred || _deferred.resolvedDefer
          _deferred = $q.defer()#temp hack until directiveControls is more flexible
        return if _optionsEditedInDirective

        options = leafletScope[directiveName] or {}

        if options.control?.promises?
          options.control.promised _deferred.promise

        mapController.getMap().then (map) ->
          if _featureGroup
            map.removeLayer _featureGroup

          if !isDefined L.Control.Draw
            $log.error "#{errorHeader} Leaflet.Draw is not loaded as a plugin."
            return

          if !isDefined(options.edit) or !isDefined(options.edit.featureGroup)
            _optionsEditedInDirective = true
            if !isDefined(options.edit)
              options.edit = {}
            angular.extend options.edit,
              featureGroup: new L.FeatureGroup()
            $timeout -> _optionsEditedInDirective = false #skip extra digest due to above mod

          _featureGroup = options.edit.featureGroup
          map.addLayer(_featureGroup)
          drawControl = new L.Control.Draw options

          map.addControl drawControl
          _deferred.resolvedDefer = true
          _deferred.resolve
            control: drawControl
            map:map

          leafletDrawEvents.bindEvents(attrs.id, map, name = null, options, leafletScope, layerName = null, {mapId: attrs.id})
  ]
