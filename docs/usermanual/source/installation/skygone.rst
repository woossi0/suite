.. _installation.skygone:

OpenGeo Suite on Skygone Cloud Hosting
======================================

The OpenGeo Suite is available as part of `Skygone <http://skygoneinc.com>`_ managed hosting solutions.  The OpenGeo Suite is available in six different tiers, in order of increasing processing power:

.. list-table::
   :widths: 40 20
   :header-rows: 1

   * - Name / Size
     - Cost per month
   * - Developer Slim
     - $89
   * - Developer Small
     - $249
   * - Production Small
     - $469
   * - Production Medium
     - $699
   * - Production Large
     - $1,279
   * - Production Extra Large
     - $2,449


.. note:: Details about the instances (number of CPUs, etc.) can be found on the Skygone `OpenGeo GIS Marketplace <https://www.thegismarketplace.com/category/101/OpenGeo>`_ page.

The process for signing up for any of these tiers is exactly the same.  Only the features and pricing differ.

Signing up
----------

#. Navigate to the `OpenGeo GIS Marketplace <https://www.thegismarketplace.com/category/101/OpenGeo>`_ page.

#. Select the tier you wish to purchase.  

   .. note:: For the free trial, select the :guilabel:`OpenGeo Cloud Edition - Mini (3-Day Free Trial)` tier.

#. Click :guilabel:`Add To Cart` on the next page.  If you have a Skygone account, sign in to it, otherwise you can register for a new account.

#. Go through the checkout process.  After checkout, you will get an email from Skygone with information about how to connect to your instance.


Logging in
----------

The OpenGeo Suite Dashboard allows you to manage virtually all components of the OpenGeo Suite from one convenient interface.  To view the OpenGeo Suite, navigate to::

  http://<IP>:8080/dashboard/

where ``<IP>`` is the IP address of your instance.  This address will be contained in the email you will receive from Skygone.  If you selected a Server Name in the above sign up form, your server will be available at::

  http://<SERVERNAME>.skygone.net:8080/dashboard/

Skygone also has a Control Panel where you can manage the details of your server.  Details on connecting to it will be available as part of your initial setup information.

