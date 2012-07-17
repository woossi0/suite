.. _installation.osx:

Installing the OpenGeo Suite for Mac OS X
=========================================

This document will discuss how to install the OpenGeo Suite for Mac OS X.

Prerequisites
-------------

The OpenGeo Suite has the following system requirements:

* **Operating System**: 10.5 Leopard, 10.6 Snow Leopard
* **Memory**: 1GB minimum (higher recommended)
* **Disk space**: 600MB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported
* **Permissions**: Administrative rights

.. _installation.osx.new:

New Installation
----------------

.. note:: If you are upgrading from a previous version, jump to the section entitled :ref:`installation.osx.upgrade`.

#. Double click to mount the :file:`OpenGeoSuite.dmg` file.  Inside the mounted image, double click on :file:`OpenGeo Suite.mpkg`

#. At the **Welcome** screen, click :guilabel:`Continue`.

    .. figure:: img/welcome.png
       :align: center

       *Welcome screen*

#. Read the **License Agreement**. To agree to the license, click :guilabel:`Continue` and then :guilabel:`Agree`.

      .. figure:: img/license.png
         :align: center

         *License Agreement*

#. To install the OpenGeo Suite on your hard drive click :guilabel:`Next`.  You will be prompted for your administrator password.  

    .. figure:: img/directory.png
       :align: center

       *Destination selection*

#. When ready to install, click :guilabel:`Install`.

    .. figure:: img/ready.png
       :align: center

       *Ready to Install*

#. Please wait while the installation proceeds.

    .. figure:: img/install.png
       :align: center

       *Installation*
      
#. You will receive confirmation that the installation was successful.  

    .. figure:: img/success.png
       :align: center

       *The OpenGeo Suite successfully installed*

After installation, the OpenGeo Dashboard will automatically start, allowing you to manage and launch the OpenGeo Suite.

For more information, please see the **User Manual**, which is available from the Dashboard.

.. note:: The OpenGeo Suite must be online in order to view documentation from the Dashboard.  If you would like to view the documentation when the Suite is offline, please paste the following link into your browser:

   .. code-block:: console

      file:///opt/opengeo/suite/webapps/opengeo-docs/usermanual/index.html

.. _installation.osx.upgrade:

Upgrading
---------

Minor version upgrades of the OpenGeo Suite can be installed on top of previous versions and all previous data and configuration is preserved. Major upgrades however may not preserve data and configuration and require more steps as outlined in the following sections.

.. _installation.osx.upgrade.v3:

Upgrading from version 2.x to 3.x
---------------------------------

The OpenGeo Suite version 3 contains numerous major version updates to its components.  This upgrade is **not-backward compatible** and all previously installed versions must be uninstalled before continuing.

.. warning:: Uninstalling OpenGeo Suite 2.x will remove all your data and configuration therefore you will need to backup your data according to the specific procedures listed below.

The procedure for upgrading is as follows:

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
#. Make sure that your PostgreSQL ``bin`` directory is on your path.  By default, this is :file:`/opt/opengeo/pgsql/8.4/bin`, though your installation may vary.  To test that this is set up correctly, open a Command Prompt and type ``psql --version``.  If you receive an error, type the following to temporarily add the above directory to your path:

   .. code-block:: console

      export PATH=$PATH:/opt/opengeo/pgsql/8.4/bin

#. Download the archive available at http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.zip and extract it to a temporary directory.  To avoid permissions issues, it is best to put this directory on your desktop or in your home directory.  By default, the backup files created from using this script will be saved into this directory.

   .. code-block:: console
   
      cd ~
      mkdir -p suite_backup/pg_backup
      cd suite_backup/pg_backup
      curl -O http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.zip
      unzip postgis_upgrade.zip

#. Run the backup command:

   .. code-block:: console

      perl postgis_upgrade.pl backup --port 54321

   .. note:: You can use standard PostGIS command line flags such as ``--host``, ``--port`` and ``--username`` if you have customized your installation.  You can also select only certain databases to backup by using the ``--dblist`` flag followed by a list of databases:  ``--dblist db1 db2 db3``.  Full syntax is available by running with ``--help``.

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles

#. The PostGIS data backup process is complete. You may now shut down the OpenGeo Suite 2.x.

#. Back up your GeoServer data directory. This directory is located by default in :file:`/opt/opengeo/suite/data_dir`.  To back up this directory, you can create an archive of it, or simply move/copy it to another location.

   .. code-block:: console

      sudo mv /opt/opengeo/suite/data_dir ~/suite_backup/

#. Uninstall the OpenGeo Suite 2.x.  (See :ref:`installation.osx.uninstall` below.)

#. Install the OpenGeo Suite 3.x.  (See :ref:`installation.osx.new` above.)

   .. todo:: DETAILS AND SCREENSHOTS ABOUT THIS UPGRADE PROCESS NEEDED

#. After installation is complete.  Restore the GeoServer data directory to its original location.

   .. code-block:: console

      sudo rm -rf /opt/opengeo/suite/data_dir
      sudo mv  ~/suite_backup/data_dir /opt/opengeo/suite
      
   .. warning:: If instead of moving you copied the data directory in order to back it up you must restore group write permission to it after moving it back into place. This can be achieved with the command ``sudo chmod -R g+w /opt/opengeo/suite/data_dir``. 

#. Start the newly-upgraded OpenGeo Suite.

#. Restore your PostGIS data by running the script again:

   .. code-block:: console

      cd ~/suite_backup/pg_backup
      perl postgis_upgrade.pl restore --port 54321

   .. note:: As with the backup, standard PostGIS connection parameters may be used.  You can also select only certain databases to restore with the ``--dblist`` flag as detailed above.

#. Your databases and roles will be restored.  You can verify that the databases were created and data restored by running ``psql -l`` on the command line.

#. Restart the OpenGeo Suite.

   .. warning:: Due to data directory upgrades, we recommend against an in-place upgrade when upgrading from versions **prior to 2.4.2**. To get the latest version, please back up your data, uninstall, manually remove your data directory, then reinstall the new version. Your data directory is located here:  ``/opt/opengeo/suite/``  Please delete this directory before upgrading.

   You can upgrade from a previous version of the OpenGeo Suite, and your settings and data will be preserved.  To do this, follow the regular installation procedure, and if a previous version is detected, the software will be automatically upgraded.

.. _installation.osx.uninstall:

Uninstallation
--------------

.. warning:: All data and settings will be deleted during the uninstallation process.  If you wish to retain your data and settings, please make a backup of the directory :file:`~/.opengeo` before proceeding.

.. note:: Please make sure that the Dashboard is closed and the OpenGeo Suite is offline before starting the uninstallation.
  
To run the uninstaller, navigate to :menuselection:`Applications --> OpenGeo --> OpenGeo Suite Uninstaller`.  You can also uninstall the OpenGeo Suite from the Terminal by typing the following.

  .. code-block:: console
       
     open /Applications/OpenGeo/OpenGeo\ Suite\ Uninstaller.app/

For More Information
--------------------

Please visit http://opengeo.org or see the documentation included with this software.
