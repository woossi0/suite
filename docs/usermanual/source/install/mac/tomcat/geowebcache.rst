.. _install.mac.tomcat.gwc:

GeoWebCache install
===================

GeoWebCache is a map image caching application and server.

.. note:: GeoServer includes an built-in copy of GeoWebCache. Installation of this *separate* stand-alone GeoWebCache may be considered for caching external WMS services. For more information see :ref:`sysadmin.deploy.strategies`.

.. note:: During installation we will be editing text files that require Administrator access to modify. We recommend using :guilabel:`TextWrangler` (from `Apple App Store <https://itunes.apple.com/ca/app/textwrangler/id404010395?mt=12>`__ ), though any text editor will do.

Directory setup
---------------

#. Using the :guilabel:`Terminal` application available in :menuselection:`Applications --> Utilities` folder: navigate to :file:`/Library/Application Support/Boundless/` and create a :file:`GeoWebCache` directory.

   .. code-block:: bash
   
      cd /Library/Application Support/Boundless/
      mkdir GeoWebCache
      
#. Create the following subdirectories in :file:`GeoWebCache`:
   
   * :file:`config` - to store application configuration
   * :file:`tilecache` - for tile cache storage

   .. code-block:: bash
   
      cd GeoWebCache
      mkdir config
      mkdir tilecache
      
Installation
------------

#. Use the :guilabel:`Terminal` to stop Tomcat by entering:

   .. code-block:: bash

      /Library/Tomcat/bin/shutdown.sh

#. Navigate to :file:`/Library/Tomcat/conf/Catalina/localhost` and create a :download:`geowebcache.xml <include/geowebcache_MAC.xml>` with the following content:

   .. literalinclude:: include/geowebcache_MAC.xml
      :language: xml
 
#. Copy the :file:`geowebcache.war` file from the Boundless WAR bundle into :file:`/Library/Tomcat/webapps` to deploy.

#. Use the :guilabel:`Terminal` to start Tomcat by entering:

   .. code-block:: bash

      /Library/Tomcat/bin/catalina.sh start

#. Use your browser to open the web application at http://localhost:8080/geowebcache.

   .. figure:: /img/gwc.png
      
      GeoWebCache

#. Confirm the :guilabel:`Storage Locations` are those configured above.
   
   .. figure:: img/gwc_storage_locations.png

      GeoWebCache storage locations

   .. note:: If the :guilabel:`Local storage` or :guilabel:`Config file` are listed in :file:`/Library/Tomcat/temp/geowebcache`, double check that the :file:`/Library/Application Support/Boundless/GeoWebCache/tilecache` and :file:`/Library/Application Support/Boundless/GeoWebCache/config` directories exist, the :file:`geowebcache.xml` file is correct, and that Tomcat has been restarted.
