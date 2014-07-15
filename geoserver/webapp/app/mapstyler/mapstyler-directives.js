angular.module('gsApp.mapstyler.directives', [
  'ui.select'
])
  .directive('mapStyler', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/mapstyler/mapstyler.tpl.html',
        replace: true,
        controller: 'MapStylerController'
      };
    });
