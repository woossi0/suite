.. _installation.linux.ubuntu.suite.community:

Installing OpenGeo Suite Community Edition on Ubuntu
====================================================

The commands contained in the following installation instructions must be run as a user with root privileges. 

.. note:: If you are upgrading from a previous version, jump to the section entitled :ref:`installation.linux.ubuntu.suite.community.upgrade`.

.. warning:: The APT packages are only available for Ubuntu 10.04 and above.

#. Begin by importing the OpenGeo GPG key:

   .. code-block:: console

      wget -qO- http://apt.opengeo.org/gpg.key | apt-key add -

#. Add the OpenGeo APT repository:

   .. code-block:: console

      echo "deb http://apt.opengeo.org/ubuntu lucid main" >> /etc/apt/sources.list
      
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

#. During the installation process, you will be asked a few questions.  The first question is regarding the proxy URL that GeoServer is accessed through publicly.  This is only necessary if GeoServer is accessed through an external proxy.  If unsure, leave this field blank and just press ``[Enter]``.

#. You will then be prompted for the name of the default GeoServer administrator account.  Press ``[Enter]`` to leave it at the default of "admin", or type in a new name.

#. Next, you will be asked for the default GeoServer administrator password.  Press ``[Enter]`` to leave it at the default of "geoserver", or type in a new password.

#. You will be asked if you want to install OpenGeo Suite-specific PostGIS extensions.  Press ``[Enter]`` to accept.

#. If any other warning or dialog boxes show up, you can cycle through them by pressing ``[Alt-O]``.

#. You can launch the OpenGeo Suite Dashboard (and verify the installation was successful) by navigating to the following URL::

      http://localhost:8080/dashboard/

Continue reading at the :ref:`installation.linux.suite.details` section.

.. _installation.linux.ubuntu.suite.community.upgrade:

Upgrading
---------

.. _installation.linux.ubuntu.suite.community.v3:

Upgrading from version 2.x to 3.x
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OpenGeo Suite version 3 contains numerous major version updates to its components.  This upgrade is also **not-backward compatible**; irreversible changes are made to the data so that they can't be used with earlier versions of the OpenGeo Suite.

In addition, the upgrade process to 3.x will reinitialize the PostGIS database, removing all PostGIS data.  Therefore, it is required to follow the upgrade steps below to ensure that your data is retained.

.. warning:: Upgrading from 2.x to 3.x will delete all of your PostGIS data.  You will need to backup your data according to the specific procedures listed below.  This procedure is different from the usual backup process.

The procedure for upgrading is as follows:

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
#. Make sure that your PostgreSQL ``bin`` directory is on your path.  By default, this is :file:`/var/lib/pgsql/8.4/bin`, though your installation may vary.  To test that this is set up correctly, open a Command Prompt and type ``psql --version``.  If you receive an error, type the following to temporarily add the above directory to your path:

   .. code-block:: console

      export PATH=$PATH:/var/lib/pgsql/8.4/bin 

#. Download the archive available at http://files.opengeo.org/suite/postgis_upgrade_pl.zip and extract it to a temporary directory.  To avoid permissions issues, it is best to put this directory on your desktop or in your home directory.  By default, the backup files created from using this script will be saved into this directory.

#. Run the backup command:

   .. code-block:: console

      perl postgis_upgrade.pl backup

   .. note:: You can use standard PostGIS command line flags such as ``--host``, ``--port`` and ``--username`` if you have customized your installation.  You can also select only certain databases to backup by using the ``--dblist`` flag followed by a list of databases:  ``--dblist db1 db2 db3``.  Full syntax is available by running with ``--help``.

#. The script will run and create a number of files:

   * Compressed dump files for every database backed up (:file:`<database>.dmp`)
   * SQL output of server roles

#. The PostGIS data backup process is complete.  You may now shut down the OpenGeo Suite 2.x.

#. Back up your GeoServer data directory.  This directory is located by default in :file:`/usr/share/opengeo-suite-data/geoserver_data`.  To back up this directory, you can create an archive of it, or simply copy it to another location.

   .. code-block:: console

      cp -r /usr/share/opengeo-suite-data/geoserver_data  ~/data_dir_backup

#. Now you are ready to install OpenGeo Suite 3.x.  To do this, it is now necessary to add an additional repository.  This repository contains the version 3 packages.  Run the following command (as root or with ``sudo``):

   .. code-block:: console

      THIS COMMAND IS NOT UPDATED YET.

      echo "deb http://apt.opengeo.org/ubuntu lucid main" >> /etc/apt/sources.list

#. Now update your repository sources:

   .. code-block:: console

      apt-get update

#. Update the ``opengeo-suite`` package:

   .. code-block:: console

      apt-get install opengeo-suite

   .. todo:: ANY SPECIFICS NEEDED ON ACTUAL INSTALLATION?

#. After installation is complete.  Restore the GeoServer data directory to its original location.

   .. code-block:: console

      cp -r ~/data_dir_backup /usr/share/opengeo-suite-data/geoserver_data 

#. Start (or restart) the newly-upgraded OpenGeo Suite.

#. As before, you will need to make sure that the new PostGIS commands are on the path once again.  If necessary, from a terminal, type the following to temporarily add the new directory to your path:

   .. code-block:: console

      export PATH=$PATH:/var/lib/pgsql/9.2/bin

#. Restore your PostGIS data by running the script again:

   .. code-block:: console

      perl postgis_upgrade.pl restore

   .. note:: As with the backup, standard PostGIS connection parameters may be used.  You can also select only certain databases to restore with the ``--dblist`` flag as detailed above.

#. Your databases and roles will be restored.  You can verify that the databases were created and data restored by running ``psql -l`` on the command line.

.. todo:: Will put this back in for 3.0.1

          Minor version upgrade.

          #. Begin by updating APT:

             .. code-block:: console

                apt-get update

          #. Update the ``opengeo-suite`` package:

             .. code-block:: console

                apt-get install opengeo-suite

Continue reading at the :ref:`installation.linux.suite.details` section.
