angular.module('gsApp.mapviewer.directives', [])
  .directive('mapViewer', function() {
      return {
        restrict: 'EA',
        templateUrl:
            '/mapviewer/mapviewer.tpl.html',
        replace: true,
        controller: 'MapViewerController'
      };
    })
  .directive('layerToggle',
    function($parse) {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          var layerToggle = $parse(attrs.layerToggle),
              layer = null;
          var el = angular.element(element[0]);
          el.addClass('layer-toggle');

          function toggleVisibility() {
            layer.setVisible(!layer.getVisible());
          }
          function onVisibilityChange(val) {
            el.toggleClass('visible', val.target.getVisible());
          }
          scope.$watch(layerToggle, function(val, oldVal) {
            // unbind old layer
            if (oldVal instanceof ol.layer.Layer && oldVal === layer) {
              oldVal.un('change:visible', onVisibilityChange);
              el.off('click', toggleVisibility);
            }
            if (val instanceof ol.layer.Layer) {
              layer = val;
              val.on('change:visible', onVisibilityChange);
              el.toggleClass('visible', val.getVisible());
              // Toggle layer visibility on click
              el.on('click', toggleVisibility);
            } else {
              el.removeClass('visible');
              el.off('click', toggleVisibility);
            }
          });
        }
      };
    })
  .directive('zoomToExtent',
    /*
     * @ngdoc directive
     * @name gsApp.mapviewer.directives:zoomToExtent
     *
     * @scope
     * @element A
     *
     * @description
     * On element click zooms to a given extent on an ol.Map
     *
     * @param {Array} extent An extent of form [minX, minY, maxX, maxY]
     * @param {ol.Map} map The map which to zoom
     */
    function() {
      return {
        restrict: 'A',
        scope: {
          extent: '=zoomToExtent',
          map: '='
        },
        link: function(scope, element, attrs) {
          var el = angular.element(element[0]);
          el.addClass('zoom-extent');
          el.on('click', function() {
            var map = scope.map;
            if (map instanceof ol.Map) {
              map.getView().fitExtent(scope.extent, map.getSize());
            }
          });
        }
      };
    })
  .directive('olMap',
    function($timeout, MapFactory) {
      /*
       * @ngdoc directive
       * @name gsApp.mapviewer.directives:olMap
       *
       * @scope
       * @element E
       *
       * @description
       * Directive that creates and renders a map to the page.
       *
       * @param {ol.Map|undefined} map Optional. If provided an instantiated
       *                               ol.Map instance will use that instead of
       *                               creating a new one; otherwise, a new
       *                               instance is created and bound.
       * @param {Array} layers Optional. Array of layers to show on the map
       * @param {Array} center Optional. Coordinate of form [lon, lat] to set
       *                       map center
       * @param {Integer} zoom Optional zoom level at which to initiate view.
       */
      return {
        restrict: 'EA',
        scope: {
          map: '=?',
          layers: '=?',
          center: '=?',
          zoom: '=?'
        },
        link: function(scope, element, attrs) {
          var map = scope.map;
          if (!(map instanceof ol.Map)) {
            map = scope.map = MapFactory.create(scope.layers);
          }

          map.setTarget(element[0]);

          var view = map.getView();

          if (scope.center) {
            var center = ol.proj.transform(scope.center,
                'EPSG:4326', view.getProjection());
            view.setCenter(center);
          }

          if (scope.zoom) {
            view.setZoom(scope.zoom);
          }

          $timeout(function() {
            map.updateSize();
          }, 300);

          scope.$watch('layers', function(newLayers, oldLayers) {
            if (newLayers && newLayers[0] instanceof ol.layer.Layer) {
              if (oldLayers && oldLayers[0] instanceof ol.layer.Layer) {
                oldLayers.forEach(function(layer) {
                  map.removeLayer(layer);
                });
              }
              newLayers.forEach(function(layer) {
                map.addLayer(layer);
              });
            }
          });
        }
      };

    });

