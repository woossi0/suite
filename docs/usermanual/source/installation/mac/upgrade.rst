.. _installation.mac.upgrade:

Upgrading OpenGeo Suite for Mac
===============================

This section describes how to upgrade from a previous **major** version of 
OpenGeo Suite. If performing a **minor** upgrade the steps in this section are 
unnecessary and you may proceed with a normal 
:ref:`install <installation.mac>`. 

.. warning:: This upgrade is **not-backward compatible**; none of your existing configuration and data will be migrated to the new installation and must be done so manually. 

Back up PostGIS databases
~~~~~~~~~~~~~~~~~~~~~~~~~

The first step of the upgrade process is to back up your existing PostGIS data. 

#. Ensure the old (3.x) version of OpenGeo Suite is running.
 
#. Open up a terminal and Make sure that the PostgreSQL ``bin`` directory is on your path. By default, this is located at :file:`/opt/opengeo/pgsql/9.1/bin`. Use the command ``psql --version`` to verify:

   .. code-block:: console
 
      export PATH=$PATH:/opt/opengeo/pgsql/9.1/bin
      psql --version 

#. To backup a PostGIS upgrade utility is used. `Download <http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-4.0.zip>`_  the archive and extract it to a temporary directory. By default, the backup files created from using this script will be saved into this same directory:

   .. code-block:: console

      mkdir -p opengeo_backup/pg_backup; cd opengeo_backup/pg_backup
      curl -O http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-4.0.zip
      unzip postgis_upgrade-4.0.zip

#. Run the backup command:

   .. code-block:: console

      perl postgis_upgrade.pl backup --port 54321 

   .. note:: For more information about supported options run ``perl postgis_upgrade.pl --help``. 

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles

#. The PostGIS data backup process is complete. You may now shut down OpenGeo Suite 3.x.

Install new Suite
~~~~~~~~~~~~~~~~~

You may now install the new version of OpenGeo Suite. See :ref:`installation.mac` for details. In order to run the PostGIS restore script you must :guilabel:`OpenGeo Client Tools` package.

Restore PostGIS databases
~~~~~~~~~~~~~~~~~~~~~~~~~

#. Ensure ``PostGIS.app`` is running.

#. Ensure the PostGIS/PostgreSQL command line tools are on the PATH. If you did not install the :guilabel:`OpenGeo Client Tools`` package in the previous section do so now. From a command prompt, type the command: 

    .. code-block:: console
 
       export PATH=/usr/local/opengeo/bin:$PATH

#. Restore your PostGIS data by running the upgrade utility again with the "restore" argument:

   .. code-block:: console

      cd opengeo_backup/pg_backup
      perl postgis_upgrade.pl restore 

#. Your databases and roles will be restored. You can verify that the databases were created and data restored by running ``psql -l`` on the command line.

Restore GeoServer data directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Stop ``GeoServer.app``. 

#. Restore the GeoServer data directory:

   .. code-block:: console

      cd ~/Libary/Application\ Support/GeoServer
      mv data_dir data_dir.old
      cp -R /opt/opengeo/suite/data_dir .

#. Restart ``GeoServer.app``. 


Uninstall old Suite
~~~~~~~~~~~~~~~~~~~

You may now uninstall the previous version of OpenGeo Suite. The uninstaller is located at :file:`/Applications/OpenGeo/OpenGeo Suite Uninstaller.app`. 