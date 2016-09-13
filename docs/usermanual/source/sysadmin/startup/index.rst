.. _sysadmin.startup:

How to add startup parameters for GeoServer
===========================================

GeoServer allows global configuration settings to be provided as Java system properties for use during the startup process. Java system properties can be supplied on the command line using ``-D`` (and are of the form ``-Dproperty=value`` or ``-D property=value``).

This section shows how to set the Java system properties used during startup.

Jetty
-----

.. warning:: We do **not** recommend using Jetty for a production deployment.

Startup flags are all contained in a file called :file:`start.ini`.

On Windows, this file is contained in :file:`jetty\\start.ini` inside the root of the installation directory. For example, :file:`C:\\Program Files\\Boundless\\OpenGeo\\jetty\\start.ini`.

.. figure:: img/startini.png

   A sample start.ini file

This file contains a mix of JVM parameters (such as memory settings) and system properties. There is a section titled :guilabel:`other geoserver options` where startup options can go, but the specific order is not important. Each option must be on its own line.

For example, to revert to the legacy handling of CRS values in GeoJSON WFS output:

#. Open :file:`start.ini` in a text editor. (You will need to open it with administrator privileges.)

#. Add the following line::

    -DGEOSERVER_GEOJSON_LEGACY_CRS=true

#. Save and close the file.

#. Restart GeoServer.

Tomcat
------

.. note:: You can view java options (:guilabel:`system-properties`) and environment variables (:guilabel:`system-environment`) on the `GeoServer Detailed Status Page <http://localhost:8080/geoserver/rest/about/status>`__.


Linux (via the Boundless Suite Packages)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To set Java Options, create a file in the :file:`/usr/share/tomcat8/conf/suite-opts` directory.  

For example, to revert to the legacy handling of CRS values in GeoJSON WFS output:

    #. Create the file :file:`legacyCRS` in :file:`/usr/share/tomcat8/conf/suite-opts`
    #. In the file, put :guilabel:`-DGEOSERVER_GEOJSON_LEGACY_CRS=true`
    #. Restart tomcat with :guilabel:`service tomcat8 restart`


Windows (via the Tomcat8 Configuration Manager)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To set Java Options, use the Windows Tomcat8 Configuration Manager (:ref:`install.windows.tomcat`), :guilabel:`Java` Tab, :guilabel:`Java Options` section.  

For example, to revert to the legacy handling of CRS values in GeoJSON WFS output:

    #. Open the Windows Tomcat8 Configuration Manager and go to the :guilabel:`Java` Tab

    #. In the :guilabel:`Java Options` add :guilabel:`-DGEOSERVER_GEOJSON_LEGACY_CRS=true`, then press :guilabel:`Apply`

         .. image:: /sysadmin/startup/img/win_tomcat_add_java_opt.png

    #. Stop and Start Tomcat (:guilabel:`General` Tab)

