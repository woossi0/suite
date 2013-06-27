.. _installation.linux.ubuntu.suite:

Installing OpenGeo Suite on Ubuntu
==================================

.. |pgupgrade_url| replace:: http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.1.zip

The commands contained in the following installation instructions assume root privileges.

New install
-----------

.. note:: If you are upgrading from a previous version, jump to the section entitled :ref:`installation.linux.ubuntu.suite.upgrade`.

.. warning:: Packages are only available for Ubuntu 10.04. Newer versions are usually known to work, but are not officially supported at this time.

#. Begin by importing the OpenGeo GPG key:

   .. code-block:: console

      wget -qO- http://apt.opengeo.org/gpg.key | apt-key add -

#. Add the OpenGeo APT repository:

   .. code-block:: console

      echo "deb http://apt.opengeo.org/suite/v3/ubuntu lucid main" >> /etc/apt/sources.list
      
#. Update APT:

   .. code-block:: console

      apt-get update

#. Search for packages from OpenGeo:

   .. code-block:: console

      apt-cache search opengeo

   If the search command does not return any results, the repository was not added properly. Examine the output of the ``apt`` commands for any errors or warnings.

#. Install the OpenGeo Suite package (``opengeo-suite``):

   .. code-block:: console

      apt-get install opengeo-suite

#. If the previous command returns an error, the OpenGeo repository may not have been added properly. Examine the output of the ``apt-get`` command for any errors or warnings.

#. During the installation process, you will be asked a few questions. The first question is regarding the proxy URL that GeoServer is accessed through publicly. This is only necessary if GeoServer is accessed through an external proxy. If unsure, leave this field blank and just press ``[Enter]``.

#. You will then be prompted for the name of the default GeoServer administrator account. Press ``[Enter]`` to leave it at the default of "admin", or type in a new name.

#. Next, you will be asked for the default GeoServer administrator password. Press ``[Enter]`` to leave it at the default of "geoserver", or type in a new password.

#. You will be asked if you want to install OpenGeo Suite-specific PostGIS extensions. Press ``[Enter]`` to accept.

#. If any other warning or dialog boxes show up, you can cycle through them by pressing ``[Alt-O]``.

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

#. Update the ``opengeo-suite`` package:

   .. code-block:: console

      apt-get install opengeo-suite
      
Major version upgrades do not happen automatically and require more steps as outlined in the following sections.

.. _installation.linux.ubuntu.suite.upgrade.v3:

Upgrading from version 2.x to 3.x
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OpenGeo Suite version 3 contains numerous major version updates to its components. This upgrade is **not-backward compatible** and will not retain
all of your previously configured PostGIS data. You will need to backup your data according to the specific procedures listed below before proceeding with the upgrade.

The procedure for upgrading is as follows:

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
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
       wget http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.zip
       unzip postgis_upgrade-3.0.zip

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

#. Back up your GeoServer data directory. This directory is located by default in :file:`/usr/share/opengeo-suite-data/geoserver_data`. To back up this directory, copy it to another location. For example:

   .. code-block:: console

      cp -r /usr/share/opengeo-suite-data/geoserver_data  /tmp/suite_backup/data_dir_backup
      
#. Now you are ready to install OpenGeo Suite 3.x. To do this, it is now necessary to add an additional repository. This repository contains the version 3 packages. Run the following command (as root or with ``sudo``):

   .. code-block:: console

      echo "deb http://apt.opengeo.org/suite/v3/ubuntu lucid main" >> /etc/apt/sources.list

#. Now update your repository sources:

   .. code-block:: console

      apt-get update

#. Install the OpenGeo Suite package:

   .. code-block:: console

      apt-get install opengeo-suite

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

      mv /usr/share/opengeo-suite-data/geoserver_data  /tmp/suite_backup/data_dir_backup_30
      cp -r /tmp/suite_backup/data_dir_backup /usr/share/opengeo-suite-data/geoserver_data

#. Change the owner of the restored data directory:

   .. code-block:: console

      chown -R tomcat6 /usr/share/opengeo-suite-data/geoserver_data

#. Start the Tomcat service:

   .. code-block:: console

      service tomcat6 start

.. note::

   Memory requirements for OpenGeo Suite 3 have increased, which requires modification to the Tomcat Java configuration. These settings are not automatically updated on upgrade and must be set manually. 

   To make the change, edit the file :file:`/etc/default/tomcat6` and append ``-XX:MaxPermSize=256m`` to the ``JAVA_OPTS`` command. Restart the OpenGeo Suite for the change to take effect.


Continue reading at the :ref:`installation.linux.suite.details` section.
