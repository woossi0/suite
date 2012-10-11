.. _apps.plugincreate.action:


Plugin with action only
=======================

The first example plugin will contain only an action, with no output. Specifically, the plugin will add a button to the toolbar called "Draw Box" which when clicked will allow the user to draw a rectangle on the map.

New application setup
---------------------

#. To begin, create a new application and run it in debug mode.

   .. note:: Please see the section on :ref:`apps.sdk.client.script` for details about creating a new application. This tutorial will assume an application called "myapp".

   OS X / Linux:

   .. code-block:: console

      suite-sdk create ~/myapp
      suite-sdk debug ~/myapp

   Windows:

   .. code-block:: console

      suite-sdk create %USERPROFILE%\myapp
      suite-sdk debug %USERPROFILE%\myapp

#. Verify in the browser that the application is running successfully by navigating to ``http://localhost:9080/``, replacing ``localhost`` with the URL where the SDK is hosted.

Creating basic plugin
---------------------

#. In the :file:`src/app` directory inside the application, create a :file:`plugins` directory.

#. In a text editor, create a new file called :file:`DrawBox.js` in the :file:`plugins` directory. This file will contain the plugin code. 

#. Add the following content to :file:`DrawBox.js`:

   .. literalinclude:: script/action_DrawBox_initial.js
      :language: javascript

   This code wraps an `OpenLayers.Control.DrawFeature <http://dev.openlayers.org/docs/files/OpenLayers/Control/DrawFeature-js.html>`_ that will allow the user to draw rectangular geometries on the map.

   .. todo:: What specific part of the code is the part that wraps the DrawFeature action?

   .. note:: Read more about the `Tool.js plugin <../../sdk-api/lib/plugins/Tool.html>`_ in the SDK API.

   As for user interaction, this code will only add a button to the toolbar with the text "Draw box". This button will not have any any functionality.

   .. note:: This example sets a namespace for the plugin called "myapp", but this can be changed, so long as it is consistent throughout.

   .. todo:: What about the ptype? If you change the namespace, does the ptype need to change to namespace_drawbox?


Connect plugin to application
-----------------------------

#. Now the the plugin is created, it must be connected to the application. Open :file:`src/app/app.js` and add a dependency at the top:

   .. literalinclude:: script/action_app.js
      :language: javascript
      :lines: 15

#. In the ``tools`` configuration section of the file add the following item to the bottom of the list:

   .. literalinclude:: script/action_app.js
      :language: javascript
      :lines: 72-75
      :emphasize-lines: 73-74

   .. todo:: :emphasize-lines: doesn't seem to work

#. Save this file.

#. Since a new dependency was added, the application will need to be restarted to see the changes. In the terminal, type CTRL+C to stop the SDK and then run the debug command again.

#. Reload the application in the browser. You should now see a new button in the toolbar titled :guilabel:`Draw box`.

   .. figure:: img/action_button_drawbox.png

      *Draw box button*

Adding functionality
--------------------

#. This button as currently designed does nothing, so the next step is to add some functionality to it.

   Open up :file:`DrawBox.js` for editing again. Find the ``addActions`` function and alter it to look like the following:

   .. literalinclude:: script/action_DrawBox.js
      :language: javascript
      :lines: 11-35

   This code creates a vector layer which will keep hold of the boxes that are being drawn by the ``OpenLayers.DrawFeature`` control. The ``handlerOptions`` specified ensure that only rectangular geometries can be drawn.

#. The drawn layer should remain visible, even when new layers get added to the map. To accomplish this, the ``raiseLayer`` function is called as a listener for the ``addlayer`` event on the map. This function responds by raising the layer. Add the following code to the :file:`DrawBox.js`:

   .. literalinclude:: script/action_DrawBox.js
      :language: javascript
      :lines: 37-42

   .. todo:: Is "raising" the correct word here? How/where exactly is this code doing the raising?

#. Since these functions depend on more classes from OpenLayers and GeoExt, more dependencies are needed. Add the following to the :file:`src/app/app.js`:

   .. literalinclude:: script/action_app.js
      :language: javascript
      :lines: 16-21

   .. todo:: Why exactly are these dependencies needed? How would one know that they are needed?

#. Restart the SDK to and reload the application in the browser to see the code in effect.

   .. figure:: img/action_drawingboxes.png

      *Drawing boxes*

Download the :download:`DrawBox.js <script/action_DrawBox.js>` and :download:`app.js <script/action_app.js>` files created in this section.

