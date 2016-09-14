.. _install.ubuntu.tomcat.gwc:

GeoWebCache Install
-------------------

.. note:: GeoServer includes an built-in copy of this application, installation of stand-alone GeoWebCache may be considered for for caching external WMS services. 

#. Create the folder :file:`C/var/opt/boundless/geowebcache/tilecache/` for the tomcat8 user.::
       
       mkdir /var/opt/boundless/geowebcache/tilecache
       chown -R tomcat tomcat /var/opt/boundless/geowebcache

#. Use :menuselection:`Start --> Apache Tomcat --> Configure Tomcat` to open :guilabel:`Apache Tomcat Properties`. Change to the :guilabel:`General` tab and click :guilabel:`Stop` to stop the service

#. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory. Use **Windows Directory** to open the :file:`conf\\Catalina\\localhost\\` directory, and create a :download:`geowebcache.xml </include/geowebcache.xml>`:
   
   .. literalinclude:: /include/geowebcache.xml
      :language: xml
            
#. From :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` navigate to the :file:`webapps` folder.

#. Copy the :file:`geowebcache.war` into :file:`webapps` to deploy.

  .. note:: Remember to restart your application server

#. From the :guilabel:`Apache Tomcat Properties` application, change to the :guilabel:`General` tab and click :guilabel:`Start` to restart Tomcat.

#. Change to the :guilabel:`General` tab and restart the service using the :guilabel:`Start` button.

#. Use your browser to open the web application at `localhost:8080/geowebcache <http://localhost:8080/geowebcache/>`__.

   .. figure:: /img/gwc.png
      
      GeoWebCache

#. Confirm the :guilabel:`Storage Locations` are those configured above.
   
   .. note:: If the :guilabel:`Local storage` is listed as :file:`/tmp/...` double check that the folder exists, the :file:`geowebcache.xml` file, and that Tomcat has restarted.
