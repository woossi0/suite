angular.module('gsApp', [
  'ngRoute',
  'gsApp.service',
  'gsApp.home',
  'gsApp.map',
]).config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $routeProvider
      .when('/', {
        templateUrl: '/home/home.tpl.html',
        controller: 'HomeCtrl'
      })
      .when('/maps', {
        templateUrl: '/map/map.tpl.html',
        controller: 'MapCtrl'
      })
      .otherwise({redirectTo: '/'});
  }]);

