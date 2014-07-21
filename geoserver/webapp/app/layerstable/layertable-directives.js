angular.module('gsApp.layerstable')
  .directive('layerstable', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/layerstable/layerstable.tpl.html',
        replace: true,
        controller: 'LayerTableCtrl'
      };
    });
