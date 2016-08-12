.. _install.windows.tomcat.data:

Data Directory
==============

New installations
-----------------

Unpacking an empty geoserver data directory into :file:`C:\\ProgramData\\Boundless\\geoserver\\data`:

1. Using :guilabel:`Windows Explorer` locate the :file:`suite-data-dir.zip` from the war bundle.

2. Right click :file:`suite-data-dir.zip` and select :file :menuselection:`Extract All`.

   .. figure:: img/data_extract_all.png
      :scale: 80% 
      
      Extract all

3. Type in the following extract location :file:`C:\\ProgramData\\Boundless\\geoserver\\data`.

   .. figure:: img/data_extract_destination.png
      :scale: 80% 
      
      Extract destination

4. The new data directory is now ready for use. This location will be referred to as ``GEOSERVER_DATA_DIRECTORY`` in subsequent documentation.

   .. figure:: img/data_default.png
      :scale: 80% 
      
      New data directory

Upgrading Boundless Suite
-------------------------

When upgrading from prior versions be advised that the data directory contents will updated in place when GeoServer is first started. 

We advise making a backup of this configuration folder prior to upgrading:

1. Using :guilabel:`Windows Explorer` navigate to :file:`C:\\ProgramData\\Boundless\\geoserver` to show your :file:`data` directory.

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

4. Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`C:\\ProgramData\\Boundless\\geoserver\\data` can be used as is, the configuration files will be updated in place the first time GeoServer runs.

Upgrading from OpenGeo Suite
----------------------------

.. warning:: These installation instructions do not cover the migration of PostGIS databases at this time.

We advise making a backup of this configuration folder prior to upgrading:

1. Shutdown all OpenGeo Suite services by navigating to :menuselection:`Start Menu --> All Programs --> OpenGeo Suite` and using the :guilabel:`Stop` shortcuts. 

2. Using :guilabel:`Windows Explorer` navigate to your existing ``GEOSERVER_DATA_DIRECTORY`` located in :file:`C:\\ProgramData\\Boundless\\OpenGeo` .

3. Select the ``GEOSERVER_DATA_DIRECTORY`` folder :file:`geoserver` and right click for the :menuselection:`Send to --> Compressed (zipped) folder` action.

4. Confirm the file name for your new backup.

5. Navigate to :menuselection:`Start Menu --> Programs --> OpenGeo Suite --> Uninstall`.

   .. note:: Uninstallation is also available via the standard Windows program removal workflow (**Programs and Features** Control Panel entry for Windows 7/Vista.)

6. Uninstalling will not delete your settings and data, which by default is located at :file:`C:\\ProgramData\\Boundless\\OpenGeo`:
   
   * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geoserver` can be used as is, the configuration files will be updated in place the first time GeoServer runs.
   * Optionally, your ``GEOSERVER_DATA_DIRECTORY`` can be moved to :file:`C:\\ProgramData\\Boundless\\geoserver\\data`. If you take this step please review and correct any absolute file references to spatial data stored in ``GEOSERVER_DATA_DIRECTORY``.
