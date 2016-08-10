.. _dataadmin.netcdf:

Working with NetCDF data
========================

Boundless Suite supports data saved in `NetCDF <http://www.unidata.ucar.edu/software/netcdf/>`_ format. NetCDF is a community standard for sharing scientific data.

This data can be loaded and published through GeoServer. Both NetCDF 3 and NetCDF 4 formats are supported.

.. note:: :ref:`GRIB <dataadmin.grib>` is also supported via a separate extension. 

GeoServer also has the ability to add NetCDF as an output format.

.. note:: There are two different extensions for NetCDF: One to create a **data store** (reading) and one to provide an **output format** (writing).

Installing NetCDF support
-------------------------

NetCDF support isn't enabled by default, so it must be separately installed through an extension.

.. include:: ../include/ext_install_links.txt

Verifying installation
----------------------

.. include:: ../../install/include/ext/netcdf_verify.txt

.. include:: ../../install/include/ext/netcdf-out_verify.txt

For more information on adding a store and publishing layers, please see the :geoserver:`GeoServer documentation for NetCDF <extensions/netcdf/netcdf.html>`.

.. Add tutorials here