angular.module('gsApp.home', [
  'gsApp.service'
])
  .controller('HomeCtrl', ['$scope', 'GeoServer', '$q',
      function($scope, GeoServer, $q) {
        $scope.title = 'Home';
        $scope.workspaces = GeoServer.workspaces.get();
        $scope.workspace = {};
        $scope.layerCollection = [];
        var promises = [];

        $scope.setSelectedWorkspace = function(_workspace) {
          GeoServer.layers.get({ /*workspace: _workspace.name*/ })
          .$promise.then(
              function(result) {
                angular.forEach(result, function(_layer, key) {
                  /* GeoServer.layer.get({ layer: _layer.name})
                   .$promise.then(function(layerResult) {
                    console.log(layerResult);*/
                  $scope.layerCollection.push({
                    name: _layer.name,
                    //   type: layerResult.type,
                    //   title: layerResult.name,
                    srs: ' ',
                    style: 'default'
                    //  });
                  });

                });
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
