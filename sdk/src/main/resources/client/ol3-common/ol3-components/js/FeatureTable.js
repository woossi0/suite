if (!window.Boundless) {
  window.Boundless = {};
}
var Boundless = window.Boundless;

Boundless.FeatureTable = function(options) {
  this.id_ = options.id;
  this.container_ = options.container;
  this.source_ = options.source;
  this.source_.on('addfeature', this.addRow, this);
  this.map_ = options.map;
  this.showFid_ = options.showFeatureId;
  this.fields_ = options.fields;
  this.select_ = options.select;
  this.offset_ = options.offset;
  this.select_.getFeatures().on('add', this.selectRow, this);
  this.select_.getFeatures().on('remove', this.unselectRow, this);
  $('#' + this.id_).on('click', 'tbody tr', this, this.handleRowClick);
  this.addHeader();
};

Boundless.FeatureTable.prototype.addHeader = function() {
  var html = '';
  if (this.showFid_ === true) {
    html += '<thead><th>FID</th>';
  }
  for (var i=0, ii=this.fields_.length; i<ii; ++i) {
    var field = this.fields_[i];
    html += '<th>' + field.toUpperCase() + '</th>';
  }
  html += '</thead>';
  $('#' + this.id_).append(html);
};

Boundless.FeatureTable.prototype.addRow = function(evt) {
  var feature = evt.feature, key;
  var row = '<tr>';
  if (this.showFid_ === true) {
    row += '<td class="fid">' + feature.getId() + '</td>';
  }
  for (var i=0, ii=this.fields_.length; i<ii; ++i) {
    var field = this.fields_[i];
    row += '<td>' + feature.get(field) + '</td>';
  }
  row += '</tr>';
  $('#' + this.id_).append(row);
};

Boundless.FeatureTable.prototype.handleRowClick = function(evt) {
  var me = evt.data;
  var fid = $(this).closest("tr").find(".fid").text();
  var feature = me.source_.forEachFeature(function(feature) {
    if (feature.getId() === fid) {
      return feature;
    }
  });
  me.select_.getFeatures().clear();
  me.select_._silent = true;
  me.select_.getFeatures().push(feature);
  delete me.select_._silent;
  var geomExtent = feature.getGeometry().getExtent();
  var extent = ol.extent.buffer(geomExtent, (ol.extent.getWidth(geomExtent)+ol.extent.getHeight(geomExtent))/2);
  me.map_.getView().getView2D().fitExtent(extent, me.map_.getSize());
  $(this).addClass('highlight').siblings().removeClass('highlight');
};

Boundless.FeatureTable.prototype.selectRow = function(evt) {
  if (this.select_._silent === true) {
    return;
  }
  var feature = evt.element;
  var fid = feature.getId();
  var me = this;
  $('#' + this.id_ + ' tr').each(function (i, row) {
    if ($(row).find(".fid").text() === fid) {
      $(row).addClass('highlight');
      var parentPos = $(row).parent().position();
      var rowpos =  $(row).position();
      $('#' + me.container_).scrollTop(rowpos.top-parentPos.top+me.offset_);
      return false;
    }
  });
};

Boundless.FeatureTable.prototype.unselectRow = function(evt) {
  $('#' + this.id_ + ' tr').each(function (i, row) {
    if ($(row).hasClass('highlight')) {
      $(row).removeClass('highlight');
      return false;
    }
  });
};
