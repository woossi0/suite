.. _sysadmin.mac:

Administration on Mac OS X
==========================

This document contains information about various tasks specific to Boundless Suite for Mac OS X. 

Boundless services
------------------

Boundless Suite is comprised of two services:

#. **Tomcat** - This contains all the Boundless web applications such as GeoServer and GeoWebCache. 

#. **PostgreSQL** - The `PostgreSQL <http://www.postgresql.org/>`_ database server with the PostGIS spatial extensions.

   .. note:: The Boundless PostgreSQL service is only available through the :ref:`virtual machine <install.mac.vm>`.

Service port configuration
--------------------------

The Tomcat and PostgreSQL services run on ports **8080** and **5432** respectively. These ports can often conflict with existing services on the system, in which case the ports must be changed.

Changing the Tomcat port
^^^^^^^^^^^^^^^^^^^^^^^^

The Tomcat port can be changed on installation.

To change the Tomcat port after installation:

#. Open the :file:`server.xml` file, typically located in your Tomcat :file:`conf` directory.

#. Search for the following line::

    <Connector port="8080" protocol="HTTP/1.1"

#. Change the port value.

#. Save the file.

#. Restart Tomcat.

.. note:: Changing the port on the virtual machine is the same as with :ref:`Ubuntu <sysadmin.ubuntu>`.

Changing the PostgreSQL port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: The Boundless PostgreSQL service is only available through the :ref:`virtual machine <install.mac.vm>`. Changing the port is the same as with :ref:`Ubuntu <sysadmin.ubuntu>`.

GeoServer data directory
------------------------

The **GeoServer data directory** is the location on the file system where GeoServer stores all of its configuration, and (optionally) file-based data.

By default, this directory is located at :file:`~/Library/Application Support/GeoServer`.

To point GeoServer to an alternate location:

#. Edit the :file:`geoserver.xml` file inside your Tomcat configuration.

   Define ``GEOSERVER_DATA_DIR`` with an appropriate value accordingly.
   
   .. code-block:: xml
      
      <Parameter name="GEOSERVER_DATA_DIR" 
        value="/var/opt/boundless/suite/geoserver/data" override="false"/>

