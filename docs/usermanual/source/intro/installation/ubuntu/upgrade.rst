.. _intro.installation.ubuntu.upgrade:

Upgrading to OpenGeo Suite Enterprise
=====================================

This section describes how to upgrade OpenGeo Suite to OpenGeo Suite Enterprise.

.. note:: OpenGeo Suite Enterprise can only be obtained through `Boundless <http://boundlessgeo.com>`_. Please `contact us <http://boundlessgeo.com/about/contact-us/sales/>`_ for information on how to purchase OpenGeo Suite Enterprise.

On Ubuntu, the additional functionality available through OpenGeo Suite Enterprise can be enabled by adding packages from a separate repository.

#. Make sure that your current instance is up-to-date. Please see the section on :ref:`updating <intro.installation.ubuntu.update>` OpenGeo Suite.

#. Add the OpenGeo Suite Enterprise repository. This repository contains all the Enterprise-specific features. Make sure to replace ``<username>`` and ``<password>`` with the user name and password supplied to you after your purchase.

   * If installing on Precise:

     .. code-block:: bash

        echo "deb http://<username>:<password>@apt-ee.boundlessgeo.com/suite/v45/ubuntu/ precise main" >> /etc/apt/sources.list.d/opengeo.list

   * If installing on Trusty:

     .. code-block:: bash

        echo "deb http://<username>:<password>@apt-ee.boundlessgeo.com/suite/v45/ubuntu/ trusty main" >> /etc/apt/sources.list.d/opengeo.list

   .. note:: If you have OpenGeo Suite Enterprise and do not have a user name and password, please `contact us <http://boundlessgeo.com/about/contact-us/sales>`_.

#. Update the repository list:

   .. code-block:: bash

      apt-get update

.. todo:: Need information on the new packages to install
