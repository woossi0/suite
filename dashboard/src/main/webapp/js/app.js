// In case of static HTML, serve static info:
var SUITE_VERSION = 4.1;
var RELEASE_DATE = "June 19, 2014";

function onLoad() {
  var active_tab = $('#home');
  var previous_link;

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
        default:
          active_tab = $('#home');
          break;
      }
      active_tab.show();
      $(this).addClass("active");

      // highlight clicked link
      if (previous_link) {
        previous_link.removeClass("active");
      }
      previous_link = $(this);
    });
  }

  setUpTabs('#gslink');
  setUpTabs('.homelink');
  setUpTabs('.aboutlink');

  // Add version info to all version spans
  var proj_version = $('#version').html();
  if (proj_version == "${project.version}") {
    proj_version = SUITE_VERSION;
    $('#version').html("");
  }
  $('.version').html(proj_version);

  // Add version to all docs links
/*
  var docs_version = "docs/" + proj_version + "/";
  $('.docs').each(function( index ) {
      var component = $(this).attr("component");
      var path = this.href.split("#")[1];
      this.href = docs_version + path;
       this.target = '_blank';
    });
<<<<<<< HEAD
*/

  // Remove non-static info
  if ($('.commit').html() == " (${git.commit.id.abbrev})") {
    $('.commit').hide();
  }
  if ($('.date').html() == " built on ${build.prettydate}") {
    $('.date').hide();
  }
  $('.release_date').html(RELEASE_DATE);

}
