angular.module('gsApp', [
  'ui.bootstrap',
  'ui.select',
  'ngSanitize',
  'ngRoute',
  'gsApp.service',
  'gsApp.home',
  'gsApp.topnav',
  'gsApp.layerstable',
  'gsApp.mapviewer',
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
          templateUrl: '/home/styler.tpl.html',
          controller: 'HomeCtrl'
        })
      .otherwise({redirectTo: '/'});

  }]).config(function(uiSelectConfig) {
  uiSelectConfig.theme = 'bootstrap';
});



