.. _installation.linux.centos.suite:

Installing OpenGeo Suite on CentOS and Red Hat
==============================================

.. |pgupgrade_url| replace:: http://repo.opengeo.org/suite/releases/pgupgrade/postgis_upgrade-3.0.1.zip

The commands contained in the following installation instructions assume root privileges.

New installation
----------------

.. note:: If you are upgrading from a previous version, jump to the section entitled :ref:`installation.linux.centos.suite.upgrade`.

.. warning:: Packages are available for CentOS 5 and above, and Red Hat Enterprise Linux (RHEL) 5 and above.

#. Change to the :file:`/etc/yum.repos.d` directory:

   .. code-block:: bash

      cd /etc/yum.repos.d

#. Add the OpenGeo YUM repository. The exact command will differ depending on whether you are using CentOS/RHEL 5 or 6, and whether you are using a 32 bit installation or 64 installation:

   .. list-table::
      :widths: 20 80
      :header-rows: 1

      * - System
        - Command
      * - CentOS 5, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/5/i386/OpenGeo.repo``
      * - CentOS 5, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/5/x86_64/OpenGeo.repo``
      * - CentOS 6, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/6/i686/OpenGeo.repo``
      * - CentOS 6, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/6/x86_64/OpenGeo.repo``
      * - RHEL 5, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/5/i386/OpenGeo.repo``
      * - RHEL 5, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/5/x86_64/OpenGeo.repo``
      * - RHEL 6, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/6/i686/OpenGeo.repo``
      * - RHEL 6, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/6/x86_64/OpenGeo.repo``

#. Now run the install. The package is called ``opengeo-suite``:

   .. code-block:: bash

      yum install opengeo-suite

#. If the previous command returns an error, the OpenGeo repositories may not have been added properly. Examine the output of the ``yum`` command for any errors or warnings.

#. You can launch the OpenGeo Suite Dashboard (and verify the installation was successful) by navigating to the following URL::

      http://localhost:8080/dashboard/

Continue reading at the :ref:`installation.linux.suite.details` section.

.. _installation.linux.centos.suite.upgrade:

Upgrading
---------

Minor version upgrades of the OpenGeo Suite packages occur along with other system upgrades via the package manager. Or alternatively you can:

#. Begin by updating YUM:

   .. code-block:: bash

      yum update

#. The relevant OpenGeo packages should be included in the upgrade list. If you do not wish to do a full update, cancel the upgrade and install the ``opengeo-suite`` package manually:

   .. code-block:: bash

      yum install opengeo-suite

Major version upgrades do not happen automatically and require more steps as outlined in the following sections.

.. _installation.linux.centos.suite.upgrade.v3:

Upgrading from version 2.x to 3.x
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The OpenGeo Suite version 3 contains numerous major version updates to its components. This upgrade is **not-backward compatible** and will not retain all of your previously configured data. You will need to backup your data according to the specific procedures listed below before proceeding with the upgrade. 

.. warning:: Upgrading on CentOS/RHEL 5 differs from upgrading on CentOS/RHEL 6 and above. Version 5 requires that the previous installation of the OpenGeo Suite be removed before upgrading. Versions 6 and above can do an upgrade in place. In both cases you *must* back up your data before proceeding. 

The procedure for upgrading is as follows.

Backup PostGIS data
^^^^^^^^^^^^^^^^^^^

#. Ensure the old (2.x) version of the OpenGeo Suite is running.
 
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

Backup GeoServer configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Back up your GeoServer data directory. This directory is located by default in :file:`/usr/share/opengeo-suite-data/geoserver_data`. To back up this directory, you can create an archive of it, or simply copy it to another location:

   .. code-block:: console

      cp -r /usr/share/opengeo-suite-data/geoserver_data /tmp/suite_backup/data_dir_backup

Uninstall OpenGeo Suite 2.x
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: If you are running CentOS/RHEL 6 or above you may skip this step.

#. Due to a conflict with CentOS 5 postgreSQL package management, the entire OpenGeo Suite installation must be removed before continuing with the upgrade. The easiest way to remove the postgreSQL packages for a Suite 2.x installation is to remove the ``postgresql84`` package.

   .. code-block:: console

      yum remove postgresql84

Install OpenGeo Suite 3.x
^^^^^^^^^^^^^^^^^^^^^^^^^

Now you are ready to install OpenGeo Suite 3.x. To do this, it is now necessary to add an additional repository. This repository contains the version 3 packages.

#. If not already, make sure you are running as ``root``:

   .. code-block:: console

      sudo su -

#. Change to the :file:`/etc/yum.repos.d` directory:

   .. code-block:: console

      cd /etc/yum.repos.d

#. Rename the existing repository file(s):

   .. code-block:: console

      for REPO in OpenGeo*.repo; do mv $REPO $REPO.old; done;

#. Run the following command:

   .. list-table::
      :widths: 20 80
      :header-rows: 1

      * - System
        - Command
      * - CentOS 5, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/5/i386/OpenGeo.repo``
      * - CentOS 5, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/5/x86_64/OpenGeo.repo``
      * - CentOS 6, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/6/i686/OpenGeo.repo``
      * - CentOS 6, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/centos/6/x86_64/OpenGeo.repo``
      * - RHEL 5, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/5/i386/OpenGeo.repo``
      * - RHEL 5, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/5/x86_64/OpenGeo.repo``
      * - RHEL 6, 32 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/6/i686/OpenGeo.repo``
      * - RHEL 6, 64 bit
        - ``wget http://yum.opengeo.org/suite/v3/rhel/6/x86_64/OpenGeo.repo``

#. Clean your repository sources:

   .. code-block:: console

      yum clean all

#. Update your repository sources:

   .. code-block:: console

      yum update

#. Install the OpenGeo Suite package:

   .. code-block:: console

      yum install opengeo-suite

Restore PostGIS data
^^^^^^^^^^^^^^^^^^^^

#. Ensure the newly-upgraded OpenGeo Suite is running.

#. Change to the postgres user and restore your PostGIS data by running the script again:

   .. code-block:: console

      sudo su postgres
      cd /tmp/suite_backup/pg_backup
      perl postgis_upgrade.pl restore
      
   .. note:: As with the backup, standard PostGIS connection parameters may be used. You can also select only certain databases to restore with the ``--dblist`` flag as detailed above.
   
#. Your databases and roles will be restored. You can verify that the databases were created and data restored by running ``psql -l`` on the command line.

#. Switch back the ``root`` user.

   .. code-block:: console

      exit
   
Restore GeoServer configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Stop tomcat and restore the GeoServer data directory to its original location.

   .. code-block:: console

      service tomcat5 stop
      rm -rf /usr/share/opengeo-suite-data/geoserver_data
      mv /tmp/suite_backup/data_dir_backup /usr/share/opengeo-suite-data/geoserver_data
      chown -R tomcat /usr/share/opengeo-suite-data/geoserver_data

#. Restart tomcat.

  .. code-block:: console

     service tomcat5 start

.. note::

   Memory requirements for OpenGeo Suite 3 have increased, which requires modification to the Tomcat Java configuration. These settings are not automatically updated on upgrade and must be set manually. 

   To make the change, edit the file :file:`/etc/sysconfig/tomcat6` (or :file:`/etc/sysconfig/tomcat5` if it exists) and append ``-XX:MaxPermSize=256m`` to the ``JAVA_OPTS`` command. Restart the OpenGeo Suite for the change to take effect.

Continue reading at the :ref:`installation.linux.suite.details` section.

