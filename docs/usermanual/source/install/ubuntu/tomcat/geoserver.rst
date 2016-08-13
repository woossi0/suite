.. _install.ubuntu.tomcat.geoserver:

GeoServer Install
==================

#. Stop the tomcat service::
   
     sudo service tomcat8 stop
      
#. Edit the :file:`/etc/sysconfig/tomcat8` file to add the following :guilabel:`Java Options`:
  
   .. literalinclude:: /include/java_opts.txt
      :language: bash
      :start-after: # geoserver
      :end-before: # geoserver end
     
#. Cerate the file :download:`/usr/share/tomcat8/conf/Catalina/localhost/geoserver.xml </include/geoserver.xml>`:
   
   .. literalinclude:: /include/geoserver.xml
      :language: xml
   
   .. note:: When upgrading from OpenGeo Suite make use of your existing GEOSERVER_DATA_DIRECTORY setting.
   
      .. literalinclude:: /include/geoserver_upgrade.xml
         :language: xml

#. Create the folder :file:`C/var/opt/boundless/geoserver/tilecache/` for the tomcat8 user.::
       
       mkdir /var/opt/boundless/geoserver/tilecache
       chown -R tomcat tomcat /var/opt/boundless/geoserver
       
#. Copy the :file:`geoserver.war` into :file:`/usr/share/tomcat8/webapps` to deploy.
     
     cp geoserver.war /usr/share/tomcat8/webapps
   
#. Restart the tomcat service::
   
     sudo service tomcat8 start
      
#. The :file:`geoserver.war` is extracted into the running :guilabel:`geoserver` web application visible in the :file:`webapps` folder.

  .. note:: It will take a moment for Tomcat to notice the web application and make it available.

#. Using your browser navigate to `localhost:8080/geoserver <http://localhost:8080/geoserver>`__. At the top of the screen fill in the default credentials of:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``

#. Using the right hand side page navigation, visit the :guilabel:`Server Status` page.

#. Confirm that the :guilabel:`Data directory` is listed correctly.
   
   .. note:: If the data directory is incorrectly located in :file:`webapps/geoserver/data` the ``GEOSERVER_DATA_DIR`` setting has not taken effect. Double check the :file:`geoserver.xml` file, and confirm that the service has restarted.


.. _install.ubuntu.tomcat.geoserver.grib:

GRIB Extension
--------------

.. include:: /install/include/ext/grib_install.txt

.. include:: /install/include/ext/grib_verify.txt


.. _install.ubuntu.tomcat.geoserver.j2k:

JPEG 2000 Extension
-------------------

.. include:: /install/include/ext/jp2k_install.txt

.. include:: /install/include/ext/jp2k_verify.txt


.. _install.ubuntu.tomcat.geoserver.mbtiles:

MBTiles Extension
-----------------

.. include:: /install/include/ext/mbtiles_install.txt

.. include:: /install/include/ext/mbtiles_verify.txt

.. _install.ubuntu.tomcat.geoserver.netcdf:

NetCDF Extension
----------------

.. note:: There are two different extensions for NetCDF: one for reading data and one for providing an output format (writing data).

NetCDF Data store support
~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: /install/include/ext/netcdf_install_win.txt

.. include:: /install/include/ext/netcdf_verify.txt

NetCDF Output format
~~~~~~~~~~~~~~~~~~~~

.. include:: /install/include/ext/netcdf-out_install_win.txt

.. include:: /install/include/ext/netcdf-out_verify.txt

.. _install.ubuntu.tomcat.geoserver.oracle:

Oracle Extension
----------------

.. include:: /install/include/ext/oracle_install_win.txt

.. include:: /install/include/ext/oracle_verify.txt
