angular.module('gsApp.home', ['gsApp.service'])
  .controller('HomeCtrl', ['$scope', 'GeoServer', function($scope, GeoServer) {
    $scope.title = 'Home';
    $scope.workspaces = GeoServer.workspaces();
  }]);