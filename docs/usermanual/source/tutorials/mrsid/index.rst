.. _dataadmin.mrsid:

Enabling MrSID Support
======================

The OpenGeo Suite comes with support for publishing data from many formats supported by the `Geospatial Data Abstraction Library <http://gdal.org>`_ (GDAL).  These formats include DTED, EHdr, AIG, ENVIHdr, and much more.

MrSID (LINK) is available to be published as well, but due to licensing issues, it is not enabled by default, so a few extra steps will be needed in order to enable its support.  These steps differ depending on how the OpenGeo Suite is installed, and on what platform.

Read on to find the section that matches your installation.

.. _prodwars:

Production WARs
---------------

.. note::

  By default, the Production WAR install will not show **any** of the GDAL image formats at all.  To enable GDAL image formats in the Production WAR file, please see the section on :ref:`dataadmin.gdal`.  This section assumes that the GDAL image formats (minus MrSID) are available.

Linux
~~~~~

Windows
~~~~~~~

Mac OS X
~~~~~~~~




Linux
-----

.. note:: This section for the OpenGeo Suite installed via Linux packages .  (INSTALL LINK).  If deployed manually via downloaded WARs, please see the :ref:`prodwars` section.

MrSID support is provided by a separate package called **gdal-mrsid**.  It is available through the standard OpenGeo APT and RPM repositories, the same repositiories as from where the OpenGeo Suite was downloaded.

You should have the OpenGeo repostiory added to your local listing.  If not, please see the section on INSTALLATION (LINK) for details on how to (re-)add it.

When the OpenGeo repository is added to your local listing, installing this package is just like instllaling any other Linux package:

For Ubuntu-based systems::

  # apt-get install gdal-mrsid

For Red Hat / CentOS systems:

  # yum install gdal-mrsid

.. note::  You must run these commands as root or use :command:`sudo`.

Once the package is installed, restart Tomcat to allow the changes to take effect::

  # service tomcat6 restart

.. warning:: CHECK THIS

Continue at the :ref:`dataadmin.mrsid.verify` section.

Windows
-------

.. note:: This section for the OpenGeo Suite installed via the Windows installer.  (INSTALL LINK).  If deployed manually via downloaded WARs, please see the :ref:`prodwars` section. 

MrSID support is enabled during the installation process.

#. Navigate through the installer until you reach the :guilabel:`Choose Components` page.

   .. figure:: img/mrsid_win_components.png
      :align: center
      
      *The Components page of the Windows installer*

#. Scroll down to the :guilabel:`Extensions` option, and expand the tree.  Check the box for :guilabel:`MrSID`.

   .. figure:: img/mrsid_win_checked.png
      :align: center
      
      *Enabling the MrSID extension*

.. warning:: IS THERE A WAY TO DO THIS AFTER INSTALL?

#. Click :guilabel:`Next` and continue the installation process. 

Continue reading at the :ref:`dataadmin.mrsid.verify` section.


Mac OS X
--------

.. note:: This section for the OpenGeo Suite installed via the OS X installer.  (INSTALL LINK).  If deployed manually via downloaded WARs, please see the :ref:`prodwars` section. 

MrSID support is enabled during the installation process.

#. On the first page of the installer, click :guilabel:`Customize`.

   .. figure:: img/mrsid_mac_customize.png
      :align: center
      
      *Click Customize to select optional components*
      

#. On the next page, check the box that says :guilabel:`MrSID Support for OpenGeo Suite`, then click :guilabel:`Next`.

   .. figure:: img/mrsid_mac_check.png
      :align: center
      
      *Check this box to enable the MrSID extension*

#. Click :guilabel:`Next` and continue the installation process. 

If the openGeo Suite was installed without mrSID support, simply re-run the original installer again, following the steps above.  The extension will be added to the existing installation.

Continue reading at the :ref:`dataadmin.mrsid.verify` section.

.. _dataadmin.mrsid.verify:

Verifying installation
----------------------

#. To verify that the MrSID extension was installed properly, navigate to the GeoServer web admin interface and log in with administrator credentials.

   .. note:: Please see the GeoServer reference documentation for more information about the GeoServer web admin interface.
   
#. Click on :guilabel:`Stores` and then :guilabel:`Add new Store` .  There should be a :guilabel:`MrSID` option under :guilabel:`Raster Data Formats`.

   .. figure:: img/mrsid_verify.png
      :align: center
      
      *Verifying that MrSID is an option in the Raster Data Sources*

