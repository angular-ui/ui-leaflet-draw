###globals inject, angular, L###
$compile = $rootScope = $scope = leafletData = $element = drawnItems = null

template = """
<leaflet lf-center='map.center' lf-draw='map.drawOptions' height='480px' width='100%'>
</leaflet>
""".replace(/\n/g, '')

describe 'leafletDraw', ->
  beforeEach ->
    module('ui-leaflet')
    inject (_$compile_, _$rootScope_, _leafletData_, _leafletDrawEvents_) ->

      $compile = _$compile_
      $rootScope = _$rootScope_
      $scope = $rootScope.$new()
      leafletData = _leafletData_
      $element = angular.element template

      drawnItems = new L.FeatureGroup()

      angular.extend $scope, map:
        center:
          lat: 42.20133
          lng: 2.19110
          zoom: 11
        drawOptions:
          position: 'bottomright'
          draw:
            polyline: metric: false
            polygon:
              metric: false
              showArea: true
              drawError:
                color: '#b00b00'
                timeout: 1000
              shapeOptions: color: 'blue'
            circle:
              showArea: true
              metric: false
              shapeOptions: color: '#662d91'
            marker: false
          edit:
            featureGroup: drawnItems
            remove: true

      el = $compile($element)($scope)
      $scope.$digest()
      document.body.appendChild(el[0])

  it 'draw control rendered', ->
    el = document.querySelector('.leaflet-draw.leaflet-control')
    el.should.be.ok
    el.childElementCount.should.be.equal 2

  it 'draw toolbar', ->
    document.querySelector('.leaflet-draw-toolbar').should.be.ok

  it 'edit toolbar', ->
    document.querySelector('.leaflet-draw-edit-edit').should.be.ok
    document.querySelector('.leaflet-draw-edit-remove').should.be.ok
