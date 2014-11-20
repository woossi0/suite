.. _cartography.ysld.tutorial.line:

Styling a line layer
====================

The roads layer contains line geometries, so we will use a :ref:`line symbolizer <cartography.ysld.reference.symbolizers.line>`.

Viewing the existing style
--------------------------

#. In the layers tab of the Composer, click on the style option for the ``ne_10m_admin_0_roads`` layer to go to the style edit page. A simple default style is already associated with this layer.

   .. figure:: img/line_default.png

      Default line style

   .. note:: Your default color may vary.

#. We can immediately see that there are far more roads than we need on this layer. Fortunately, the road data contains a ``scalerank`` attribute to help determine the importance of different roads. Add a :ref:`filter <cartography.ysld.reference.filters>` to only show roads with ``scalerank < 4``. Then our style looks like:

   .. code-block:: yaml
      :emphasize-lines: 6

         name: roads
         title: Simple road style
         feature-styles:
         - name: name
           rules:
           - filter: ${scalerank < 4}
             symbolizers:
             - line:
                 stroke-color: '#000000'
                 stroke-width: 1

   The layer now appears much less cluttered:

   .. figure:: img/line_simple.png

      Only important roads are shown (``scalerank < 4``)

Setting scale
-------------

If we zoom in, we want to see all the roads, not just those included in our filter. The :ref:`scale <cartography.ysld.reference.scalezoom>` property can be used with rules to show or hide features depending on the zoom level. In order to determine what roads to show, we will again use the ``scalerank`` attribute of the data to add the following rules:

* If scale is less than 8000000, show features with ``scalerank < 4``
* If scale is between 2000000 and 8000000, show features with ``scalerank < 8``
* If scale is greater than 2000000, show all features

#. Add these rules to the style:
   
   .. note::
      
      YAML requires that the rules form a list with the same amount of indentation as shown below. To adjust indentation select a block of text and use TAB (or Shift-TAB) as appropriate.

   .. code-block:: yaml
      :emphasize-lines: 6,12-22
      
      name: roads
      title: Simple road style
      feature-styles:
      - name: name
        rules:
        - scale: (8000000,)
          filter: ${scalerank < 4}
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 1
        - scale: (2000000,8000000)
          filter: ${scalerank < 8}
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 1
        - scale: (,2000000)
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 1

   .. note:: You can replace the scale values with scientific notation if you'd like: ``8e6`` for ``8000000``, ``2e6`` for ``2000000``.

Differentiating features
------------------------

On the smaller scales, we want some differentiation between roads based of the feature's type. We will use the ``featurecla`` attribute for this:

#. Add a new rule for roads that have attribute ``featurecla = 'Ferry'``, and draw these roads with a blue line:

   .. code-block:: yaml
      :emphasize-lines: 19-24
      
        rules:
        - scale: (8000000,)
          filter: ${scalerank < 4}
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 1
        - scale: (2000000,8000000)
          filter: ${scalerank < 8}
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 1
        - scale: (,2000000)
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 1
        - name: ferry
          scale: (,8000000)
          filter: ${featurecla = 'Ferry'}
          symbolizers:
          - line:
              stroke-color: '#00CCFF'

#. Further modify this rule to use a dashed line. Add the following at the bottom, at the same indentation as the ``stroke-color``:

   .. code-block:: yaml
      :emphasize-lines: 7-8
      
        - name: ferry
          scale: (,8000000)
          filter: ${featurecla = 'Ferry'}
          symbolizers:
          - line:
              stroke-color: '#00CCFF'
              stroke-width: 2
              stroke-dasharray: '4 6'

.. todo:: Figure?

Adding road casing
------------------

Line symbolizers only have a stroke, so you cannot normally draw an outline around a line. This effect can be simulated by drawing two line symbolizers of different widths, one on top of the other.

#. Add a new rule to draw expressways (``expressway = 1``) using 6px-wide black lines with round ends. This will be our outline:

   .. code-block:: yaml
      :emphasize-lines: 9-16

        - name: ferry
          scale: (,8000000)
          filter: ${featurecla = 'Ferry'}
          symbolizers:
          - line:
              stroke-color: '#00CCFF'
              stroke-width: 2
              stroke-dasharray: '4 6'
        - name: expressway
          scale: (,8000000)
          filter: ${expressway = 1}
          symbolizers:
          - line:
              stroke-color: '#000000'
              stroke-width: 6
              stroke-linecap: round

#. In order to ensure the inner line is drawn last, it must be in a separate :ref:`feature style <cartography.ysld.reference.featurestyles>`. At the bottom of our YSLD, we add a new feature style which contains a rule to draw expressways using 4px orange lines with round ends:

   .. code-block:: yaml
      :emphasize-lines: 9-18

          - name: expressway
            scale: (,8000000)
            filter: ${expressway = 1}
            symbolizers:
            - line:
                stroke-color: '#000000'
                stroke-width: 6
                stroke-linecap: round
      - name: inner
        rules:
        - name: expressway
          scale: (,8000000)
          filter: ${expressway = 1}
          symbolizers:
          - line:
              stroke-color: '#FFCC00'
              stroke-width: 4
              stroke-linecap: round

   The first feature type style will draw expressways as a black casing, the second will draw expressways as an orange line. When these two drawings are composed together they will form an orange line with black casing.

#. After adding the ferries and expressways rules, this is the view when zoomed in:

   .. figure:: img/line_intermediate.png

      Road casing and other styles

#. Now that we have these rules for special types of roads, we want to make sure our basic rule does not also draw lines for these special roads. We can add a filter to the rule to exclude these from the rule (``<>`` means "not equal to"):

   .. code-block:: yaml
      :emphasize-lines: 3

     - name: roads
        scale: (,8000000)
        filter: ${scalerank < 8 AND expressway <> 1 AND featurecla <> 'Ferry'}
        symbolizers:
        - line:
            stroke-color: '#333333'
            stroke-width: 1

Using ``else`` to account for all other features
------------------------------------------------

When we added the above rules, we made them apply for all zoom levels below ``8000000``. However, we still have a rule that draws all the roads if the zoom level is below ``2000000``. We want to use this rule, but we do not want it to apply if we are already drawing a styled road.

To accomplish this, we can make an ``else`` rule. This means that it will only apply if no other filter is true. This way, when we zoom in, we eventually see all the roads, without drawing over our special styles for ferries and expressways,

#. Add the following rule:

   .. code-block:: yaml
      :emphasize-lines: 8-14

        - name: roads
          scale: ( ,8000000)
          filter: ${scalerank < 8 AND expressway <> 1 AND featurecla <> 'Ferry'}
          symbolizers:
          - line:
              stroke-color: '#333333'
              stroke-width: 1
        - name: else
          scale: (,2000000)
          else: true
          symbolizers:
          - line:
              stroke-color: '#777777'
              stroke-width: 0.5
      - name: inner

Final style
-----------

After all these changes, the final style should look like this:

.. literalinclude:: files/ysldtut_line.ysld
   :language: yaml

The resulting map shows different levels of road detail at different zoom levels:

.. figure:: img/line_all_zoom_1.png

   Completed Roads layer (zoomed out)

.. figure:: img/line_all_zoom_2.png

   Completed Roads layer (intermediate zoom)

.. figure:: img/line_all_zoom_3.png

   Completed Roads layer (zoomed in)

.. note:: :download:`Download the final line style <files/ysldtut_line.ysld>`

Continue on to :ref:`cartography.ysld.tutorial.polygon`.