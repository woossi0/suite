if (!window.Boundless) {
  window.Boundless = {};
}
var Boundless = window.Boundless;

Boundless.TransactionHandler = function(options) {
  this.srsName_ = options.srsName;
  this.source_ = options.source;
  this.geometryType_ = options.geometryType;
  this.geometryName_ = options.geometryName;
  this.url_ = options.url;
  this.map_ = options.map;
  this.featureNS_ = options.featureNS;
  this.featureType_ = options.featureType;
  this.draw_ = new ol.interaction.Draw({
    source: this.source_,
    'type': this.geometryType_,
    geometryName: this.geometryName_
  });
  this.hasDraw_ = false;
  this.select_ = new ol.interaction.Select();
  this.modify_ = new ol.interaction.Modify({
    features: this.select_.getFeatures()
  });
  this.select_.getFeatures().on('add', this.onSelectAdd_, this);
  this.select_.getFeatures().on('remove', this.onSelectRemove_, this);
  this.dirty_ = {};
  this.map_.addInteraction(this.select_);
  this.map_.addInteraction(this.modify_);
  this.format_ = new ol.format.WFS();
  this.serializer_ = new XMLSerializer();
  this.draw_.on('drawend', this.onDrawEnd, this);
};

Boundless.TransactionHandler.prototype.getSelect = function() {
  return this.select_;
};

Boundless.TransactionHandler.prototype.onSelectAdd_ = function(evt) {
  var feature = evt.element;
  var fid = feature.getId();
  feature.on('change', function(evt) {
    this.dirty_[evt.target.getId()] = true;
  }, this);
};

Boundless.TransactionHandler.prototype.onSelectRemove_ = function(evt) {
  var feature = evt.element;
  var fid = feature.getId();
  if (this.dirty_[fid]) {
    // do a WFS transaction to update the geometry
    var properties = feature.getProperties();
    // get rid of bbox which is not a real property
    delete properties.bbox;
    var clone = new ol.Feature(properties);
    clone.setId(fid);
    var node = this.format_.writeTransaction(null, [clone], null, {
      gmlOptions: {srsName: this.srsName_},
      featureNS: this.featureNS_,
      featureType: this.featureType_
    });
    $.ajax({
      type: "POST",
      url: this.url_,
      data: this.serializer_.serializeToString(node),
      contentType: 'text/xml',
      success: function(data) {
        var result = this.format_.readTransactionResponse(data);
        if (result.transactionSummary.totalUpdated === 1) {
          delete this.dirty_[fid];
        }
      },
      context: this
    });
  }
};

Boundless.TransactionHandler.prototype.onDrawEnd = function(evt) {
  var feature = evt.feature;
  var node = this.format_.writeTransaction([feature], null, null, {
    gmlOptions: {srsName: this.srsName_},
    featureNS: this.featureNS_,
    featureType: this.featureType_
  });
  $.ajax({
    type: "POST",
    url: this.url_,
    data: this.serializer_.serializeToString(node),
    contentType: 'text/xml',
    success: function(data) {
      var result = this.format_.readTransactionResponse(data);
      feature.setId(result.insertIds[0]);
      this.map_.removeInteraction(this.draw_);
      this.hasDraw_ = false;
    },
    context: this
  });
};

Boundless.TransactionHandler.prototype.activateInsert = function() {
  if (this.hasDraw_ !== true) {
    this.map_.addInteraction(this.draw_);
    this.hasDraw_ = true;
  }
};

Boundless.TransactionHandler.prototype.deleteSelected = function() {
  var features = this.select_.getFeatures();
  if (features.getLength() === 1) {
    var feature = features.getAt(0);
    // TODO prompt the user to make he's sure
    var node = this.format_.writeTransaction(null, null, [feature], {
      featureNS: this.featureNS_,
      featureType: this.featureType_
    });
    $.ajax({
      type: "POST",
      url: this.url_,
      data: this.serializer_.serializeToString(node),
      contentType: 'text/xml',
      success: function(data) {
        var result = this.format_.readTransactionResponse(data);
        if (result.transactionSummary.totalDeleted === 1) {
          this.select_.getFeatures().clear();
          this.source_.removeFeature(feature);
        }
      },
      context: this
    });
  }
};
