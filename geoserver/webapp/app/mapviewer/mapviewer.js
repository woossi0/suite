angular.module('gsApp.mapviewer', [
  'gsApp.mapviewer.directives',
  'gsApp.mapviewer.services'
])
  .controller('MapViewerController', ['$scope', function($scope) {


      $scope.mapOpts = {
        center: [-45.0000, -72.0000],
        zoom: 12
      };

      function createMapLayers(layers) {
        $scope.repo.layers.createOlLayers(layers);
        var layerState = $scope.mapState.getLayers();
        $scope.mapLayers = layers.map(function(l) {
          if (!layerState) { l.ol.setVisible(true); }
          else {
            l.ol.setVisible(layerState.indexOf(l.path) >= 0);
          }
          l.ol.on('change:visible', function(evt) {
            $scope.mapState.toggleLayer(l.name, this.getVisible());
          });
          return l.ol;
        });
      }

      function getMaxExtent(layers) {
        var bounds = [Infinity, Infinity, -Infinity, -Infinity];
        layers.forEach(function(l) {
          var b = l.bounds;
          bounds[0] = Math.min(b.xMin, bounds[0]);
          bounds[1] = Math.min(b.yMin, bounds[1]);
          bounds[2] = Math.max(b.xMax, bounds[2]);
          bounds[3] = Math.max(b.yMax, bounds[3]);
        });
        return bounds;
      }
      /*
      $scope.$watch('mapState.state', function(state) {
        if (state) {
          angular.forEach($scope.mapState.toParamObj(), function(v, k) {
            $location.search(k, v);
          });
        }
      }, true);
      */
      $scope.$watch('layersData', function(layersData) {
        if (layersData) {
          $scope.layers = layersData.layers;

          createMapLayers(layersData.layers);

          if ($scope.map) {
            if (!$scope.mapOpts.center) {
              $scope.map.getView().fitExtent(getMaxExtent(layersData.layers),
                  $scope.map.getSize());
            }

            $scope.map.getView().on(['change:center', 'change:resolution'],
                function(evt) {
                  var view = this;
                  var center = ol.proj.transform(view.getCenter(),
                      'EPSG:3857', 'EPSG:4326');
                  $scope.mapState.setCenter(center);
                  $scope.mapState.setZoom(view.getZoom());
                  $scope.mapState.setLayers($scope.layers.filter(function(l) {
                    return l.ol.getVisible();
                  }).map(function(l) { return l.name; }));
                });
          }
        }
      });

    }]);
