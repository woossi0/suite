angular.module('gsApp.home', [
  'gsApp.service',
  'gsApp.layerstable'
])
  .controller('HomeCtrl', ['$scope', 'GeoServer', '$http',
      function($scope, GeoServer, $http) {
        $scope.title = 'Home';
        $scope.workspaces = GeoServer.workspaces.get();
        $scope.workspace = {};
        $scope.layers = [];

        $scope.setSelectedWorkspace = function(_workspace) {
          $scope.layerCollection = [];

          GeoServer.capabilities.get({workspace: _workspace.name})
            .$promise.then(function(result) {

                var featureTypes = result.FeatureTypeList.FeatureType;

                // single layers seem to get returned as a single object
                if (Object.prototype.toString.call(featureTypes) !==
                    '[object Array]') {
                  featureTypes = [featureTypes];
                }
                for (var i = 0, len = featureTypes.length; i < len; i++) {
                  var l = featureTypes[i];
                  var bbox =
                      l.WGS84BoundingBox.LowerCorner.toString()
                        .split(' ').concat(
                      l.WGS84BoundingBox.UpperCorner.toString()
                        .split(' '));

                  $scope.layerCollection.push({
                    name: l.Name.split(':')[1],
                    type: l.type,
                    title: l.Title,
                    srs: 'EPSG:' + l.DefaultCRS.split('::')[1],
                    style: 'default',
                    workspace: _workspace.name,
                    extent: bbox
                  });
                }
              });

          GeoServer.layers.get({ workspace: _workspace.name })
          .$promise.then(
              function(result) {
                var promises = [];
                for (var i = 0, len = result.length; i < len; i++) {
                  GeoServer.layer.get({ layer: result[i].name})
                    .$promise.then(
                      function(l) {
                        for (var j = 0,
                            len = $scope.layerCollection.length; j < len; j++) {
                          if ($scope.layerCollection[j].name === l.name) {
                            $scope.layerCollection[j].type =
                                l.type.toLowerCase();
                          }
                        }
                      });
                }
              });
        };

        // TODO only gets style with the same name as layer
        $scope.retrieveStyleForLayer = function(_layername) {
          if (_layername) {
            var url = GeoServer.apiRestRoot() + '/styles/' +
                _layername + '.sld';
            $http.get(url, {
              responseType: 'xml'
            })
            .success(function(data) {
                  $scope.stylesInfo.push(data);
                });
          }
          // mapstyler is watching $scope.stylesInfo when request returns
        };

        $scope.$watch('selectedLayer', function(lyr) {
          $scope.$parent.selectedLayer = lyr;
        });
        $scope.$watch('layers', function(lyrs) {
          $scope.$parent.layers = lyrs;
        });
      }]);
