if (!window.Boundless) {
  window.Boundless = {};
}
var Boundless = window.Boundless;

Boundless.WFSBBOXLoader = function(options) {
  this.url_ = options.url;
  this.featurePrefix_ = options.featurePrefix;
  this.featureType_ = options.featureType;
  this.srsName_ = options.srsName;
  this.outputFormat_ = 'application/json';
  this.callback_ = options.callback;
};

Boundless.WFSBBOXLoader.prototype.load = function(extent, resolution, projection) {
  var wfs = this.url_;
  var featureType = this.featurePrefix_ + ':' + this.featureType_;
  var outputFormat = this.outputFormat_;
  var url = wfs + 'service=WFS&' +
    'version=1.1.0&request=GetFeature&typename=' + featureType + '&' +
    'outputFormat=' + outputFormat + '&srsname='+this.srsName_+'&bbox=' +
    extent.join(',') +','+this.srsName_;
  var me = this;
  $.ajax({
    url: url,
    context: extent
  }).then(function(response) {
    me.callback_.call(this, response);
  });
};
