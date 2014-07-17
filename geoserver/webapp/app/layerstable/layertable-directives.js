angular.module('gsApp.layerstable', [
  'ui.bootstrap.popover'
])
  .directive('layerstable', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/layerstable/layerstable.tpl.html',
        controller: 'LayerTableCtrl',
        replace: true
      };
    });
