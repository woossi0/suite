angular.module('gsApp.service', ['ngResource', 'ngSanitize'])
.factory('GeoServer', ['$http', '$resource',
      function($http, $resource) {
        var apiRoot = '/geoserver/rest';

        return {
          workspaces: $resource(apiRoot + '/workspaces.json', {}, {
            get: {
              method: 'GET',
              isArray: true,
              transformResponse: function(data, header) {
                var response = angular.fromJson(data);
                return response.workspaces.workspace;
              }
            }
          }),
          layers: $resource(apiRoot + '/layers.json', {}, {
            get: {
              method: 'GET',
              isArray: true,
              responseType: 'json',
              transformResponse: function(data, header) {
                var response = data;
                if (typeof response !== 'object') {
                  response = angular.fromJson(data);
                }
                response = angular.fromJson(data);
                return response.layers.layer;
              }
            }
          }),
          layer: $resource(apiRoot + '/layers/:layer.json',
              {layer: '@layer'}, {
                get: {
                  method: 'GET',
                  isArray: false,
                  responseType: 'json',
                  transformResponse: function(data, header) {
                    var response = data;
                    if (typeof response !== 'object') {
                      response = angular.fromJson(data);
                    }
                    return response.layer;
                  }
                }
              })
        };
      }]);
