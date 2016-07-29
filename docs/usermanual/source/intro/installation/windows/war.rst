.. _intro.installation.windows.war:

Installing the application server bundle on Windows 
===================================================

Java installation
-----------------

Data Directory
--------------

New installations
'''''''''''''''''

Unpacking an empty geoserver data directory into :file:`C:\\ProgramData\\Boundless\\geoserver\\data`:

1. Open :file:`Downloads` folder using :guilabel:`Windows Explorer`.

2. Right click :file:`suite-data-dir.zip` and select :file :menuselection:`Extract All`.

   .. figure:: img/data_extract_all.png
      
      Extract all

3. Type in the following extract location :file:`C:\\ProgramData\\Boundless\\geoserver\\data`.

   .. figure:: img/data_extract_destination.png
      
      Extract destination

4. The new data directory is now ready for use.

   .. figure:: img/data_default.png
      
      New data directory

Upgrading
'''''''''

When upgrading from prior versions be advised that the data directory contents will updated in place when GeoServer is first started. 

We advise making a backup of this configuration folder prior to upgrading:

1. Using :guilabel:`Windows Explorer` navigate to :file:`C:\\ProgramData\\Boundless\\geoserver`.

   .. figure:: img/upgrade_data.png
      
      Data directory

2. Select the :file:`data` folder and right click for the :menuselection:`Send to --> Compressed (zipped) folder` action.

   .. figure:: img/upgrade_compressed.png
      
      Compressed (zipped) folder
      
3. Confirm the :file:`data.zip` name for your new backup.

   .. figure:: img/upgrade_backup.png
      
      Backup data directory

Tomcat installation
-------------------

New installation
----------------

Upgrading
---------

