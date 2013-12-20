.. _geoexplorer.using.upload:

Upload Data
===========


With GeoExplorer you can upload data, shapefiles (compressed into an archive file) or GeoTIFF files directly into a local instance of GeoServer. The data will be configured and styled automatically to work in GeoExplorer.

.. warning:: Shapefiles must be in an archive file. Simply selecting the ``.shp`` file will not work. Refer to the section on :ref:`geoexplorer.using.upload.formats` for more information.

To upload data, you must login to the local GeoServer instance for authentication. For more information, please refer to the :ref:`geoexplorer.using.login` section.

.. |addlayer| image:: ../images/button_addlayer.png 
              :align: bottom

#. To access the Upload layers panel, click :guilabel:`Add Layers` |addlayer| on the :ref:`geoexplorer.workspace.layerstoolbar` and click :guilabel:`Upload layers`. 

   .. figure:: images/uploadlayers.png

      *Upload layers tool*

   If you're not already logged into the local GeoServer instance, a :guilabel:`Login` dialog box will be displayed. Enter your GeoServer user name and password.

   .. figure:: images/login_filled.png

     *Login to the local GeoServer*

#. On successful completion of the login process, the :guilabel:`Upload layers` panel will display. 

   .. figure:: images/panel_uploadlayers.png

     *Upload layers panel*

#. Complete the :guilabel:`Upload layers` panel.

   .. list-table::
         :header-rows: 1
         :widths: 20 80

         * - Field
           - Description
         * - Title
           - Layer Title—Human-readable layer headline (as opposed to the ID/Name). If left blank, the Title will be set to ``[filename]`` and the ID set to ``[workspace]:[filename]``.
         * - Description
           - Layer Abstract—Description of the layer. This may span multiple paragraphs if required.
         * - Data
           - Data file to be uploaded—Valid file extensions are ``.zip``, ``.gz``, ``.tar.bz2``, ``.tar``, ``.tgz``, ``.tbz2``, or ``.tif``. Click the folder button to display a file select dialog box. See the section on :ref:`geoexplorer.using.upload.formats` for more information on what types of data can be uploaded.

   Click the :guilabel:`Options` check box to display three additional options.

   .. list-table::
         :header-rows: 1
         :widths: 20 80

         * - Field
           - Description
         * - Workspace
           - GeoServer workspace to be associated with the layer. Select from any available  workspaces. Default is the default workspace in GeoServer. 
         * - Store
           - GeoServer store where the layer will be stored. Select from any available store. Default is the default store in GeoServer.         
         * - CRS
           - Coordinate Reference System ID—EPSG spatial reference code (for example, EPSG:4326)


   .. figure:: images/panel_uploadfilled.png

      *Completed Upload layers panel*

#. When the :guilabel:`Upload layers` panel is completed, click :guilabel:`Upload` to start loading the data.

   .. figure:: images/upload_progressbar.png

      *Uploading and configuring data*

The data is processed in the following order:

#. File copied to the GeoServer data directory (subfolder named ``incoming``)
#. Archive unpacked (if applicable)
#. Data loaded as a layer in GeoServer (with your Title and Description assigned)
#. Projection for the layer will be determined. If this is not possible (for example, the CRS ID wasn't supplied when the data was uploaded), the projection information must be supplied separately in GeoServer.
#. Unique style created for the layer


After the upload process is complete, you will see your new layer in the :guilabel:`Available Layers` panel. You can now :ref:`geoexplorer.using.add` to your map.

.. _geoexplorer.using.upload.formats:

Data formats
------------

The :guilabel:`Upload layers` panel will accept data in either shapefile or GeoTIFF format. If you are uploading shapefiles, the shapefile must be added to an archive file (zip, tar, gzip, or bzip).  (The upload data process requires a single file, and shapefiles include a number of files including, but not limited to, ``.shp``, ``.shx``, and ``.dbf`` files.)

A GeoTIFF file (``.tif``) does not need to be in an archive format, but may be added to an archive file if reducing file size is a requirement.
