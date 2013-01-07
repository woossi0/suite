.. sysadmin.virtualservices:

Using virtual services
======================

.. warning:: Document status: **Needs technical review**

**Virtual services** provide a way to section off GeoServer layers. Using virtual services, a user can interact with GeoServer through standard OGC protocols while only a subset of the published layers is visible. This is advantageous for when there are multiple project administrators working on the same GeoServer instance, or when a given GeoServer instance is serving a large amount of layers, making the capabilities documents time-consuming to load.

Virtual services operate by providing workspace-specific endpoints for OGC services. Using these endpoints, the user/client will only "see" the layers associated with that particular workspace.

From an administration perspective, virtual services allows the roles of GeoServer administrator and project administrator to be separated.

This tutorial will show how to implement a typical scenario utilizing virtual services.

.. note:: Read more about `Virtual Services <../../geoserver/services/virtual-services.html>`_ in the GeoServer reference.

Scenario
--------

There are two project administrators working on the same GeoServer instance. One is working on the **Lakes** project. She wants to be able to load and administer all of the data related to her project, but does not need to know about or administer any other project. The other project administrator is working on the **Traffic** project. He too wants to be able to load and administer all of the data related to his project, but does not need to know about or administer any other project.

To configure this scenario, the following steps must be taken:

* Create two workspaces: ``lakes`` and ``traffic``
* Load all relevant data to the proper workspace
* Instruct usage of virtual services endpoints
* Disable global service endpoints


Creating workspaces
-------------------

First, configure the virtual service endpoints.

#. From the GeoServer web interface, log in to the administrator account.

#. Click :guilabel:`Workspaces`.

   .. figure:: img/workspaceslink.png

      *Click to manage workspaces*

#. Click :guilabel:`Add new workspace`.

   .. figure:: img/addnewworkspacelink.png

      *Click to add a new workspace*

#. Fill out the form:

   * In the box titled :guilabel:`Name`, enter ``lakes``
   * In the box titled :guilabel:`Namespace URI`, enter ``http://lakes``.
   * Do not check the :guilabel:`Default Workspace` box.

   Click :guilabel:`Submit` when done.

   .. figure:: img/workspacelakes.png

      *New workspace: Lakes*

#. Click on :guilabel:`Add new workspace` again. 

#. Fill out the form:

   * In the box titled :guilabel:`Name`, enter ``traffic``
   * In the box titled :guilabel:`Namespace URI`, enter ``http://traffic``.
   * Do not check the :guilabel:`Default Workspace` box.

   Click :guilabel:`Submit` when done.

   .. figure:: img/workspacetraffic.png

      *New workspace: Traffic*

   .. note::

      Workspace creation can also be done programmatically through the REST API by submitting a POST request to this endpoint::

        http://<GEOSERVER_URL>/rest/workspaces

      with the following content::

        <workspace><name>lakes</name></workspace>

#. To verify that the virtual service endpoints have been configured correctly, navigate to the following URLs::

      http://<GEOSERVER_URL>/lakes/wfs?request=GetCapabilities
      http://<GEOSERVER_URL>/traffic/wfs?request=GetCapabilities

   .. figure:: img/validcaps.png

      *A valid capabilities document from a virtual service*

   If a valid capabilities document displays, the workspaces were set up correctly. If a 404 error page displays, the workspace may not have been created successfully. If so, please retry the above steps.

#. Similar verification can be done with the equivalent WMS virtual service endpoints::

     http://<GEOSERVER_URL>/lakes/wms?request=GetCapabilities
     http://<GEOSERVER_URL>/traffic/wms?request=GetCapabilities


Loading layers
--------------

The process for loading layers remains unchanged. See the section on :ref:`dataadmin` for more information. Make sure that all layers and stores are in the appropriate workspace.

.. note:: If layers had been already loaded prior to the creation of these workspaces, the layers will need to be migrated to the appropriate workspace. To migrate layers from one workspace to another, move the stores that the layers are contained in, and all the contained layers will switch workspaces.


Verifying virtual services
--------------------------

Now that all layers are in their appropriate workspaces, verify this by navigating to any of the virtual service endpoints mentioned above::

  http://<GEOSERVER_URL>/lakes/wms?request=GetCapabilities
  http://<GEOSERVER_URL>/traffic/wms?request=GetCapabilities

Scroll down in the document to the ``<Layer>`` section (``<FeatureTypeList>`` for WFS). The layers loaded in that workspace should be listed but should also be the only layers listed.

You can also verify virtual services in `GeoExplorer <../../geoexplorer>`_.

#. Open GeoExplorer.

#. Open the Add Layers dialog.

   .. figure:: img/geoexplorer_addlayerslink.png

      *Adding layers in GeoExplorer*

#. In the select box titled :guilabel:`View available data from:`, select :guilabel:`Add a New Server...`.

   .. figure:: img/geoexplorer_addnewserverlink.png

      *Adding a new WMS server in GeoExplorer*

#. In the :guilabel:`URL` field, enter one of the WMS virtual service endpoints.

   .. figure:: img/geoexplorer_addnewserverdialog.png

      *Entering the virtual service endpoint*

#. Click :guilabel:`Add Server`.

#. The layers listed should be only those loaded into that particular workspace.

   .. figure:: img/geoexplorer_vslayers.png

      *Virtual service layers*


Restricting global services
---------------------------

A key benefit of virtual services is segmentation; no user needs to see every single layer in GeoServer. Because of this, once workspaces are properly set up, global services can be disabled.

#. Click :guilabel:`Global` under :guilabel:`Settings`.

   .. figure:: img/globalsettingslink.png

      *Click to manage GeoServer global settings*

#. Uncheck :guilabel:`Enable Global Services`.

   .. figure:: img/globalservicesdisabled.png

      *Global service disabled*

#. Click :guilabel:`Submit`.

   .. note::
     
      Disabling global services can also be done programmatically through the REST API by submitting a PUT request to this endpoint::

        http://<GEOSERVER_URL>/rest/settings/

      with the following content::

        <global><globalServices>false</globalServices></global>

#. Verify that the global endpoint has been disabled by navigating to the following URL:: 

     http://<GEOSERVER_URL>/wfs?request=GetCapabilities

   The response should include the following error message:  "**No workspace specified**"

   .. figure:: img/noworkspacespecified.png

      *Exception when viewing a disabled global capabilities document*

#. The virtual service endpoints will still be valid::

      http://<GEOSERVER_URL>/lakes/wfs?request=GetCapabilities
      http://<GEOSERVER_URL>/traffic/wfs?request=GetCapabilities

