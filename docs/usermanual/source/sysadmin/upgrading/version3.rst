.. _sysadmin.upgrading.v3:

Upgrading from version 2.x to 3.x
=================================

.. warning::

   Note to all OpenGeo testers.  This page is going away soon.

   * Windows upgrade guide is now at :ref:`installation.windows.v3`.
   * Mac OS X upgrade guide is now at :ref:`installation.osx.v3`.
   * Ubuntu upgrade guide isn't broken out yet, but when it is it will be near :ref:`installation.linux.suite`.
   * CentOS upgrade guide isn't broken out yet, but when it is it will be near :ref:`installation.linux.suite`.

The OpenGeo Suite version 3 contains numerous major version updates to its components.  This upgrade is also **not-backward compatible**; irreversible changes are made to the data so that they can't be used with earlier versions of the OpenGeo Suite.

For GeoServer, it is strongly recommended to :ref:`back up your existing data directory <sysadmin.backup.geoserver>` before continuing.

In addition, the upgrade process to 3.x will reinitialize the PostGIS database, removing all PostGIS data.  Therefore, it is required to follow the upgrade steps below to ensure that your data is retained.

.. warning:: Upgrading from 2.x to 3.x will delete all of your PostGIS data.  You will need to backup your data according to the specific procedures listed below.  This procedure is different from the usual backup process.

The procedure for upgrading your PostGIS data is as follows:

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
#. Make sure that your PostgreSQL ``bin`` directory is on your path.  In particular, the following utilities will be required:

   * :file:`psql`
   * :file:`pg_dump`
   * :file:`pg_dumpall`
   * :file:`pg_restore`
   * :file:`createdb`

#. Download `this archive <http://LINKNEEDED.com>`_ and extract it to a temporary directory.

   .. note:: For the time being, file is available at https://github.com/opengeo/suite/blob/dev/installer/common/pgupgrade/postgis_upgrade.pl .

   .. todo:: DOWNLOAD LINKS NEEDED.

#. *(Linux / OS X only)*  Copy the :file:`postgis_restore.pl` file from your PostGIS installation to this same directory.  The :file:`postgis_restore.pl` script can be found in the ``utils`` directory of the PostGIS install.

   .. todo:: MAYBE WE SHOULD BUNDLE postgis_restore.pl INSTEAD

#. Create a new directory for backup files if desired.

#. Run the following command, substituting in the correct backup location.  Make sure the script has write access to this location (by using ``sudo`` or the ``Administrator`` prompt if necessary):

   **Linux / OS X:**

   .. code-block:: console

      perl postgis_upgrade.pl backup -o path/to/backup/

   **Windows:**

   .. code-block:: console

      postgis_upgrade.exe backup -o C:\path\to\backup\

   .. note:: You can use standard postgis flags, such as ``--host``, ``--port`` and ``--username``.  You can also select only certain databases to backup by using the ``-s`` flag followed by a list of databases:  ``-s db1 db2 db3``.  Full syntax is available by running with ``--help``.

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles (:file:`roles.sql`)

#. The PostGIS data backup process is complete.  You may now shut down the OpenGeo Suite 2.x.

#. Back up your GeoServer data directory and any other files as described in the :ref:`sysadmin.backup` section.

#. Install the OpenGeo Suite 3.x.

   .. todo:: DETAILS ABOUT THIS UPGRADE PROCESS

#. After installation is complete.  Restore the GeoServer data directory to its original location.

#. Start the newly-upgraded OpenGeo Suite.

#. Restore your PostGIS data by running the script again:

   **Linux / OS X:**

   .. code-block:: console

      perl postgis_upgrade.pl restore -o path/to/backup/

   **Windows:**

   .. code-block:: console

      postgis_upgrade.exe restore -o C:\path\to\backup\

   .. note:: As with the backup, standard PostGIS connection parameters may be used.  You can also select only certain databases to restore with the ``-s`` flag as detailed above.

#. Your databases and roles will be restored.  You can verify that the databases were created and data restored by running ``psql -l`` on the command line.

