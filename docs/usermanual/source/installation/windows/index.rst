.. _installation.windows:

Installing the OpenGeo Suite for Windows
========================================

This document will discuss how to install the OpenGeo Suite for Windows.

Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: Windows XP, Windows Vista, Windows 7 (each 32 and 64 bit)
* **Memory**: 512MB minimum (1GB recommended)
* **Disk space**: 600MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported
* **Permissions**: Administrative rights

.. _installation.windows.new:

New Installation
----------------

.. warning:: If upgrading from version 2.x, please see the section on :ref:`installation.windows.upgrade.v3`.

#. Double-click the :file:`OpenGeoSuite.exe` file.

#. At the **Welcome** screen, click :guilabel:`Next`.

   .. figure:: img/welcome.png
      :align: center

      *Welcome screen*

#. Read the **License Agreement** then click :guilabel:`I Agree`.

   .. figure:: img/license.png
      :align: center

      *License Agreement*

#. Select the **Destination folder** where you would like to install the OpenGeo Suite, and click :guilabel:`Next`.

   .. figure:: img/directory.png
      :align: center

      *Destination folder for the installation*

#. Select the name and location of the **Start Menu folder** to be created, and click :guilabel:`Next`.

   .. figure:: img/startmenu.png
      :align: center

      *Start Menu folder to be created*

#. Select the components you wish to install, and click :guilabel:`Next`.

   .. figure:: img/components.png
      :align: center

      *Component selection*

   .. note::  All components will be installed by default except for MrSID support and the ArcSDE and Oracle Spatial extensions.  If enabling these extensions, certain additional files will need to be manually copied to the installation directory.  For the ArcSDE extension, the files :file:`jsde*.jar` and :file:`jpe*.jar` are required.  For Oracle, the file :file:`ojdbc*.jar` is required.  These file(s) must be copied to the following path :file:`<installation_folder>\\webapps\\geoserver\\WEB-INF\\lib`.  

#. Click :guilabel:`Install` to perform the installation.

   .. figure:: img/ready.png
      :align: center

      *Ready to install*

#. Please wait while the installation proceeds.

   .. figure:: img/install.png
      :align: center

      *Installation*

#. After installation, click :guilabel:`Finish` to launch the OpenGeo Suite Dashboard, from which you can start the OpenGeo Suite.  If you would like to start the OpenGeo Suite Dashboard at a later time, uncheck the box and then click :guilabel:`Finish`.

   .. figure:: img/finish.png
      :align: center

      *The OpenGeo Suite successfully installed*

For more information, please see the **User Manual**, which is available through the Dashboard, or in the Start Menu at :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Documentation --> User Manual`.

.. note:: The OpenGeo Suite must be online in order to view documentation from the Dashboard.  If you would like to view the documentation when the Suite is offline, please use the shortcuts in the Start Menu.



.. _installation.windows.upgrade:

Upgrading
---------

Minor version upgrades of the OpenGeo Suite can be installed on top of previous versions and all previous data and configuration is preserved. Major upgrades however may not preserve data and configuration and require more steps as outlined in the following sections.

.. _installation.windows.upgrade.v3:

Upgrading from version 2.x to 3.x
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OpenGeo Suite version 3 contains numerous major version updates to its components.  This upgrade is also **not-backward compatible**; irreversible changes are made to the data so that they can't be used with earlier versions of the OpenGeo Suite.

In addition, the upgrade process to 3.x will reinitialize the PostGIS database, removing all PostGIS data.  Therefore, it is required to follow the upgrade steps below to ensure that your data is retained.

.. warning:: Upgrading from 2.x to 3.x will delete all of your PostGIS data.  You will need to backup your data according to the specific procedures listed below.  This procedure is different from the usual backup process.

The procedure for upgrading is as follows:

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
#. Make sure that your PostgreSQL ``bin`` directory is on your path.  By default, this is :file:`C:\\Program Files\\OpenGeo\\OpenGeo Suite\\pgsql\\8.4\\bin` though your installation may vary.  To test that this is set up correctly, open a Command Prompt and type ``psql --version``.  If you receive an error, type the following to temporarily add the above directory to your path:

   .. code-block:: console

      set PATH=%PATH%;C:\Program Files\OpenGeo\OpenGeo Suite\pgsql\8.4\bin

#. Download the archive available at http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.zip and extract it to a temporary directory.  To avoid permissions issues, it is best to put this directory on your desktop or in your home directory.  By default, the backup files created from using this script will be saved into this directory.

#. Run the backup command:

   .. code-block:: console

      postgis_upgrade.exe backup --port 54321 

   .. note:: You can use standard PostGIS command line flags such as ``--host``, ``--port`` and ``--username`` if you have customized your installation.  You can also select only certain databases to backup by using the ``--dblist`` flag followed by a list of databases:  ``--dblist db1 db2 db3``.  Full syntax is available by running with ``--help``.

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles

#. The PostGIS data backup process is complete.  You may now shut down the OpenGeo Suite 2.x.

#. *Optional but recommended:*  Back up your GeoServer data directory.  This directory is located by default in :file:`<user_home_directory>\\.opengeo\\data_dir`.  To back up this directory, you can create an archive of it, or simply copy it to another location.

#. Uninstall the OpenGeo Suite 2.x.  (See :ref:`installation.windows.uninstall` below.)

#. The uninstallation will not remove the existing PostGIS data store, so that will need to be done manually.  This directory is typically at :file:`<user_home_directory>\\.opengeo\\pgdata\\`.  Remove (or rename) this directory.

#. Install the OpenGeo Suite 3.x.  (See :ref:`installation.windows.new` above.)

#. After installation is complete, start the newly-upgraded OpenGeo Suite.

#. As before, you will need to add the new PostGIS commands to your path once again.  From a command prompt, type the following to temporarily add the new directory to your path (substituting the correct path if your installation was in a different location):

   .. code-block:: console

      set PATH=%PATH%;C:\Program Files\OpenGeo\OpenGeo Suite\pgsql\9.1\bin

#. Restore your PostGIS data by running the script again:

   .. code-block:: console

      postgis_upgrade.exe restore --port 54321

   .. note:: As with the backup, standard PostGIS connection parameters may be used.  You can also select only certain databases to restore with the ``--dblist`` flag as detailed above.

#. Your databases and roles will be restored.  You can verify that the databases were created and data restored by running ``psql -l`` on the command line.


.. _installation.windows.uninstall:

Uninstallation
--------------

.. note:: Please make sure that the Dashboard is closed and the OpenGeo Suite is offline before starting the uninstallation.

#. Navigate to :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Uninstall`

   .. note:: Uninstallation is also available via the standard Windows program removal workflow.  (**Add/Remove Programs** for Windows XP, **Installed Programs** for Windows Vista, 7, etc.)

#. Click :guilabel:`Uninstall` to start the uninstallation process.

   .. figure:: img/uninstall.png
      :align: center

      *Ready to uninstall the OpenGeo Suite*

   .. note:: Uninstalling will not delete your settings and data.  Should you wish to delete this, you will need to do this manually.  The uninstallation process will display the location of your settings directory, typically :file:`<user_home_directory>\\.opengeo`.

#. When done, click :guilabel:`Close`.

   .. figure:: img/unfinish.png
      :align: center

      *The OpenGeo Suite is successfully uninstalled*


For More Information
--------------------

Please visit http://opengeo.org or see the documentation included with this software.
