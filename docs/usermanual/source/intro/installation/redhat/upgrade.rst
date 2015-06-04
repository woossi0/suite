.. _intro.installation.redhat.upgrade:

Upgrading to OpenGeo Suite Enterprise
=====================================

This section describes how to upgrade OpenGeo Suite to **OpenGeo Suite Enterprise** on Red Hat-based systems.

.. note:: OpenGeo Suite Enterprise can only be obtained through `Boundless <http://boundlessgeo.com>`_. Please `contact us <http://boundlessgeo.com/about/contact-us/sales/>`__ for information on how to purchase OpenGeo Suite Enterprise.

On a system that already has OpenGeo Suite:

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

#. Clean the metadata for existing packages:

   .. code-block:: bash

      yum clean metadata

#. Now you can reinstall the existing packages, which will now include the OpenGeo Suite Enterprise components. Currently all of the Enterprise-specific components are contained in the ``geoserver`` package:

   .. code-block:: bash

      yum reinstall geoserver

#. You can now install additional packages as well, such as new :ref:`extensions <intro.extensions>`. For example, to install the :ref:`MongoDB <dataadmin.mongodb>` extension:

   .. code-block:: bash

      yum install geoserver-mongodb

   .. note:: See the :ref:`Packages <intro.installation.redhat.packages>` section for details about individual packages.

After upgrade
-------------

The upgrade is now complete. Please see the section on :ref:`intro.installation.redhat.postinstall` to continue.
