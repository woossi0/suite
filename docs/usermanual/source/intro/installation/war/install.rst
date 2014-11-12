.. _intro.installation.war.install:

Installing
==========

OpenGeo Suite is compatible with a number of application servers, among them Jetty, JBoss, and WebSphere. One of the most popular platforms is `Apache Tomcat <http://tomcat.apache.org/>`_. Tomcat is available for all operating systems and is a stable and well-tested solution.

Tomcat Management Console
-------------------------

The following sections will assume that Tomcat is used, although most of the instructions and recommended strategies will also apply to other application servers with minimal alterations.

#. The tomcat manager has an upper limit on the size of WAR files that can be deployed.
   
   To increase this limit navigate to :file:`$CATALINA_BASE/webapps/manager/WEB-INF\web.xml` and edit the **multipart-config** parameters:
   
   .. code-block:: xml
      
       <multipart-config>
         <!-- 260 MB max -->
         <max-file-size>262144000</max-file-size>
         <max-request-size>262144000</max-request-size>
         <file-size-threshold>0</file-size-threshold>
       </multipart-config>

#. OpenGeo Suite requires the use of Java 7 as a minimum.

   * Oracle JDK 7
   * Open JDK 7

   
   .. for reference http://docs.geoserver.org/latest/en/user/installation/java.html

#. Increase the memory made available to your application server. Increase both the heap space (used for data) and the PermGen space (used to load web applications).

   For Tomcat these settings are managed by:
   
   * Linux: Create a :file:`$CATALINA_BASE/bin/setenv.sh`:
      
     .. code-block:: sh
     
        export CATALINA_OPTS = "-Xmx1024m -XX:MaxPermSize=128m"
        
   * Windows: Create a :file:`setenv.bat` on windows:
      
     .. code-block:: bat
        
        set CATALINA_OPTS = "-Xmx1024m -XX:MaxPermSize=128m"
     
     As an alternative you can configure these settings in the Tomcat Properties available in the from the task bar.
     
     * :guilabel:`Java Options`: append :kbd:`-XX:MaxPermSize=128m`
     * :guilabel:`Maxium memory pool: :kbd:`2014` MB
     
     .. figure:: img/tomcat-windows.png
        
        Tomcat 8.0 Properties : Java Options and Memory Pool

#. Restart Tomcat, and open the management console: 

   * http://localhost:8080/manager/
   
#. Locate the :guilabel:`Deploy` heading and click on the :guilabel:`Browse` button to locate the file:`geoserver.war` file.

     .. figure:: img/deploy-browse.png
        
        Tomcat Manager : War file to deploy
        
#. Click on :guilabel:`Deploy` and white while the WAR file is uploaded and unpacked into the :file:`webapps` folder.

#. Repeat this process as needed for:
   
   * dashboard.war
   * geoexplorer
   * geoserver.war
   * geowebcache.war
   
#. Out of the box geoserver includes a built-in data directory used to manage configuration information.
   
   To facilitate updating, and for application serves that empty out the webapps folder each restart, we will move to an external data directory configuration.
   
#. Copy the :file:`geoserver/WEB-INF/data` folder to an external location.

#. Locate :file:`geoserver/WEB-INF/web.xml` and change the GEOSERVER_DATA_DIRECTORY configuration to point to the new location.

#. In the same fashion update :file:`geowebcache/WEB_INF/web.xml` to point to a distinct cache location.

Manual Deploy
-------------

Web applications are usually deployed by copying the individual WAR files to an application server's :file:`webapps` directory. You may have to restart the container service afterwards. Otherwise, please see your application server's instructions for further information on deploying web applications.

The following sections will assume that Tomcat is used, although most of the instructions and recommended strategies will also apply to other application servers with minimal alterations.

#. Stop the application server.

#. Increase the memory made available to your application server. Increase both the heap space (used for data) and the PermGen space (used to load web applications).

   For tomcat these settings are provided by:
   
   * Linux: Create a :file:`$CATALINA_BASE/bin/setenv.sh`:
      
     .. code-block:: sh
     
        export CATALINA_OPTS = "-Xmx1024m -XX:MaxPermSize=128m"
        
   * Windows: Create a :file:`setenv.bat` on windows:
      
     .. code-block:: bat
        
        set CATALINA_OPTS = "-Xmx1024m -XX:MaxPermSize=128m"
     
     As an alternative you can configure these settings in the Tomcat Properties available in the from the task bar.
     
     * :guilabel:`Java Options`: append :kbd:`-XX:MaxPermSize=128m`
     * :guilabel:`Maxium memory pool: :kbd:`2014` MB
     
     .. figure:: img/tomcat-windows.png
        
        Tomcat 8.0 Properties : Java Options and Memory Pool

#. Locate the folder used to deploy web applications. For Tomcat this folder is called :file:`webapps`.

#. Copy the OpenGeo Suite web applications as needed into the :file:`webapps` folder:

   * dashboard.war
   * geoserver.war
   * geoexplorer.war
   * geowebcache.war
   
#. Unzip opengeo-docs.zip into the :file:`webapps` folder:

  * opengeo-docs

Installation strategies
-----------------------

The main benefit of the application server bundle is its flexibility. It is up to you determine the exact deployment that suits our needs. The following describes some common deployment scenarios.

Sandbox
~~~~~~~

If your application server is configured to sandbox web applications, you will need to grant additional permissions allowing GeoServer and GeoWebCache access to both Environmental variables and the File System. These permissions are used to locate the GEOSERVER_DATA_DIRECTORY.
  
For Tomcat locate the file:`$CATALINA_BASE/conf/catalina.policy` file and add:
  
.. code-block:: ini
  
   # OpenGeo Suite permissions used to access Env Variables and GEOSERVER_DATA_DIRECTORY
   grant codeBase "file:${catalina.base}/webapps/geoserver/WEB-INF/libs/-" {
      permission java.security.AllPermission;
   };
   grant codeBase "file:${catalina.base}/geowebcache/geoserver/WEB-INF/libs/-" {
      permission java.security.AllPermission;
   };
  
Start tomcat with the ``-security`` option to use :file:`catalina.policy`.

Split GeoServer and GeoWebCache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GeoWebCache can act as a proxy between GeoServer and a client. It may be advantageous to place GeoWebCache in an public facing servlet container, as it only hosts images and contains no data. You can then host GeoServer in a non-public facing implementation such that only GeoWebCache can access it. This provides a level of isolation for your data, limiting direct data access. 

Multiple GeoServers
~~~~~~~~~~~~~~~~~~~

It is possible to deploy multiple copies of GeoServer in the same application server. This may be used to implement a "round robin" strategy for handling requests. You could go further and use multiple application servers to host GeoServer instances, making your system more fault tolerant.

For information on this approach see the section on clustering.

Separate PostGIS and GeoServer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A recommended installation strategy is to ensure PostGIS and GeoServer are not installed on the same server. This is primarily for security reasons, to prevent PostGIS from being accessed via the web. Give that PostGIS is a separate installation from the WAR bundle, this configuration is straightforward to implement.