/**
 * Add all your dependencies here.
 *
 * @require LayersControl.js
 * @require TransactionHandler.js
 * @require FeatureTable.js
 * @require WFSBBOXLoader.js
 */

// ========= config section =============================================
var url = '/geoserver/wfs?';
var featurePrefix = 'usa';
var featureType = 'states';
var featureNS = 'http://census.gov';
var srsName = 'EPSG:900913';
var geometryName = 'the_geom';
var geometryType = 'MultiPolygon';
var fields = ['STATE_NAME', 'STATE_ABBR'];
var layerTitle = 'States';
// ======================================================================
var loadFeatures = function(response) {
  vectorSource.addFeatures(vectorSource.readFeatures(response));
};    
var BBOXLoader = new Boundless.WFSBBOXLoader({
  url: url,
  featurePrefix: featurePrefix,
  featureType: featureType,
  srsName: srsName,
  callback: loadFeatures
});
var vectorSource = new ol.source.ServerVector({
  format: new ol.format.GeoJSON({geometryName: geometryName}),
  loader: $.proxy(BBOXLoader.load, BBOXLoader),
  strategy: ol.loadingstrategy.createTile(new ol.tilegrid.XYZ({
    maxZoom: 19
  })),
  projection: 'EPSG:3857'
});
var vector = new ol.layer.Vector({
  title: layerTitle,
  source: vectorSource,
  style: new ol.style.Style({
    stroke: new ol.style.Stroke({
      color: 'rgba(0, 0, 255, 1.0)',
      width: 2
    })
  })
});
var map = new ol.Map({
  controls: ol.control.defaults().extend([
    new Boundless.LayersControl({
      groups: {
        background: {
          title: "Base Layers",
          exclusive: true
        },
        default: {
          title: "Overlays"
        }
      }
    })
  ]),
  // render the map in the 'map' div
  target: document.getElementById('map'),
  // use the Canvas renderer
  renderer: 'canvas',
  layers: [
    // MapQuest streets
    new ol.layer.Tile({
      title: 'Street Map',
      group: "background",
      source: new ol.source.MapQuest({layer: 'osm'})
    }),
    // MapQuest imagery
    new ol.layer.Tile({
      title: 'Aerial Imagery',
      group: "background",
      visible: false,
      source: new ol.source.MapQuest({layer: 'sat'})
    }),
    // MapQuest hybrid (uses a layer group)
    new ol.layer.Group({
      title: 'Imagery with Streets',
      group: "background",
      visible: false,
      layers: [
        new ol.layer.Tile({
          source: new ol.source.MapQuest({layer: 'sat'})
        }),
        new ol.layer.Tile({
          source: new ol.source.MapQuest({layer: 'hyb'})
        })
      ]
    }),
    vector
  ],
  // initial center and zoom of the map's view
  view: new ol.View2D({
    center: [-10764594.758211, 4523072.3184791],
    zoom: 3
  })
});
var transaction = new Boundless.TransactionHandler({
  source: vector.getSource(),
  geometryType: geometryType,
  geometryName: geometryName,
  srsName: srsName,
  featureNS: featureNS,
  featureType: featureType,
  url: url,
  map: map
});
var table = new Boundless.FeatureTable({
  id: 'features',
  fields: fields,
  showFeatureId: true,
  source: vector.getSource(),
  map: map, 
  container: 'features-container',
  select: transaction.getSelect(),
  offset: 37 /* not sure why this is 37 pixels */
});
var deleteFeature = function() {
  transaction.deleteSelected();
};
var drawFeature = function() {
  transaction.activateInsert();
};
