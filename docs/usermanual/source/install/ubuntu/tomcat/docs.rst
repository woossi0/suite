.. _install.ubuntu.tomcat.docs:

Suite Documentation Install
---------------------------

#. Copy the :file:`suite-docs.war` into :file:`/usr/share/tomcat8/webapps` to deploy.
     
     cp suite-docs.war /usr/share/tomcat8/webapps

  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.

#. Use your browser to open the web application at `localhost:8080/suite-docs <http://localhost:8080/suite-docs/>`__.

   .. figure:: /install/include/war/img/suite-docs.png
      
      Boundless Suite User Manual