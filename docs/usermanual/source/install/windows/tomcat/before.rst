.. _install.windows.tomcat.before:

Before you start
================

These instructions cover the installation of Java, the Tomcat Application Server and Boundless Suite components.

When upgrading care must be taken to locate and backup the data directory and remove prior versions of the application.

.. include:: include/sysreq.txt

Upgrading from OpenGeo Suite 4.8 and earlier
--------------------------------------------

.. warning:: These installation instructions do not cover the migration of PostGIS databases at this time.

We advise making a backup of all your data and configuration prior to upgrading:

1. Shutdown all OpenGeo Suite services by navigating to :menuselection:`Start Menu --> All Programs --> OpenGeo Suite` and using the :guilabel:`Stop` shortcuts. 

2. Using :guilabel:`Windows Explorer` navigate to your existing ``GEOSERVER_DATA_DIRECTORY`` located in :file:`C:\\ProgramData\\Boundless\\OpenGeo` .

3. Select the ``GEOSERVER_DATA_DIRECTORY`` folder :file:`geoserver` and right click for the :menuselection:`Send to --> Compressed (zipped) folder` action.

4. Confirm the file name for your new backup.

5. Backup this .zip file

6. Navigate to :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Uninstall`.

   .. note:: Uninstallation is also available via the standard Windows program removal workflow (**Programs and Features** Control Panel entry for Windows 7/Vista.)

7. Uninstalling will not delete your settings and data, which by default is located at :file:`C:\\ProgramData\\Boundless\\OpenGeo`:
   
   * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geoserver` can be used as-is, the configuration files will be updated in place the first time GeoServer runs.  When you set your ``GEOSERVER_DATA_DIRECTORY`` later, use this directory.
   * Optionally, your ``GEOSERVER_DATA_DIRECTORY`` can be moved to :file:`C:\\ProgramData\\Boundless\\geoserver\\data`. If you take this step please review and correct any absolute file references to spatial data stored in ``GEOSERVER_DATA_DIRECTORY``.

Upgrading from Boundless Suite 4.9 and above
--------------------------------------------

When upgrading from a **prior version** be advised that the data directory contents will updated in place when GeoServer is first started. 

We advise making a backup of all your data and configuration prior to upgrading:

1. Using :guilabel:`Windows Explorer` navigate to your ``GEOSERVER_DATA_DIRECTORY`` (usually :file:`C:\\ProgramData\\Boundless\\geoserver`) to show your :file:`data` directory.

   .. figure:: img/upgrade_data.png
      :scale: 80% 
      
      Boundless Suite Data directory

2. Select the ``GEOSERVER_DATA_DIRECTORY`` folder and right click for the :menuselection:`Send to --> Compressed (zipped) folder` action.

   .. figure:: img/upgrade_compressed.png
      :scale: 80% 
      
      Compressed (zipped) folder
      
3. Confirm the file name for your new backup.

   .. figure:: img/upgrade_backup.png
      :scale: 80% 
      
      Backup data directory

4. Backup this .zip file

5. Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`C:\\ProgramData\\Boundless\\geoserver\\data` can be used as is, the configuration files will be updated in place the first time GeoServer runs.
