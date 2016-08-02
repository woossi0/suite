.. _dataadmin.jp2k:

Working with JPEG 2000 (JP2K) data
==================================

Boundless Suite supports data saved in `JPEG 2000 <https://jpeg.org/jpeg2000/index.html>`_ format. This image format utilizes wavelet compression for more efficient storage.

This data can be loaded and published through GeoServer.

Installing JPEG 2000 support
-----------------------------

JPEG 2000 support isn't enabled by default, so it must be separately installed through an extension.

Installing JPEG 2000 support is the same as most :ref:`Boundless Suite Extensions <intro.extensions>`.

Installation instructions are dependent on your operating system and method of install:

* Tomcat on Ubuntu
* Tomcat on Red Hat
* :ref:`Tomcat on Windows <install.windows.tomcat.extensions>`
* Tomcat on OS X
* Packages on Ubuntu
* Packages on Red Hat
* Boundless virtual machine

Verifying installation
----------------------

.. include:: ../../install/include/ext/jp2k_verify.txt

For more information on adding a store and publishing layers, please see the `GeoServer documentation for JPEG 2000 <../../geoserver/extensions/jp2k/>`_.

.. Add tutorials here