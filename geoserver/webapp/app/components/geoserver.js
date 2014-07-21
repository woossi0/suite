angular.module('gsApp.service', ['ngResource', 'ngSanitize'])
.factory('GeoServer', ['$http', '$resource',
      function($http, $resource) {
        var apiRestRoot = '/geoserver/rest/';
        var apiRoot = '/geoserver/';

        return {
          apiRestRoot: function() {
            return apiRestRoot;
          },
           apiRoot: function() {
            return apiRoot;
          },
          workspaces: $resource(apiRestRoot + 'workspaces.json', {}, {
            get: {
              method: 'GET',
              isArray: true,
              transformResponse: function(data, header) {
                var response = angular.fromJson(data);
                return response.workspaces.workspace;
              }
            }
          }),
          layers: $resource(apiRestRoot + 'layers.json', {}, {
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
          layer: $resource(apiRestRoot + 'layers/:layer.json',
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
              }),
          capabilities: $resource(apiRoot + ':workspace/ows',
              {workspace: '@workspace'}, {
                get: {
                  method: 'GET',
                  params: {
                    'SERVICE': 'WFS',
                    'REQUEST': 'GetCapabilities'
                  },
                  isArray: false,
                  responseType: 'xml',
                  transformResponse: function(data, header) {
                    var x2js = new X2JS();
                    var json = x2js.xml_str2json(data);
                    return json.WFS_Capabilities;
                  }
                }
              })
        };
      }]);
