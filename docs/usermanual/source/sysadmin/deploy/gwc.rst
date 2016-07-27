.. _sysadmin.deploy.gwc:

GeoWebCache Checklist
=====================

Downloads:

* geowebcache.zip

Installation:

* ``webapp/geowebcache``
* ``/var/opt/boundless/geowebcache/config/``
* ``/var/opt/boundless/geowebcache/tilecache/``

Environment:

* Java 8
* Servlet 3

Application directories:

* Specify location for GeoWebCache configuration::

      -DGEOWEBCACHE_CONFIG_DIR=/var/opt/boundless/geowebcache/config/
      
* (Recommended) Alternate location for GeoWebCache Cache directory::

      -DGEOWEBCACHE_CACHE_DIR=/var/opt/boundless/geowebcache/tilecache/

