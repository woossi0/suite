angular.module('gsApp.mapviewer.adapter', [])
.factory('OlAdapter',

    function() {
      var GeoServerUrl = {
        baseUrl: 'http://localhost:8080/geoserver/',

        getBaseUrl: function() {
          return this.baseUrl;
        }
      };

      var defaultColor = '#000066'; //TODO: make configurable

      GeoServerUrl.getTilesUrl = GeoServerUrl.getBaseUrl() + '/tiles';

      function getTilesUrl(layerName, repo, color) {
        color = color || defaultColor;
        var style = '0xFF' + color.substring(1);
        return GeoServerUrl.getTilesUrl(repo, layerName, style) +
            '/{z}/{x}/{y}.png';
      }

      var styles = {
        'MODIFIED': [
          new ol.style.Style({
            stroke: new ol.style.Stroke({
              color: 'rgb(48,132,243)',
              width: 2
            }),
            fill: new ol.style.Fill({
              color: 'rgba(48,132,243,0.3)'
            }),
            image: new ol.style.Circle({
              radius: 10,
              fill: new ol.style.Fill({
                color: 'rgb(48,132,243)'
              })
            })
          })
        ],
        'MODIFIED_old': [
          new ol.style.Style({
            stroke: new ol.style.Stroke({
              color: 'rgb(133,170,219)',
              width: 2
            }),
            fill: new ol.style.Fill({
              color: 'rgba(133,170,219,0.3)'
            }),
            image: new ol.style.Circle({
              radius: 10,
              fill: new ol.style.Fill({
                color: 'rgba(133,170,219,0.7)'
              })
            })
          })
        ],
        'ADDED': [
          new ol.style.Style({
            stroke: new ol.style.Stroke({
              color: 'rgb(94,207,107)',
              width: 2
            }),
            fill: new ol.style.Fill({
              color: 'rgba(94,207,107,0.3)'
            }),
            image: new ol.style.Circle({
              radius: 10,
              fill: new ol.style.Fill({
                color: 'rgb(94,207,107)'
              })
            })
          })
        ],
        'REMOVED': [
          new ol.style.Style({
            stroke: new ol.style.Stroke({
              color: 'rgb(217,89,98)',
              width: 2
            }),
            fill: new ol.style.Fill({
              color: 'rgba(217,89,98,0.3)'
            }),
            image: new ol.style.Circle({
              radius: 10,
              fill: new ol.style.Fill({
                color: 'rgba(217,89,98,.6)'
              })
            })
          })
        ]
      };

      function extractFeatures(changes) {
        var newColl = [], oldColl = [];
        var parser = new ol.format.GeoJSON();
        changes.forEach(function(change) {
          // Set changeType as a feature property
          var oldFeat = change.oldFeature,
              newFeat = change.newFeature,
              type = change.changeType;
          if (newFeat) {
            change.olNew = parser.readFeature(newFeat);
            change.olNew.set('changeType', type);
            newColl.push(change.olNew);
          }
          if (oldFeat) {
            change.olOld = parser.readFeature(oldFeat);
            if (type === 'MODIFIED') { type += '_old'; }
            change.olOld.set('changeType', type);
            oldColl.push(change.olOld);
          }
        });
        return [newColl, oldColl];
      }
      function createDiffLayer(featArray) {
        var source = new ol.source.Vector({});
        source.addFeatures(featArray);
        // create layer
        return new ol.layer.Vector({
          style: function(feature, resolution) {
            return styles[feature.get('changeType')];
          },
          source: source
        });
      }
      return {

        setUrl: function(workspace) {
          GeoServerUrl.baseUrl = GeoServerUrl.getBaseUrl() + workspace + '/wms';
        },

        getBaseUrl: function() {
          return GeoServerUrl.getBaseUrl();
        },

        createTileLayer: function(layer, repo, ref) {
          layer.ol = new ol.layer.Tile({
            name: layer.path,
            repo: repo.name,
            owner: repo.owner,
            color: defaultColor, // this allows get/set later
            visible: false,
            source: new ol.source.XYZ({
              url: getTilesUrl(layer.path, repo, defaultColor, ref)
            })
          });
          // update URL template on color changes
          layer.ol.on('change:color', function() {
            layer.ol.getSource().setUrl(
                getTilesUrl(layer.path, repo, layer.ol.get('color')));
          });
        },

        createLayerFromDiff: function(diff) {
          // Collect features into FeatureCollection
          var features = extractFeatures(diff.changes);
          return features.map(createDiffLayer);
        },

        createDiffImageLayers: function(repo, layerName, oldRef, newRef) {
          return [
            new ol.layer.Tile({
              source: new ol.source.XYZ({
                url: GeoServerUrl.getDiffImageUrl(repo, layerName, oldRef,
                  newRef) + '/{z}/{x}/{y}.png?showNew=false'
              })
            }),
            new ol.layer.Tile({
              source: new ol.source.XYZ({
                url: GeoServerUrl.getDiffImageUrl(repo, layerName, oldRef,
                  newRef) + '/{z}/{x}/{y}.png?showNew=true'
              })
            })
          ];
        }
      };
    })
    .factory('MapState', function() {
      var state = {};
      return {
        state: state,
        setCenter: function(center) {
          state.center = center;
        },
        setZoom: function(zoom) {
          state.zoom = zoom;
        },
        setLayers: function(layers) {
          state.layers = layers;
        },
        getCenter: function() {
          return state.center;
        },
        getZoom: function() {
          return state.zoom;
        },
        getLayers: function() {
          return state.layers;
        },
        toggleLayer: function(layer, add) {
          var index = state.layers ? state.layers.indexOf(layer) : -1;
          add = (typeof add !== 'undefined') ? add : index === -1;
          if (index >= 0 && !add) {
            state.layers.splice(index, 1);
          }
          if (index === -1 && add) {
            state.layers = state.layers || [];
            state.layers.push(layer);
          }
        },
        toParamObj: function() {
          var paramObj = {};
          if (state.center) {
            paramObj.lat = state.center[0];
            paramObj.lon = state.center[1];
          }
          if (state.zoom) {
            paramObj.z = state.zoom;
          }
          if (state.layers) {
            paramObj.l = state.layers;
          }
          return paramObj;
        },
        fromParamObj: function(params) {
          if (params.lat && params.lon) {
            state.center = [+params.lat, +params.lon];
            state.layers = [];
          }
          if (params.z) {
            state.zoom = params.z;
          }
          if (params.l) {
            state.layers = params.l;
          }
        }
      };
    });
