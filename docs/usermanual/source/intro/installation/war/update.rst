Update
======

Update from Suite 4.1.1
-----------------------

#. Ensure your application server is configured with an external GEOSERVER_DATA_DIRECTORY.
   
   This step ensures that no geoserver, geowebacache or geoexplorer configuration information is maintained in your webapps folder.
   
#. Uninstall Suite 4.1.1 wars: :doc:`uninstall`

#. Restart Tomcat. This will allow memory used by Suite 4.1.1 to be reclaimed (preventing errors during Suite 4.5 installation).

#. Install Suite 4.5 wars: :doc:`install`

