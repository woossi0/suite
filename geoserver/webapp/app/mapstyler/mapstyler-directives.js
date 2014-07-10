angular.module('gsApp.mapstyler.directives', [])
  .directive('mapstyler', function() {
    return {
      restrict: 'EA',
      templateUrl:
          '/mapstyler/mapstyler.tpl.html',
      scope: {
        user: '='
      },
      replace: true
    };
  });
