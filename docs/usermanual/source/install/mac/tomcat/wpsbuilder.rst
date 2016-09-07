.. _install.mac.tomcat.wpsbuilder:

WPS Builder install
===================

WPS Builder is a graphical application for building and executing WPS process chains.

.. note:: The WPS Builder requires GeoServer and the GeoServer WPS extension to be installed.

#. Navigate to the :file:`/Library/Tomcat/webapps` folder.

#. Copy the :file:`suite-docs.war` file from the Boundless WAR bundle into the :file:`webapps` directory.

   .. note:: It will take a few moments for Tomcat to deploy the web application.

#. Navigate to http://localhost:8080/wpsbuilder to verify that the documentation deployed successfully.
   
   .. figure:: /install/include/war/img/wpsbuilder.png
      
      WPS Builder

   If you see processes listed in the left column, WPS Builder is installed correctly.
