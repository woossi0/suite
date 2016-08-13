.. _install.ubuntu.tomcat.quickview:

Quickview Install
=================

#. Copy the :file:`quickview.war` into :file:`/usr/share/tomcat8/webapps` to deploy.
     
     cp quickview.war /usr/share/tomcat8/webapps
     
  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.
  
#. Use your browser to open the web application at `localhost:8080/quickview <http://localhost:8080/quickview/>`__. 
   
   .. figure:: /install/include/war/img/quickview.png
      
      Quickview