.. _intro.installation.war:

OpenGeo Suite for Application Servers
=====================================

In addition to being available through installers and packages, OpenGeo Suite components are available as Web Applications for use with an Application server. Web Applications are distributed as operating system independent web application archives (WAR).

.. toctree::
   :maxdepth: 1

   install
   update
   upgrade
   uninstall
   extensions
   
This is the recommended method of install for systems that already have an application server in place. Rather than install a second Tomcat or Jetty container, it is desirable to deploy the applications on the existing infrastructure.

   
.. note::

   The individual applications shipped as part of the WAR bundle are:

   * GeoServer
   * GeoExplorer
   * GeoWebCache
   * Dashboard

   Additional downloads for use use in an application server:

   * opengeo-docs.zip
   * opengeo-extensions.zip
   
   As PostGIS is not a web application, it is not included in this bundle. If you want to use PostGIS as part of your OpenGeo Suite installation, you should use the packages available for your operating system, and install only the PostGIS component.

   QGIS is also not included. Boundless has installers for :ref:`Windows <intro.installation.windows.qgis>` and :ref:`OS X <intro.installation.mac.qgis>`. To use QGIS with Linux, please see the `QGIS community installation instructions <https://www.qgis.org/en/site/forusers/download.html>`_.



