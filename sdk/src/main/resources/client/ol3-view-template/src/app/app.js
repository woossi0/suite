/**
 * Add all your dependencies here.
 *
 * @require Popup.js
 * @require LayersControl.js
 */

// create the classes for the subway lines
// since they are lines, we use ol.style.Stroke objects
var class1 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#ff3135",
    width: 3
  })
})];
var class2 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#009b2e",
    width: 3
  })
})];
var class3 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#ce06cb",
    width: 3
  })
})];
var class4 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#fd9a00",
    width: 3
  })
})];
var class5 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#ffff00",
    width: 3
  })
})];
var class6 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#ffff00",
    width: 3
  })
})];
var class7 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#9ace00",
    width: 3
  })
})];
var class8 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#6e6e6e",
    width: 3
  })
})];
var class9 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#976900",
    width: 3
  })
})];
var class10 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#969696",
    width: 3
  })
})];
var class11 = [new ol.style.Style({
  stroke: new ol.style.Stroke({
    color: "#ffff00",
    width: 3
  })
})];

// cache the styles in an object for re-use, so they do not need to
// get instantiated all the time by the style function
// the key of the style cache is the value of the routeId attribute of the features
var styleCache = {
  "1": class1,
  "2": class1,
  "3": class1,
  "4": class2,
  "5": class2,
  "6": class2,
  "7": class3,
  "A": class4,
  "C": class4,
  "E": class4,
  "SI": class4,
  "H": class4,
  "Air": class5,
  "B": class6,
  "D": class6,
  "F": class6,
  "M": class6,
  "G": class7,
  "FS": class8,
  "GS": class8,
  "J": class9,
  "Z": class9,
  "L": class10,
  "N": class11,
  "Q": class11,
  "R": class11
};
// style cache for the icons
var iconStyleCache = {
  "assets/img/theater.png": {
    "24-28": [new ol.style.Style({
      image: new ol.style.Icon({
        size: [24, 28],
        anchor: [12, 28],
        anchorXUnits: 'pixels',
        anchorYUnits: 'pixels',
        src: 'assets/img/theater.png'
      })
    })]
  },
  "assets/img/museum.png": {
    "24-28": [new ol.style.Style({
      image: new ol.style.Icon({
        size: [24, 28],
        anchor: [12, 28],
        anchorXUnits: 'pixels',
        anchorYUnits: 'pixels',
        src: 'assets/img/museum.png'
      })
    })]
  }
};

// create a new popup with a close box
// the popup will draw itself in the popup div container
// it will use an offset in the y direction of 25 pixels so it does not
// overlap the icon
// autoPan means the popup will pan the map if it's not visible (at the edges of the map).
var popup = new Boundless.Popup({
  element: document.getElementById('popup'),
  closeBox: true,
  offsetY: -25,
  autoPan: true
});

// create the boroughs vector layer from GeoJSON
var boroughs = new ol.layer.Vector({
  title: "Boroughs",
  style: new ol.style.Style({
    stroke: new ol.style.Stroke({
      color: 'black',
      width: 5
    })
  }),
  source: new ol.source.GeoJSON({
    projection: 'EPSG:3857',
    url: 'data/boroughs.geojson'
  })
});

// create the OpenLayers Map object
// we add a layer switcher to the map with two groups:
// 1. background, which will use radio buttons
// 2. default (overlays), which will use checkboxes
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
  // add the popup as a map overlay
  overlays: [popup],
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
    // our boroughs vector layer which we created before
    boroughs,
    // the subways vector layer which will use the classification which we
    // created above
    new ol.layer.Vector({
      title: 'Subway lines',
      hover: true,
      visible: false,
      style: function(feature) {
        var routeId = feature.get('route_id');
        return styleCache[routeId];
      },
      source: new ol.source.GeoJSON({
        projection: 'EPSG:3857',
        url: 'data/subways.geojson'
      })
    }),
    // the theaters vector layer from GeoJSON (points)
    new ol.layer.Vector({
      title: "<img src='assets/img/theater.png' width='24' height='28'>&nbsp;Theaters",
      style: new iconSizeFunction([24, 28], [12,28], 'assets/img/theater.png'),
      // the result of this function will determine the contents of the popup
      featureInfo: function(feature) {
        return "<table class='table table-striped table-bordered table-condensed'>" + "<tr><th>Name</th><td>" + feature.get('NAME') + "</td></tr>" + "<tr><th>Phone</th><td>" + feature.get('TEL') + "</td></tr>" + "<tr><th>Address</th><td>" + feature.get('ADDRESS1') + "</td></tr>" + "<tr><th>Website</th><td><a class='url-break' href='" + feature.get('URL') + "' target='_blank'>" + feature.get('URL') + "</a></td></tr>" + "<table>";
      },
      source: new ol.source.GeoJSON({
        projection: 'EPSG:3857',
        url: 'data/DOITT_THEATER_01_13SEPT2010.geojson'
      })
    }),
    // the museums vector layer from GeoJSON (points)
    new ol.layer.Vector({
      title: "<img src='assets/img/museum.png' width='24' height='28'>&nbsp;Museums",
      visible: false,
      style:  new iconSizeFunction([24, 28], [12,28], 'assets/img/museum.png'),
      // the result of this function will determine the contents of the popup
      featureInfo: function(feature) {
        return "<table class='table table-striped table-bordered table-condensed'>" + "<tr><th>Name</th><td>" + feature.get('NAME') + "</td></tr>" + "<tr><th>Phone</th><td>" + feature.get('TEL') + "</td></tr>" + "<tr><th>Address</th><td>" + feature.get('ADRESS1') + "</td></tr>" + "<tr><th>Website</th><td><a class='url-break' href='" + feature.get('URL') + "' target='_blank'>" + feature.get('URL') + "</a></td></tr>" + "<table>";
      },
      source: new ol.source.GeoJSON({
        projection: 'EPSG:3857',
        url: 'data/DOITT_MUSEUM_01_13SEPT2010.geojson'
      })
    })
  ],
  // initial center and zoom of the map's view
  view: new ol.View2D({
    center: ol.proj.transform([-73.979378, 40.702222], 'EPSG:4326', 'EPSG:3857'),
    zoom: 10
  })
});

// create a feature overlay which is used to show the highlighted subway line segment
var featureOverlay = new ol.FeatureOverlay({
  map: map,
  style: new ol.style.Style({
    stroke: new ol.style.Stroke({
      color: '#00FFFF',
      width: 3
    })
  })
});

// register a single click listener on the map
// show the popup for layers that have a featureInfo function
map.on('singleclick', function(evt) {
  var featureLayer;
  // find the feature at the clicked pixel location
  var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
    featureLayer = layer;
    return feature;
  });
  if (feature && featureLayer.get('featureInfo')) {
    popup.setPosition(feature.getGeometry().getCoordinates());
    popup.setContent(featureLayer.get('featureInfo')(feature));
    popup.show();
  } else {
    popup.hide();
  }
});
var highlight;
// when the mouse is moved over the subway layer, highlight the
// subway segment which is under the cursor
// also show the pointer cursor for the icons so it is more obvious
// that those features have a popup associated with them on click
$(map.getViewport()).on('mousemove', function(evt) {
  var pixel = map.getEventPixel(evt.originalEvent);
  var featureLayer;
  var feature = map.forEachFeatureAtPixel(pixel, function(feature, layer) {
    featureLayer = layer;
    return feature;
  });
  if (feature && featureLayer && featureLayer.get('featureInfo')) {
    map.getTarget().style.cursor = 'pointer';
  } else {
    map.getTarget().style.cursor = '';
  }
  if (feature !== highlight) {
    if (highlight) {
      featureOverlay.removeFeature(highlight);
    }
    if (feature && featureLayer.get('hover')) {
      // adding the feature to the feature overlay shows it in the highlight style
      featureOverlay.addFeature(feature);
    }
    highlight = feature;
  }
});

// calculate a size that changes based on a resolution value
function calcIconSize (_origSize, resolution) {
  var width = Math.round(2 * _origSize[0] / ( Math.log(resolution)));
  var height = Math.round((_origSize[1]/_origSize[0]) * width);
  var olsize = [width, height];
  if (olsize[0] > _origSize[0] || olsize[0] < 0) {
    return _origSize;
  } else {
    return olsize;
  }
}

// return an icon size that changes based on current map zoom resolution
function iconSizeFunction(_origSize, _anchor, _imgSrc) {
  return function(feature, resolution) {
    var size = calcIconSize(_origSize, resolution);
    var key = size.join("-");
    if (!iconStyleCache[_imgSrc][key]) {
      iconStyleCache[_imgSrc][key] = [new ol.style.Style({
        image: new ol.style.Icon({
          anchor: [size[0]/2, size[1]],
          anchorXUnits: 'pixels',
          anchorYUnits: 'pixels',
          size: size,
          src: _imgSrc
        })
      })];
    }
    return iconStyleCache[_imgSrc][key];
  };
}

