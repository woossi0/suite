.. _intro.installation.ubuntu.install:

Installing
==========

.. only:: basic

   This section describes how to perform an installation of **OpenGeo Suite** |version| on Ubuntu Linux.

   .. note:: If upgrading to OpenGeo Suite Enterprise from OpenGeo Suite, please see the section on :ref:`intro.installation.ubuntu.upgrade`.

.. only:: enterprise

   This section describes how to perform an installation of **OpenGeo Suite Enterprise** |version| on Ubuntu Linux.

These instructions should be followed if:

* Your system does not have OpenGeo Suite
* You are updating from a **minor version** of OpenGeo Suite (for example: from **4.x** to **4.y**)

If updating from a previous **major version** of OpenGeo Suite (for example: from **3.x** to **4.y**), see the :ref:`intro.installation.ubuntu.update` section.

.. note:: QGIS, while part of OpenGeo Suite, is not currently bundled as a package by Boundless. To use QGIS with an Ubuntu system, please see the `QGIS community installation instructions <https://www.qgis.org/en/site/forusers/download.html>`_.

System requirements
-------------------

The following Ubuntu versions are supported:

* `Precise Pangolin <http://releases.ubuntu.com/precise/>`_ (12.04 LTS)
* `Trusty Tahr <http://releases.ubuntu.com/trusty/>`_ (14.04 LTS)

.. warning::

   OpenGeo Suite is not supported on any other versions of Ubuntu. If running an unsupported installation, dependency conflicts may occur.

OpenGeo Suite for Ubuntu Linux has the following system requirements:

* Memory: 512MB minimum (1GB recommended)
* Disk space: 750MB minimum (plus extra space for any loaded data)
* Browser: Any modern web browser is supported
* Permissions: Super user privileges are required for installation

Pre-installation process
------------------------

This installation will add the OpenGeo Suite package repository and then install the appropriate packages. See the :ref:`Packages <intro.installation.ubuntu.packages>` section for details about the possible packages to install.

.. warning:: Mixing repositories with is not recommended. If you already have a community (non-Boundless) repository that contains some of the components of OpenGeo Suite (such as PostgreSQL) please remove them before installing OpenGeo Suite.

The commands in this section require root privileges. 

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su - 

#. Import the Boundless GPG key:

   .. code-block:: bash

      wget -qO- http://apt.boundlessgeo.com/gpg.key | apt-key add - 

.. only:: basic

   #. Add the OpenGeo Suite repository.

      * If installing on Precise:

        .. code-block:: bash

           echo "deb http://apt.boundlessgeo.com/suite/v45/ubuntu/ precise main" >> /etc/apt/sources.list.d/opengeo.list

      * If installing on Trusty:

        .. code-block:: bash

           echo "deb http://apt.boundlessgeo.com/suite/v45/ubuntu/ trusty main" >> /etc/apt/sources.list.d/opengeo.list

.. only:: enterpise

   #. Add the OpenGeo Suite Enterprise repository. Make sure to replace ``<username>`` and ``<password>`` with the user name and password supplied to you after your purchase.

      * If installing on Precise:

        .. code-block:: bash

           echo "deb https://<username>:<password>@apt-ee.boundlessgeo.com/suite/v45/ubuntu/ precise main" >> /etc/apt/sources.list.d/opengeo.list

      * If installing on Trusty:

        .. code-block:: bash

           echo "deb https://<username>:<password>@apt-ee.boundlessgeo.com/suite/v45/ubuntu/ trusty main" >> /etc/apt/sources.list.d/opengeo.list

      .. note: If you have OpenGeo Suite Enterprise and do not have a user name and password, please `contact us <http://boundlessgeo.com/about/contact-us/sales>`_.

Installation process
--------------------

#. Update the repository list:

   .. code-block:: bash

      apt-get update

#. Search for OpenGeo Suite packages to verify that the repository list is correct. If the command does not return any results, examine the output of the ``apt`` command for any errors or warnings.

   .. code-block:: bash

      apt-cache search opengeo

#. You have options on what packages to install:

   .. note::  See the :ref:`Packages <intro.installation.ubuntu.packages>` section for details of individual packages.

   * To install typical server components:

     .. code-block:: bash

        apt-get install opengeo-server

   * To install typical client components:

     .. code-block:: bash

        apt-get install opengeo-client

   * To install typical client and server components:

     .. code-block:: bash

        apt-get install opengeo

After installation
------------------

Installation is now complete. Please see the section on :ref:`intro.installation.ubuntu.misc`.
