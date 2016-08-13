.. _install.windows.tomcat.geoserver:

GeoServer Install
==================

.. note:: During installation we will be editing text files that require Administrator access to modify. We recommend the :guilabel:`Notepad++` ( `notepad-plus-plus.org <https://notepad-plus-plus.org/>`__ ).

#. Use :menuselection:`Start --> Apache Tomcat --> Configure Tomcat` to open :guilabel:`Apache Tomcat Properties`. Change to the :guilabel:`General` tab and click :guilabel:`Stop` to stop the service
   
   .. figure:: img/tomcat_stop.png
      
      Stop Tomcat Service
      
#. Change to the :guilabel:`Java` tab and add the following :guilabel:`Java Options`:
  
   .. literalinclude:: include/java_opts.txt
      :language: bash
      :start-after: # geoserver
      :end-before: # geoserver end
     
   Press :guilabel:`Apply`.

   .. figure:: img/geoserver_system_properties.png
   
      Java system properties

#. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory.
   
   .. figure:: img/tomcat_program_directory.png
   
      Tomcat Program Directory

#. Use **Windows Directory** to open the :file:`conf\\Catalina\\localhost\\` directory, and create a :download:`geoserver.xml <include/geoserver.xml>`:
   
   .. literalinclude:: include/geoserver.xml
      :language: xml
   
   .. note:: When upgrading from OpenGeo Suie make use of your existing GEOSERVER_DATA_DIRECTORY setting.
   
      .. literalinclude:: include/geoserver_upgrade.xml
         :language: xml

#. Create the folder :file:`C:\ProgramData\Boundless\geoserver\tilecache` referenced above.

#. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory, open the :file:`webapps` directory.
   
   Copy the :file:`geoserver.war` into this folder to deploy.

   .. figure:: img/geoserver_deploy.png
       
      Deploy of geoserver.war

#. Change to the :guilabel:`General` tab and restart the service using the :guilabel:`Start` button.
   
   .. figure:: img/tomcat_start.png
      
      Start Tomcat Service
      
#. The :file:`geoserver.war` is extracted into the running :guilabel:`geoserver` web application visible in the :file:`webapps` folder.

  .. note:: It will take a moment for Tomcat to notice the web application and make it available.

#. Using your browser navigate to `localhost:8080/geoserver <http://localhost:8080/geoserver>`__. At the top of the screen fill in the default credentials of:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``

   .. figure:: img/geoserver_login.png
       
      Login to GeoServer application
      
#. Using the right hand side page navigation, visit the :guilabel:`Server Status` page.

   .. figure:: img/geoserver_status.png
       
      Page Navigation

#. Confirm that the :guilabel:`Data directory` is listed correctly.

   .. figure:: img/geoserver_status_page.png
      :scale: 75%
      
      Server Status Data directory
      
   .. note:: If the data directory is incorrectly located in :file:`webapps/geoserver/data` the ``GEOSERVER_DATA_DIR`` setting has not taken effect. Double check the :file:`geoserver.xml` file, and confirm that the service has restarted.


.. _install.windows.tomcat.geoserver.gdal:

GDAL Extension
--------------

..note:: The file:`GDAL-suite4.9.zip` is available as part of Boundless


.. _install.windows.tomcat.geoserver.grib:

GRIB Extension
--------------

.. include:: /install/include/ext/grib_install_win.txt

.. include:: /install/include/ext/grib_verify.txt


.. _install.windows.tomcat.geoserver.j2k:

JPEG 2000 Extension
-------------------

.. include:: /install/include/ext/jp2k_install_win.txt

.. include:: /install/include/ext/jp2k_verify.txt


.. _install.windows.tomcat.geoserver.mbtiles:

MBTiles Extension
-----------------

.. include:: /install/include/ext/mbtiles_install_win.txt

.. include:: /install/include/ext/mbtiles_verify.txt

.. _install.windows.tomcat.geoserver.netcdf:

NetCDF Extension
----------------

.. note:: There are two different extensions for NetCDF: one for reading data and one for providing an output format (writing data).

Data store support
~~~~~~~~~~~~~~~~~~

.. include:: /install/include/ext/netcdf_install_win.txt

.. include:: /install/include/ext/netcdf_verify.txt

Output format
~~~~~~~~~~~~~

.. include:: /install/include/ext/netcdf-out_install_win.txt

.. include:: /install/include/ext/netcdf-out_verify.txt

.. _install.windows.tomcat.geoserver.oracle:

Oracle Extension
----------------

.. include:: /install/include/ext/oracle_install_win.txt

.. include:: /install/include/ext/oracle_verify.txt
