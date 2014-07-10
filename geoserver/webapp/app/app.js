angular.module('gsApp', [
  'ui.bootstrap',
  'ngRoute',
  'gsApp.service',
  'gsApp.home',
  'gsApp.topnav',
  'gsApp.layers',
  'gsApp.mapstyler'
]).config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $routeProvider
      .when('/', {
        templateUrl: '/home/home.tpl.html',
        controller: 'HomeCtrl'
      })
      .when('/styler', {
        templateUrl: '/mapstyler/mapstyler.tpl.html',
        controller: 'MapStylerCtrl'
      })
      .otherwise({redirectTo: '/'});
  }]);

