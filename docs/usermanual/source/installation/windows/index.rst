.. _installation.windows:

Installing OpenGeo Suite for Windows
====================================

.. |pgupgrade_url| replace:: http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.1.zip

This document describes how to install OpenGeo Suite for Windows.

Prerequisites
-------------

OpenGeo Suite has the following system requirements:

* **Operating System**: Vista, 7, 8, (each 32 and 64 bit), Server 2003 or newer, XP (Client Tools and Dev Tools only) 
* **Memory**: 1GB minimum (2GB recommended)
* **Disk space**: 600MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported
* **Permissions**: Administrative rights

Installation options
--------------------

OpenGeo Suite is a collection of software components. While it is possible to install the entire collection on a single machine for testing purposes, we suggest that you install server tools on one machine and client tools on another. You will have the option of choosing which components you wish during the installation process.

By default only the server tools will be installed.


.. _installation.windows.new:

New Installation
----------------

.. warning:: If upgrading from version 2.x, please see the section on :ref:`installation.windows.upgrade.fromv2`.

#. Double-click the :file:`OpenGeoSuite.exe` file.

#. At the **Welcome** screen, click :guilabel:`Next`.

   .. figure:: img/welcome.png

      Welcome screen

#. Read the **License Agreement** then click :guilabel:`I Agree`.

   .. figure:: img/license.png

      License Agreement

#. Select the **Destination folder** where you would like to install OpenGeo Suite, and click :guilabel:`Next`.

   .. figure:: img/directory.png

      Destination folder for the installation

#. Select the name and location of the **Start Menu folder** to be created, and click :guilabel:`Next`.

   .. figure:: img/startmenu.png

      Start Menu folder to be created

#. Next select the components you wish to install. The following is a list of the components available to install:

   .. list-table::
      :header-rows: 1
      :stub-columns: 1

      * - Component
        - Sub-component
        - Description
        - Default
      * - PostGIS
        - 
        - Spatial database
        - Yes
      * - PostGIS
        - PointCloud 
        - PostGIS extension that allows for Lidar types
        -
      * - GeoServer
        -
        - Map and feature server
        - Yes
      * - GeoServer
        - Mapmeter
        - GeoServer extension for connecting to Mapmeter monitoring service (see mapmeter.com)
        - 
      * - GeoServer
        - CSS Styling
        - GeoServer extension for styling maps with CSS support
        - 
      * - GeoServer
        - WPS
        - GeoServer extension for Web Processing Service (WPS) support
        - 
      * - GeoServer
        - CSW
        - GeoServer extension for Catalogue Service for Web (CSW) support
        - 
      * - GeoServer
        - Clustering
        - GeoServer extension for adding clustering support
        - 
      * - GeoWebCache
        - 
        - Tile cache server
        - Yes
      * - GeoExplorer
        -
        - Map viewing and editing utility
        - Yes
      * - Client Tools
        - PostGIS
        - Tools for managing PostGIS databases
        - 
      * - Client Tools
        - pgAdmin
        - Graphical PostGIS database manager
        - 
      * - Client Tools
        - GDAL/OGR
        - Spatial data manipulation library
        - 
      * - Dev Tools
        - Webapp SDK
        - Toolkit for building web map applications
        - 
      * - Client Tools
        - GeoScript
        - Scripting extension for GeoServer
        - 
        
   Select the components you wish to install, and click :guilabel:`Next`.

   .. figure:: img/components.png

      Component selection

#. Click :guilabel:`Install` to perform the installation.

   .. figure:: img/ready.png

      Ready to install

#. Please wait while the installation proceeds.

   .. figure:: img/install.png

      Installation

#. After installation, click :guilabel:`Finish`.

   .. figure:: img/finish.png

      OpenGeo Suite successfully installed

.. todo:: Information about the Dashboard and post-install steps will go here.

For more information, please see the **User Manual**.


.. _installation.windows.upgrade:

Upgrading
---------

Minor version upgrades of OpenGeo Suite can be installed on top of previous versions and all previous data and configuration is preserved. Major upgrades however may not preserve data and configuration and require more steps as outlined in the following sections.


.. _installation.windows.upgrade.fromv2:

Upgrading from version 2.x
~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenGeo Suite version 2 contains an older version of many major components. This upgrade is also **not-backward compatible**; irreversible changes are made to the data so that they can't be used with earlier versions of OpenGeo Suite.

In addition, the upgrade process will reinitialize the PostGIS database, removing all PostGIS data. Therefore, it is required to follow the upgrade steps below to ensure that your data is retained.

.. warning:: Upgrading from 2.x will delete all of your PostGIS data. You will need to backup your data according to the specific procedures listed below. This procedure is different from the usual backup process.

The procedure for upgrading is as follows:

#. Ensure the old (2.x) version of OpenGeo Suite is running.
 
#. Make sure that your PostgreSQL ``bin`` directory is on your path. By default, this is :file:`C:\\Program Files\\OpenGeo\\OpenGeo Suite\\pgsql\\8.4\\bin` though your installation may vary. To test that this is set up correctly, open a Command Prompt and type ``psql --version``. If you receive an error, type the following to temporarily add the above directory to your path:

   .. code-block:: console

      set PATH=%PATH%;C:\Program Files\OpenGeo\OpenGeo Suite\pgsql\8.4\bin

#. Download the archive available at |pgupgrade_url| and extract it to a temporary directory. To avoid permissions issues, it is best to put this directory on your desktop or in your home directory. By default, the backup files created from using this script will be saved into this directory.

#. Run the backup command:

   .. code-block:: console

      postgis_upgrade.exe backup --port 54321 

   .. note:: You can use standard PostGIS command line flags such as ``--host``, ``--port`` and ``--username`` if you have customized your installation. You can also select only certain databases to backup by using the ``--dblist`` flag followed by a list of databases:  ``--dblist db1 db2 db3``. Full syntax is available by running with ``--help``.

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles

#. The PostGIS data backup process is complete. You may now shut down OpenGeo Suite 2.x.

#. Back up your GeoServer data directory. This directory is located by default in :file:`<user_home_directory>\\.opengeo\\data_dir`. To back up this directory, copy it to :file:`<user_home_directory>\\.opengeo\\data_dir_old`.

#. Uninstall OpenGeo Suite 2.x. (See :ref:`installation.windows.uninstall` below.)

#. The uninstallation will not remove the existing PostGIS data store, so that will need to be done manually. This directory is typically at :file:`<user_home_directory>\\.opengeo\\pgdata\\`. Remove (or rename) this directory.

#. Install the new version of OpenGeo Suite. (See :ref:`installation.windows.new` above.)

#. After installation is complete, start the newly-upgraded OpenGeo Suite.

#. As before, you will need to add the new PostGIS commands to your path once again. From a command prompt, type the following to temporarily add the new directory to your path (substituting the correct path if your installation was in a different location):

   .. code-block:: console

      set PATH=%PATH%;C:\Program Files\OpenGeo\OpenGeo Suite\pgsql\9.1\bin

#. Restore your PostGIS data by running the script again:

   .. code-block:: console

      postgis_upgrade.exe restore --port 54321

   .. note:: As with the backup, standard PostGIS connection parameters may be used. You can also select only certain databases to restore with the ``--dblist`` flag as detailed above.

#. Your databases and roles will be restored. You can verify that the databases were created and data restored by running ``psql -l --port 54321`` on the command line.

#. Stop OpenGeo Suite.

#. Restore the GeoServer data directory. Rename the existing :file:`<user_home_directory>\\.opengeo\\data_dir` to :file:`<user_home_directory>\\.opengeo\\data_dir_30` and rename the backed-up data directory :file:`<user_home_directory>\\.opengeo\\data_dir_old` to :file:`<user_home_directory>\\.opengeo\\data_dir`.

#. Start OpenGeo Suite.

.. note::

   Memory requirements for OpenGeo Suite have increased since version 2, which requires modification to the Tomcat Java configuration. These settings are not automatically updated on upgrade and must be set manually. 

   To make the change, open the file :file:`C:\\Program Files\\OpenGeo\\OpenGeo Suite\\opengeo-suite.bat` in a text editor and append ``-XX:MaxPermSize=256m`` to the end of the line that starts with ``set VMOPTS=...``. Restart OpenGeo Suite for the change to take effect.


.. _installation.windows.uninstall:

Uninstallation
--------------

Before proceeding with uninstallation, please make sure that all applications are closed OpenGeo Suite services are all stopped. To stop all OpenGeo services, navigate in your Start Menu to :menuselection:`Administrative Tools --> Services`. Select the **OpenGeo Jetty** and **OpenGeo PostgreSQL** services, and select :menuselection:`Action --> Stop Service`.

#. Navigate to :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Uninstall`.

   .. note:: Uninstallation is also available via the standard Windows program removal workflow. (**Add/Remove Programs** for Windows XP, **Programs and Features** for Windows Vista, 7, etc.)

#. Click :guilabel:`Uninstall` to start the uninstallation process.

   .. figure:: img/uninstall.png

      Ready to uninstall OpenGeo Suite

#. Uninstalling will not delete your settings and data. Should you wish to delete this, you will need to do it manually. The uninstallation process will display the location of your settings directory.

   .. figure:: img/undatadir.png

      Location of data and settings

#. The uninstallation will proceed.

   .. figure:: img/uninstalling.png

      Uninstalling OpenGeo Suite

#. When finished, click :guilabel:`Close`.


For more information
--------------------

Please see the documentation included with this software.

