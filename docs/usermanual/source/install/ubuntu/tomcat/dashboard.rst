.. _install.ubuntu.tomcat.dashboard:

Dashboard Install
=================

#. Copy the :file:`dashboard.war` into :file:`/usr/share/tomcat8/webapps` to deploy.
     
     cp dashboard.war /usr/share/tomcat8/webapps

  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.

#. Use your browser to open the web application at `localhost:8080/dashboard <http://localhost:8080/dashboard/>`__.
   
   .. figure:: /intro/img/dashboard.png
      
      Boundless Suite Dashboard