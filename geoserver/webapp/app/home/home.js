angular.module('gsApp.home', ['gsApp.service' ])
  .controller('HomeCtrl', ['$scope', 'GeoServer', function($scope, GeoServer) {
    $scope.title = 'Home';
    $scope.workspaces = GeoServer.workspaces();
  }])
  .controller('LayerTableCtrl', ['$scope', '$modal',
    function($scope, $modal) {

      $scope.layerHeaders = ['Select', 'Name', 'Type', 'Title',
      'Store', 'SRS', 'Style', 'Preview'];

      $scope.sortBy = function (chosen_header) {
        $scope.predicate =  '' + chosen_header;
      };

      $scope.layerCollection = [
        {check: 'ok', name: 'states', type: 'Point',
        title: 'States', store: 'states_shp', srs: 'EPSG:4326',
        style: 'draft', preview: ''},
        {check: 'ok', name: 'streets', type: 'Line',
        title: 'Streets', store: 'Medford', srs: 'EPSG:4326',
        style: 'none', preview: ''},
        {check: 'ok', name: 'wetlands', type: 'Polygon',
        title: 'Wetlands', store: 'Medford', srs: 'EPSG:4326',
        style: 'applied', preview: ''},
        {check: 'ok', name: 'wetlands', type: 'Raster',
        title: 'Wetlands', store: 'Medford', srs: 'EPSG:4326',
        style: 'none', preview: ''}
      ];

    }]);
