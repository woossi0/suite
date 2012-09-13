.. _webmaps.basic.load:

Load your data
==============

The first step is to load data into the OpenGeo Suite. These are many tools and methods to accomplish this (see the :ref:`dataadmin` section), but the simplest way is to use **GeoExplorer**. GeoExplorer allows you to create web maps based on layers served through GeoServer and a variety of other sources. When deployed alongside GeoServer and PostGIS, GeoExplorer will convert spatial files into PostGIS tables, and then serve that data through GeoServer. This process is seamless; all you need to do is supply the data!

#. First, make sure the OpenGeo Suite is running. You can do this by clicking on the :guilabel:`Start` button in the :ref:`dashboard`. If running on Linux or without a desktop-based Dashboard, start the Tomcat or other servlet container service.

#. Run GeoExplorer by selecting :guilabel:`GeoExplorer` in the Dashboard or by navigating to its direct URL (such as ``http://localhost:8080/geoexplorer``).

   .. note:: A web-based Dashboard is always available in any OpenGeo Suite deployment. If the OpenGeo Suite webapps are deployed at ``http://localhost:8080/``, then the Dashboard will be available at ``http://localhost:8080/dashboard``.

   .. figure:: img/load_geoexplorer.png

<<<<<<< HEAD
#. Click the :guilabel:`Import Shapefiles` link in the PostGIS section under :guilabel:`Components`.  This will load :guilabel:`pgShapeLoader` which will allow you to convert shapefiles to a tables in a PostGIS database.
=======
      *GeoExplorer*
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c

#. Click on the :guilabel:`Add Layers` button (green circle with the white plus) on the top left of the screen, and then select :guilabel:`Upload Layers`.

   .. figure:: img/load_uploadmenu.png

      *Click this menu item to access the Upload Layers dialog*

#. For security reasons, you will be asked to log in. Enter the administrative user name and password for GeoServer. The default is ``admin`` / ``geoserver``.

<<<<<<< HEAD
   .. figure:: ../../dataadmin/pgGettingStarted/img/pgshapeloader.png
=======
   .. figure:: img/load_login.png
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c

      *Login to GeoExplorer using GeoServer credentials*

<<<<<<< HEAD
#. Next, click the box titled :guilabel:`Shape File.`  In the folder dialog that appears, navigate to the location of your first shapefile, select it, then click :guilabel:`Open`.

   .. figure:: ../../dataadmin/pgGettingStarted/img/pgshp_select.png
=======
   .. note:: For security reasons, it is strongly recommended that you change the admin password. See the `Security <../../geoserver/webadmin/security/>`_ section of the GeoServer reference for more information on changing passwords.

   .. todo:: Also link to master password tutorial.
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c

#. A dialog will be displayed on the left side of the screen. There are boxes for :guilabel:`Title` and :guilabel:`Description`. You can add those fields in, or you can leave them to be auto-populated by GeoExplorer in the next steps.

   .. figure:: img/load_metadata.png

      *Title and Description fields for new layer*

#. The third box is for the location of your data files. GeoExplorer accepts the following file types:

   * Shapefile archive in ``zip`` format or equivalent, including all required files (``.shp``, ``.shx``, ``.dbf``, ``.prj``)
   * GeoTIFF

   .. note:: Uploading just the ``.shp`` file is not sufficient.

   Click on the yellow folder icon to bring up a file select dialog for your operating system. Select the file to upload, and click :guilabel:`OK`.

<<<<<<< HEAD
   .. figure:: ../../dataadmin/pgGettingStarted/img/pgshp_importing.png
=======
   .. figure:: img/load_fileselected.png
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c

      *File selected and ready for upload*

#. If your data does not include a ``.prj`` file, check the :guilabel:`Options` box and in the resulting dialog, enter the coordinate reference system ID in the :guilabel:`CRS` field. 

   .. figure:: img/load_crs.png

      *Manually declaring a CRS*

#. When done, click :guilabel:`Upload`.

   .. figure:: img/load_uploadbutton.png

      *Click the Upload button to continue*

#. Your data will be uploaded.

   .. figure:: img/load_progress.png

      *Progress bar during upload*

#. Your file will be loaded as a database table, and this table will be loaded into GeoServer as a Layer. You should immediately see your layer in the Map Window.

   .. figure:: img/load_success.png

      *A successfully loaded layer*

#. If you wish to load more data, you may repeat these steps. Otherwise, continue on to :ref:`webmaps.basic.style`.

.. todo:: Bulk layer loading is available through the GeoServer Layer Importer.

Optional: Adding hosted base layers
-----------------------------------

GeoExplorer displays a default base layer (`MapQuest OpenStreetMap <http://open.mapquest.com/>`_) but many others are available. To select another base layer:

#. Click on the :guilabel:`Add Layers` button (green circle with the white plus) on the top left of the screen, and then select :guilabel:`Add Layers`.

   .. figure:: img/load_addlayers.png

      *Adding layers*

#. In the dialog named :guilabel:`View available data from`, select an alternate data source, such as :guilabel:`Google Layers` or :guilabel:`MapBox Layers`.

<<<<<<< HEAD
#. To launch the pgAdmin tool, click the :guilabel:`Manage` link next to the PostGIS component in the Dashboard. 
=======
   .. figure:: img/load_hostedlayersource.png
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c

      *Hosted layer sources*

#. A list of hosted layers will be shown. Select the layer you would like to add as a base layer, and click :guilabel:`Add Layers`.

   .. figure:: img/load_hostedlayer.png

<<<<<<< HEAD
#. Double-click the server instance :guilabel:`PostGIS (localhost:54321)` in the :guilabel:`Object browser`.
=======
      *Selecting a hosted layer*
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c

#. The base layer will be added to the map. Only one base layer is visible at one time, so you may need to drag the layers around in the Layers List to view them properly.

   .. figure:: img/load_hostedlayeradded.png

<<<<<<< HEAD
#. Expand the tree to view :menuselection:`Databases -> [username] -> Schemas -> public -> Tables`.  You should see a listing of tables corresponding to the shapefiles that you loaded.

   .. note:: PostGIS automatically creates one additional table, :guilabel:`spatial_ref_sys`, and a view, :guilabel:`geometry_columns`, to record spatial reference and geometry column metadata for each table in the database.

   .. figure:: ../../dataadmin/pgGettingStarted/img/pgshp_pgadminconfirm.png
      :align: center

      *Database table listing*

For more information about pgAdmin and PostGIS, please see `Getting Started with PostGIS <../../dataadmin/pgGettingStarted/index.html>`_ or the :guilabel:`PostGIS Documentation` available from the :ref:`dashboard`.
=======
      *Hosted layer added to the map*
>>>>>>> 64efd5d7865ff71a2031ce4700bb124ae18aaf7c
