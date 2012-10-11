.. _apps.plugincreate.output:

Plugin with output only
=======================

This example will create a new plugin that will display the length and area of all the boxes that are drawn on the map. 

.. todo:: Technically, doesn't this plugin have an output?

Creating a basic panel
----------------------

#. The first step is to create a plugin that outputs some simple text (unrelated to the box length). Create a file called :file:`BoxInfo.js` in the :file:`plugins` directory.

#. Open this file in a text editor and add the following:

   .. code-block:: javascript

      Ext.ns("myapp.plugins");

      myapp.plugins.BoxInfo = Ext.extend(gxp.plugins.Tool, {

        ptype: "myapp_boxinfo",

        addOutput: function(config) {
          return myapp.plugins.BoxInfo.superclass.addOutput.call(this, Ext.apply({
            title: "Box info",
            html: "This is where the box info will be shown"
          }, config));
        }

      });

      Ext.preg(myapp.plugins.BoxInfo.prototype.ptype, myapp.plugins.BoxInfo);

  This plugin will only implement the ``addOutput`` function to create a panel with a title and some content.

Connecting to the application
-----------------------------

#. Connect this new plugin to the application. Open up :file:`src/app/app.js` and add the dependency in the top of the file:

   .. code-block:: javascript

      * @require plugins/BoxInfo.js

#. Also, add a container that can hold the output, this is done in the ``items`` section of the ``portalConfig``:

   .. code-block:: javascript

      {
        id: "southpanel",
        xtype: "container",
        layout: "fit",
        region: "south",
        height: 100
      }

#. In the ``tools`` section, add an entry for the "boxinfo" tool and direct its output to the south panel:

   .. code-block:: javascript

      {
        ptype: "myapp_boxinfo",
        outputTarget: "southpanel"
      }

#. Restart the SDK and reload the application in the browser to see the results:

   .. figure:: img/output_boxinfo.png

      *Box info*


Adding dynamic content
----------------------

#. To connect this panel to dynamic content, it needs a reference to the vector ``boxLayer`` that is created by the ``DrawBox`` tool. This is done by attaching an ``id`` to the DrawBox tool in :file:`app.js`. The BoxInfo tool will then reference this ``id`` value. Add the ``id`` to :file:`app.js` after ``ptype: "myapp_drawbox"`` and before ``actiontarget: "map.tbar"``. 

   .. code-block:: javascript

      id: "drawbox",

#. Add the reference to the boxinfo config, after ``ptype: "myapp_boxinfo"`` and before ``outputTarget: "southpanel"``:

   .. code-block:: javascript

      boxTool: "drawbox",

#. Now replace the ``addOutput`` function of the BoxInfo tool with the following code. With this change, the application will depict information about the box that has been drawn.

   .. code-block:: javascript

      boxTool: null,

      tplText: 'Area: {area}, length: {length}',

      title: "Box info",

      addOutput: function(config) {
        if (this.boxTool !== null) {
          var layer = this.target.tools[this.boxTool].boxLayer;
          layer.events.on({
            featureadded: this.addFeature,
            scope: this
          });
          this.tpl = new Ext.Template(this.tplText);
        }
        return myapp.plugins.BoxInfo.superclass.addOutput.call(this, Ext.apply({
          title: this.title,
          autoScroll: true
        }, config));
      },

      addFeature: function(evt) {
        var geom = evt.feature.geometry,
          output = this.output[0];
        output.add({html: this.tpl.applyTemplate({area: geom.getArea(), length: geom.getLength()})});        
        output.doLayout();
      }

   In the above code, the ``boxTool`` string identifier finds the boxInfo tool so that it can get a reference to its ``boxLayer`` property. When a feature gets added to the ``boxLayer``, the code adds a panel to the output container. The content is generated using an ``Ext.Template``.

   .. todo:: I wish this could be broken down into more discrete steps.

#. Reload the application as before. Draw a few boxes on the map and verify that container at the bottom will display information about the boxes:

   .. figure:: img/output_boxinfo_arealength.png

      *Box info showing area and length*

Image showing boxes and the panel at bottom.

   .. todo:: Just length? Not length and width? Which dimension is "length"?  Seems to shift.

Bonus: Improving output
-----------------------

#. To adjust the output, use the ``tplText`` parameter and the ``outputConfig`` section of the tool in :file:`src/app/app.js`. For example, the following code will display only the area and turn off autoscrolling,

   .. code-block:: javascript

      {
        ptype: "myapp_boxinfo",
        boxTool: "drawbox",
        tplText: "AREA: {area}",
        outputTarget: "southpanel",
        outputConfig: {
          title: "My title",
          autoScroll: false
        }
      }

   .. todo:: img/output_boxinfo_alt.png

      *Box info showing alternate output*

   .. todo:: autoScroll: false? No length? "My title"? This almost seems less improved. Shouldn't we switch these examples?


