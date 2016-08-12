.. _install.windows.tomcat.composer:

Composer Install
================

You must install GeoServer prior to installing Composer:

1. From :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` navigate to the :file:`webapps` folder.

2. Copy the :file:`composer.war` into :file:`webapps` to deploy.

  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.

3. Use your browser to open the web application at `localhost:8080/composer <http://localhost:8080/composer/>`__.  Login using the default credentials of:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``
   
   .. figure:: /install/include/war/img/composer_login.png
      
      Login to Composer application