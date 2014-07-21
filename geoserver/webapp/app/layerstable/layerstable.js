angular.module('gsApp.layerstable', [
  'gsApp.service', 'mgcrea.ngStrap.modal', 'ngSanitize'
])
  .controller('LayerTableCtrl', ['$scope', '$modal', 'GeoServer', '$http',
      function($scope, $modal, GeoServer, $http) {

        $scope.layerHeaders = ['Name', 'Type', 'Title',
          'Store', 'SRS', 'Style'];

        $scope.sortBy = function(chosen_header) {
          $scope.predicate = '' + chosen_header;
        };

        $scope.layers.selectedLayer = null;
        $scope.setSelected = function(lyr) {
          $scope.layers.selectedLayer = lyr;
          $scope.selectedLayer = lyr;
        };

        function setWorkspace() {
          if (! $scope.currentWorkspace) {
            $scope.currentWorkspace = $scope.workspace.selected.name;
          }
          return $scope.currentWorkspace;
        }

        $scope.openPreview = function(_layername) {
          var workspace = setWorkspace();
          var imageContent = '<img src="' + GeoServer.apiRoot() + workspace + '/wms?service=WMS&version=1.1.0&request=GetMap&layers=' + workspace + ':' + _layername + '&styles=&bbox=-180.0,-89.99892578124998,180.00000000000003,83.59960937500006&width=555&height=268&srs=EPSG:4326&format=image/png"/>';

          var modalInstance = $modal({
            title: "Layer Preview",
            html: true,
          /*  contentTemplate: '/layerstable/modal/preview.tpl.html',*/
            content: imageContent,
            resolve: {
              layername: function() {
                return _layername;
              }
            }
          });
        };

        $scope.retrieveGeojson = function(_layername) {
          if (_layername) {
            setWorkspace();
            var url = GeoServer.apiRoot() + $scope.currentWorkspace + '/ows';
            $http.get(url, {
              params: {service: 'WFS',
                version: '1.0.0',
                request: 'GetFeature',
                typeName: $scope.currentWorkspace + ':' + _layername,
                maxfeatures: 50,
                outputformat: 'application/json'
              },
              responseType: 'json'

            })
            .success(function(data, status, headers, config) {
                  var element = angular.element('<a/>');
                  element.attr({
                    href: 'data:attachment/json;charset=utf-8,'
                      + encodeURI(JSON.stringify(data)),
                    target: '_blank',
                    download: $scope.currentWorkspace + '.geojson'
                  })[0].click();
                });
          }
        };

      }]);
