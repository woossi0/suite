angular.module('gsApp.mapstyler', [
  'gsApp.mapstyler.directives',
  'ui.ace'
])
  .controller('MapStylerController', ['$scope', function($scope) {
      $scope.title = 'Maps';

      $scope.editor_modes = [
        {title: 'SLD', mode: 'xml'},
        {title: 'YSLD', mode: 'yaml'},
        {title: 'CSS', mode: 'css'}
      ];
      $scope.editor = {};
      $scope.firstMode = function() {
        $scope.editor.currentMode = $scope.editor_modes[0];
      };

      // Initial code content...
      $scope.aceModel = '<!-- SLD code in here. -->\n';
      $scope.chosenLayer = {};

      // Ace editor: https://github.com/angular-ui/ui-ace

      $scope.aceLoaded = function(_editor) {
        $scope.ace = _editor;
        var _session = _editor.getSession();
        var _renderer = _editor.renderer;

        // Options
        _editor.setTheme('ace/theme/github');
        _editor.setReadOnly(false);
        _session.setUseSoftTabs(true);
        _renderer.setShowGutter(true);

        var undo_manager = _session.getUndoManager();
        undo_manager.reset();
        _session.setUndoManager(undo_manager);

        // Events
        _editor.on('changeSession', function() {
        });
        _session.on('change', function() {
        });
      };

      $scope.modeChanged = function() {
        $scope.ace.getSession().setMode(
            '/ace/mode/' + $scope.editor.currentMode.mode
        );
        switch ($scope.editor.currentMode.mode) {
          case 'xml':
            $scope.aceModel = '<!-- SLD code in here. -->\n';
            break;
          case 'yaml':
            $scope.aceModel = '<!-- YSLD code in here. -->\n';
            break;
          case 'css':
            $scope.aceModel = '<!-- CSS code in here. -->\n';
            break;
          default:
            $scope.aceModel = '<!-- SLD code in here. -->\n';
        }
      };

      $scope.aceChanged = function(e) {

      };

      $scope.$watch('stylesInfo', function(stylesInfo) {
        if (stylesInfo && stylesInfo.length > 0) {
          // vkbeautify adds code spacing
          $scope.aceModel = vkbeautify.xml(stylesInfo[0]);
        }
      }, true);

    }]);
