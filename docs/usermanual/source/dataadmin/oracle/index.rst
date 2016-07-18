.. _dataadmin.oracle:

Working with Oracle data
========================

Boundless Suite can read and publish data from an Oracle Spatial database. Any table that has a valid geometry column can be published as a layer in GeoServer.

.. todo:: Caveats?

.. todo:: System requirements? What versions of Oracle?

Installing Oracle support is the same with most :ref:`Boundless Suite Extensions <intro.extensions>` but with an important additional step required at the end.

The first task is to install the Boundless Suite extension. But because of licensing issues, **an additional file is required to be installed, and this must be done manually.** 


Installing Oracle support
-------------------------

Windows
~~~~~~~

#. The Oracle extension can be added to Boundless Suite by copying the contents of the :file:`oracle` extension folder (not the folder itself) to the GeoServer library directory. If GeoServer is installed at :file:`/opt/tomcat/webapps/geoserver`, the GeoServer library directory will be found at :file:`/opt/tomcat/webapps/geoserver/WEB-INF/lib`.

#. Next, copy the Oracle JDBC driver from your Oracle installation to the GeoServer library directory. This file, often named :file:`ojdbc##.jar`, can be found either on the installation media or by doing a search on the system that includes Oracle. To find the target, open the directory that contains your Boundless Suite installation.typically something like :file:`C:\\Program Files\\Boundless\\Suite\\`), navigate to :menuselection:`webapps --> geoserver --> WEB-INF --> lib`.

   .. figure:: img/oracle_jar.png

      Oracle JAR file copied to the correct location

#. After the file is copied, restart GeoServer. This can be done from the Start Menu by navigating to :menuselection:`All Programs --> Boundless Suite` and using the :guilabel:`Stop` and then :guilabel:`Start` shortcuts, or by restarting the :guilabel:`OpenGeo Jetty` service in the Windows :guilabel:`Services` dialog.

Ubuntu Linux
~~~~~~~~~~~~

#. The Oracle extension can be added to Boundless Suite by installing the ``geoserver-oracle`` package:

   .. code-block:: console

      apt-get install geoserver-oracle

   .. note:: This command will need to be run as root or with :command:`sudo`.

#. Next, copy the Oracle JDBC driver from your Oracle installation to the GeoServer library directory. This file, often named :file:`ojdbc##.jar`, can be found either on the installation media or by doing a search on the system that includes Oracle. The target in most installations will be :file:`/usr/share/opengeo/geoserver/WEB-INF/lib/`.

#. Restart the Tomcat service.

Red Hat Linux
~~~~~~~~~~~~~

#. The Oracle extension can be added to Boundless Suite by installing the ``geoserver-oracle`` package:

   .. code-block:: console

      yum install geoserver-oracle

   .. note:: This command will need to be run as root or with :command:`sudo`.

#. Next, copy the Oracle JDBC driver from your Oracle installation to the GeoServer library directory. This file, often named :file:`ojdbc##.jar`, can be found either on the installation media or by doing a search on the system that includes Oracle. The target in most installations will be :file:`/usr/share/opengeo/geoserver/WEB-INF/lib/`.

#. Restart the Tomcat service.

Application servers
~~~~~~~~~~~~~~~~~~~

#. The Oracle extension can be added to Boundless Suite by copying the contents of the :file:`oracle` extension folder (not the folder itself) to the GeoServer library directory. If GeoServer is installed at :file:`/opt/tomcat/webapps/geoserver`, the GeoServer library directory will be found at :file:`/opt/tomcat/webapps/geoserver/WEB-INF/lib`.

#. Next, copy the Oracle JDBC driver from your Oracle installation to the same directory. This file, often named :file:`ojdbc##.jar`, can be found either on the installation media or by doing a search on the system that includes Oracle.

#. Restart GeoServer or the application server.


Verifying installation
----------------------

To verify that the extension has been installed properly:

#. Log in to the GeoServer web interface.

#. Click :guilabel:`Stores` then :guilabel:`Add new store`.

#. In the list of :guilabel:`Vector data stores`, you should see *three* entries:

   * Oracle
   * Oracle (JNDI)
   * Oracle (OCI)

   .. figure:: img/oracle_stores.png

      Three ways to connect to an Oracle database

If you don't see all of these entries, the extension did not install completely. In most cases, it is the plain :guilabel:`Oracle` option that is desired.

.. note:: If you see entries named :guilabel:`Oracle NG`, they are the correct entries. The ``NG`` part can be ignored.

.. todo:: Add info about the different types of connections.

.. todo:: Add info about publishing a layer.

Caveats
-------

Oracle data will be assumed to be point geometries, so new layers will be styled accordingly. Data can be rendered as intended by changing the styling of the layer to use the correct geometry.
