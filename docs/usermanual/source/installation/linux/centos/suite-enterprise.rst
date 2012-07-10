.. _installation.linux.centos.suite.enterprise:

Installing OpenGeo Suite Enterprise Edition on CentOS
=====================================================

The commands contained in the following installation instructions must be run as a user with root privileges. 

.. note:: If you are upgrading from a previous version, jump to the section entitled :ref:`installation.linux.centos.suite.enterprise.upgrade`.

.. warning:: The RPM packages are only compatible with CentOS 5 and above.

#. Change to the :file:`/etc/yum.repos.d` directory:

   .. code-block:: bash

      cd /etc/yum.repos.d

#. Add the OpenGeo YUM repository.  The exact command will differ depending on whether you are using CentOS 5 or 6, and whether you are using a 32 bit installation or 64 installation.

   .. list-table::
      :widths: 20 80
      :header-rows: 1

      * - System
        - Command
      * - CentOS 5, 32 bit
        - ``wget http://yum.opengeo.org/centos/5/i386/OpenGeo.repo``
      * - CentOS 5, 64 bit
        - ``wget http://yum.opengeo.org/centos/5/x86_64/OpenGeo.repo``
      * - CentOS 6, 32 bit
        - ``wget http://yum.opengeo.org/centos/6/i686/OpenGeo.repo``
      * - CentOS 6, 64 bit
        - ``wget http://yum.opengeo.org/centos/6/x86_64/OpenGeo.repo``

#. Now add the OpenGeo Enterprise YUM repository.  This repository is password protected.  You will have received a username and password when you `registered for the Enterprise Edition <http://opengeo.org/products/suite/register/>`_.  Add the following YUM repository using the commands below, making sure to substitute in your username for ``<username>`` and password for ``<password>``.  Again, the exact command will differ depending on your system.

   .. list-table::
      :widths: 20 80
      :header-rows: 1

      * - System
        - Command
      * - CentOS 5, 32 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/5/i386/OpenGeoEE.repo``
      * - CentOS 5, 64 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/5/x86_64/OpenGeoEE.repo``
      * - CentOS 6, 32 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/6/i686/OpenGeoEE.repo``
      * - CentOS 6, 64 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/6/x86_64/OpenGeoEE.repo``

#. Edit the downloaded :file:`OpenGeoEE.repo` file, filling in your username and password in place of ``<yourUserName>`` and ``<yourPassword>``.

#. Update the YUM databases:

   .. code-block:: bash

      yum update

#. Now we are ready to install the OpenGeo Suite.  The package is called ``opengeo-suite-ee``:

   .. code-block:: bash

      yum install opengeo-suite-ee

#. If the previous command returns an error, the OpenGeo repositories may not have been added properly. Examine the output of the ``yum`` command for any errors or warnings.

#. You can launch the OpenGeo Suite Dashboard (and verify the installation was successful) by navigating to the following URL::

      http://localhost:8080/dashboard/

Continue reading at the :ref:`installation.linux.suite.details` section.


.. _installation.linux.centos.suite.enterprise.upgrade:

Upgrading
---------

.. _installation.linux.centos.suite.enterprise.v3:

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

      cp -r /usr/share/opengeo-suite-data/geoserver_data ~/data_dir_backup

#. **CentOS 5 only**  Due to conflicts with the way that CentOS 5 manages packages, it is necessary to active remove PostgreSQL 8.4 before continuing:

   .. todo:: THIS PACKAGE NAME IS PROBABLY INCORRECT

   .. code-block:: console

      yum remove postgresql84-libs

#. Now you are ready to install OpenGeo Suite 3.x.  To do this, it is now necessary to add some additional repositories.  These repositories contain the version 3 packages.  Run the following two commands (as root or with ``sudo``):

   THESE COMMANDS ARE NOT UPDATED YET.

   .. list-table::
      :widths: 20 80
      :header-rows: 1

      * - System
        - Command
      * - CentOS 5, 32 bit
        - ``wget http://yum.opengeo.org/centos/5/i386/OpenGeo.repo``
      * - CentOS 5, 64 bit
        - ``wget http://yum.opengeo.org/centos/5/x86_64/OpenGeo.repo``
      * - CentOS 6, 32 bit
        - ``wget http://yum.opengeo.org/centos/6/i686/OpenGeo.repo``
      * - CentOS 6, 64 bit
        - ``wget http://yum.opengeo.org/centos/6/x86_64/OpenGeo.repo``

   .. list-table::
      :widths: 20 80
      :header-rows: 1

      * - System
        - Command
      * - CentOS 5, 32 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/5/i386/OpenGeoEE.repo``
      * - CentOS 5, 64 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/5/x86_64/OpenGeoEE.repo``
      * - CentOS 6, 32 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/6/i686/OpenGeoEE.repo``
      * - CentOS 6, 64 bit
        - ``wget --user='<username>' --password='<password>' http://yum-ee.opengeo.org/centos/6/x86_64/OpenGeoEE.repo``

 
#. Now update your repository sources:

   .. code-block:: console

      yum update

#. Update the ``opengeo-suite-ee`` package:

   .. code-block:: console

      yum install opengeo-suite-ee

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


.. todo:: Will add this back in for 3.0.1

          #. Begin by updating YUM:

             .. code-block:: bash

                yum update

          #. The relevant OpenGeo packages should be included in the upgrade list. If you do not wish to do a full update, cancel the upgrade and install the ``opengeo-suite-ee`` package manually:

             .. code-block:: bash

                yum install opengeo-suite-ee


Continue reading at the :ref:`installation.linux.suite.details` section.

