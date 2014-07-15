angular.module('gsApp', [
  'ui.bootstrap',
  'ui.select',
  'ngSanitize',
  'ngRoute',
  'gsApp.service',
  'gsApp.home',
  'gsApp.topnav',
  'gsApp.layers',
  'gsApp.mapstyler',
  'gsApp.mapviewer'
]).config(['$routeProvider', '$locationProvider',
  function($routeProvider, $locationProvider, MapFactoryProvider) {
    $locationProvider.html5Mode(true);
    $routeProvider
    .when('/', {
      templateUrl: '/home/home.tpl.html',
      controller: 'HomeCtrl'
    })
    .otherwise({redirectTo: '/'});

  }]).config(function(uiSelectConfig) {
  uiSelectConfig.theme = 'bootstrap';
});


// Override default ol.Map base layer
MapFactoryProvider.setBaseLayers(function() {
  return [
    new ol.layer.Tile({
      //source: new ol.source.Stamen({layer: 'toner-lite'})
      source: new ol.source.XYZ({
        url: 'http://54.243.224.151/geoserver/gwc/service/tms/1.0.0/' +
            'lightbasemap@EPSG%3A900913@png/{z}/{x}/{-y}.png',
        attributions: [ol.source.OSM.DATA_ATTRIBUTION]
      })
    }),
    new ol.layer.Image({
      source: new ol.source.ImageWMS({
        url: 'http://54.243.224.151/geoserver/wms',
        params: {
          'LAYERS': 'lightbasemaplabels',
          'VERSION': '1.1.0',
          'TRANSPARENT': true
        },
        serverType: 'geoserver',
        hidpi: false
      })
    })
  ];
});

