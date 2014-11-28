.. _intro.installation.ubuntu.install:

Installing
==========
   
.. only:: basic

   This section describes how to perform an installation of **OpenGeo Suite** |version| on Ubuntu Linux. These instructions should be followed if your system does not have OpenGeo Suite installed.

.. only:: enterprise

   This section describes how to perform an installation of **OpenGeo Suite Enterprise** |version| on Ubuntu Linux. These instructions should be followed if your system does not have OpenGeo Suite installed.

.. warning:: Upgrading to OpenGeo Suite Enterprise

   If upgrading to OpenGeo Suite Enterprise from OpenGeo Suite, please see the section on :ref:`intro.installation.ubuntu.upgrade`.

.. warning:: Updating from OpenGeo Suite 4.1.1

   These instructions should **not** be followed when updating from a previous **minor version** of OpenGeo Suite. To update from OpenGeo Suite 4.1.1 see the :ref:`intro.installation.ubuntu.quick` section.
      
.. warning:: Updating from OpenGeo Suite 3.1

   These instructions should **not** be followed when updating from a previous **major version** of OpenGeo Suite. To update from OpenGeo Suite 3.1 see the :ref:`intro.installation.ubuntu.update` section.

.. note:: While QGIS is part of OpenGeo Suite it is not currently bundled as a package by Boundless. To use QGIS with an Ubuntu system, please see the `QGIS community installation instructions <https://www.qgis.org/en/site/forusers/download.html>`_.

System requirements
-------------------

The following Ubuntu versions are supported:

* `Precise Pangolin <http://releases.ubuntu.com/precise/>`_ (12.04 LTS)
* `Trusty Tahr <http://releases.ubuntu.com/trusty/>`_ (14.04 LTS)

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

#. Add the OpenGeo Suite repository.

   .. only:: basic

         * If installing on Precise:

           .. code-block:: bash

              echo "deb http://apt.boundlessgeo.com/suite/v45/ubuntu/ precise main" > /etc/apt/sources.list.d/opengeo.list

         * If installing on Trusty:

           .. code-block:: bash

              echo "deb http://apt.boundlessgeo.com/suite/v45/ubuntu/ trusty main" > /etc/apt/sources.list.d/opengeo.list

   .. only:: enterprise

      Make sure to replace ``<username>`` and ``<password>`` with the user name and password supplied to you after your purchase.

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
