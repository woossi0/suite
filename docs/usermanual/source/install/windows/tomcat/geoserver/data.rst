.. _install.windows.tomcat.geoserver.data:

GeoServer Data Directory
========================

.. note:: If you have an existing geoserver, follow the "Upgrading" instructions, below.

New installations
-----------------

Unpacking the sample geoserver data directory into :file:`C:\\ProgramData\\Boundless\\geoserver\\data`:

1. Using :guilabel:`Windows Explorer`, locate the :file:`suite-data-dir.zip` from the WAR bundle.

2. Right click :file:`suite-data-dir.zip` and select :menuselection:`Extract All`.

   .. figure:: ../img/data_extract_all.png
      :scale: 80% 
      
      Extract all

3. Type in the following extract directory :file:`C:\\ProgramData\\Boundless\\geoserver\\data`.
   
   .. warning:: Ensure that you are extracting to the correct directory.
   
   .. figure:: ../img/data_extract_destination.png
      :scale: 80% 
      
      Extract destination

4. The new data directory is now ready for use. This location will be referred to as the ``GEOSERVER_DATA_DIRECTORY`` in subsequent documentation.

   .. figure:: ../img/data_default.png
      :scale: 80% 
      
      New data directory

Upgrading
---------

.. warning:: Please uninstall previous releases before proceeding, and be sure to backup your data directory. For more information see :ref:`install.windows.tomcat.before`.

When upgrading make use of your existing data directory:

* Upgrading from OpenGeo Suite 4.8 and earlier:
   
   * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geoserver` can be used as is, the configuration files will be updated in place the first time GeoServer runs.
   * Optionally, your ``GEOSERVER_DATA_DIRECTORY`` can be moved to :file:`C:\\ProgramData\\Boundless\\geoserver\\data`. If you take this step please review and correct any absolute file references to spatial data stored in ``GEOSERVER_DATA_DIRECTORY``.

* Upgrading from an earlier version of Boundless Suite 4.9 and above:
  
  * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`C:\\ProgramData\\Boundless\\geoserver\\data` can be used as is, the configuration files will be updated in place the first time GeoServer runs.

