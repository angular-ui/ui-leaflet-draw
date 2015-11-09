/**
 *  ui-leaflet-draw
 *
 * @version: 0.0.1
 * @author: Nicholas McCready
 * @date: Sun Nov 08 2015 22:50:12 GMT-0500 (EST)
 * @license: MIT
 */

(function (window, angular){
  (function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  angular.module('ui-leaflet').factory('leafletDrawEvents', function(leafletEventsHelpersFactory) {
    var DrawEvents;
    DrawEvents = (function(superClass) {
      extend(DrawEvents, superClass);

      function DrawEvents() {
        DrawEvents.__super__.constructor.call(this, 'leafletDirectiveDraw', 'draw');
      }

      DrawEvents.prototype.getAvailableEvents = function() {
        return ['created', 'edited', 'deleted', 'drawstart', 'drawstop', 'editstart', 'editstop', 'deletestart', 'deletestop'].map(function(n) {
          return 'draw:' + n;
        });
      };

      return DrawEvents;

    })(leafletEventsHelpersFactory);
    return new DrawEvents();
  });

}).call(this);

(function() {
  var directiveName;

  directiveName = 'lfDraw';

  angular.module('ui-leaflet').config(function($provide, nemDebugProvider) {
    return $provide.decorator('leafletDirective', function($delegate) {
      var directive;
      directive = $delegate[0];
      directive.$$isolateBindings[directiveName] = {
        attrName: directiveName,
        mode: '=',
        optional: true
      };
      return $delegate;
    });
  }).directive(directiveName, function(leafletLogger, leafletData, leafletHelpers, leafletIterators, leafletDrawEvents, $timeout, $q) {
    var $log, errorHeader, isDefined;
    $log = leafletLogger;
    isDefined = leafletHelpers.isDefined;
    errorHeader = leafletHelpers.errorHeader;
    return {
      restrict: 'A',
      scope: false,
      replace: false,
      require: ['leaflet'],
      controller: function($scope) {
        this._deferredDrawTool = $q.defer();
        this.getDrawTool = function() {
          return this._deferredDrawTool.promise;
        };
        return this.getScope = function() {
          return $scope;
        };
      },
      link: function(scope, element, attrs, controller) {
        var _deferred, _featureGroup, _optionsEditedInDirective, leafletScope, mapController;
        mapController = controller[0];
        leafletScope = mapController.getLeafletScope();
        _featureGroup = void 0;
        _optionsEditedInDirective = false;
        _deferred = void 0;
        return leafletScope.$watchCollection(directiveName, function() {
          var options;
          if (!_deferred || _deferred.resolvedDefer) {
            _deferred = $q.defer();
          }
          if (_optionsEditedInDirective) {
            return;
          }
          options = leafletScope[directiveName] || {};
          if (options.control != null) {
            options.control.promised(_deferred.promise);
          }
          return mapController.getMap().then(function(map) {
            var drawControl, layerName, name;
            if (_featureGroup) {
              map.removeLayer(_featureGroup);
            }
            if (!isDefined(L.Control.Draw)) {
              $log.error(errorHeader + " Leaflet.Draw is not loaded as a plugin.");
              return;
            }
            if (!isDefined(options.edit) || !isDefined(options.edit.featureGroup)) {
              _optionsEditedInDirective = true;
              angular.extend(options, {
                edit: {
                  featureGroup: new L.FeatureGroup()
                }
              });
              $timeout(function() {
                return _optionsEditedInDirective = false;
              });
            }
            _featureGroup = options.edit.featureGroup;
            map.addLayer(_featureGroup);
            drawControl = new L.Control.Draw(options);
            map.addControl(drawControl);
            _deferred.resolvedDefer = true;
            _deferred.resolve({
              control: drawControl,
              map: map
            });
            return leafletDrawEvents.bindEvents(attrs.id, map, name = null, options, leafletScope, layerName = null, {
              mapId: attrs.id
            });
          });
        });
      }
    };
  });

}).call(this);

})(window, angular);