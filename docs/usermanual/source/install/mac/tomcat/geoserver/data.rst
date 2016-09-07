.. _install.mac.tomcat.data:

GeoServer Data Directory
========================

.. note:: If you have an existing geoserver, follow the "Upgrading" instructions, below.

New installations
-----------------

Unpack the sample geoserver data directory into :file:`/Library/Application Support/Boundless/GeoServer/data`:

1. Using :guilabel:`Terminal`, locate the :file:`suite-data-dir.zip` from the WAR bundle.

  .. code-block:: console
  
      cd ~/Downloads/BoundlessSuite-4.9-war

2. Create the GeoServer directory.

  .. code-block:: console
  
      mkdir -p /Library/Application Support/Boundless/GeoServer/data

3. Extract the data directory into the GeoServer directory.

  .. code-block:: console
  
      unzip suite-data-dir.zip -d /Library/Application Support/Boundless/GeoServer/data

   .. warning:: Ensure that you are extracting to the correct directory.

4. The new data directory is now ready for use. This location will be referred to as the ``GEOSERVER_DATA_DIRECTORY`` in subsequent documentation.

Upgrading
---------

.. warning:: Please uninstall previous releases before proceeding, and be sure to backup your data directory. For more information see :ref:`install.mac.tomcat.before`.

When upgrading make use of your existing data directory:

* Upgrading from OpenGeo Suite 4.8 and earlier:
   
   * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`~/Library/Application Support/GeoServer/data_dir` can be used as is, the configuration files will be updated in place the first time GeoServer runs.
   * Optionally, your ``GEOSERVER_DATA_DIRECTORY`` can be moved to :file:`/Library/Application Support/Boundless/GeoServer/data`. If you take this step please review and correct any absolute file references to spatial data stored in ``GEOSERVER_DATA_DIRECTORY``.

* Upgrading from an earlier version of Boundless Suite 4.9 and above:
  
  * Your ``GEOSERVER_DATA_DIRECTORY`` in :file:`/Library/Application Support/Boundless/GeoServer/data` can be used as is, the configuration files will be updated in place the first time GeoServer runs.

