
//Redirect to the relative path "suffix" within the geoserver user manual.
window.pathToGeoServerDocs = function(suffix) {
  var gsRoot = $(".gs_logo > a ").attr("href");
  gsRoot = gsRoot.replace("index.html", "");
  gsRoot = gsRoot.replace("#", "");

  gsRoot = gsRoot + suffix;

  window.location.href = gsRoot;
}