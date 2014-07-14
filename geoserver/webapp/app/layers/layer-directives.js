angular.module('gsApp.layers', ['ui.bootstrap.popover'])
  .directive('layers', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/layers/layers.tpl.html',
        replace: true
      };
    })
  .directive('layertable', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/layers/layers-table.tpl.html',
        controller: 'LayerTableCtrl',
        replace: true
      };
    });
