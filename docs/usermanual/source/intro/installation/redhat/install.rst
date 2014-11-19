.. _intro.installation.redhat.install:

Installing
==========

.. only:: basic

   This section describes how to perform an installation of **OpenGeo Suite** |version| on Red Hat-based Linux distributions.

   .. note:: If upgrading to OpenGeo Suite Enterprise from OpenGeo Suite, please see the section on :ref:`intro.installation.redhat.upgrade`.

.. only:: enterprise

   This section describes how to perform an installation of **OpenGeo Suite Enterprise** |version| on Red Hat-based Linux distributions.

These instructions should be followed if:

* Your system does not have OpenGeo Suite
* You are upgrading from a **minor version** of OpenGeo Suite (for example: from **4.x** to **4.y**)

If upgrading from a previous **major version** of OpenGeo Suite (for example: from **3.x** to **4.y**), see the :ref:`intro.installation.redhat.update` section.

.. note:: QGIS, while part of OpenGeo Suite, is not currently bundled as a package by Boundless. To use QGIS with an Red Hat system, please see the `QGIS community installation instructions <https://www.qgis.org/en/site/forusers/download.html>`_.

System requirements
-------------------

The following distributions are supported:

* Fedora 18 and 19
* CentOS 5 and 6
* RHEL 5 and 6

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

   This installation will add the OpenGeo Suite package repositories and then install the appropriate packages. See the :ref:`Packages <intro.installation.redhat.packages>` section for details about the possible packages to install.

.. warning:: Mixing repositories with is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of OpenGeo Suite (such as PostgreSQL) please remove them before installing OpenGeo Suite.

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

After installation
------------------

Installation is now complete. Please see the section on :ref:`intro.installation.redhat.misc`.
