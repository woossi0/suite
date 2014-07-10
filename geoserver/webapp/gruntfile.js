var fs = require('fs');
var path = require('path');
var url = require('url');

var config = {
    proxy: {
        host: 'localhost',
        port: '8080'
    }
};

var sources = {
    js: ['app/**/*.js', '!app/**/*.spec.js', '!app/loader.js'],
    less: 'app/**/*.less',
    test: 'app/**/*.spec.js',
    tpl: 'app/**/*.tpl.html'
};

var dependencies = [
    'bower_components/jquery/dist/jquery.min.js',
    'bower_components/angular/angular.js',
    'bower_components/angular-route/angular-route.js',
    'bower_components/angular-resource/angular-resource.js',
    'bower_components/angular-ui-bootstrap/build/angular-ui.min.js',
    'bower_components/angular-bootstrap/ui-bootstrap.js',
    'bower_components/angular-bootstrap/ui-bootstrap-tpls.js',
    'vendor/angular-strap/dimensions.min.js',
    'vendor/angular-strap/tooltip.js',
    'vendor/angular-strap/tooltip.tpl.js'
].map(function(dep) {
    return dep;
});

module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('./package.json'),
        connect: {
          server: {
            options: {
                port: 8000,
                base: [
                    path.join(__dirname, 'build'),
                    path.join(__dirname, 'app'),
                   __dirname
                ],
                livereload: true,
                middleware: function(connect, options) {
                    var middlewares = [];

                    // proxy
                    middlewares.push(require('grunt-connect-proxy/lib/utils').proxyRequest);

                    // debug script loader
                    middlewares.push(function(req, res, next) {
                      var parts = url.parse(req.url);
                      var loaderUrl = '/geoserver.min.js';
                      if (parts.pathname.substr(-loaderUrl.length) === loaderUrl) {
                        var template = path.join(__dirname, 'app', 'loader.js');
                        fs.readFile(template, 'utf8', function(err, string) {
                          if (err) {
                            return next(err);
                          }
                          var scripts = grunt.file.expand(dependencies.concat(sources.js))
                              .map(function(script) {
                                return '/' + script.split(path.sep).join('/');
                              });
                          res.setHeader('content-type', 'application/javascript');
                          var body = string.replace('{{{ paths }}}', JSON.stringify(scripts));
                          res.end(body, 'utf8');
                        });
                      } else {
                        next();
                      }
                    });

                    // static files.
                    options.base.forEach(function(base) {
                      middlewares.push(connect.static(base));
                    });

                    // directory browsable
                    var directory = options.directory || options.base[options.base.length - 1];
                    middlewares.push(connect.directory(directory));

                    return middlewares;
                }
            },
            proxies: [{
                context: '/geoserver/',
                host: config.proxy.host,
                port: config.proxy.port
            }]
          }
        },
        jshint: {
          options: {
            jshintrc: true
          },
          js: sources.js,
          test: sources.tests
        },
        less: {
          build: {
            cleancss: true,
            files: {
              'build/geoserver.css': [sources.less]
            }
          }
        },
        copy: {
          index: {
            expand: true,
            cwd: 'app/',
            src: 'index.html',
            dest: 'build/'
          }
        },
        ngmin: {
          dist: {
            src: sources.js,
            dest: 'build/geoserver.js'
          }
        },
        html2js: {
          all: {
            options: {
              rename: function(relativePath) {
                return '/app/' + relativePath;
              },
              module: 'gsApp.templates',
            },
            src: sources.tpl,
            dest: 'build/templates.js'
          }
        },
        uglify: {
           dist: {
             files: {
                'build/geoserver.min.js': dependencies.concat('build/geoserver.js', 'build/templates.js')
             }
           }
        },
        watch: {
          less: {
            files: sources.less,
            tasks: ['less'],
            options: {
              livereload: true
            }
          },
          js: {
            files: sources.js,
            //tasks: ['jshint:src', 'karma:dev:run'],
            tasks: ['jshint:js'],
            options: {
              livereload: true
            }
          },
          tpl: {
            files: sources.tpl,
            tasks: ['html2js:all']
          },
          test: {
            files: sources.test,
            //tasks: ['jshint:spec', 'karma:dev:run']
          }
        },
        clean: {
          build: {
            src: 'build/'
          }
        }
    });

    // plugins
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-connect-proxy');
    grunt.loadNpmTasks('grunt-ngmin');
    grunt.loadNpmTasks('grunt-html2js');

    // tasks
    grunt.registerTask('build', [
      'less', 'copy', 'ngmin', 'html2js', 'uglify']);
    grunt.registerTask('start', [
      'less', 'configureProxies:server','connect', 'watch']);
};
