.. _install.ubuntu.tomcat.wpsbuilder:

WPS Builder Install
===================

#. Copy the :file:`wpsbuilder.war` into :file:`/usr/share/tomcat8/webapps` to deploy.
     
     cp wpsbuilder.war /usr/share/tomcat8/webapps
     
  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.
  
#. Use your browser to open the web application at `localhost:8080/wpsbuilder <http://localhost:8080/wpsbuilder/>`__. 
   
   .. figure:: /install/include/war/img/wpsbuilder.png
      
      WPS Builder
      
   .. note:: The WPS Builder requires the GeoServer WPS Extension has been installed prior to use.

