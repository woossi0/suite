.. _installation.linux.ubuntu.suite:

Installing OpenGeo Suite on Ubuntu
==================================

.. |pgupgrade_url| replace:: http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.1.zip

Opengeo Suite packages are available for Ubuntu 10.04 (Lucid) and 12.04 (Precise).

The commands below assume root privileges.

New install
-----------

.. note:: If you are upgrading from a previous version, jump to the section entitled :ref:`installation.linux.ubuntu.suite.upgrade`.

#. Begin by importing the OpenGeo GPG key:

   .. code-block:: console

      wget -qO- http://apt.opengeo.org/gpg.key | apt-key add -

#. Add the OpenGeo APT repository:

   .. warning:: These commands contain links to **beta** packages. When the final version of the software is released, these links will change, so you will need to run these commands again.

   Ubuntu 12.04 (Precise):

   .. code-block:: console

      echo "deb http://apt.opengeo.org/beta/suite/v4/ubuntu/ precise main" > /etc/apt/sources.list.d/opengeo.list

   Ubuntu 10.04 (Lucid):

   .. code-block:: console

      echo "deb http://apt.opengeo.org/beta/suite/v4/ubuntu/ lucid main" > /etc/apt/sources.list.d/opengeo.list
      
#. Update APT:

   .. code-block:: console

      apt-get update

#. Search for packages from OpenGeo:

   .. code-block:: console

      apt-cache search opengeo

   If the search command does not return any results, the repository was not added properly. Examine the output of the ``apt`` commands for any errors or warnings.

#. OpenGeo Suite is a collection of software components. While it is possible to install the entire collection on a single machine for testing purposes, we suggest that you install server tools on one machine and client tools on another. You will have the option of choosing which components you wish during the installation process.

   The server package is called ``opengeo-server``. The client package is ``opengeo-client``. The package to install everything is called ``opengeo``. The instructions below will show the full installation, but please be sure to install the correct package for your system.

#. Install OpenGeo Suite package (``opengeo``):

   .. code-block:: console

      apt-get install opengeo

#. If the previous command returns an error, the OpenGeo repository may not have been added properly. Examine the output of the ``apt-get`` command for any errors or warnings.

#. You can launch the OpenGeo Suite Dashboard (and verify the installation was successful) by navigating to the following URL::

      http://localhost:8080/dashboard/

Continue reading at the :ref:`installation.linux.suite.details` section.

.. _installation.linux.ubuntu.suite.upgrade:

Upgrading
---------

Minor version upgrades of the OpenGeo Suite packages occur along with other system upgrades via the package manager. Or alternatively:

#. Begin by updating APT:

   .. code-block:: console

      apt-get update

#. Update the ``opengeo`` package (or whichever package was originally installed):

   .. code-block:: console

      apt-get install opengeo
      
Major version upgrades do not happen automatically and require more steps as outlined in the following sections.

.. _installation.linux.ubuntu.suite.upgrade.fromv2:

Upgrading from version 2.x
~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenGeo Suite version 2 contains an older version of many major components. This upgrade is also **not-backward compatible**; irreversible changes are made to the data so that they can't be used with earlier versions of OpenGeo Suite.

In addition, the upgrade process will reinitialize the PostGIS database, removing all PostGIS data. Therefore, it is required to follow the upgrade steps below to ensure that your data is retained.

The procedure for upgrading is as follows:

#. Ensure the old (2.x) version of OpenGeo Suite is running.
 
#. Change to the root user.

   .. note:: If you don't have direct access to the root account you must use the sudo command to execute the commands in the steps that follow. All the commands assume root access.
   
#. Make sure that your PostgreSQL binaries are on the path. By default they should be located in ``/usr/bin`` but your installation may vary. To test that this is set up correctly, open a Command Prompt and type ``psql --version``. If you receive an error, find the binaries and update the ``PATH`` environment variable.

#. Change user to the ``postgres`` user.

    .. code-block:: console
    
       sudo su postgres

#. Download the archive available at |pgupgrade_url| and extract it to a temporary directory. To avoid permissions issues, the :file:`/tmp/suite_backup/pg_backup` path will be created and used.

    .. warning:: The :file:`/tmp` directory is not recommended for long-term storage of backups, as the directory can often be purged as a part of normal system activity. If using a different directory, make sure that both the ``postgres`` and ``root`` users have read/write permissions to it.

    .. code-block:: console

       mkdir -p /tmp/suite_backup/pg_backup
       cd /tmp/suite_backup/pg_backup
       wget http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.1.zip
       unzip postgis_upgrade-3.0.1.zip

#. Run the backup command:

   .. code-block:: console
    
      perl postgis_upgrade.pl backup
       
   .. note:: You can use standard PostGIS command line flags such as ``--host``, ``--port`` and ``--username`` if you have customized your installation. You can also select only certain databases to backup by using the ``--dblist`` flag followed by a list of databases:  ``--dblist db1 db2 db3``. Full syntax is available by running with ``--help``.

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles

#. The PostGIS data backup process is complete. Switch from the ``postgres`` user to the ``root`` user:

   .. code-block:: console

      exit
      sudo su -

#. Back up your GeoServer data directory. This directory is located by default in :file:`/var/lib/opengeo/geoserver`. To back up this directory, copy it to another location. For example:

   .. code-block:: console

      cp -r /var/lib/opengeo/geoserver  /tmp/suite_backup/data_dir_backup
      
#. Now you are ready to install OpenGeo Suite. To do this, it is now necessary to add an additional repository. Run the following command (as root or with ``sudo``):

   Ubuntu 12.04 (Precise):

   .. code-block:: console

      echo "deb http://apt.opengeo.org/test/suite/v4/ubuntu/ precise main" > /etc/apt/sources.list.d/opengeo.list

   Ubuntu 10.04 (Lucid):

   .. code-block:: console

      echo "deb http://apt.opengeo.org/test/suite/v4/ubuntu/ lucid main" > /etc/apt/sources.list.d/opengeo.list

#. Now update your repository sources:

   .. code-block:: console

      apt-get update

#. Install the full OpenGeo Suite package (``opengeo``) or just the server tools (``opengeo-server``) or client tools (``opengeo-client``):

   .. code-block:: console

      apt-get install opengeo

#. Ensure the newly-upgraded OpenGeo Suite is running.

#. Change to the postgres user and restore your PostGIS data by running the script again:

   .. code-block:: console

      sudo su postgres
      cd /tmp/suite_backup/pg_backup
      perl postgis_upgrade.pl restore

   .. note:: As with the backup, standard PostGIS connection parameters may be used. You can also select only certain databases to restore with the ``--dblist`` flag as detailed above.

#. Your databases and roles will be restored. You can verify that the databases were created and data restored by running ``psql -l`` on the command line.

#. Exit out of the postgres user and change to root.

#. Stop the Tomcat service:

   .. code-block:: console

      service tomcat6 stop

#. Restore your GeoServer data directory, renaming the existing one first. For example:

   .. code-block:: console

      mv /var/lib/opengeo/geoserver /tmp/suite_backup/data_dir_backup_30
      cp -r /tmp/suite_backup/data_dir_backup /var/lib/opengeo/geoserver

#. Change the owner of the restored data directory:

   .. code-block:: console

      chown -R tomcat6 /var/lib/opengeo/geoserver

#. Start the Tomcat service:

   .. code-block:: console

      service tomcat6 start

.. note::

   Memory requirements for OpenGeo Suite have increased, which requires modification to the Tomcat Java configuration. These settings are not automatically updated on upgrade and must be set manually. 

   To make the change, edit the file :file:`/etc/default/tomcat6` and append ``-XX:MaxPermSize=256m`` to the ``JAVA_OPTS`` command. Restart the OpenGeo Suite for the change to take effect.

Continue reading at the :ref:`installation.linux.suite.details` section.
