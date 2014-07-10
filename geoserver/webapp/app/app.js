angular.module('gsApp', [
  'ui.bootstrap',
  'ngRoute',
  'gsApp.service',
  'gsApp.home',
  'gsApp.topnav',
  'gsApp.layers',
  'gsApp.map'
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

