.. _sysadmin.deploy.geoserver:

GeoServer Installation Checklist
================================

Download:

* suite-geoserver.war
* suite-data-directory.zip

Installation:

* ``webapps/geoserver``
* ``/var/opt/boundless/geoserver/data/`` - geoserver configuration files
* ``/var/opt/boundless/geoserver/data/gwc/`` - embbeded geowebcache configuration files
* ``/var/opt/boundless/geoserver/data/logs/`` - geoserver log file and reporting level
* ``/var/opt/boundless/geoserver/tilecache/``

Application environment:

* Java 8

* Application Server supporting with Servlet 3.0.

* (Optional) Appropriate memory allocation. The default memory allocation is 1/4 system memory which may be appropriate for your use.
  
  Each application server has a different way of configuring available memory, setting for Tomcat 8 outlined below.::
  
     -Xms=256m  -Xmx=756m
  
* Appropriate memory management::
  
     -XX:SoftRefLRUPolicyMSPerMB=36000
  
* (Recommended) Boot classpath modification for Marlin rasterizer::
   
     -Xbootclasspath/a:geoserver/WEB-INF/lib/marlin-0.7.3-Unsafe.jar
     -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine
     -Dsun.java2d.renderer.useThreadLocal=false
  
  This allows GeoServer WMS to effectively use machines with more than 8 cpu cores.

Data directory:

* Contents of suite-data-directory.zip should be unpacked to a suitable location:
  
  * Windows: 
  * Linux: ``/var/opt/boundless/geoserver/data/``
  * OSX:
  
Installation:

* Deploy the geoserver.war to your application server:
  
  * Tomcat 8 provides a management console that can be used for deploy, you will need to increase the size limit before use.
  * Tomcat 8 webapps folder is monitored for new war files, copy geoserver.war into this folder to deploy. You may wish to remove the geoserver.war file after it has been unpacked by the application server to save space.

* Specify location of GeoServer Data Directory

* Confirm data directory is available on startup:
  
  You can add additional file and folder locations here to confirm the presense of any required network shares.

* Required system properties::
  
     -Dorg.geotools.referencing.forceXY=true
  
* Recommended system properties::
   
     -Dorg.geotoools.render.lite.scale.unitCompensation=true

* (Recommended) Specify location of GeoWebCache Cache directory::

      -DGEOSERVER_GWC_CACHE_DIR=/var/opt/boundless/geoserver/tilecache/

* (Optional) Specify location of GeoWebCache configuration::

      -DGEOSERVER_GWC_CONFIG_DIR=/var/opt/boundless/geoserver/gwc/
   
* (Optional) Specify the location where geoserver logs are stored::

      -DGEOSERVER_AUDIT_PATH=/var/opt/boundless/geoserver/logs/

   This setting is often used to allow each node in a cluster to store logs to a distinct location.

* (Optional) GeoServer requires write access to the data directory location, if operating in a restricted environment you will need to grant GeoServer additional permissions to allow this access.

* (Optional) The web.xml file can be used for configuration when deploying several several geoserver instances onto the same application server. Review the contents of {{web.xml}} for details.

GeoServer Extensions
--------------------

(pending)