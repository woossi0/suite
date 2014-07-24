angular.module('gsApp.mapstyler.directives', [
  'ui.select'
])
  .directive('mapStyler', function() {
      return {
        restrict: 'EAC',
        templateUrl:
            '/mapstyler/mapstyler.tpl.html',
        replace: true,
        scope: {
          selectedWorkspace: '=selectedWorkspace',
          selectedLayer: '=selectedLayer',
          layerCollection: '=layerCollection'
        },
        controller: 'MapStylerController'
      };
    });
