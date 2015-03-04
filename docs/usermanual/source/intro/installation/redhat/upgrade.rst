.. _intro.installation.redhat.upgrade:

Upgrading to OpenGeo Suite Enterprise
=====================================

This section describes how to upgrade OpenGeo Suite to **OpenGeo Suite Enterprise** on Red Hat-based systems.

.. note:: OpenGeo Suite Enterprise can only be obtained through `Boundless <http://boundlessgeo.com>`_. Please `contact us <http://boundlessgeo.com/about/contact-us/sales/>`__ for information on how to purchase OpenGeo Suite Enterprise.

#. To upgrade, you must first :ref:`uninstall <intro.installation.redhat.uninstall>` your current version of OpenGeo Suite. Your data and settings will be preserved.

#. Change to the ``root`` user:

   .. code-block:: bash

      sudo su - 

#. Add the OpenGeo Suite Enterprise repository by replacing the file :file:`/etc/yum.repos.d/OpenGeo.repo` with the following contents::

     [opengeo]
     name=opengeo
     baseurl=https://<username>:<password>@yum-ee.boundlessgeo.com/suite/v45/<OS>/$releasever/$basearch
     enabled=1
     gpgcheck=0

   Make sure to replace ``<username>`` and ``<password>`` with the user name and password supplied to you after your purchase. Also, replace ``<OS>`` with either ``centos`` or ``rhel`` based on your distribution.

   .. note:: If you have OpenGeo Suite Enterprise and do not have a user name and password, please `contact us <http://boundlessgeo.com/about/contact-us/sales>`__.

#. Update the repository list:

   .. code-block:: bash

      yum update

#. Now install the appropriate OpenGeo Suite packages. You have options on what packages to install:

   .. note:: See the :ref:`Packages <intro.installation.redhat.packages>` section for details of individual packages.

   * To install typical server components:

     .. code-block:: bash

        yum install opengeo-server

   * To install typical client components:

     .. code-block:: bash

        yum install opengeo-client

   * To install typical client and server components:

     .. code-block:: bash

        yum install opengeo

#. If you installed any additional packages originally, you can update them now. For example:

   * To update the :ref:`Boundless SDK <webapps.sdk>`:

     .. code-block:: bash

        yum install opengeo-webapp-sdk

   * To update a GeoServer extension such as :ref:`WPS <processing>`:

        yum install geoserver-wps

After upgrade
-------------

The upgrade is now complete. Please see the section on :ref:`intro.installation.redhat.postinstall` to continue.
