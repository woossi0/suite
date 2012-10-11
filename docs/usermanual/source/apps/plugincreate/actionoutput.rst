.. _apps.plugincreate.actionoutput:


Plugin with action and output
=============================

This final example will modify the DrawBox control created previously to also display a popup after the box has been drawn on the map.

#. Open up the :file:`DrawBox.js` file in a text editor.

#. Add an event listener to the ``DrawFeature`` control to display a popup containing the area of the box. Replace the existing control with the following code.

   .. code-block:: javascript

      control: new OpenLayers.Control.DrawFeature(this.boxLayer,
        OpenLayers.Handler.RegularPolygon, {
          handlerOptions: {
            sides: 4,
            irregular: true
          },
          eventListeners: {
            featureadded: this.displayPopup,
            scope: this
          }
        }
      )

#. Add the ``displayPopup`` function, which will create the output in the form of a ``GeoExt.Popup``. Place it right before the ``raiseLayer`` function:

   .. code-block:: javascript

      displayPopup: function(evt) {
        this.removeOutput();
        this.addOutput({
          xtype: "gx_popup",
          title: "Feature info",
          location: evt.feature,
          map: this.target.mapPanel,
          width: 150,
          height: 75,
          html: "Area: " + evt.feature.geometry.getArea()
        });
      },

#. Add the dependency for the ``GeoExt.Popup`` in the top of the file:

   .. code-block:: javascript

      * @requires GeoExt/widgets/Popup.js

#. Open up the :file:`app.js` and add an ``outputTarget`` for the ``DrawBox`` tool, in between the ``id: "drawbox",`` and the ``actionTarget: "map.tbar"``:

   .. code-block:: javascript

      outputTarget: "map",

#. Restart the SDK and reload the application in the browser. Test the functionality by drawing boxes. After drawing a box there will now be a popup at the feature's location containing the area of the box drawn:

.. todo:: image showing this

.. todo:: What units is this info in? How would we know this?

.. todo:: Once code is verified, include complete scripts as separate files and pull code in from them.