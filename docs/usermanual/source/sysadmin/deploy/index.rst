.. _sysadmin.deploy:

Application Server
==================

In addition to being available through packages, Boundless Suite web applications are available individually for use in a custom deployment or on your own application server.

The main benefit of using individual application server bundle is its flexibility. This section will cover installation requirements needed for each application, and explore some common deployment scenarios.

The following check lists for each application can be used as a during installation. For more detailed step-by-step installation instructions review the "Tomcat Installation" :ref:`installation instructions for each platform <intro.installation>`.

.. toctree::
   :maxdepth: 1

   strategies
   geoserver
   gwc
   composer
   dashboard
   quickview
   wps
   docs

.. note: Each individual web application is distributed as a web archives (WAR files), the applications shipped as part of the WAR bundle are:

   * GeoServer
   * GeoWebCache
   * QuickView
   * Dashboard
   * Documentation

   An additional *extensions download* is provided containing GeoServer extensions, some of which can tage advantage of native binaries if available.