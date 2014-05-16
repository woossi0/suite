// In case of static HTML, serve static info:
var SUITE_VERSION = 4.1;

function onLoad() {
  var active_tab = $('#home');

  // set up link navigation
  function setUpTabs (tab_button) {
    $(tab_button).click(function(e) {
      e.preventDefault();
      active_tab.hide();

      switch (tab_button) {
        case '#gslink':
          active_tab = $('#gettingstarted');
          break;
        case '.homelink':
          active_tab = $('#home');
          break;
        case '.aboutlink':
          active_tab = $('#about');
          break;
        case '#documentationlink':
          active_tab = $('#documentation');
          break;
        default:
          active_tab = $('#home');
          break;
      }

      active_tab.show();
    });
  }

  setUpTabs('#gslink');
  setUpTabs('.homelink');
  setUpTabs('.aboutlink');
  setUpTabs('#documentationlink');

  // Add version info to all version spans
  var proj_version = $('#version').html();
  if (proj_version == "${project.version}") {
    proj_version = SUITE_VERSION;
    $('#version').html("");
  }
  $('.version').html(proj_version);

  // Add version to all docs links
  var docs_version = "docs/" + proj_version + "/";
  $('.docs').each(function( index ) {
      var component = $(this).attr("component");
      var path = this.href.split("#")[1];
      this.href = docs_version + path;
       this.target = '_blank';
    });

  // Remove non-static info
  if ($('.commit').html() == " (${git.commit.id.abbrev})") {
    $('.commit').html("");
  }
  if ($('.date').html() == " built on ${build.prettydate}.") {
    $('.date').html("");
  }

}
