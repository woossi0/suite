.. _intro.installation.ubuntu.packages:

Installing packages on Ubuntu
=============================

This page describes how to perform a package installation of **Boundless Suite** |version| on Ubuntu Linux.

.. note:: For upgrades, see the below section on :ref:`Upgrading <intro.installation.ubuntu.packages.upgrade>`.

.. include:: include/sysreq.txt

.. _intro.installation.ubuntu.packages.install:

New installation
----------------

This section describes how to perform a clean package installation of **Boundless Suite** |version| on Ubuntu Linux.

See the :ref:`intro.installation.ubuntu.packages.list` for details about the possible packages to install.

.. warning:: Mixing repositories is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of Boundless Suite (such as PostgreSQL) please remove them before installing Boundless Suite.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Add the Boundless repository:

   * **Ubuntu 12**:

     .. code-block:: bash

        echo "deb https://<username>:<password>@SERVER precise main" > /etc/apt/sources.list.d/boundless.list

   * **Ubuntu 14**:

     .. code-block:: bash

        echo "deb https://<username>:<password>@SERVER trusty main" > /etc/apt/sources.list.d/boundless.list

   .. warning:: VERIFY SERVER

   Make sure to replace each instance of ``<username>`` and ``<password>`` with the user name and password supplied to you.

   .. note:: Please `contact us <http://boundlessgeo.com/about/contact-us/sales>`__ if you have purchased Boundless Suite and do not have a user name and password.

#. Update the repository list:

   .. code-block:: bash

      apt-get update

#. Search for Boundless packages to verify that the repository list is correct. 

   .. code-block:: bash

      apt-get search suite-

   If the command does not return any results, examine the output of the ``apt-get`` command for any errors or warnings.

#. You have options on what packages to install. A standard installation including common packages is as follows:

   .. code-block:: bash

      apt-get install PACKAGES

   .. warning:: NEED PACKAGE LIST

   .. note::  See the :ref:`intro.installation.ubuntu.packages.list` for details of individual packages.

#. Restart the server.

     .. code-block:: bash

        service tomcat8 restart

#. Verify that the installation succeeded by opening your browser and navigating to the following URL:

   * http://localhost:8080/dashboard

   .. warning:: ADD IMAGE

#. If you see the above image, then Boundless Suite was installed correctly.

#. Please see the section on :ref:`sysadmin.ubuntu` for best practices and additional information.

.. _intro.installation.ubuntu.packages.upgrade:

Upgrade
-------

This section describes how to upgrade Boundless Suite 4.x to |version| on Ubuntu Linux.

Because of the package changes involved, if you have any version earlier than 4.9, it will need to be uninstalled first.

.. note:: The data directory at ``/var/lib/opengeo/geoserver`` will not be removed.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su -

#. Uninstall old packages:

   .. code-block:: bash

      yum remove PACKAGES

   .. warning:: NEED PACKAGE LIST

#. Continue above in the :ref:`intro.installation.ubuntu.packages.install` section.

.. _intro.installation.ubuntu.packages.list:

Package list
------------

Boundless Suite is broken up into a number of discrete packages. This section describes all of the available packages.

The packages are managed through the standard package management system for Ubuntu called `apt <https://help.ubuntu.com/community/AptGet/Howto>`_. All packages can be installed with the following command::

  sudo apt-get install <package>

where ``<package>`` is any one of the package names listed below.

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
   * - ``suite-tomcat8``
     - Apache Tomcat application server
   * - ``suite-wpsbuilder``
     - :ref:`Graphical utility <processing.wpsbuilder>` for executing WPS processes

.. warning:: NEED MORE PACKAGE NAMES

The following packages add additional functionality to GeoServer. After installing any of these packages, you will need to restart Tomcat:

.. code-block:: console

   service tomcat8 restart

For more information, please see the section on :ref:`GeoServer extensions <intro.extensions>`.

The following packages are available:

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
   * - ``suite-gs-geopackage``
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

.. warning:: NEED MORE PACKAGE NAMES
