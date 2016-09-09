.. _install.ubuntu.packages:

Installing packages on Ubuntu
=============================

This page describes how to perform a package installation of **Boundless Suite** |version| on Ubuntu Linux.

.. note:: For upgrades, see the below section on :ref:`Upgrading <install.ubuntu.packages.upgrade>`.

.. include:: include/sysreq.txt

.. _install.ubuntu.packages.install:

New installation
----------------

This section describes how to perform a clean package installation of **Boundless Suite** |version| on Ubuntu Linux.

See the :ref:`install.ubuntu.packages.list` for details about the possible packages to install.

.. warning:: Mixing repositories is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of Boundless Suite (such as PostgreSQL) please remove them before installing Boundless Suite.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Add the Boundless repository:

   * **Ubuntu 14**:

     .. code-block:: bash

        echo "deb https://<username>:<password>@SERVER trusty main" > /etc/apt/sources.list.d/boundless.list
        echo "deb https://<username>:<password>@SERVER trusty main" > /etc/apt/sources.list.d/boundless.list

        
        deb http://jenkins:Thae9suv@priv-repo.boundlessgeo.com/suite-test-debian/amd64 ./
        deb http://jenkins:Thae9suv@priv-repo.boundlessgeo.com/third-party-debian/amd64 ./


   Make sure to replace each instance of ``<username>`` and ``<password>`` with the user name and password supplied to you.

   .. note:: Please `contact us <http://boundlessgeo.com/about/contact-us/sales>`__ if you have purchased Boundless Suite and do not have a user name and password.

#. Update the repository list:

   .. code-block:: bash

      apt-get update

#. Search for Boundless packages to verify that the repository list is correct. 

   .. code-block:: bash

      apt-cache search suite-

   If the command does not return any results, examine the output of the ``apt-cache`` command for any errors or warnings.

#. You have options on what packages to install. A simple installation including geoserver, documentation, and dashboard is as follows:

   .. code-block:: bash

      apt-get install suite-geoserver suite-docs suite-dashboard 

   A more complete install, including all the suite web applications, Postgresql/Postgres, GDAL, and NetCDF, is as follow:

   .. code-block:: bash

     apt-get install suite-dashboard \
                 suite-geoserver \
                 suite-geowebcache \
                 suite-composer \
                 suite-docs \
                 suite-quickview  \
                 suite-wpsbuilder \
                 postgresql-9.3-postgis-2.1 \
                 suite-gs-gdal \
                 suite-gs-netcdf \
                 suite-gs-netcdf-out 

   .. note::  See the :ref:`install.ubuntu.packages.list` for details of individual packages.

#. Restart the server.

     .. code-block:: bash

        service tomcat8 restart

#. Verify that the installation succeeded by opening your browser and navigating to the following URL:

   * http://localhost:8080/dashboard

   .. image:: /install/include/ext/img/dashboard.png

#. If you see the above image, then Boundless Suite was installed correctly.

#. Please see the section on :ref:`sysadmin.ubuntu` for best practices and additional information.

.. _install.ubuntu.packages.upgrade:

Upgrade
-------

This section describes how to upgrade Boundless Suite 4.x to |version| on Ubuntu Linux.

Because of the major package changes involved, if you have any version earlier than 4.9, it **must** be uninstalled first.

.. note:: The data directory at ``/var/lib/opengeo/geoserver`` will not be removed.

#. Backup your configuration and data

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Uninstall old packages:

   .. note:: This will uninstall several packages (including tomcat7).  Verify that removing these packages will not interfer with other applications running on your system.  Ensure you do not have another tomcat (or other server) on port 8080.

   .. code-block:: bash

       apt-get remove tomcat7   \
          geoexplorer \
          libgeos-3.5.0 \
          libgeos-c1  \
          libgeos-dev \
          libgeos-doc \
          geoserver \
          geoserver-* \
          geowebcache \
          libght \
          libght-dev  \
          laszip \
          laszip-dev  \
          libgeotiff  \
          libgeotiff-dev \
          libjpeg-turbo-official  \
          opengeo \
          opengeo-*  \
          pdal \
          pdal-dev \
          pgadmin3 \
          pgadmin3-data \
          postgresql-9.3-pointcloud\
          postgis-2.1 \
          postgresql-9.3-postgis-2.1\
          libpq5 \
          postgresql-9.3   \
          postgresql-client-9.3 \
          postgresql-client-common  \
          postgresql \
          libproj0 \
          libproj-dev \
          proj\
          proj-bin  \
          proj-data  \
          libgdal-opengeo-dev \
          libgdal-opengeo \
          gdal-mrsid    


     apt-get autoremove

#. Remove the reference to the Suite 4.8 repository

   .. code-block:: bash

     rm /etc/apt/sources.list.d/opengeo.list

#. Continue above in the :ref:`install.ubuntu.packages.install` section, and use :file:`/var/lib/opengeo/geoserver` as your :guilabel:`GEOSERVER_DATA_DIR`

.. _install.ubuntu.packages.list:

Package list
------------

Boundless Suite is broken up into a number of discrete packages. This section describes all of the available packages.

The packages are managed through the standard package management system for Ubuntu called `apt <https://help.ubuntu.com/community/AptGet/Howto>`_. All packages can be installed with the following command::

  sudo apt-get install <package>

where ``<package>`` is any one of the package names listed below.

Main Suite Web Applications

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :class: non-responsive

   * - Package
     - Description
   * - ``suite-composer``
     - :ref:`Composer application <webmaps.composer>`
   * - ``suite-dashboard``
     - :ref:`Boundless Suite Dashboard <intro.dashboard>`
   * - ``suite-docs``
     - Boundless Suite documentation
   * - ``suite-geoserver``
     - GeoServer application
   * - ``suite-geowebcache``
     - GeoWebCache application
   * - ``suite-quickview``
     - QuickView application showcasing the :ref:`WebSDK <webapps.sdk>`
   * - ``suite-wpsbuilder``
     - :ref:`Graphical utility <processing.wpsbuilder>` for executing WPS processes
   * - ``suite-tomcat8``
     - Apache Tomcat application server (automatically installed by these packages)


The following packages add additional functionality to GeoServer. After installing any of these packages, you will need to restart Tomcat:

.. code-block:: console

   service tomcat8 restart

For more information, please see the section on :ref:`GeoServer extensions <intro.extensions>`.

The following Geoserver extension packages are available:

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :class: non-responsive

   * - Package
     - Description
   * - ``suite-gs-arcsde``
     - ArcSDE middleware extension
   * - ``suite-gs-app-schema``
     - Application Schema support
   * - ``suite-gs-cloudwatch``
     - Connection to :ref:`Amazon CloudWatch <sysadmin.cloudwatch>` monitoring
   * - ``suite-gs-cluster``
     - Clustering extension. Use with ``suite-gs-jdbcconfig``.
   * - ``suite-gs-csw``
     - Catalogue Service for Web (CSW) extension
   * - ``suite-gs-db2``
     - DB2 database extension
   * - ``suite-gs-gdal``
     - GDAL extension
   * - ``suite-gs-geomesa-accumulo``
     - :ref:`GeoMesa <dataadmin.geomesa>` data source support
   * - ``suite-gs-geopkg``
     - GeoPackage extension
   * - ``suite-gs-grib``
     - GRIB data format extension
   * - ``suite-gs-inspire``
     - Additional WMS and WFS metadata configuration for INSPIRE compliance
   * - ``suite-gs-jdbcconfig``
     - Database catalog and configuration extension. Use with ``suite-gs-cluster``.
   * - ``suite-gs-jdbcstore``
     - JDBCStore extension
   * - ``suite-gs-jp2k``
     - JPEG2000 extension
   * - ``suite-gs-mbtiles``
     - MBTiles extension
   * - ``suite-gs-mongodb``
     - MongoDB data format extension
   * - ``suite-gs-netcdf``
     - NetCDF data format support (read-only)
   * - ``suite-gs-netcdf-out``
     - NetCDF data format support (output)
   * - ``suite-gs-oracle``
     - Oracle database extension
   * - ``suite-gs-script``
     - Scripting (Python) extension
   * - ``suite-gs-sqlserver``
     - SQL Server database extension
   * - ``suite-gs-vectortiles``
     - Vector tiles extension
   * - ``suite-gs-wps``
     - Web Processing Service (WPS) extension

The following major Binary Packages are available;

.. list-table::
   :header-rows: 1
   :widths: 30 70
   :class: non-responsive

   * - Package
     - Description
   * - ``libgdal``
     - Main GDAL/OGR binary package
   * - ``libgdal-java``
     - Java support for GDAL
   * - ``libgdal-dev``
     - Development support for GDAL
   * - ``gdal-mrsid``
     - MrSID plugin for GDAL
   * - ``libjpeg-turbo-official``
     - Libjpeg turbo binaries (version 1.4.2)
   * - ``netcdf-bin``
     - NetCDF Binary packages 
   * - ``netcdf-dev``
     - Development support for the NetCDF Binary 
   * - ``postgresql-9.3-postgis-2.1``
     - Postgresql 9.3 and PostGIS 2.1
   * - ``postgresql-9.3-pointcloud``
     - Pointcloud for postgresql 
   * - ``pdal``
     - PDAL (Point Data Abstraction Library)
   * - ``pdal-dev``
     - Development support for PDAL
   * - ``proj``
     - PROJ.4 libary
   * - ``libgeos-3.5.0``
     - GEOS (Geometry Engine, Open Source) Library
