.. _sysadmin.deploy.geoserver:

GeoServer Installation Checklist
================================

Download:

* suite-geoserver.war
* suite-data-directory.zip

Installation:

* ``/usr/share/tomcat8/webapps/geoserver``
* ``/var/opt/boundless/geoserver/data/`` - geoserver configuration files
* ``/var/opt/boundless/geoserver/data/gwc/`` - embbeded geowebcache configuration files
* ``/var/opt/boundless/geoserver/data/logs/`` - geoserver log file and reporting level
* ``/var/opt/boundless/geoserver/tilecache/``

Application environment:

* Application Server supporting with Servlet 3.0.
* Java 8
* (Recommended) Java Cryptography Extension policy files
* (Optional) Appropriate memory allocation. The default memory allocation is 1/4 system memory which may be appropriate for your use.
  
  Each application server has a different way of configuring available memory, setting for Tomcat 8 outlined below.::
  
     -Xms=256m  -Xmx=756m
* Appropriate memory management::
  
     -XX:SoftRefLRUPolicyMSPerMB=36000
* (Recommended) Disable JVM performance monitoring::

    -XX:-UsePerfData

* (Recommended) Boot classpath modification for Marlin rasterizer::
   
     -Xbootclasspath/a:geoserver/WEB-INF/lib/marlin-0.7.3-Unsafe.jar
     -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine
     -Dsun.java2d.renderer.useThreadLocal=false
  
  This allows GeoServer WMS to effectively use machines with more than 8 cpu cores.

Data directory:

* Contents of suite-data-directory.zip should be unpacked to a suitable location:
  
  * Windows: ``C:\ProgramData\Boundless\geoserver\data``
  * Linux: ``/var/opt/boundless/geoserver/data/``
  * OSX: ``~/Library/Application Support/GeoServer/data_dir``
  
Installation:

* Deploy the geoserver.war to your application server:
  
  * Tomcat 8 provides a management console that can be used for deploy, you will need to increase the size limit before use.
  * Tomcat 8 webapps folder is monitored for new war files, copy geoserver.war into this folder to deploy. You may wish to remove the geoserver.war file after it has been unpacked by the application server to save space.

* Specify location of GeoServer Data Directory::
  
    -DGEOSERVER_DATA_DIRECTORY=/var/opt/boundless/geoserver/data/
    
* Prevent GeoServer from loading if data directory is unavailable::

    -DGEOSERVER_DATA_DIRECTORY=/var/opt/boundless/geoserver/data/global.xml
  
  .. note:: You can add additional file and folder locations here to confirm the presense of any required network shares.

* Required system properties::
  
     -Dorg.geotools.referencing.forceXY=true
  
* Recommended system properties::
   
     -Dorg.geotoools.render.lite.scale.unitCompensation=true

* (Recommended) Specify location of GeoWebCache Cache directory::

      -DGEOSERVER_GWC_CACHE_DIR=/var/opt/boundless/geoserver/tilecache/

* (Optional) Specify alternate location for GeoWebCache configuration::

      -DGEOSERVER_GWC_CONFIG_DIR=/var/opt/boundless/geoserver/gwc/
   
* (Optional) Specify the location where geoserver logs are stored::

      -DGEOSERVER_AUDIT_PATH=/var/opt/boundless/geoserver/logs/

   This setting is often used to allow each node in a cluster to store logs to a distinct location.

* (Optional) GeoServer requires write access to the data directory location, if operating in a restricted environment you will need to grant GeoServer additional permissions to allow this access.

* (Optional) The web.xml file can be used for configuration when deploying several several geoserver instances onto the same application server. Review the contents of {{web.xml}} for details.

NetCDF Extension
----------------

* Install NetCDF 4.4.0
* Extract into `webapps/geoserver/WEB-INF/libs`.
* Windows::

    -Djava.library.path='C:\Program Files (x86)\netCDF 4.4.0\bin'
    -Djna.library.path='C:\Program Files (x86)\netCDF 4.4.0\bin'

GeoServer GDAL Extension
------------------------

GeoServer extension allows the use of the system install of GDAL to be used for additional format support.

* Install GDAL
* Ensure environmental variable is set::

    GDAL_DATA=/usr/share/gdal 
* Extract extension into `webapps/geoserver/WEB-INF/libs`.
* Windows::

    -Djava.library.path='C:\GDAL'

LibJPEG Turbo Extension
-----------------------

* Install libjpeg-turbo
* Extract extension to `webapps/geoserver/WEB-INF/libs`.
* Windows::

    -Djava.library.path='C:\libjpeg-turbo\bin'
