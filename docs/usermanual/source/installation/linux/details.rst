.. _installation.linux.suite.details:

Installation details
====================

This section discusses some helpful information about OpenGeo Suite Linux packages, as well as how to access the various components after installation.

Starting/Stopping OpenGeo Suite
-------------------------------

GeoServer, GeoExplorer, and all other web-based containers including the documentation are installed into the existing Tomcat instance on the machine. Starting and stopping these applications are therefore accomplished by managing them through the standard Tomcat instance. Tomcat is installed as a service under the name of :command:`tomcat6` (or possibly :command:`tomcat5`, depending on your system), and can be managed accordingly:

.. code-block:: bash

   service tomcat6 start
   service tomcat6 stop


PostGIS is also installed as a service, under the name of :command:`postgresql`, and can be managed in the same way as Tomcat:

.. code-block:: bash

   service postgresql start
   service postgresql stop

Both services are started and set to run automatically when OpenGeo Suite is installed.

Accessing web applications
--------------------------

The easiest way to launch the web-based applications contained in OpenGeo Suite is via the Dashboard. All web applications are linked from this application. The Dashboard is accessible via the following URL::

  http://localhost:8080/dashboard/

.. note:: You will need to change the port number if your Tomcat installation is serving on a different port.

.. list-table::
   :widths: 30 70
   :header-rows: 1

   * - Application
     - URL
   * - OpenGeo Suite Dashboard
     - http://localhost:8080/dashboard/
   * - GeoServer
     - http://localhost:8080/geoserver/
   * - GeoExplorer
     - http://localhost:8080/geoexplorer/
   * - OpenGeo Suite Documentation
     - http://localhost:8080/opengeo-docs/

Accessing PostGIS
-----------------

You can access PostGIS in one of two ways: via the command line will the :command:`psql` application, or via a graphical interface with the :command:`pgadmin3` application. Both commands should be on the path and can be invoked from any Terminal window. If unfamiliar with PostGIS, start with :command:`pgadmin3`.

This version of PostGIS is running on port 5432, with administrator user name and password **opengeo** / **opengeo**.

System requirements
-------------------

OpenGeo Suite has the following system requirements:

* Operating System: Ubuntu 10.04 or higher, CentOS 5 or higher
* Memory: 512MB minimum (1GB recommended)
* Disk space: 750MB minimum (plus extra space for any loaded data)
* Browser: Any modern web browser is supported
* Permissions: Super user privileges are required for installation
