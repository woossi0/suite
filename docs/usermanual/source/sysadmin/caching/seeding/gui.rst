.. _sysadmin.caching.seeding.gui:

Seeding a tile cache graphically
================================

.. warning:: Document status: **Needs Technical Review (MP)**

This section explains how to start a seed task in the built-in tile caching system. The considerations for how best to determine the parameters for such a job are contained in the :ref:`sysadmin.caching.seeding.considerations` section.

This section will assume that a grid set has already been configured for the layer, either a default grid set or because a custom grid set was created.

.. todo:: Add link to Custom Grid Set tutorial when it exists.

To seed a tile cache for a given layer:

#. Log in to the GeoServer web admin interface with an administrative user with sufficient credentials to manage seeding jobs.

   .. todo:: Which roles will work? Anything other than ROLE_ADMINISTRATOR?

#. Once logged in, click the :guilabel:`Tile Layers` link under the :guilabel:`Tile Caching` section.

   .. figure:: img/gui_menu_tilelayers.png

      *Tile Layers link in the Tile Cache menu*

   .. todo:: Consolidate this with other GS UI images

#. Find the entry for the layer you would like to seed, and click :guilabel:`Seed/Truncate`.

   .. figure:: img/gui_menu_layerlist.png

      *usa:states in the list of tiled layers*

#. This will bring up the embedded GeoWebCache interface, which is responsible for managing the tile cache.

   .. figure:: img/gui_gwcseedpage.png

      *Embedded GeoWebCache menu used for seeding*

#. Fill out the form titled :guilabel:`Create a new task`.

   .. list-table::
      :header-rows: 1

      * - Option
        - Description
      * - :guilabel:`Number of tasks to use`
        - Number of concurrent threads to use in the seeding process. Value to use is system-dependent.
      * - :guilabel:`Type of operation`
        - Determines the operation. Select :guilabel:`Seed` in most cases.
      * - :guilabel:`Grid Set`
        - Desired grid set to use when generating tiles.
      * - :guilabel:`Format`
        - Image format for tiles.
      * - :guilabel:`Zoom start`
        - Lowest zoom level to generate tiles. Usually 0.
      * - :guilabel:`Zoom end`
        - Highest zoom level to generate tiles. See :ref:`sysadmin.caching.seeding.considerations` for advice on determining which zoom levels to seed.
      * - :guilabel:`Bounding box`
        - Use this extent to seed tiles from only a subsection of the entire grid set extent. See :ref:`sysadmin.caching.seeding.considerations` for advice on when to seed a portion of the extent.

   .. todo:: Should say more about number of threads.

   .. figure:: img/gui_gwcseedform.png

      *Seeding form*

#. When the form is filled out, click :guilabel:`Submit`. The seed task will start. The page will show the task's status, including estimated time remaining. Click the :guilabel:`Refresh list` button to update the view. 

   .. figure:: img/gui_status.png

      *Status of seed tasks*

.. todo:: How to see a list of all the currently running seed tasks?

#. The status of this layer's seed tasks are available at ``http://<GEOSERVER_URL>/gwc/rest/seed/namespace_layer``. In the URL, the colon in the fully qualified layer name is replaced by an underscore (so ``usa:states`` would become ``usa_states``).

   It is also possible to view all currently running tasks from this page (or any layer's seed page) by selecting :guilabel:`List all Layers tasks` at the very top of the page. The view will automatically refresh to include seed tasks from other layers.

   .. figure:: img/gui_listalllayers.png

      *Select this to view seed tasks for all layers*

#. On this status page, it is also possible to kill (cancel) seed tasks. To kill a seed task, find the seed task to kill and click the :guilabel:`Kill Task` button.

  .. figure:: img/gui_killtask.png

     *Click to kill task*