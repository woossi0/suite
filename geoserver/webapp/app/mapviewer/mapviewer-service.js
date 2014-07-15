angular.module('gsApp.mapviewer.services', [])
/*
 * @ngdoc service
 * @name gsApp.mapviewer.provider:MapFactoryProvider
 *
 * @description
 * The `MapFactoryProvider` allows the default options
 * and layers for the {@link geogit.map.service:MapFactory `MapFactory`}
 * service to be get/set in your
 * app's config.
 *
 * The map defaults to using a canvas renderer with MapQuest OSM as a basemap.
 */
.provider('MapFactory', function() {

      this.baselayers = function() {
        return [
          new ol.layer.Image({
            source: new ol.source.ImageWMS({
              url: 'http://localhost:8080/geoserver/opengeo/wms',
              params: {
                'LAYERS': 'opengeo:countries',
                'VERSION': '1.1.0',
                'TRANSPARENT': true
              },
              serverType: 'geoserver',
              hidpi: false
            })
          })
        ];
      };

      this.defaults = function() {
        return {
          controls: ol.control.defaults().extend([
            new ol.control.FullScreen()
          ]),
          renderer: 'canvas',
          view: new ol.View2D({
            center: [0, 0],
            zoom: 2
          })
        };
      };

      /*
      * @ngdoc function
      * @name getBaseLayers
      * @methodOf gsApp.mapviewer.provider:MapFactoryProvider
      * @description
      * Get MapFactory default layers.
      *
      * @return {Array.<ol.layer.Layer>} Array of ol3 Layers.
      */
      this.getBaseLayers = function() {
        return this.baselayers();
      };
      /*
      * @ngdoc function
      * @name setBaseLayers
      * @methodOf gsApp.mapviewer.provider:MapFactoryProvider
      *
      * @description
      * Set MapFactory default layers.
      *
      * @param {Function} baselayers returns array of ol3 Layers.
      */
      this.setBaseLayers = function(baselayers) {
        this.baselayers = baselayers;
      };
      /*
      * @ngdoc function
      * @name getDefaults
      * @methodOf gsApp.mapviewer.provider:MapFactoryProvider
      *
      * @description
      * Get MapFacory option defaults.
      * @return {olx.MapOptions} Map config object.
      */
      this.getDefaults = function() {
        return this.defaults();
      };
      /*
      * @ngdoc function
      * @name setDefaults
      * @methodOf gsApp.mapviewer.provider:MapFactoryProvider
      *
      * @description
      * Set MapFactory option defaults.
      * @param {function} defaults Function that returns map config object.
      */
      this.setDefaults = function(def) {
        this.defaults = this.def;
      };

      this.$get = function() {
        var defaults = this.defaults,
            baselayers = this.baselayers;
        /*
        * @ngdoc service
        * @name gsApp.mapviewer.service:MapFactory
        *
        * @description
        * Service for creating ol.Map instances.
        */
        return {
          /*
          * @ngdoc function
          * @name create
          *
          * @methodOf gsApp.mapviewer.service:MapFactory
          *
          * @description
          * Creates an `ol.Map` instance.
          *
          * Uses defaults as set in
          * {@link geogit.map.service:MapFactoryProvider
          * `MapFactoryProvider`} unless different layers and
          * options are passed in.
          *
          * @param  {Array.<ol.layer.Layer>} layers Optional array
          * of layers to put on the map.
          * @param  {Object} options Optional set of
          * {@link http://ol3js.org/en/master/apidoc/ol.Map.html ol.Map options}
          * to override defaults.
          *
          * @return {ol.Map} A new map instance.
          */
          create: function(layers, options) {
            layers = layers || [];
            options = options || {};
            var opts = angular.extend(defaults(), options);
            opts.layers = baselayers().concat(layers);

            return new ol.Map(opts);
          }
        };
      };

    });
