.. _install.ubuntu.tomcat.data:

Data Directory
==============

New installations
-----------------

Unpacking an empty geoserver data directory into :file:`/var/opt/boundless/geoserver/data`:

#. Unzip :file:`suite-data-dir.zip` ...

#. Adjust permissions...

Upgrading from OpenGeo Suite
----------------------------

.. warning:: These installation instructions do not cover the migration of PostGIS databases at this time.

We advise making a backup of this configuration folder prior to upgrading:

1. Navigate to :file:`/var/lib/opengeo/geoserver` and make a backup of your data directory.::

      cd /var/lib/opengeo
      zip -r data.zip geoserver

4. Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`/var/lib/opengeo/geoserver` can be used as is, the configuration files will be updated in place the first time GeoServer runs.

Upgrading from OpenGeo Suite
----------------------------

.. warning:: These installation instructions do not cover the migration of PostGIS databases at this time.

We advise making a backup of this configuration folder prior to upgrading:

1. Stop the tomcat service.

2. Navigate to :file:`/var/lib/opengeo/geoserver` and make a backup of your data directory.::

      cd /var/lib/opengeo
      zip -r data.zip geoserver

3. Uninstall OpenGeo Suite.
     
     $ sudo apt-get remove opengeo-tomcat6 opengeo-tomcat7 geoserver geowebcache geoexplorer opengeo-dashboard opengeo-docs opengeo-server
   
   If you encounter any errors during the uninstall process you may need to manually remove tomcat6::
   
     $ sudo apt-get remove tomcat6
     
4. Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`/var/lib/opengeo/geoserver` can be used as is, the configuration files will be updated in place the first time GeoServer runs.

6. Uninstalling will not delete your settings and data, which by default is located at :file:`/var/lib/opengeo/geoserver`:
   
   * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`/var/lib/opengeo/geoserver` can be used as is, the configuration files will be updated in place the first time GeoServer runs.
   * Optionally, your ``GEOSERVER_DATA_DIRECTORY`` can be moved to :file:`/var/opt/boundless/geoserver/data/`. If you take this step please review and correct any absolute file references to spatial data stored in ``GEOSERVER_DATA_DIRECTORY``.
