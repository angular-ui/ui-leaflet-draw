<!DOCTYPE html>
<html ng-app="demoapp">

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body ng-controller="Controller">
  <leaflet lf-center="map.center" lf-draw="map.drawOptions" height="480px" width="100%">
  </leaflet>
  <h1>ui-leaflet-draw</h1>
  <p>Number of drawn features: {{drawnItemsCount()}}</p>
</body>
<script src="bower_components/leaflet/dist/leaflet.js"></script>
<script src="bower_components/leaflet-draw/dist/leaflet.draw-src.js"></script>
<script src="bower_components/angular/angular.min.js"></script>
<script src="bower_components/angular-simple-logger/dist/angular-simple-logger.js"></script>
<script src="bower_components/ui-leaflet/dist/ui-leaflet.js"></script>
<script src="dist/ui-leaflet-draw.js"></script>
<link rel="stylesheet" href="bower_components/leaflet/dist/leaflet.css" />
<link rel="stylesheet" href="bower_components/leaflet-draw/dist/leaflet.draw.css" />
<script>
  'use strict';
  angular.module("demoapp", ['ui-leaflet'])
  .controller('Controller', function ($scope, leafletDrawEvents) {

    var drawnItems = new L.FeatureGroup();

    $scope.drawnItemsCount = function() {
      return drawnItems.getLayers().length;
    }

    angular.extend($scope, {
      map: {
        center: {
          lat: 42.20133,
          lng: 2.19110,
          zoom: 11
        },
        drawOptions: {
          position: "bottomright",
          draw: {
            polyline: {
              metric: false
            },
            polygon: {
              metric: false,
              showArea: true,
              drawError: {
                color: '#b00b00',
                timeout: 1000
              },
              shapeOptions: {
                color: 'blue'
              }
            },
            circle: {
              showArea: true,
              metric: false,
              shapeOptions: {
                color: '#662d91'
              }
            },
            marker: false
          },
          edit: {
            featureGroup: drawnItems,
            remove: true
          }
        }
      }
    });

    var handle = {
      created: function(e,leafletEvent, leafletObject, model, modelName) {
        drawnItems.addLayer(leafletEvent.layer);
      },
      edited: function(arg) {},
      deleted: function(arg) {},
      drawstart: function(arg) {},
      drawstop: function(arg) {},
      editstart: function(arg) {},
      editstop: function(arg) {},
      deletestart: function(arg) {},
      deletestop: function(arg) {}
    };

    var drawEvents = leafletDrawEvents.getAvailableEvents();
    drawEvents.forEach(function(eventName){
        $scope.$on('leafletDirectiveDraw.' + eventName, function(e, payload) {
          //{leafletEvent, leafletObject, model, modelName} = payload
          var leafletEvent, leafletObject, model, modelName; //destructuring not supported by chrome yet :(
          leafletEvent = payload.leafletEvent, leafletObject = payload.leafletObject, model = payload.model,
          modelName = payload.modelName;

          handle[eventName.replace('draw:','')](e,leafletEvent, leafletObject, model, modelName);
        });
    });
  });
</script>

</html>
