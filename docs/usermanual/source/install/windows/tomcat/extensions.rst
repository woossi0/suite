.. _install.windows.tomcat.extensions:

Installing Extensions
=====================

BoundlessSuite Extension Bundle
-------------------------------

Extensions are included in a separate bundle from the main application server bundle. The extensions bundle will have a file name of :file:`BoundlessSuite-ext.zip`.


Unpacking a web application distribution into a suitable location:

1. Download :suite:`BoundlessSuite-ext.zip <war-archive/BoundlessSuite-ext.zip>` to :file:`Downloads` folder

2. Open and :file:`Downloads` folder using :guilabel:`Windows Explorer`.

3. Right click :file:`BoundlessSuite-ext.zip` and select :file :menuselection:`Extract All`.

4. Extract to the default :file:`Download` folder location.

Extension List
--------------

.. (insert big table of extensions here, link to feature overview in intro)

GRIB
~~~~

.. include:: ../../include/ext/grib_install_win.txt

.. include:: ../../include/ext/grib_verify.txt


JPEG 2000
---------

.. include:: ../../include/ext/jp2k_install_win.txt

.. include:: ../../include/ext/jp2k_verify.txt


Marlin Rasterizer
-----------------

We recommend making use of the Marlin Rasterizer for improved WMS performance:

1. From the :file:`BoundlessSuite-ext` download open the :file:`marlin` folder.
2. Copy the :file:`marlin-0.7.3-Unsafe.jar` to your Tomcat :file:`bin` folder. The file will be located in:
   
   * :file:`C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\bin\marlin-0.7.3-Unsafe.jar`
   
   .. figure:: img/marlin_install.png
      :scale: 80%
      
      Marlin Install
      
3. Return to :guilabel:`Apache Tomcat Properties`, the :guilabel:`Java` tab, to add the following additional :guilabel:`Java Options`::
     
     -Xbootclasspath/a:C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\bin\marlin-0.7.3-Unsafe.jar
     -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine
     -Dsun.java2d.renderer.useThreadLocal=false
  
  Press :guilabel:`Apply`.

4. From the :guilabel:`General` tab and restart the service using :guilabel:`Stop` and :guilabel:`Start` buttons.

5. After Tomcat has restarted login to the GeoServer application and visit the :guilabel:`Server Status` page to confirm the use of the Marlin Rasterizer. The :guilabel:`Java Rendering Engine` should be listed as ``org.marlin.pisces.PiscesRenderingEngine``.

   .. figure:: img/geoserver_marlin.png
      
      Server Status Marlin rendering Engine


MBTiles
-------

.. include:: ../../include/ext/mbtiles_install_win.txt

.. include:: ../../include/ext/mbtiles_verify.txt
