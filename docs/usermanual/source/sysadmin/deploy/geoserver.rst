.. _sysadmin.deploy.geoserver:

GeoServer Installation Checklist
================================

Downloads:

* :suite:`BoundlessSuite-war.zip <war-archive/BoundlessSuite-latest-war.zip>`
* :suite:`suite-data-dir.zip <war-archive/suite-data-dir-latest.zip>`
* :suite:`BoundlessSuite-ext.zip <war-archive/BoundlessSuite-latest-ext.zip>`

Installation Locations:

============================================================= =======================
location                                                      description
============================================================= =======================
``/usr/share/tomcat8/conf/Catalina/localhost/geoserver.xml``  context-parameter definition
``/usr/share/tomcat8/conf/Catalina/bin/setenv.sh``            java system-properties definition
``/usr/share/tomcat8/webapps/geoserver``                      web application
``/var/opt/boundless/geoserver/data/``                        geoserver configuration files
``/var/opt/boundless/geoserver/data/gwc/``                    embbeded geowebcache configuration files
``/var/opt/boundless/geoserver/tilecache/``                   embedded geowebcache cache location
``/var/opt/boundless/geoserver/logs/``                        geoserver log file and reporting level
============================================================= =======================

Application environment:

* Application Server supporting with Servlet 3.0 (Tomcat 7 or newer)
* Java 8 (Java 9 unsupported at this time)
* (Recommended) Java Cryptography Extension policy files
* Java system properties

  .. note:: Each application server has a different way of configuring java options including available memory.
     
     On Tomcat system properties are defined by the ``JAVA_OPTS`` environmental variable defined in the :download:`tomcat8/bin/setenv.sh </include/setenv.sh>` (or in the :file:`tomcat8` service definition):

    .. literalinclude:: /include/setenv.sh
       :language: bash
       :end-before: # geoserver settings
       

* (Optional) Appropriate memory allocation. The default memory allocation is 1/4 system memory which may be appropriate for your use.
  
  .. literalinclude:: /include/java_opts.txt
     :language: bash
     :start-after: # memory
     :end-before: # memory management
     
* Required memory management:

  .. literalinclude:: /include/java_opts.txt
     :language: bash
     :start-after: # memory management
     :end-before: # performance
     
* Recommended - Disable JVM performance monitoring:

  .. literalinclude:: /include/java_opts.txt
     :language: bash
     :start-after: # performance
     :end-before: # geoserver
  
* Recommended - Boot classpath modification for Marlin rasterizer (allowing GeoServer WMS to effectively use machines with more than 8 cpu cores):
   
  .. literalinclude:: /include/marlin.txt
     :language: bash

Data directory:

* Contents of :file:`suite-data-directory.zip` should be unpacked to a suitable location:  
  * Windows: ``C:\ProgramData\Boundless\geoserver\data``
  * Linux: ``/var/opt/boundless/geoserver/data/``
  * OSX: ``~/Library/Application Support/GeoServer/data_dir``
  
Installation
------------

Context parameters:

* Use your application server's facilities for defining context-parameters.
  
  .. warning:: The ``web.xml`` provides the default context-parameter value definitions.
  
     Editing context-parameters directly in the ``web.xml`` is not recommended (as you would need to reapply your changes when upgrading).

  .. note:: On Tomcat the :download:`tomcat8/conf/Catalina/localhost/geoserver.xml </include/geoserver.xml>` file used define context-parameter values:
   
     .. literalinclude:: /include/geoserver.xml
        :language: xml

* Fill in required context parameters for GeoServer:

  * GEOSERVER_DATA_DIR - location of the GeoServer configuration directory::
       
       /var/opt/boundless/suite/geoserver/data
       
  * GEOSERVER_REQUIRE_FILE - prevent GeoServer from loading if data directory is unavailable.::
        
        /var/opt/boundless/suite/geoserver/data/global.xml
    
    You can list additiona file and folder locations here to confirm the presense of any required network shares.

* Recommended context-parameters:
  
  * GEOWEBCACHE_CACHE_DIR - location of GeoWebCache Cache directory::
  
       /var/opt/boundless/suite/geoserver/gwc
      
* Optional context-parameters:
  
  * GEOSERVER_GWC_CONFIG_DIR - alternate location for GeoWebCache configuration::

       /var/opt/boundless/geoserver/gwc/
   
  * GEOSERVER_LOG_LOCATION - location where geoserver logs are stored::

       /var/opt/boundless/geoserver/logs/

  * PROXY_BASE_URL - adjust capabilities output to reflect proxy configuration.::
      
       http://my.custom.com/geoserver
      
Java system properties:

* .. note:: On Tomcat system properties are defined by the ``JAVA_OPTS`` environmental variable defined in the :download:`tomcat8/bin/setenv.sh </include/setenv.sh>` (or in the :file:`tomcat8` service definition):

    .. literalinclude:: /include/setenv.sh
       :language: bash
       :prepend: #! /bin/sh
       :start-after: # geoserver settings

* Required system properties:
  
  .. literalinclude:: /include/java_opts.txt
     :language: bash
     :start-after: # geoserver
     :end-before: # geoserver recommended

  
* Recommended system properties:
   
  .. literalinclude:: /include/java_opts.txt
     :language: bash
     :start-after: # geoserver recommended
     :end-before: # geowebcache

Web application:

* Deploy the geoserver.war to your application server:
  
  * Tomcat 8 provides a management console that can be used for deploy, you will need to increase the size limit before use.
  * Tomcat 8 webapps folder is monitored for new war files, copy geoserver.war into this folder to deploy. You may wish to remove the :file:`geoserver.war` file after it has been unpacked by the application server to save space.

* (Optional) GeoServer requires write access to environmental variables, if operating in a restricted environment you will need to grant GeoServer additional permissions to allow this access.

  .. note:: On Tomcat the :file:`tomcat8/conf/catalina.policy` file can be used to sandbox web applications.
  
     If your organization employees this facility the restriction can be relaxed for access to the data directory using::
         
        grant codeBase "file:${catalina.base}/webapps/geoserver/-" {
          permission java.security.AllPermission;
        };
        

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
