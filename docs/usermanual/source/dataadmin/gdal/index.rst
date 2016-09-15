.. _dataadmin.gdal:

Enabling GDAL image formats support
===================================

.. note:: This document only concerns the extra image formats that can be made available in GeoServer via GDAL. The GDAL binaries, such as :command:`gdalinfo` are installed separately.

Boundless Suite comes with support for publishing data from many formats supported by the `Geospatial Data Abstraction Library <http://gdal.org>`_ (GDAL).  These formats include DTED, EHdr, AIG, ENVIHdr, and much more.

.. note:: See the :ref:`install` section for more information on the various ways to install Boundless Suite.

Installation
------------


**RedHat Package**:  Install the :file:`suite-gs-gdal` package.  For details, see :ref:`RedHat Packages <install.redhat.packages>`.

**Ubuntu Package**:  Install the :file:`suite-gs-gdal` package.  For details, see :ref:`Ubuntu Packages <install.ubuntu.packages>`.

**RedHat WAR**: :ref:`Installing Binaries <install.redhat.tomcat.geoserver.binary>`.

**Ubuntu WAR**: :ref:`Installing Binaries <install.ubuntu.tomcat.geoserver.binary>`.

**Windows WAR**: :ref:`Installing GDAL <install.windows.tomcat.extensions.gdal>`.


.. _dataadmin.gdal.verify:

Verification
------------

.. include:: /install/include/ext/gdal_verify.txt
