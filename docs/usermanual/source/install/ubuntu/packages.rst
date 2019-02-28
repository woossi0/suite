.. _install.ubuntu.packages:

Package install on Ubuntu
=========================

This page describes how to perform a package installation of **Boundless Server** |version| on Ubuntu Linux.

.. note:: For upgrades, see the section on :ref:`Upgrading <install.ubuntu.packages.upgrade>` below.

.. include:: include/sysreq.txt

.. _install.ubuntu.packages.install:

New installation
----------------

This section describes how to perform a clean package installation of **Boundless Server** |version| on Ubuntu Linux.

See the :ref:`install.ubuntu.packages.list` for details about the possible packages to install.

.. warning:: Mixing repositories is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of Boundless Server (such as PostgreSQL) please remove them before installing Boundless Server.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Import the Boundless GPG key:

   .. code-block:: bash

      wget -qO- https://downloads-repo.boundlessgeo.com/GPG-KEY-Boundless | apt-key add -

#. Add the Boundless repository:

   (Ubuntu 14)

   .. code-block:: bash

      echo "deb [arch=amd64] https://<username>:<password>@downloads-repo.boundlessgeo.com/server-repo/1.2.0/ubuntu/14 trusty main" > /etc/apt/sources.list.d/boundless.list

   (Ubuntu 16)

   .. code-block:: bash

     echo "deb [arch=amd64] https://<username>:<password>@downloads-repo.boundlessgeo.com/server-repo/1.2.0/ubuntu/16 xenial main" > /etc/apt/sources.list.d/boundless.list

   Make sure to replace each instance of ``<username>`` and ``<password>`` with the user name and password supplied to you.

   .. note:: Your username is your email address. When entering your username into the ``Boundless.repo`` file, the ``@`` in your username should be preserved as-is.

   .. note:: Please `contact us <http://boundlessgeo.com/about/contact-us/>`__ if you have purchased Boundless Server and do not have a user name and password.

#. Update the repository list:

   .. code-block:: bash

      apt-get update

#. Search for Boundless packages to verify that the repository list is correct.

   .. code-block:: bash

      apt-cache search boundless-server-

   If the command does not return any results, examine the output of the ``apt-cache`` command for any errors or warnings.

#. You have options on what packages to install.

   * A simple installation including GeoServer, documentation, and the :ref:`intro.dashboard`:

     .. code-block:: bash

        apt-get install boundless-server-geoserver boundless-server-docs boundless-server-dashboard

   * A more complete install, including all the web applications, PostGIS, GDAL, and NetCDF:

     .. code-block:: bash

        apt-get install boundless-server-dashboard \
                        boundless-server-geoserver \
                        boundless-server-geowebcache \
                        boundless-server-composer \
                        boundless-server-docs \
                        boundless-server-quickview  \
                        boundless-server-wpsbuilder \
                        postgresql-9.6-postgis-2.5 \
                        boundless-server-gs-gdal \
                        boundless-server-gs-netcdf \
                        boundless-server-gs-netcdf-out

   .. note::  See the :ref:`install.ubuntu.packages.list` for details of individual packages.
   
   .. note:: Boundless Server installs Java 8 by default for backwards compatibility with older installations.

             For a new installation of Boundless Server, we recommend :ref:`using Java 11 <sysadmin.jvm.openjdk11>`.

             If you already have an existing JVM installed, you may also need to change the *default* java. Run ``java -version`` to check the default java version. If it is not the expected version, use :ref:`update-alternatives<sysadmin.jvm.alternatives>` to change the default.

#. Restart the server.

   .. code-block:: bash

      service tomcat9 restart

#. Verify that the installation succeeded by opening your browser and navigating to one of the following URLs:

   * http://localhost:8080/dashboard
   * http://localhost:8080/geoserver

   .. note:: Please see the section on :ref:`sysadmin.ubuntu` for additional information and best practices.

.. _install.ubuntu.packages.upgrade:

Upgrade
-------

Upgrading from 1.0.0 or 1.1.0 to 1.2.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to upgrade Boundless Suite 1.0.0 or 1.1.0 to Boundless Server 1.2.0 on Ubuntu-based Linux distributions.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Stop the server:

   .. code-block:: bash

      service tomcat8 stop

#. Backup the contents of ``/etc/tomcat8``.

#. Generate a list of boundless-server packages you currently have installed:

   .. code-block:: bash

      yum list installed | grep boundless-server

#. Replace the 1.1.0 repo definition with the new repo definition. Open ``/etc/apt/sources.list.d/boundless.list`` and replace the contents with:

   .. code-block:: none

      deb [arch=amd64] https://<username>:<password>@downloads-repo.boundlessgeo.com/server-repo/1.2.0/ubuntu trusty main

   Make sure to replace each instance of ``<username>`` and ``<password>`` with the user name and password supplied to you.

   .. note:: Your username is your email address. When entering your username into the ``Boundless.repo`` file, the ``@`` in your username should be preserved as-is.

#. Refresh the apt repo data:

   .. code-block:: bash

      apt-get update

#. Remove the old version of Tomcat:

   .. code-block:: bash

      apt-get remove boundless-server-tomcat8

#. Remove the old version of PostGIS:

   .. note: If you are not using PostGIS, you can skip this step. However, if you are using PostGIS, you **must** upgrade, for compatibility with the latest version of GDAL.

   .. code-block:: bash

      apt-get remove postgresql-9.6-postgis-2.3 postgis-2.3

#. Install the new version of PostGIS:

   .. code-block:: bash

      apt-get install postgresql-9.6-postgis-2.5 

#. Using the list of boundless-server packages you generated above, re-install Boundless Server. This will also install the new version of Tomcat.

   For example:

   .. code-block:: bash

      apt-get install boundless-server-geoserver boundless-server-docs boundless-server-dashboard

#. If you had previously made any changes to the context or configuration files in ``/etc/tomcat8``, copy these changes into the corresponding files in ``/etc/tomcat9``.

#. If you are using the :ref:`Clustering <sysadmin.clustering>` extension, follow the :ref:`steps to upgrade it <sysadmin.clustering.install.upgrade>` now.

#. Start the server.

   .. code-block:: bash

      service tomcat9 start

#. Verify that the installation succeeded by opening your browser and navigating to one of the following URLs:

   * http://localhost:8080/dashboard
   * http://localhost:8080/geoserver

Upgrading from Suite 4.9.1 or 4.10.0 to Server 1.0.0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to upgrade Boundless Suite 4.9.1 or 4.10.0 to Boundless Server 1.0.0 on Ubuntu-based Linux distributions.

.. note::

   If you made changes to the tomcat context files located in ``/etc/tomcat8/Catalina/localhost/``, please back them up now or your changes will be lost. After completing the upgrade process, restore the backed up files to ``/etc/tomcat9/Catalina/localhost/``.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Replace the 4.10.0 repo definition with the new repo definition. Open ``/etc/apt/sources.list.d/boundless.list`` and replace the contents with:

   .. code-block:: none

      deb [arch=amd64] https://<username>:<password>@downloads-repo.boundlessgeo.com/server-repo/1.1.0/ubuntu trusty main

   Make sure to replace each instance of ``<username>`` and ``<password>`` with the user name and password supplied to you.

   .. note:: Your username is your email address. When entering your username into the ``Boundless.repo`` file, the ``@`` in your username should be preserved as-is.

#. Refresh the apt repo data:

   .. code-block:: bash

      apt-get update

#. Install all Boundless Server |version| packages corresponding to the ``suite-*`` packages which are currently installed. For example:

   .. code-block:: bash

      apt-get install boundless-server-geoserver boundless-server-docs boundless-server-dashboard

#. Restart the server.

   .. code-block:: bash

      service tomcat8 restart

#. Verify that the installation succeeded by opening your browser and navigating to one of the following URLs:

   * http://localhost:8080/dashboard
   * http://localhost:8080/geoserver

Upgrading from 4.9.0 to 4.9.1
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to upgrade Boundless Suite 4.9.0 to Boundless Suite 4.9.1 on Ubuntu Linux.

.. note::

   If you made changes to the tomcat context files located in ``/etc/tomcat8/Catalina/localhost/``, please back them up now or your changes will be lost. After completing the upgrade process, restore the backed up files to ``/etc/tomcat9/Catalina/localhost/``.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Remove the 4.9.0 packages:

   .. code-block:: bash

      apt-get remove suite-*

   Make note of which packages were removed this way.

#. Import the Boundless GPG key:

   .. code-block:: bash

      wget -qO- https://downloads-repo.boundlessgeo.com/GPG-KEY-Boundless | apt-key add -

#. Replace the 4.9.0 repo definition with the new repo definition. Open ``/etc/apt/sources.list.d/boundless.list`` and replace the contents with:

   .. code-block:: none

      deb [arch=amd64] https://<username>:<password>@downloads-repo.boundlessgeo.com/suite-repo/4.9.1/ubuntu trusty main

   Make sure to replace each instance of ``<username>`` and ``<password>`` with the user name and password supplied to you.

   .. note:: Your username is your email address. When entering your username into the ``Boundless.repo`` file, the ``@`` in your username should be preserved as-is.

#. Refresh the apt repo data:

   .. code-block:: bash

      apt-get update

#. Install all Boundless Suite 4.9.1 packages corresponding to the ``suite-*`` packages which were removed in step 1. For example:

   .. code-block:: bash

      apt-get install suite-geoserver suite-docs suite-dashboard


Upgrading from 4.8 and older
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to upgrade Boundless Server 4.8 and earlier to |version| on Ubuntu Linux.

.. warning:: We do **not** recommend upgrading Boundless Server on a production server. Instead, do a new install on new machine, then transfer your data and settings to the new machine.

.. warning::

   Because of the major package changes involved, if you have any version earlier than 4.9.0, it must be uninstalled first.  Make sure you backup your data, configuration, your old 4.8 install, and any other data/software on the system.

   The data directory at ``/var/lib/opengeo/geoserver`` will not be removed during uninstallation.

#. Backup your configuration and data

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Uninstall old packages:

   .. warning:: This will uninstall many packages (including ``tomcat7``, ``postgresql/postgis``, and other common GIS tools). Verify that removing these packages will **not** interfere with other applications running on your system. Ensure you do not have another Tomcat (or other service) on port 8080.

   .. code-block:: bash

      apt-get remove gdal-mrsid \
                     geoexplorer \
                     geoserver \
                     geoserver-* \
                     geowebcache \
                     laszip \
                     laszip-dev \
                     libgdal-opengeo \
                     libgdal-opengeo-dev \
                     libgeos-3.5.0 \
                     libgeos-c1 \
                     libgeos-dev \
                     libgeos-doc \
                     libgeotiff \
                     libgeotiff-dev \
                     libght \
                     libght-dev \
                     libjpeg-turbo-official \
                     libpq5 \
                     libproj-dev \
                     libproj0 \
                     opengeo \
                     opengeo-* \
                     pdal \
                     pdal-dev \
                     pgadmin3 \
                     pgadmin3-data \
                     postgis-* \
                     postgresql-* \
                     proj \
                     proj-bin \
                     proj-data \
                     tomcat7
      apt-get autoremove

#. Remove the reference to the Suite 4.8 repository:

   .. code-block:: bash

      rm /etc/apt/sources.list.d/opengeo.list

#. Continue above in the :ref:`install.ubuntu.packages.install` section. When finished, change your :guilabel:`GEOSERVER_DATA_DIR` environment variable to point to the correct location.

   .. note:: A default installation of Boundless Server, will install a sample GeoServer data directory. Make sure to update the :guilabel:`GEOSERVER_DATA_DIR` environment variable to point to your old data directory, if desired.


.. _install.ubuntu.packages.list:

Package list
------------

Boundless Server is broken up into a number of discrete packages. This section describes all of the available packages.

The packages are managed through the standard package management system for Ubuntu called `apt <https://help.ubuntu.com/community/AptGet/Howto>`_. All packages can be installed with the following command::

  sudo apt-get install <package>

where ``<package>`` is any one of the package names listed below.

Boundless Server web applications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :class: non-responsive

   * - Package
     - Description
   * - ``boundless-server-composer``
     - :ref:`Composer application <webmaps.composer>`
   * - ``boundless-server-dashboard``
     - :ref:`Boundless Server Dashboard <intro.dashboard>`
   * - ``boundless-server-docs``
     - Boundless Server documentation
   * - ``boundless-server-geoserver``
     - GeoServer application
   * - ``boundless-server-geowebcache``
     - GeoWebCache application
   * - ``boundless-server-quickview``
     - QuickView application showcasing the :ref:`WebSDK <webapps.sdk>`
   * - ``boundless-server-wpsbuilder``
     - :ref:`Graphical utility <processing.wpsbuilder>` for executing WPS processes
   * - ``boundless-server-tomcat9``
     - Apache Tomcat application server (automatically installed by these packages)

Boundless Server GeoServer extensions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following packages add additional functionality to GeoServer. After installing any of these packages, you will need to restart Tomcat:

.. code-block:: console

   service tomcat9 restart

For more information, please see the section on :ref:`GeoServer extensions <intro.extensions>`.

.. include:: /install/include/server-gs-packages.txt

Binary packages
~~~~~~~~~~~~~~~

The following major binary packages are available:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :class: non-responsive

   * - Package
     - Description
   * - ``gdal``
     - Main GDAL/OGR binary package
   * - ``gdal-java``
     - Java support for GDAL
   * - ``gdal-devel``
     - Development support for GDAL
   * - ``gdal-mrsid``
     - MrSID plugin for GDAL
   * - ``libjpeg-turbo-official``
     - Libjpeg turbo binaries (version 1.4.2)
   * - ``libnetcdf-bin``
     - NetCDF Binary packages
   * - ``libnetcdf-dev``
     - Development support for the NetCDF Binary
   * - ``postgresql-9.6-postgis-2.5``
     - PostgreSQL and PostGIS
   * - ``proj``
     - PROJ.4 libary
   * - ``libgeos-3.5.0``
     - GEOS (Geometry Engine, Open Source) library
