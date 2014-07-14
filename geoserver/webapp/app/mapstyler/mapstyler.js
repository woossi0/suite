angular.module('gsApp.mapstyler',
  ['gsApp.mapstyler.directives', 'ui.ace'])
  .controller('MapStylerCtrl', ['$scope', function($scope) {
    $scope.title = 'Maps';

    $scope.chosenLayer = {};

    // Ace editor: https://github.com/angular-ui/ui-ace

    $scope.aceLoaded = function(_editor) {
       // Editor part
      var _session = _editor.getSession();
      var _renderer = _editor.renderer;

      // Options
      _editor.setTheme('ace/theme/monokai');
      _editor.setReadOnly(false);
    //  _session.setUndoManager(new ace.UndoManager());
      _renderer.setShowGutter(false);

      // Events
      _editor.on('changeSession', function(){  });
      _session.on('change', function(){  });
    };

    $scope.aceChanged = function(e) {

    };

  }]);
