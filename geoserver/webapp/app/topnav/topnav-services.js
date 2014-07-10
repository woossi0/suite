angular.module('gsApp.topnav.services', [])
  .factory('topNavService', function() {
      return {
        fetchUser: function() {
          return 'Joe Schmoe!';
        }
      };
    });
