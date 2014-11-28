.. _intro.installation.redhat.quick:

Minor Update
============

.. only:: basic

   This section describes how to perform minor a minor update from OpenGeoSuite 4.1.1 to **OpenGeo Suite** |version| on Red Hat-based Linux distributions. This procedure should be followed when updating from a **minor** version of OpenGeo Suite.

.. only:: enterprise

   This section describes how to perform minor update from OpenGeoSuite 4.1.1 to **OpenGeo Suite Enterprise** |version| on Red Hat-based Linux distributions. This procedure should be followed when updating from a **minor** version of OpenGeo Suite.
   
.. warning:: Upgrading to OpenGeo Suite Enterprise

   If upgrading to OpenGeo Suite Enterprise |version| from OpenGeo Suite, please see the section on :ref:`intro.installation.redhat.upgrade`.
      
.. warning:: Updating from OpenGeo Suite 3.1

   These instructions should **not** be followed when updating from a previous **major version** of OpenGeo Suite. To update from OpenGeo Suite 3.1 see the :ref:`intro.installation.redhat.update` section.
   
.. note:: QGIS, while part of OpenGeo Suite, is not currently bundled as a package by Boundless. To use QGIS with a Red Hat system, please see the `QGIS community installation instructions <https://www.qgis.org/en/site/forusers/download.html>`_.

System requirements
-------------------

The following distributions are supported:

* Fedora 18 and 19
* CentOS 6
* RHEL 6

OpenGeo Suite for Red Hat has the following system requirements:

* Memory: 512MB minimum (1GB recommended)
* Disk space: 750MB minimum (plus extra space for any loaded data)
* Browser: Any modern web browser is supported
* Permissions: Super user privileges are required for installation

Pre-installation process
------------------------

.. only:: basic

   This installation will add the OpenGeo Suite package repository and then install the appropriate packages. See the :ref:`Packages <intro.installation.redhat.packages>` section for details about the possible packages to install.

.. only:: enterprise

   This installation will add the OpenGeo Suite Enterprise package repositories and then install the appropriate packages. See the :ref:`Packages <intro.installation.redhat.packages>` section for details about the possible packages to install.

.. warning:: Mixing repositories is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of OpenGeo Suite (such as PostgreSQL) please remove them before installing OpenGeo Suite.

The commands in this section require root privileges. 

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su - 

.. only:: basic

   #. Add the OpenGeo Suite repository by creating the file :file:`/etc/yum.repos.d/OpenGeo.repo` with the following contents::

        [opengeo]
        name=opengeo
        baseurl=http://yum.boundlessgeo.com/suite/v45/<OS>/$releasever/$basearch
        enabled=1
        gpgcheck=0

      Make sure to replace ``<OS>`` with one of ``fedora``, ``centos``, or ``rhel`` based on your distribution.

.. only:: enterprise

   #. Add the OpenGeo Suite Enterprise repository by creating the file :file:`/etc/yum.repos.d/OpenGeo.repo` with the following contents::

        [opengeo]
        name=opengeo
        baseurl=https://<username>:<password>@yum-ee.boundlessgeo.com/suite/v45/<OS>/$releasever/$basearch
        enabled=1
        gpgcheck=0

      Make sure to replace ``<username>`` and ``<password>`` with the user name and password supplied to you after your purchase. Also, replace ``<OS>`` with one of ``fedora``, ``centos``, or ``rhel`` based on your distribution.

      .. note: If you have OpenGeo Suite Enterprise and do not have a user name and password, please `contact us <http://boundlessgeo.com/about/contact-us/sales>`_.

Installation process
--------------------

#. Search for OpenGeo Suite packages to verify that the repository list is correct. If the command does not return any results, examine the output of the ``yum`` command for any errors or warnings.

   .. code-block:: bash

      yum search opengeo

#. Run the following command to remove the previous OpenGeo Suite Tomcat package:

   .. code-block:: bash

      rpm -e tomcat6 tomcat6-lib tomcat6-el-2.1-api tomcat6-servlet-2.5-api tomcat6-jsp-2.1-api opengeo-tomcat-4.1

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

#. Be sure to update any all additional See the :ref:`packages <intro.installation.redhat.packages>` that you installed originally. For example:

   * To update the :ref:`Boundless SDK <webapps.sdk>`:

     .. code-block:: bash

        yum install opengeo-webapp-sdk

   * To update a GeoServer extension such as :ref:`WPS <processing>`:

        yum install geoserver-wps

After update
------------

Update is now complete. Please see the section on :ref:`intro.installation.redhat.misc` for for common tasks and additional configuration and compatibility settings.
