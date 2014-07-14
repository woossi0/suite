angular.module('gsApp.mapstyler',
    ['gsApp.mapstyler.directives', 'ui.ace'])
  .controller('MapStylerController', ['$scope', function($scope) {
      $scope.title = 'Maps';

      $scope.editor_modes = ['SLD', 'YSLD', 'CSS'];
      $scope.editor = {};
      $scope.editor.mode = $scope.editor_modes[0];

      // Initial code content...
      $scope.aceModel = '<!-- SLD code in here. -->\n';
      $scope.chosenLayer = {};

      // Ace editor: https://github.com/angular-ui/ui-ace

      $scope.aceLoaded = function(_editor) {
        $scope.ace = _editor;
        var _session = _editor.getSession();
        var _renderer = _editor.renderer;

        // Options
        _editor.setTheme('ace/theme/monokai');
        _editor.setReadOnly(false);
        _session.setUndoManager(new ace.UndoManager());
        _renderer.setShowGutter(false);

        // Events
        _editor.on('changeSession', function() {
        });
        _session.on('change', function() {
        });
      };

      $scope.modeChanged = function() {
        $scope.ace.getSession().setMode(
            '/ace/mode/' + $scope.editor.mode.toLowerCase());
      };

      $scope.aceChanged = function(e) {

      };

    }]);
