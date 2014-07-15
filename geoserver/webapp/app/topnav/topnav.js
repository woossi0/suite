angular.module('gsApp.topnav', [
  'gsApp.topnav.services',
  'gsApp.topnav.directives'
])
  .controller('TopNavCtrl', function($scope, topNavService) {
      $scope.message = topNavService.fetchUser();
    });
