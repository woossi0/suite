.. _sysadmin.jvm:

Setting the JVM
===============

This section will discuss JVM (Java) settings for use with Boundless Server.

We recommend using the Oracle OpenJDK JVM with Boundless Server. Specifically, we recommend using **Oracle OpenJDK 11** for all new installations.

The current GeoServer release requires a Java 8 or newer JVM.

When to use Java 8
------------------

While we recommend using Java 11, there are some situations in which you may need to use Java 8 instead.

If you are upgrading from a previous version of Boundless Server, continue to use Java 8 until you have verified that everything is working after the upgrade. After the upgrade is complete, you can switch to Java 11. If this introduces new issues, revert to Java 8.

If you are currently using `Native JAI and/or Native ImageIO <../../geoserver/production/java.html#install-native-jai-and-imageio-extensions>`_, the native bindings do not work on Java 11. Use Java 8.

If you are using the :ref:`GeoMesa Extension <intro.extensions.geomesa>`, it does not yet support Java 11. Use Java 8.

Determining the current Java version
------------------------------------

You may wish the verify the version of Java you are currently using.

.. warning:: It is possible to have multiple versions of the JRE installed, so just running ``java -version`` may not accurately reflect the version of the JRE being used by Boundless Server.

To confirm the version of Java used:

#. Log in to the GeoServer admin interface.

#. Navigate to the :guilabel:`Server Status` page, found on the left side under :guilabel:`About & Status`.

   .. figure:: img/jvm_serverstatuslink.png

      Click to open the Server Status page

#. The JRE used by GeoServer is listed in the :guilabel:`JVM Version` entry.

   .. figure:: img/jvm_version.png
      
      JVM version

.. _sysadmin.jvm.openjdk11:

Changing to OpenJDK 11
----------------------

Linux
^^^^^

#. Download the Oracle JRE. In your browser, navigate to the `Oracle OpenJDK 11 download page <https://jdk.java.net/11/>`_.

#. Click the download link that matches your system::

     Linux/x64  tar.gz 

#. Extract the download file contents to your temporary directory or desktop.

#. In a terminal, change to the directory that contains the extracted folder.

#. Move this directory to :file:`/usr/lib/jvm` (or wherever you'd like to place your JRE):

   .. code-block:: console

      sudo mv jdk-11.0.2 /usr/lib/jvm

#. *(Optional)* Change your ``JAVA_HOME`` environment variable to point to this new directory:

   .. code-block:: console

      export $JAVA_HOME=/usr/lib/jvm/jdk-11.0.2
      
#. Ensure your application server is using this new Java. Many application servers will pick up the system ``JAVA_HOME`` environment variable or require that their service definition be modified.

#. If using Boundless Server packages (or just using Tomcat) open :file:`/etc/tomcat9/tomcat9.conf` in a text editor.

#. Near the top of the file, the ``JAVA_HOME`` variable is set. Change it to:

   .. code-block:: bash
      :emphasize-lines: 3

      # This is the $JAVA_HOME of JDK, not JRE. not needed if you've setup
      # the file "/etc/profile.d/java.sh" with this variable.
      JAVA_HOME=/usr/lib/jvm/jdk-11.0.2

   .. note:: Make sure the line is uncommented (does not start with ``#``).

#. Save and close the file.

#. Restart Tomcat. 

#. Boundless Server should now be using the new version of Java. Verify in GeoServer by navigating to the Server Status page.

   .. figure:: img/jdk11_status.png

      JVM Version showing OpenJDK 11

#. On the line named :guilabel:`JVM Version`, you should see the Oracle JRE. (For historical reasons, it will be shown as "Java HotSpot.")

.. note:: Read more about :ref:`running Boundless Server in Production <sysadmin.production>`.

Windows application servers
^^^^^^^^^^^^^^^^^^^^^^^^^^^

If running Boundless Server in an application server on a Windows system:

#. Download the Oracle JRE. In your browser, navigate to the `Oracle OpenJDK 11 download page <https://jdk.java.net/11/>`_.

#. Click the download link that matches your system::

     Windows/x64  zip

#. Extract the download file contents to your temporary directory or desktop.

#. Move this directory to :file:`C:\\Program Files\\Java` (or wherever you'd like to place your JRE).

#. *(Optional)* Change your ``JAVA_HOME`` environment variable to point to this new directory. From the :guilabel:`System` Control Panel select :guilabel:`Advanced System Settings`. From the :guilabel:`System Properties` dialog navigate to the :guilabel:`Advanced Tab` and click :guilabel:`Environment Variables`. Define a System Variable by clicking :guilabel:`New` and entering:
   
   .. list-table::
      :widths: 30 70
      :header-rows: 1

      * - Variable name
        - Variable value
      * - JAVA_HOME
        - :file:`C:\\Program Files\\Java\\jdk-11.0.2`

#. Restart your application server.

#. Make sure that your application server is using this new Java. It may be reading the ``JAVA_HOME`` environment variable, or you may need to consult your application server documentation.

#. Boundless Server should now be using the new version of Java. Verify in GeoServer by navigating to the Server Status page.

   .. figure:: img/jdk11_status.png
      
      GeoServer Server Status page showing OpenJDK 11

.. note:: Read more about :ref:`running Boundless Server in Production <sysadmin.production>`.

.. note:: Read more about :ref:`installing Java on Windows <install.windows.tomcat.java>`.


.. _sysadmin.jvm.openjdk8:

Changing to OpenJDK 8
---------------------

Linux
^^^^^

#. Download the AdoptOpenJDK JRE. In your browser, navigate to the `AdoptOpenJDK download page <https://adoptopenjdk.net/releases.html>`_.

#. Choose :guilabel:`OpenJDK 8 (LTS)` for version and :guilabel:`HotSpot` for JVM.

#. Select the platform that matches your system, and click the :guilabel:`Download JRE` button.

#. Extract the download file contents to your temporary directory or desktop.

#. In a terminal, change to the directory that contains the extracted folder.

#. Move this directory to :file:`/usr/lib/jvm` (or wherever you'd like to place your JRE):

   .. code-block:: console

      sudo mv jdk8u202-b08-jre /usr/lib/jvm

#. *(Optional)* Change your ``JAVA_HOME`` environment variable to point to this new directory:

   .. code-block:: console

      export $JAVA_HOME=/usr/lib/jvm/jdk8u202-b08-jre
      
#. Ensure your application server is using this new Java. Many application servers will pick up the system ``JAVA_HOME`` environment variable or require that their service definition be modified.

#. If using Boundless Server packages (or just using Tomcat) open :file:`/etc/tomcat9/tomcat9.conf` in a text editor.

#. Near the top of the file, the ``JAVA_HOME`` variable is set. Change it to:

   .. code-block:: bash
      :emphasize-lines: 3

      # This is the $JAVA_HOME of JDK, not JRE. not needed if you've setup
      # the file "/etc/profile.d/java.sh" with this variable.
      JAVA_HOME=/usr/lib/jvm/jdk8u202-b08-jre

   .. note:: Make sure the line is uncommented (does not start with ``#``).

#. Save and close the file.

#. Restart Tomcat. 

#. Boundless Server should now be using the new version of Java. Verify in GeoServer by navigating to the Server Status page.

   .. figure:: img/jdk8_status.png

      JVM Version showing AdoptOpenJDK 8

.. note:: Read more about :ref:`running Boundless Server in Production <sysadmin.production>`.

Windows application servers
^^^^^^^^^^^^^^^^^^^^^^^^^^^

If running Boundless Server in an application server on a Windows system:

#. Download the AdoptOpenJDK JRE. In your browser, navigate to the `AdoptOpenJDK download page <https://adoptopenjdk.net/releases.html>`_.

#. Choose :guilabel:`OpenJDK 8 (LTS)` for version and :guilabel:`HotSpot` for JVM.

#. Select the platform that matches your system, and click the :guilabel:`Download JRE` button.

#. Extract the download file contents to your temporary directory or desktop.

#. Move this directory to :file:`C:\\Program Files\\Java` (or wherever you'd like to place your JRE).

#. *(Optional)* Change your ``JAVA_HOME`` environment variable to point to this new directory. From the :guilabel:`System` Control Panel select :guilabel:`Advanced System Settings`. From the :guilabel:`System Properties` dialog navigate to the :guilabel:`Advanced Tab` and click :guilabel:`Environment Variables`. Define a System Variable by clicking :guilabel:`New` and entering:
   
   .. list-table::
      :widths: 30 70
      :header-rows: 1

      * - Variable name
        - Variable value
      * - JAVA_HOME
        - :file:`C:\\Program Files\\Java\\jdk8u202-b08-jre`

#. Restart your application server.

#. Make sure that your application server is using this new Java. It may be reading the ``JAVA_HOME`` environment variable, or you may need to consult your application server documentation.

#. Boundless Server should now be using the new version of Java. Verify in GeoServer by navigating to the Server Status page.

   .. figure:: img/jdk8_status.png
      
      GeoServer Server Status page showing AdoptOpenJDK 8

#. On the line named :guilabel:`JVM Version`, you should see the Oracle JRE. (For historical reasons, it will be shown as "Java HotSpot.")

.. note:: Read more about :ref:`running Boundless Server in Production <sysadmin.production>`.

.. note:: Read more about :ref:`installing Java on Windows <install.windows.tomcat.java>`.

.. _sysadmin.jvm.alternatives:

Setting the default JVM using *update-alternatives*
---------------------------------------------------

If you used linux packages to install different versions of java and are using the Boundless Server packages you can use the *update-alternatives* command to set the *default* java for your system.  

.. note:: This method may change the java version other applications are using on your server.  This may cause issues.

#. Run the command;

    .. code-block:: bash
      
        update-alternatives --config java

#. You will be presented with a list of installed Java versions.  Choose the one you would like to use.

    .. code-block:: none 

        There are 2 programs which provide 'java'.
        
           Selection    Command
        -----------------------------------------------
         *+ 1           /usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java
            2           /usr/java/jre1.8.0_101/bin/java

        Enter to keep the current selection[+], or type selection number:

#. Verify by running;

   .. code-block:: bash

        java -version

#. Restart Tomcat

