.. _dataadmin.mrsid:

Enabling MrSID image support
============================

Boundless Suite comes with support for publishing data from many formats supported by the `Geospatial Data Abstraction Library <http://gdal.org>`_ (GDAL). These formats include DTED, EHdr, AIG, ENVIHdr, and much more.

`MrSID <http://www.gdal.org/frmt_mrsid.html>`_ is available as an optional extension as well, but due to licensing issues, it is not enabled by default. The steps to enable support will differ depending on how Boundless Suite is installed, and on what platform.

Find the method of installation below and continue there.

Installation
------------

Ubuntu
~~~~~~

.. note:: By default, Boundless Suite for Applications Servers (WAR bundle) will not show **any** of the GDAL image formats at all. To enable GDAL image formats in this type of installation, please see the section on :ref:`dataadmin.gdal`. This section assumes that the GDAL image formats are already enabled.

MrSID support is provided by a separate package called **gdal-mrsid**.

#. Install the following package from the OpenGeo repository. (See :ref:`intro.installation.ubuntu.packages` for instructions on how to add the OpenGeo repository)::

      apt-get install gdal-mrsid

   .. note::  You must run these commands as root or use :command:`sudo`.

#. Restart Tomcat.

Continue at the :ref:`dataadmin.mrsid.verify` section.

CentOS / Red Hat
~~~~~~~~~~~~~~~~

.. note:: By default, Boundless Suite for Application Servers will not show **any** of the GDAL image formats at all. To enable GDAL image formats in this type of install, please see the section on :ref:`dataadmin.gdal`. This section assumes that the GDAL image formats are already enabled.

MrSID support is provided by a separate package called **gdal-mrsid**.

#. Install the following package from the OpenGeo repository. (See :ref:`intro.installation.redhat.packages` for instructions on how to add the OpenGeo repository)::

      yum install gdal-mrsid

   .. note::  You must run this command as root or use :command:`sudo`.

#. Copy :file:`/usr/lib/gdal.jar` (:file:`/usr/lib64/gdal.jar` on 64-bit installs) to :file:`/usr/share/tomcat6/webapps/geoserver/WEB-INF/lib/gdal-1.8.1.jar`.

   .. note:: You may need to replace ``tomcat6`` with ``tomcat5`` in the above path depending on the server configuration.

#. Restart Tomcat.

Continue reading at the :ref:`dataadmin.mrsid.verify` section.

Windows (Application server)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Navigate to:  http://data.boundlessgeo.com/gdal_support/ .

#. Download the file that matches the version of Boundless Suite (e.g. :file:`mrsid_win_30.zip` for version 3.0).

   .. note:: This file requires 32-bit Java/Tomcat.

#. Extract the contents of this archive to the location where the GDAL libraries were extracted (see :ref:`dataadmin.gdal`).

#. Restart Tomcat.

Continue reading at the :ref:`dataadmin.mrsid.verify` section.


Mac OS X
~~~~~~~~

On OS X, MrSID support is compiled into GDAL, so if you have :ref:`installed GDAL image formats <dataadmin.gdal>`, you will have MrSID support.

.. _dataadmin.mrsid.verify:

Verification
------------

#. To verify that the MrSID extension was installed properly, navigate to the GeoServer web admin interface and log in with administrator credentials.

#. Click on :guilabel:`Stores` and then :guilabel:`Add new Store`. There should be a :guilabel:`MrSID` option under :guilabel:`Raster Data Formats`.

   .. figure:: img/mrsid_verify.png
      
      Verifying that MrSID is an option in the Raster Data Sources

