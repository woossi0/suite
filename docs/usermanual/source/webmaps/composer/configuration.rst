.. _webmaps.composer.configuration:

Configuration
=============

The configuration pages in Composer allow you to manage data, layers, and maps.

This section will describe the various configuration pages. For viewing and styling layers, please see the :ref:`next section <webmaps.composer.styleview>`.

All Project Workspaces
----------------------

This page, accessible from the navigation panel by clicking :guilabel:`Project Workspaces` displays a list of all project workspaces.

.. figure:: img/allprojectworkspaces.png

   All Project Workspaces

In the box at the top of the page, the list of project workspaces can be sorted by name or by last modification, and can also be filtered via string.

For each workspace, links are avilable for the following functions:

* :guilabel:`Open`, for viewing the maps an layers in the project workspace
* :guilabel:`Settings`, for changing the project workspace name and settings
* :guilabel:`Info`, for showing the number of maps, layers, and stores associated with the project workspace

Project Workspace Settings
--------------------------

On a project workspace settings page, the following options are available:

* :guilabel:`Name`, for changing the project workspace name
* :guilabel:`Namespace URI`, for changing the namespace URI. This is a string that uniquely identifies the namespace to GeoServer. It must be in the form of a URL, but need not resolve to an actual web location
* :guilabel:`Default`, for specifying if this project workspace is the default. If a project is not specified in a GeoServer request, the default project workspace will be assumed.
* :guilabel:`Delete Workspace`, which will remove not only the project workspace, but **all of the contents of that project workspace**.

After making changes, click :guilabel:`Save Changes`.

.. figure:: img/workspacesettings.png

   Project workspace settings

Project Workspace contents
--------------------------

Clicking the name of a project workspace will bring up the contents of that project workspace.

.. figure:: img/workspace.png

   Project workspace contents

This page contains three tabs which show the following:

* :guilabel:`Maps` (default) shows the list of all maps created in the project workspace
* :guilabel:`Layers` shows the list of all layers published in the project workspace
* :guilabel:`Data` shows the connections to the underlying stores (file or database sources)

Maps tab
~~~~~~~~

The Maps tab shows the list of all maps created in the project workspace.

In the box at the top of the page, the list of maps can be sorted by name or by last modification, and can also be filtered via string.

For each map, there is a small preview of the map, which when clicked will open the map for :ref:`styling and viewing <webmaps.composer.styleview>`. There are also details about the map, such as the number of layers, the spatial reference system used in the map, and how recently the map was modified.

Two other links, notated with icons, are available. The link icon brings up a traditional GeoServer Layer Preview of the map. The gear icon brings up the :guilabel:`Map Settings` page, which allows details about the map to be entered:

* :guilabel:`Map Name`, for the name of the map used in URLs
* :guilabel:`Title`, for the human-readable name of the map
* :guilabel:`Projection` for the spatial reference system of the map
* :guilabel:`Description`, for long-form information about the map

.. figure:: img/mapsettings.png

   Map settings

Layers tab
~~~~~~~~~~

Data tab
~~~~~~~~