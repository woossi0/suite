.. _intro.installation.redhat.minorupdate:

Updating a minor version
========================

This section describes how to perform a minor update from OpenGeo Suite 4.x to |version| on Red Hat-based Linux distributions.

.. note::

   * For new installations, please see the section on :ref:`intro.installation.redhat.install`.
   * For upgrading to **OpenGeo Suite Enterprise**, please see the section on :ref:`intro.installation.redhat.upgrade`.
   * For updating from a previous **major version** of OpenGeo Suite (3.x), please see the :ref:`intro.installation.redhat.majorupdate` section.

.. note:: While QGIS is part of OpenGeo Suite, is not currently bundled as a package by Boundless. To use QGIS with a Red Hat system, please see the `QGIS community installation instructions <https://www.qgis.org/en/site/forusers/download.html>`_.

.. include:: include/sysreq.txt

Pre-installation process
------------------------

This installation will add the OpenGeo Suite package repository and then install the appropriate packages. See the :ref:`Packages <intro.installation.redhat.packages>` section for details about the possible packages to install.

.. warning:: Mixing repositories is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of OpenGeo Suite (such as PostgreSQL) please remove them before installing OpenGeo Suite.

The commands in this section require root privileges. 

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su - 

#. Add the OpenGeo Suite repository by creating the file :file:`/etc/yum.repos.d/OpenGeo.repo` with the following contents:

   .. only:: basic

      ::

        [opengeo]
        name=opengeo
        baseurl=http://yum.boundlessgeo.com/suite/v45/<OS>/$releasever/$basearch
        enabled=1
        gpgcheck=0

      Make sure to replace ``<OS>`` with either ``centos`` or ``rhel`` based on your distribution.

   .. only:: enterprise

      ::

        [opengeo]
        name=opengeo
        baseurl=https://<username>:<password>@yum-ee.boundlessgeo.com/suite/v45/<OS>/$releasever/$basearch
        enabled=1
        gpgcheck=0

      Make sure to replace ``<username>`` and ``<password>`` with the user name and password supplied to you after your purchase. Also, replace ``<OS>`` with either ``centos`` or ``rhel`` based on your distribution.

      .. note:: If you have OpenGeo Suite Enterprise and do not have a user name and password, please `contact us <http://boundlessgeo.com/about/contact-us/sales>`__.

Installation process
--------------------

#. Search for OpenGeo Suite packages to verify that the repository list is correct. If the command does not return any results, examine the output of the ``yum`` command for any errors or warnings.

   .. code-block:: bash

      yum search opengeo

#. Run the following commands to remove the previous OpenGeo Suite Tomcat package:

   .. code-block:: bash

      rpm -e --nodeps --noscripts opengeo-tomcat 
      yum remove tomcat6

#. You have options on what packages to install:

   .. note::  See the :ref:`Packages <intro.installation.redhat.packages>` section for details of individual packages.

   * To install typical server components:

     .. code-block:: bash

        yum install opengeo-server

   * To install typical client components:

     .. code-block:: bash

        yum install opengeo-client

   * To install typical client and server components:

     .. code-block:: bash

        yum install opengeo

  .. note:: If you encounter an error where gdal failed to install, you may need to manually uninstall gdal-filegdb:

      .. code-block:: bash

         yum remove gdal-filegdb

#. Be sure to update any all additional See the :ref:`packages <intro.installation.redhat.packages>` that you installed originally. For example:

   * To update the :ref:`Boundless SDK <webapps.sdk>`:

     .. code-block:: bash

        yum install opengeo-webapp-sdk

   * To update a GeoServer extension such as :ref:`WPS <processing>`:

        yum install geoserver-wps

After update
------------

The update is now complete. Please see the section on :ref:`intro.installation.redhat.postinstall` to continue.
