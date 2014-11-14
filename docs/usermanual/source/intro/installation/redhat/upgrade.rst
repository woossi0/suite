.. _intro.installation.redhat.upgrade:

Upgrading to OpenGeo Suite Enterprise
=====================================

This section describes how to upgrade OpenGeo Suite to OpenGeo Suite Enterprise.

.. note:: OpenGeo Suite Enterprise can only be obtained through `Boundless <http://boundlessgeo.com>`_. Please `contact us <http://boundlessgeo.com/about/contact-us/sales/>`_ for information on how to purchase OpenGeo Suite Enterprise.

On Red Hat-based systems, the additional functionality available through OpenGeo Suite Enterprise can be enabled by adding packages from a separate repository.

#. Make sure that your current instance is up-to-date. Please see the section on :ref:`updating <intro.installation.redhat.update>` OpenGeo Suite.

#. Add the OpenGeo Suite Enterprise repository. This repository contains all the Enterprise-specific features.

   .. todo:: Need information about CentOS Enterprse packages.

   .. note:: If you have OpenGeo Suite Enterprise and do not have a user name and password, please `contact us <http://boundlessgeo.com/about/contact-us/sales>`_.

#. Update the repository list:

   .. code-block:: bash

      yum update

.. todo:: Need information on the new packages to install
