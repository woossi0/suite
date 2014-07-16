angular.module('gsApp.home', [
  'gsApp.service'
])
  .controller('HomeCtrl', ['$scope', 'GeoServer', '$q',
      function($scope, GeoServer, $q) {
        $scope.title = 'Home';
        $scope.workspaces = GeoServer.workspaces.get();
        $scope.workspace = {};
        $scope.layerCollection = [];

        $scope.setSelectedWorkspace = function(_workspace) {
          GeoServer.layers.get({ /*workspace: _workspace.name*/ })
        .$promise.then(
              function(result) {
                var promises = [];

                for (var i = 0, len = result.length; i < len; i++) {
                  GeoServer.layer.get({ layer: result[i].name})
                  .$promise.then(
                      function(l) {
                        $scope.layerCollection.push({
                          name: l.name,
                          type: l.type,
                          title: l.name,
                          srs: ' ',
                          style: 'default'
                        });
                      }
                      );
                }
              });

        };

        $scope.layers = [];

      }])
  .controller('LayerTableCtrl', ['$scope', '$modal',
      function($scope, $modal) {

        $scope.layerHeaders = ['Name', 'Type', 'Title',
          'Store', 'SRS', 'Style', 'Preview'];

        $scope.sortBy = function(chosen_header) {
          $scope.predicate = '' + chosen_header;
        };

        $scope.layers.selectedLayer = null;
        $scope.setSelected = function(lyr) {
          $scope.layers.selectedLayer = lyr;
        };

      }]);
