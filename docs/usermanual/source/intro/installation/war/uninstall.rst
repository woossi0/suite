.. _intro.installation.war.uninstall:

Uninstallation
==============

This document describes how to uninstall WAR distribution of OpenGeo Suite. During installation a WAR was copied into the application server webapps folder, and deployed into a folder.

Management Console Undeploy
---------------------------

These instructions use the Tomcat Application Server as an example. The steps required for each application server will be similar to the ones presented here.

#. From the management console, each web application can be started, stopped, reloaded and undeployed.
   
#. From the management click :guilabel:`Undeploy` next to each OpenGeo Suite web application:
   
   * opengeo-docs
   * dashboard
   * geoserver
   * geoexplorer
   * GeoWebCache
   
#. The management console will remove the folder and associated WAR file for each web application.
   
#.  Undeploying will not delete your external GEOSERVER_DATA_DIRECRTORY.
    
    Should you wish to delete this directory, you will need to do it manually.
    
Manual Undeploy
---------------

These instructions use the Tomcat Application Server as an example. The steps required for each application server will be similar to the ones presented here.

#. Stop the application service, to prevent it redeploying the application while we are cleaning up.

#. Locate the webapps folder and remove the following files:

   * :file:`opengeo-docs.war`
   * :file:`dashboard.war`
   * :file:`geoserver.war`
   * :file:`geoexplorer.war`
   * :file:`geowebcache.war`
   
#. Remove the following folders

   * :file:`opengeo-docs`
   * :file:`dashboard`
   * :file:`geoserver`
   * :file:`geoexplorer`
   * :file:`geowebcache`

#. Restart the application server.

#.  Undeploying will not delete your external GEOSERVER_DATA_DIRECRTORY.
    
    Should you wish to delete this directory, you will need to do it manually.