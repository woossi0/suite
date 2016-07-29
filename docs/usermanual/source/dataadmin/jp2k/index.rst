Loading and publishing JPEG 2000 (JP2K) data
============================================

Boundless Suite supports data saved in `JPEG 2000 <https://jpeg.org/jpeg2000/index.html>`_ format. This image format utilizes wavelet compression for more efficient storage.

This data can be loaded and published through GeoServer.

Installing JPEG 2000 support
-----------------------------

JPEG 2000 support isn't enabled by default, so it must be separately installed through an extension.

Installing JPEG 2000 support is the same as most :ref:`Boundless Suite Extensions <intro.extensions>`.

Application server installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you have installed Boundless Suite applications using WAR files on your own application server (such as Tomcat), you will need to copy some files to the proper location.

The files to be copied are inside the Boundless Suite extensions bundle.

#. Inside the Boundless Suite extensions bundle, navigate to the :file:`jp2k` directory.

#. Copy the contents of the :file:`jp2k` directory into the library directory (:file:`WEB-INF/lib`) of your GeoServer instance. For example, if your GeoServer application is located at :file:`/usr/share/tomcat8/webapps/geoserver` copy the files to :file:`/usr/share/tomcat8/webapps/geoserver/WEB-INF/lib`. 

#. Restart the application server or reload the GeoServer application.

Packages
~~~~~~~~

If you have installed GeoServer using Linux packages, you can install the extension via packages as well.

Ubuntu::

  apt-get install suite-gs-jp2k

Red Hat / CentOS::

  yum install suite-gs-jp2k

.. note:: This command will need to be run as root or with :command:`sudo`.

Virtual machine
~~~~~~~~~~~~~~~

If you are using the Boundless Suite virtual machine, you will need to log in (SSH) to the terminal on the VM and install the package just like a standard Ubuntu install::

  apt-get install suite-gs-jp2k

.. note:: This command will need to be run as root or with :command:`sudo`.

Verifying installation
----------------------

To verify that the extension has been installed properly:

#. Log in to the GeoServer web interface.

#. Click :guilabel:`Stores` then :guilabel:`Add new store`.

#. In the list of :guilabel:`Raster Data Stores`, you should see an entry for :guilabel:`JP2K (Direct)`.

   .. figure:: img/jp2k_storelink.png

      JPEG 2000 in the list of raster stores

   If you don't see this entry, the extension did not install completely.

Adding a store
--------------

#. Select :guilabel:`JP2K (Direct)` in the :guilabel:`Add new store` dialog.

#. Fill out the form:

   .. include:: ../include/storeform.txt

   .. figure:: img/jp2k_storepage.png

      JPEG 2000 store configuration page

#. Click :guilabel:`Submit`.

With the store loaded, you can now publish the layer in the standard way.
