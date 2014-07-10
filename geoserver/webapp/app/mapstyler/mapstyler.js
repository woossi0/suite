angular.module('gsApp.mapstyler',
  ['gsApp.mapstyler.directives', 'ui.ace'])
  .controller('MapStylerCtrl', function($scope) {
    $scope.title = 'Maps';

    // Ace editor: https://github.com/angular-ui/ui-ace

    $scope.aceLoaded = function(_editor) {
      // Options
      _editor.setReadOnly(true);
    };

    $scope.aceChanged = function(e) {
      //
    };

  });
