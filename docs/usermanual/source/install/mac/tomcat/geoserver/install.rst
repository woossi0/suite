.. _install.mac.tomcat.install:


GeoServer WAR Install
=====================

#. Use the :guilabel:`Terminal` to stop the Apache Tomcat service using the command:

    .. code-block:: bash

        /Library/Tomcat/bin/shutdown.sh

    .. note:: If a stack trace appears, Tomcat may already be stopped and therefore the connection is refused.

#. Edit the :file:`/Library/Tomcat/bin/setenv.sh` file to add the following to :guilabel:`Java Options`:

    .. literalinclude:: ../../../../include/java_opts.txt
        :language: bash
        :start-after: # geoserver
        :end-before: # geoserver end

#. In :file:`/Library/Tomcat/conf/Catalina/localhost` create a :download:`geoserver.xml <../include/geoserver_MAC.xml>` with the following content:

    .. literalinclude:: ../include/geoserver_MAC.xml
        :language: xml

    .. note:: When upgrading from OpenGeo Suite make use of your existing ``GEOSERVER_DATA_DIRECTORY`` location with a different :download:`geoserver.xml <../include/geoserver_upgrade_MAC.xml>`.

    .. literalinclude:: ../include/geoserver_upgrade_MAC.xml
        :language: xml
        
#. Create the folder :file:`/Library/Application Support/Boundless/GeoServer/tilecache`, as is referenced above.

#. Use :guilabel:`Terminal` to copy the :file:`geoserver.war` into the Tomcat :file:`/Library/Tomcat/webapps` folder to deploy.

    .. code-block:: bash

        cp ~/Downloads/BoundlessSuite-4.9-war/geoserver.war /Library/Tomcat/webapps/

#. Start the Tomcat service, Tomcat will deploy the :file:`geoserver.war` into a :guilabel:`geoserver` folder visible in the :file:`webapps` folder.

    .. code-block:: bash

        /Library/Tomcat/bin/catalina.sh start

#. Using your browser navigate to `localhost:8080/geoserver <http://localhost:8080/geoserver>`__. At the top of the screen fill in the default GeoServer credentials:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``

#. Visit the :guilabel:`Server Status` page, under :guilabel:`About & Status` on the left-hand side of the page.

    .. figure:: ../img/gs_server_status_mac.png

        GeoServer status page


#. Confirm the :guilabel:`Data Directory` is correct.

    .. figure:: ../img/gs_data_dir_mac.png

        GeoServer data directory location
