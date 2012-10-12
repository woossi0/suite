.. _apps.plugincreate.actionoutput:


Plugin with action and output
=============================

This final example will modify the DrawBox control created previously to also display a popup after the box has been drawn on the map.

#. Open up the :file:`DrawBox.js` file in a text editor.

#. Add an event listener to the ``DrawFeature`` control to display a popup containing the area of the box. Replace the existing control with the following code.

   .. literalinclude:: script/actionoutput_DrawBox.js
      :language: javascript
      :lines: 26-37

#. Add the ``displayPopup`` function, which will create the output in the form of a ``GeoExt.Popup``. Place it right before the ``raiseLayer`` function:

   .. literalinclude:: script/actionoutput_DrawBox.js
      :language: javascript
      :lines: 42-53

#. Add the dependency for the ``GeoExt.Popup`` in the top of the file:

   .. literalinclude:: script/actionoutput_DrawBox.js
      :language: javascript
      :lines: 3

#. Open up the :file:`app.js` and add an ``outputTarget`` for the ``DrawBox`` tool, in between ``id: "drawbox",`` and ``actionTarget: "map.tbar"``:

   .. literalinclude:: script/actionoutput_app.js
      :language: javascript
      :lines: 79-84
      :emphasize-lines: 82

#. Restart the SDK and reload the application in the browser. Test the functionality by drawing boxes. After drawing a box there will now be a popup at the feature's location containing the area of the box drawn. The units are in meters, as the geometry is using Google Web Mercator projection.

   .. figure:: img/actionoutput_popup.png

      *Popup showing area of drawn box*

Download the :download:`DrawBox.js <script/actionoutput_DrawBox.js>` and :download:`app.js <script/actionoutput_app.js>` files created in this section.  Also, download :download:`BoxInfo.js <script/output_BoxInfo.js>` from the previous section to have all the files needed to recreate this application.

