.. _intro.installation.war.install:

Installing
==========

OpenGeo Suite is compatible with a number of application servers, among them Jetty, Tomcat, JBoss, and WebSphere. The most popular application server, and the most recommended is `Tomcat <http://tomcat.apache.org/>`_. Tomcat is available for all operating systems.

The following sections will assume that Tomcat is used, although most of the instructions and recommended strategies will also apply to other application servers with minimal alteration. 

System requirements
-------------------

OpenGeo Suite requires the use of Java 7 as a minimum. Either **Oracle JRE 7** or **OpenJDK 7** is supported.

.. for reference http://docs.geoserver.org/latest/en/user/installation/java.html

Other system requirements are the same as for other operating systems:

* :ref:`Windows <intro.installation.windows.install>`
* :ref:`OS X <intro.installation.mac.install>`
* :ref:`Ubuntu <intro.installation.ubuntu.install>`
* :ref:`Red Hat / CentOS <intro.installation.redhat.install>`

Deploying with Tomcat
---------------------

This section will show how to deploy the web applications to Tomcat.

Tomcat Management Console
~~~~~~~~~~~~~~~~~~~~~~~~~

The use of the `Tomcat Management Console <http://tomcat.apache.org/tomcat-7.0-doc/manager-howto.html>`_ is optional and provides an administrative front end for monitoring Tomcat that can also be used to deploy web applications.

#. The windows installer can be used to both install the Tomcat Management Console and configure an administrative user.

#. Linux users are asked to install the additional `tomcat7-admin` package, and configure the :file:`/var/lib/tomcat7/conf/tomcat-users.xml` file with the following with appropriate username and password:
   
   .. code-block:: xml
   
      <role rolename="admin"/>
      <role rolename="admin-gui"/>
      <role rolename="manager-gui"/>
      <user username="admin" password="password" roles="admin,admin-gui,manager-gui"/>

#. The Tomcat Management Console has an upper limit on the size of WAR files that can be deployed. This will need to be changed in order to deploy many of the OpenGeo Suite web applications.
   
#. Open the :file:`webapps/manager/WEB-INF/web.xml` file in a text editor.

#. Edit the ``*multipart-config`` parameters as follows:
   
   .. code-block:: xml
      :emphasize-lines: 3,4
      
       <multipart-config>
         <!-- 260 MB max -->
         <max-file-size>262144000</max-file-size>
         <max-request-size>262144000</max-request-size>
         <file-size-threshold>0</file-size-threshold>
       </multipart-config>

#. Save and close this file.



Increasing available memory
~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenGeo Suite requires more memory to be allocated on the application server. Increase both the heap space (used for data) and the PermGen space (used to load web applications).

.. note:: Due to how the PermGen space is managed in Java 7, it is recommended that you restart Tomcat whenever you would restart a web application.

Linux / OS X:

#. Create a :file:`setenv.sh` file in CATALINA_HOME bin directory if it does not already exist ( :file:`/usr/share/tomcat7/bin/setenv.sh` .)

#. Ensure the script includes the following line to set CATALINA_OPTS:

   .. code-block:: sh
      :emphasize-lines: 2
      
      #!/bin/sh
      export CATALINA_OPTS="-Xmx1024m -XX:MaxPermSize=128m"

#. Save and close the file.

#. Restart Tomcat.

Windows:

#. Create a :file:`setenv.bat` file in CATALINA_HOME bin directory if it does not already exist.

#. Add the following line:

   .. code-block:: bat

      set CATALINA_OPTS="-Xmx1024m -XX:MaxPermSize=128m"

#. Save and close the file. 

#. As an alternative you can configure these settings in the Tomcat Properties available in the from the task bar:
     
   * :guilabel:`Java Options`: Append :kbd:`-XX:MaxPermSize=128m`
   * :guilabel:`Maximum memory pool`: :kbd:`1024 MB`
     
   .. figure:: img/tomcat-windows.png
        
      Tomcat memory options

#. Restart Tomcat.

Manual deploy
~~~~~~~~~~~~~

If you are comfortable working in the Tomcat :file:`webapps` folder, or have not installed the Tomcat Management Console, a manual deploy is recommended.

#. Shutdown Tomcat
#. For deploying manually, copying the individual WAR files to the :file:`webapps` directory.
#. Restart Tomcat, as Tomcat loads each WAR file will be unpacked into a corresponding directory.

Tomcat Management Console Deploy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
For deploying using Tomcat Management Console:

#. Open the Management Console (often available at ``http://localhost:8080/manager/html``).

#. Locate the :guilabel:`Deploy` heading and click the :guilabel:`Browse` button.

   .. figure:: img/deploy-browse.png
        
      Deploying a web application

#. Select the web application file to deploy.

#. Click :guilabel:`Deploy`. The WAR file will be uploaded and unpacked into the :file:`webapps` folder.

#. Repeat this process as needed for every web application to be deployed.
   
Externalizing the GeoServer data directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GeoServer includes a built-in data directory used to manage configuration information. To facilitate updating and prevent data loss, it is highly recommended to move the data directory to a location external to the application itself.

#. Stop Tomcat.

#. Move the :file:`geoserver/data` directory to an external location. Here are some suggested locations:
   
   * **Linux**: :file:`/var/lib/opengeo/geoserver`
   * **Windows**: :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geoserver`
   * **OS X**: :file:`/Users/opengeo/geoserver_data`

#. Open :file:`geoserver/WEB-INF/web.xml` in a text editor.

#. Change the ``GEOSERVER_DATA_DIRECTORY`` parameter to point to the new directory location.

#. Restart Tomcat.

Externalizing the GeoWebCache Configuration and Cache 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, GeoWebCache stores the cache and cache configuration information in the temporary storage folder of the application server (:file:`$CATALINA_BASE/temp` for Tomcat). To prevent data loss, it is highly recommended to move the data directory to a permanent location external to the application server.

#. Stop Tomcat.

#. Move the :file:`geowebcache/geowebcache.xml` file from ``geowebcache`` to an external location. Here are some suggested locations:
   
   * **Linux**: :file:`/var/lib/opengeo/geowebcache/geowebcache.xml`
   * **Windows**: :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geowebcache\\geowebcache.xml`
   * **OS X**: :file:`/Users/opengeo/geowebcache_data/geowebcache.xml`

#. Open :file:`geowebcache/WEB-INF/geowebcache-core-context.xml` in a text editor and modify the constructor argument with the new location:
   
   .. code-block:: xml
      :emphasize-lines: 5
      
      <!-- The location of a static configuration file for GeoWebCache. 
           By default this lives in WEB-INF/classes/geowebcache.xml -->
      <bean id="gwcXmlConfig" class="org.geowebcache.config.XMLConfiguration">
        <constructor-arg ref="gwcAppCtx" />
        <constructor-arg ref="/var/lib/opengeo/geowebcache" />
        <!-- By default GWC will look for geowebcache.xml in {GEOWEBCACHE_CACHE_DIR},
             if not found will look at GEOSEVER_DATA_DIR/gwc/
             alternatively you can specify an absolute or relative path to a directory
             by replacing the gwcDefaultStorageFinder constructor argument above by the directory
             path, like constructor-arg value="/etc/geowebcache"     
        -->
        <property name="template" value="/geowebcache.xml">
          <description>Set the location of the template configuration file to copy over to the
            cache directory if one doesn't already exist.
          </description>
        </property>
      </bean>

#. You may also wish to edit the :file:`geowebcache.xml` configuration at this time to `include additional layers <../../../geowebcache/configuration/layers/howto.html>`__.

#. Here are some suggested locations for the cache directory:

   * **Linux**: :file:`/var/cache/geowebcache`
   * **Windows**: :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geowebcache`
   * **OS X**: :file:`/Users/opengeo/geowebcache_data`

#. Open :file:`geowebcache/WEB-INF/web.xml` in a text editor and onfigure the ``GEOWEBCACHE_CACHE_DIR`` location. 
   
   .. code-block:: xml
      :emphasize-lines: 3
      
      <context-param>
        <param-name>GEOWEBCACHE_CACHE_DIR</param-name>
        <param-value>/var/cache/geowebcache</param-value>
      </context-param>

#. Restart Tomcat.
