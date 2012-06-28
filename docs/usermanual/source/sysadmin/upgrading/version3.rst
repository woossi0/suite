.. _sysadmin.upgrading.v3:

Upgrading from version 2.x to 3.x
=================================

The OpenGeo Suite version 3 contains numerous major version updates to its components.  This upgrade is also **not-backward compatible**; irreversible changes are made to the data so that they can't be used with earlier versions of the OpenGeo Suite.

For GeoServer, it is strongly recommended to :ref:`back up your existing data directory <sysadmin.backup.geoserver>` before continuing.

In addition, the upgrade process to 3.x will reinitialize the PostGIS database, removing all PostGIS data**.  Therefore, it is required to follow the upgrade steps below to ensure that your data is retained.

.. warning:: Upgrading from 2.x to 3.x will delete all of your PostGIS data.  You will need to backup your data according to the specific procedures listed below.  This procedure is different from the usual backup process.

The procedure for upgrading your PostGIS data is as follows:

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
#. Make sure that your PostgreSQL ``bin`` directory is on your path.  In particular, the following utilities will be required:

   * :file:`psql`
   * :file:`pg_dump`
   * :file:`pg_dumpall`
   * :file:`pg_restore`
   * :file:`createdb`

#. Ensure that the connection parameters are set as defaults, such as by setting the environment variables PGHOST, PGUSER, etc.  You can verify that these settings are correct by passing a command with no connection parameters, such as:

   .. code-block:: console

      psql -c "\echo hello world"

#. Download `this archive <http://LINKNEEDED.com>`_ and extract it to a temporary directory.

   .. todo:: DOWNLOAD LINKS NEEDED.

#. *(Linux / OS X only)*  Copy the :file:`postgis_restore.pl` file from your PostGIS installation to this same directory.  The :file:`postgis_restore.pl` script can be found in the ``utils`` directory of the PostGIS install.

   .. todo:: MAYBE WE SHOULD BUNDLE postgis_restore.pl INSTEAD

#. Create a new directory for backup files if desired.

#. Run the following command, substituting in the correct backup location.  Make sure the script has write access to this location (by using ``sudo`` or the ``Administrator`` prompt if necessary):

   **Linux / OS X:**

   .. code-block:: console

      perl pgdbupgrade.pl --backup path/to/backup/

   **Windows:**

   .. code-block:: console

      pgdbupgrade.exe --backup C:\path\to\backup\

#. The script will run and create a number of files:

   * Compressed dump files for every database found (:file:`<database>.dmp`)
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

      perl pgdbupgrade.pl --restore path/to/backup/

   **Windows:**

   .. code-block:: console

      pgdbupgrade.exe --restore C:\path\to\backup\

#. Your databases and roles will be restored.  You can verify that the data was restored properly by running ``psql -l`` on the command line.

