.. _sysadmin.jvm.setting:

Setting the Oracle JVM
======================

We recommend using the Oracle JVM with OpenGeo Suite, as testing has shown that the Oracle JVM is significantly faster than other JVM implementations.

Specifically, we recommend using **Oracle JRE 6**. Even though it isn't the latest version, it is the most well-tested and stable version of the JVM with GeoServer.

Determining the current Java version
------------------------------------

You may wish the verify the version of Java you are currently using.

Windows and OS X
^^^^^^^^^^^^^^^^

OpenGeo Suite installers bundle the Oracle Java 7 in its package, so there is no need to do anything here.

All other systems
^^^^^^^^^^^^^^^^^

To confirm the version of Java used:

#. Log in to the GeoServer Admin interface
#. Navigate to the **Server Status** page
#. Confirm the **JVM Version** is listed as Java 7 or higher.
     
   .. figure:: img/jvm-version.png
      
      JVM Version showing OpenJDK 7

.. note:: Linux systems often have both Java 6 and Java 7 installed. OpenGeo Suite installs the service ``tomcat7`` and modifies the service configuration to ensure OpenJDK 7 is used.

Changing to the Oracle JRE
--------------------------

Linux  
^^^^^

#. First, download the Oracle JRE. In your browser, navigate to http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1880261.html . This is Oracle's download page for JRE 7.
   
   .. note:: You may evaluate the latest Java virtual machine for use in your organisation. We conservatively recommend the use of Java 7. For additional details please see our section on :ref:`sysadmin.production.performance`.
   
#. Click the radio box to accept the license agreement and then click the download link that matches your system.::

     jre-7u71-linux-x64.tar.gz

#. Extract the download file contents to your temporary directory or your desktop.

#. In a terminal, change to that directory and confirm the directory contents:

   .. code-block:: bash
     
      $ ls jre1.7.0_71
      bin        man      THIRDPARTYLICENSEREADME-JAVAFX.txt
      COPYRIGHT  plugin   THIRDPARTYLICENSEREADME.txt
      lib        README   Welcome.html
      LICENSE    release

#. Move this directory to :file:`/usr/lib/jvm` (or wherever you'd like to place your JRE):

   .. code-block:: console

      sudo mv jre1.7.0_71 /usr/lib/jvm

#. *(Optional)* Change your ``JAVA_HOME`` environment variable to point to this new directory:

   .. code-block:: console

      export $JAVA_HOME=/usr/lib/jvm/jre1.7.0_71
      
#. Ensure your application server (Jetty, Tomcat, etc.) is using this new Java. Many application servers will pick up the system ``JAVA_HOME`` environment variable or require that their service definition be modified.

#. If using OpenGeo Suite packages (or using Tomcat) open :file:`/etc/default/tomcat7` in a text editor (or equivalent for your system). Scroll down to the end of the file where the ``JAVA_HOME`` variable is set. Add the line:

   .. code-block:: bash
      :emphasize-lines: 3

      OPENGEO_OPTS="-Djava.awt.headless=true -Xms256m -Xmx768m -Xrs -XX:PerfDataSamplingInterval=500 -XX:MaxPermSize=256m -Dorg.geotools.referencing.forceXY=true -DGEOEXPLORER_DATA=/var/lib/opengeo/geoexplorer"
      JAVA_OPTS="$JAVA_OPTS $OPENGEO_OPTS"
      JAVA_HOME=/usr/lib/jvm/jre1.7.0_71

   Save and close the file. Restart Tomcat. 

#. OpenGeo Suite should now be using the new version of Java. Verify in GeoServer by navigating to the Server Status page.

   .. figure:: img/serverstatus.png

      JVM Version showing Oracle JRE on Linux

#. On the line named :guilabel:`JVM Version`, you should see the Oracle JRE. (For historical reasons, it will be shown as "Java HotSpot.")

.. note:: Read more about :ref:`running OpenGeo Suite in Production <sysadmin.production>`.

Windows application servers
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: As mentioned above, OpenGeo Suite for Windows automatically includes the appropriate JRE. No action is needed.

If running OpenGeo Suite for Application Servers on a Windows system:

#. First, download the Oracle JRE. In your browser, navigate to http://www.oracle.com/technetwork/java/javase/downloads/jre7-downloads-1880261.html . This is Oracle's download page for JRE 7.

#. Click the radio box to accept the license agreement and then click the download link that matches your system.::

     jre-7u71-windows-x64.exe

#. Use the installer (or manual directions) to update Java.
   
   .. warning:: When installing a new Java Runtime Environment from Oracle pay careful attention to the  installation wizard. Oracle has a habit of including unwanted extras such as JavaFX and browser toolbars.

#. *(Optional)* Change your ``JAVA_HOME`` environment variable to point to this new directory. From the **System** control panel select **Advanced System Settings**. From the **System Properties** dialog navigate to the **Advanced Tab** and click **Environment Variables**. Define a System Variable by clicking **New** and filling in:
   
   .. list-table:: New System Variable 
      :widths: 30 70
      :header-rows: 1

      * - Variable name
        - Variable value
      * - JAVA_HOME
        - :file:`C:\\Program Files\\Java\\jre7`

#. Make sure that your application server (Jetty, Tomcat, etc.) is using this new Java. It may be reading the ``JAVA_HOME`` environment variable, or you may need to consult your application server documentation.

#. OpenGeo Suite should now be using the new version of Java. Verify in GeoServer by navigating to the Server Status page.

   .. figure:: img/jvm-version-windows.png
      
      JVM Version showing Oracle JRE on Windows

#. On the line named :guilabel:`JVM Version`, you should see the Oracle JRE. (For historical reasons, it will be shown as "Java HotSpot.")

.. note:: Read more about :ref:`running OpenGeo Suite in Production <sysadmin.production>`.