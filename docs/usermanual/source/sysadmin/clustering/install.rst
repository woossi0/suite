.. _sysadmin.clustering.install:

Installing the clustering extension
===================================

The clustering extension is not installed by default in :ref:`installations <install>` of Boundless Server. It must be installed separately and then later :ref:`enabled <sysadmin.clustering.setup>`.

.. note:: Prior to installation of the clustering extension, it is important to ensure that you have set up an external data directory, located in a shared location that all GeoServer instances will be able to access.

Install
-------

Installing the clustering extension is the similar to most :ref:`Boundless Server Extensions <intro.extensions>`. One notable exception is that clustering consists of multiple extensions which must be installed seperately.

Installation instructions are dependent on your operating system and method of install. The JDBCConfig and Clustering extensions are both **required**. JDBCStore is **optional**.

**JDBCConfig**:

* **Tomcat**: :ref:`Ubuntu<install.ubuntu.tomcat.extensions.jdbcconfig>`, :ref:`Red Hat<install.redhat.tomcat.extensions.jdbcconfig>`, :ref:`Windows<install.windows.tomcat.extensions.jdbcconfig>`
* **Packages**: :ref:`Ubuntu<install.ubuntu.packages.list>`, :ref:`Red Hat<install.redhat.packages.list>`

**Clustering**: 

* **Tomcat**: :ref:`Ubuntu<install.ubuntu.tomcat.extensions.clustering>`, :ref:`Red Hat<install.redhat.tomcat.extensions.clustering>`, :ref:`Windows<install.windows.tomcat.extensions.clustering>`
* **Packages**: :ref:`Ubuntu<install.ubuntu.packages.list>`, :ref:`Red Hat<install.redhat.packages.list>`

**JDBCStore**: 

* **Tomcat**: :ref:`Ubuntu<install.ubuntu.tomcat.extensions.jdbcstore>`, :ref:`Red Hat<install.redhat.tomcat.extensions.jdbcstore>`, :ref:`Windows<install.windows.tomcat.extensions.jdbcstore>`
* **Packages**: :ref:`Ubuntu<install.ubuntu.packages.list>`, :ref:`Red Hat<install.redhat.packages.list>`

.. warning:: **JDBCStore** is currently *experimental*, and not recommened for production use.

.. _sysadmin.clustering.install.upgrade:

Upgrading from 1.0.0 or 1.1.0 to 1.2.0
--------------------------------------

Boundless Server 1.2.0 updates Hazelcast (a core component of the clustering extension) from 2.3 to 3.11.

If you use the clustering extension, you will need to upgrade your Hazelcast configuration when you update to Boundless Server 1.2.0. After updating your installation of Boundless Server, but before starting tomcat, do the following:

If you have not made any substantial modifications to the contents of ``$GEOSERVER_DATA_DIR/cluster``:

1. Backup ``$GEOSERVER_DATA_DIR/cluster`` (typically ``/var/opt/boundless/server/geoserver/data/cluster``) and delete it

2. Start GeoServer, and it will automatically recreate the ``cluster`` dir with a new ``hazelcast.xml`` file.

3. Update any properties from your backup as applicable, then restart geoserver.

If you have made substantial changes to the contents of ``$GEOSERVER_DATA_DIR/cluster``, then you should instead manually update ``hazelcast.xml``:

1. Open ``$GEOSERVER_DATA_DIR/cluster/hazelcast.xml`` for editing.

2. Replace the opening ``<hazelcast>`` tag with the following::

    <hazelcast xmlns="http://www.hazelcast.com/schema/config"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://www.hazelcast.com/schema/config
                               https://hazelcast.com/schema/config/hazelcast-config-3.11.xsd">

3. Replace all instances of ``instanceName`` with ``instance-name``.

4. Save and close the file, then start GeoServer.

5. If you get a startup error that references hazelcast, it is likely there are additional tags in your ``hazelcast.xml`` which are unsupported in Hazelcast 3.11. Examine the Hazelcast 3.11 schema at https://hazelcast.com/schema/config/hazelcast-config-3.11.xsd to see what is and isn't supported, and upgrade any unsupported tags, then restart GeoServer.



