angular.module('gsApp.home', ['gsApp.service'])
  .controller('HomeCtrl', ['$scope', 'GeoServer', function($scope, GeoServer) {
    $scope.title = 'Home';
    $scope.workspaces = GeoServer.workspaces();

    $scope.workspace = {};
    $scope.layers = {};

    $scope.layerCollection = [
      {name: 'states', type: 'Point',
      title: 'States', store: 'states_shp', srs: 'EPSG:4326',
      style: 'draft', preview: ''},
      {name: 'streets', type: 'Line',
      title: 'Streets', store: 'Medford', srs: 'EPSG:4326',
      style: 'none', preview: ''},
      {name: 'wetlands', type: 'Polygon',
      title: 'Wetlands', store: 'Medford', srs: 'EPSG:4326',
      style: 'applied', preview: ''},
      {name: 'hillshade', type: 'Raster',
      title: 'Hillshade', store: 'Medford', srs: 'EPSG:4326',
      style: 'none', preview: ''}
    ];

  }])
  .controller('LayerTableCtrl', ['$scope', '$modal',
    function($scope, $modal) {

      $scope.layerHeaders = ['Name', 'Type', 'Title',
      'Store', 'SRS', 'Style', 'Preview'];

      $scope.sortBy = function (chosen_header) {
        $scope.predicate =  '' + chosen_header;
      };

      $scope.layers.selectedLayer = null;
      $scope.setSelected = function(lyr) {
        $scope.layers.selectedLayer = lyr;
      };

    }]);
