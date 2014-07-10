angular.module('gsApp.topnav.directives', [])
  .directive('topnav', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/topnav/topnav.tpl.html',
        scope: {
          user: '='
        },
        replace: true
      };
    });
