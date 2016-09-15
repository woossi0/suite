.. _sysadmin.clustering.install:

Installing the clustering extension
===================================

The clustering extension is not installed by default in :ref:`installations <install>` of Boundless Suite. It must be installed separately and then later :ref:`enabled <sysadmin.clustering.setup>`.

.. note:: Prior to installation of the clustering extension, it is important to ensure that you have set up an external data directory, located in a shared location that all GeoServer instances will be able to access.

Install
-------


* **JDBCConfig**:  :ref:`RedHat WAR <install.redhat.tomcat.extensions.jdbcconfig>`, :ref:`Ubuntu WAR <install.ubuntu.tomcat.extensions.jdbcconfig>`, :ref:`Windows WAR <install.windows.tomcat.extensions.jdbcconfig>`, :ref:`RedHat Package <install.redhat.packages.list>`, :ref:`Ubuntu Package <install.ubuntu.packages.list>`  
* **Clustering**: :ref:`RedHat WAR <install.redhat.tomcat.extensions.clustering>`, :ref:`Ubuntu WAR <install.ubuntu.tomcat.extensions.clustering>`, :ref:`Windows WAR <install.windows.tomcat.extensions.clustering>`, :ref:`RedHat Package <install.redhat.packages.list>`, :ref:`Ubuntu Package <install.ubuntu.packages.list>`
* **JDBCStore**: :ref:`RedHat WAR <install.redhat.tomcat.extensions.jdbcstore>`, :ref:`Ubuntu WAR <install.ubuntu.tomcat.extensions.jdbcstore>`, :ref:`Windows WAR <install.windows.tomcat.extensions.jdbcstore>`, :ref:`RedHat Package <install.redhat.packages.list>`, :ref:`Ubuntu Package <install.ubuntu.packages.list>`

.. note:: **JDBCStore** is currently *experimental*, and not currently recommened for production use.
