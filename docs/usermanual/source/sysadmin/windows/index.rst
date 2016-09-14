.. _sysadmin.windows:

Administration on Windows
=========================

This document contains information about various tasks specific to Boundless Suite for Windows. 

.. |postgresql.conf| replace:: :file:`C:\\ProgramData\\Boundless\\OpenGeo\\pgsql\\9.3\\postgresql.conf`

.. todo:: Might want to make the PG version a global var.

Boundless services
------------------

Boundless Suite is comprised of two services:

#. **Tomcat** - This contains all the Boundless web applications such as GeoServer and GeoWebCache. The service can be started / stopped from the :command:`Tomcat Manger` application which can be found by :menuselection:`Start --> Configure Tomcat`.

#. **PostgreSQL** - The `PostgreSQL <http://www.postgresql.org/>`_ database server with the PostGIS spatial extensions.

   .. note:: The Boundless PostgreSQL service is only available through the :ref:`virtual machine <install.windows.vm>`.

Service port configuration
--------------------------

The Tomcat and PostgreSQL services run on ports **8080** and **5432** respectively. These ports can often conflict with existing services on the system, in which case the ports must be changed. 

Changing the Tomcat port
^^^^^^^^^^^^^^^^^^^^^^^^

The Tomcat port can be changed on installation.

To change the Tomcat port after installation:

#. Open the :file:`server.xml` file, typically located in your Tomcat :file:`conf` directory (such as :file:`C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat\\conf`).

#. Search for the following line::

    <Connector port="8080" protocol="HTTP/1.1"

#. Change the port value.

#. Save the file.

#. Restart Tomcat.

.. note:: Changing the port on the virtual machine is the same as with :ref:`Ubuntu <sysadmin.ubuntu>`.

Changing the PostgreSQL port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: The Boundless PostgreSQL service is only available through the :ref:`virtual machine <install.windows.vm>`. Changing the port is the same as with :ref:`Ubuntu <sysadmin.ubuntu>`.

.. _intro.installation.windows.postinstall.datadir:

GeoServer data directory
------------------------

The **GeoServer data directory** is the location on the file system where GeoServer stores all of its configuration, and (optionally) file-based data.

By default, this directory is located at :file:`C:\\ProgramData\\Boundless\\geoserver\\data`.

To point GeoServer to an alternate location:

#. Change the Tomcat Java Options to point at the new location. This can be done via the Tomcat Configuration application.

#. Restart the Tomcat service.
