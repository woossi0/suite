.. _sysadmin.cors:

How to enable Cross-Origin Resource Sharing (CORS)
==================================================

The Same Origin Policy enforced by browsers is designed to prevent a malicious script from one server being able to access sensitive data on a different server.

But if you want your GeoServer to be usable outside of your own domain, you will want to enable Cross-Origin Resource Sharing (CORS).

Jetty
-----

#. Download the ``jetty-servlets.jar`` from http://repo.maven.apache.org/maven2/org/eclipse/jetty/jetty-servlets/7.6.13.v20130916/jetty-servlets-7.6.13.v20130916.jar.

#. Copy this file to your :file:`jetty/lib` folder:

   * Windows: :file:`C:\\Program Files (x86)\\Boundless\\OpenGeo\\jetty\\lib`
   * OS X: :file:`/Users/<user>/Library/Application Support/GeoServer/jetty/lib`

#. Edit your GeoServer :file:`web.xml` file and add the following content:

   .. code-block:: xml

      <web-app ...>
          ...
          <filter>
              <filter-name>cross-origin</filter-name>
              <filter-class>org.eclipse.jetty.servlets.CrossOriginFilter</filter-class>
          </filter>
          ...
          <filter-mapping>
              <filter-name>cross-origin</filter-name>
              <url-pattern>/*</url-pattern>
          </filter-mapping>
          ...
      </web-app>

#. Save this file.

#. Restart GeoServer.
