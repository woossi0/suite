angular.module('gsApp.mapstyler.directives', ['ui.select'])
  .directive('mapstyler', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/mapstyler/mapstyler.tpl.html',
        replace: true,
        controller: 'MapStylerController'
      };
    });
