angular.module('gsApp.service', ['ngResource'])
  .factory('GeoServer', ['$resource', function($resource) {
    var headers = {'Content-Type': 'application/json'};
    return $resource('/geoserver/rest/:path', {}, {
        workspaces: {
            method: 'GET',
            params: {
                path: 'workspaces.json'
              },
              isArray: true,
              transformResponse: function(data, headersGetter) {
                var response = JSON.parse(data);
                return response.workspaces.workspace;
              },
              headers: headers
            }
          });
  }]);
