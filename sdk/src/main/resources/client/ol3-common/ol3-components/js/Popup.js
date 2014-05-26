if (!window.Boundless) {
  window.Boundless = {};
}
var Boundless = window.Boundless;

/**
 * @class
 * A popup that can be used to show information about a feature.
 * The map is the core component of OpenLayers. In its minimal configuration it
 * needs an element (a div that is normally a child of the map div):
 *
 *     var popup = new Boundless.Popup({
 *       element: document.getElementById('popup')
 *     });
 *
 * A more complete configuration would be:
 *
 *     var popup = new Boundless.Popup({
 *       element: document.getElementById('popup'),
 *       closeBox: true,
 *       offsetY: -25,
 *       autoPan: true
 *     });
 *
 * `closeBox` will determine whether or not an x will be shown which on click
 * close the popup.
 * `offsetX` and `offsetY` are offsets to be applied to the positioning of the
 * popup overlay.
 * `autoPan` will determine if the map will automatically be panned if the
 * popup is not completely visible.
 * The popup is added to the map by using the `overlays` configuration option
 * of the map.
 *
 * @constructor
 * @extends {ol.Overlay}
 * @param {Object} options Options.
 */
Boundless.Popup = function(options) {
  this.autoPan = options.autoPan !== undefined ? options.autoPan : false;
  this.margin = options.margin !== undefined ? options.margin : 10;
  ol.Overlay.call(this, options);
  if (options.closeBox === true) {
    $('<a href="#" id="popup-closer" class="ol-popup-closer"></a>').click(
      this.getElement(), function(evt) {
        evt.data.style.display = 'none';
        evt.target.blur();
        return false;
      }).appendTo($(this.getElement()));
  }
  $('<div id="popup-content"></div>').appendTo($(this.getElement()));
};

ol.inherits(Boundless.Popup, ol.Overlay);

/**
 * Set the content to be shown in the popup.
 * @param {string} content The content to be shown.
 */
Boundless.Popup.prototype.setContent = function(content) {
  document.getElementById('popup-content').innerHTML = content;
};

/**
 * Show this popup.
 */
Boundless.Popup.prototype.show = function() {
  $(this.getElement()).show();
};

/**
 * Hide this popup.
 */
Boundless.Popup.prototype.hide = function() {
  $(this.getElement()).hide();
};

/**
 * Set the position for this overlay.
 * @param {ol.Coordinate|undefined} position Position.
 */
Boundless.Popup.prototype.setPosition = function(position) {
  ol.Overlay.prototype.setPosition.call(this, position);
  if (this.autoPan === true) {
    var map = this.getMap();
    var el = this.getElement();
    var margin = this.margin;
    window.setTimeout(function() {
      var resolution = map.getView().getResolution();
      var center = map.getView().getCenter();
      var popupOffset = $(el).offset();
      var mapOffset = $(map.getTarget()).offset();
      var offsetY = popupOffset.top - mapOffset.top;
      var mapSize = map.getSize();
      var offsetX = (mapOffset.left + mapSize[0])-(popupOffset.left+$(el).outerWidth(true));
      if (offsetY < 0 || offsetX < 0) {
        var dx = 0, dy = 0;
        if (offsetX < 0) {
          dx = (margin-offsetX)*resolution;
        }
        if (offsetY < 0) {
          dy = (margin-offsetY)*resolution;
        }
       map.getView().setCenter([center[0]+dx, center[1]+dy]);
      }
    }, 0);
  }
};
