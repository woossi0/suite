angular.module('gsApp.mapviewer', [
  'gsApp.mapviewer.directives',
  'gsApp.mapviewer.services',
  'gsApp.mapviewer.adapter'
])
  .controller('MapViewerController', ['$scope', '$location',
      'OlAdapter', 'MapFactory', 'MapState',
      function($scope, $location, OlAdapter, MapFactory, MapState) {

        $scope.mapState = MapState;

        var params = {}; //$location.search();
        $scope.mapState.fromParamObj(params);

        $scope.mapOpts = {
          center: $scope.mapState.getCenter(),
          zoom: $scope.mapState.getZoom()
        };

        $scope.getLayer = function() {
          if ($scope.layersData) {
            OlAdapter.get().then(function(layersData) {
              $scope.layersData = layersData;
            });
          }
        };

        function createMapLayers(layers) {
          var layerState = $scope.mapState.getLayers();
          $scope.mapLayers = layers.map(function(l) {
            if (!layerState) { l.setVisible(true); }
            else {
              l.setVisible(layerState.indexOf(l.path) >= 0);
            }
            l.on('change:visible', function(evt) {
              $scope.mapState.toggleLayer(l.name, this.getVisible());
            });
            return l;
          });
        }

        function getMaxExtent(layers) {
          var bounds = [-180, -90, 180, 90];
          layers.forEach(function(l) {
            var b = l.getSource().getExtent();
            bounds[0] = Math.max(b[0], bounds[0]);
            bounds[1] = Math.max(b[1], bounds[1]);
            bounds[2] = Math.min(b[2], bounds[2]);
            bounds[3] = Math.min(b[3], bounds[3]);
          });
          return bounds;
        }

        $scope.$watch('mapState.state', function(state) {
          if (state) {
            angular.forEach($scope.mapState.toParamObj(), function(v, k) {
              $location.search(k, v);
            });
          }
        }, true);

        $scope.$watch('layersData', function(layersData) {
          if (layersData) {
            $scope.layers = layersData.layers;
            createMapLayers(layersData.layers);

            if ($scope.map) {
              if (! $scope.mapOpts.center) {
                /*  $scope.map.getView().
                fitExtent(getMaxExtent(layersData.layers),
                  $scope.map.getSize()); not working */
                var extent = getMaxExtent(layersData.layers);
                var ctr = ol.extent.getCenter(extent);
                $scope.map.getView().setCenter(ctr);
              }

              $scope.map.getView().on(['change:center', 'change:resolution'],
                  function(evt) {
                    var view = this;
                    var center = ol.proj.transform(view.getCenter(),
                        'EPSG:3857', 'EPSG:4326');
                    $scope.mapState.setCenter(center);
                    $scope.mapState.setZoom(view.getZoom());
                    $scope.mapState.setLayers($scope.layers.filter(function(l) {
                      return l.getVisible();
                    }).map(function(l) { return l.name; }));
                  });

            }
          }
        });

        // For layer info that needs to be fetched
        $scope.$watch('layersInfo', function(layersInfo) {
          if (layersInfo) {
            angular.forEach(layersInfo, function(_layer, key) {
              // get the layer info to load the layer
              // get the layer style and load that in the editor
              if (_layer.type && _layer.type.toLowerCase() === 'vector') {
                var layerRef = _layer.workspace +
                    ':' + _layer.name;
                OlAdapter.setUrl(_layer.workspace);

                var layerRequest = new ol.layer.Tile({
                  source: new ol.source.TileWMS({
                    url: OlAdapter.getBaseUrl(),
                    params: {
                      'LAYERS': layerRef,
                      'VERSION': '1.1.0',
                      'TRANSPARENT': true
                    },
                    projection: _layer.srs,
                    extent: _layer.extent
                  })
                });
                if (! $scope.layersData) {
                  $scope.layersData = {};
                  $scope.layersData.layers = [];
                }
                $scope.layersData.layers.push(layerRequest);

              } else if (_layer.type && _layer.type.toLowerCase() === 'raster') {
                // get as raster layer
              }
            });
          }
        });

      }]);
