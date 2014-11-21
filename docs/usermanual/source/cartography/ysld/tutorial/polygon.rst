.. _cartography.ysld.tutorial.polygon:

Styling a polygon layer
=======================

The Countries layer is a polygon layer, and therefore we use a :ref:`polygon symbolizer <cartography.ysld.reference.symbolizers.polygon>` to display it. 

Viewing the existing style
--------------------------

#. In the layers tab of the Composer, click on the style option for the ``ne_10m_admin_0_countries`` layer to go to the style edit page. A simple default style is already associated with this layer.

   .. figure:: img/poly_default.png

      Default polygon style

   .. note:: Your default color may vary.

   Observe that the default style draws a colored polygon with a black border for every country.

#. The default style will look something like this:
   
   .. code-block:: yaml
   
      name: Default Styler
      title: A boring default style
      abstract: A sample style that just prints out a green line
      feature-styles:
      - name: name
        rules:
        - name: Rule 1
          title: Green Line
          abstract: A green line with a 2 pixel width
          symbolizers:
          - line:
              stroke-color: '#0000FF'
              stroke-width: 1

Setting basic styling
---------------------

Polygon symbolizers provide options for styling both fill (inside) and stroke (outline) of features.

#. Modify the default style to create a nicer display using the following additional parameters:

   .. list-table::
      :class: non-responsive
      :widths: 40 60 
      :header-rows: 1

      * - Parameter
        - Description
      * - ``fill-color: '#EFEFC3'``
        - Change the fill color to a pale brown
      * - ``fill-opacity: 0.5``
        - Make the fill 50% transparent
      * - ``stroke-color: '#777777'``
        - Change the stroke color
      * - ``stroke-dasharray: '4 4'``
        - Use dashed lines of 4px with 4px gaps
      * - ``stroke-width: 0.5``
        - Use a line width of 0.5 px

#. The complete style after these changes will be:

   .. code-block:: yaml
      :emphasize-lines: 1-3,7-13
      
      name: countries
      title: Countries style
      abstract: countries of the world
      feature-styles:
      - name: name
        rules:
        - symbolizers:
          - polygon:
              stroke-color: '#777777'
              stroke-dasharray: '4 4'
              stroke-width: 0.5
              fill-color: '#EFEFC3'
              fill-opacity: 0.5

   And the layer now will look like this:

   .. figure:: img/poly_basic.png

      Basic styled polygons

Adding filters
--------------

Suppose we wish to display different colors for each country. The countries layer contains an attribute called ``MAPCOLOR7``, which assigns each country a number from 1 to 7, such that no adjacent countries have the same number. We can use this attribute to control what color a country is using :ref:`filters <cartography.ysld.reference.filters>`. Filters apply a condition to a rule, so that the symbolizers in that rule are only drawn if the filter evaluates to true.

#. Add seven rules, corresponding to the seven possibilities for ``MAPCOLOR7``. For each value, set the ``fill-color`` to the following values:

   .. list-table::
      :class: non-responsive
      :widths: 40 60 
      :header-rows: 1

      * - Filter
        - Parameter
      * - ``MAPCOLOR7 = 1``
        - ``fill-color: '#FFC3C3'``
      * - ``MAPCOLOR7 = 2``
        - ``fill-color: '#FFE3C3'``
      * - ``MAPCOLOR7 = 3``
        - ``fill-color: '#FFFFC3'``
      * - ``MAPCOLOR7 = 4``
        - ``fill-color: '#C3FFE3'``
      * - ``MAPCOLOR7 = 5``
        - ``fill-color: '#C3FFFF'``
      * - ``MAPCOLOR7 = 6``
        - ``fill-color: '#C3C3FF'``
      * - ``MAPCOLOR7 = 7``
        - ``fill-color: '#BFC3FF'``

#. After adding the filters, the style will look like:
   
   .. code-block:: yaml
      :emphasize-lines: 7-62

       name: countries
       title: Countries style
       abstract: countries of the world
       feature-styles:
       - name: name
         rules:
         - filter: ${MAPCOLOR7 = 1}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#FFC3C3'
               fill-opacity: 0.5
         - filter: ${MAPCOLOR7 = 2}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#FFE3C3'
               fill-opacity: 0.5
         - filter: ${MAPCOLOR7 = 3}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#FFFFC3'
               fill-opacity: 0.5
         - filter: ${MAPCOLOR7 = 4}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#C3FFE3'
               fill-opacity: 0.5
         - filter: ${MAPCOLOR7 = 5}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#C3FFFF'
               fill-opacity: 0.5
         - filter: ${MAPCOLOR7 = 6}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#C3C3FF'
               fill-opacity: 0.5
         - filter: ${MAPCOLOR7 = 7}
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#BFC3FF'
               fill-opacity: 0.5

   .. figure:: img/poly_color.png

      Adjacent countries will not have the same color

Compacting thematic styles with transformation functions
--------------------------------------------------------

While filters are very useful, the required syntax is quite long, and much of the content is redundant. The exact same functionality can be accomplished much more concisely using the :ref:`recode function <cartography.ysld.reference.functions>`.

#. Replace the rules with our origional (before we added the filters):
   
   .. code-block:: yaml
      :emphasize-lines: 3-8
      
        rules:
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: '#EFEFC3'
               fill-opacity: 0.5

#. Change the ``fill-color`` to the following CQL expression:
   
   .. code-block:: yaml
      :emphasize-lines: 7-11
      
        rules:
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: ${
                   recode(MAPCOLOR7,
                     1, '#FFC3C3', 2, '#FFE3C3', 3, '#FFFFC3', 4, '#C3FFE3',
                     5, '#C3FFFF', 6, '#C3C3FF', 7, '#BFC3FF')
                 }
               fill-opacity: 0.5

   This sets the ``fill-color`` based on the value of ``MAPCOLOR7``, according to the key-value pairs in the ``recode`` function. If ``MAPCOLOR7 = 1``, set to ``ffc3c3``, if ``MAPCOLOR7 = 2`` set to ``ffe3c3``, etc.

#. The style now looks much simpler:
   
   .. code-block:: yaml

      name: countries
      title: Countries style
      abstract: countries of the world
      feature-styles:
       - name: name
         rules:
         - title: countries
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: ${
                   recode(MAPCOLOR7,
                     1, '#FFC3C3', 2, '#FFE3C3', 3, '#FFFFC3', 4, '#C3FFE3',
                     5, '#C3FFFF', 6, '#C3C3FF', 7, '#BFC3FF')
                 }
               fill-opacity: 0.5

   It should be noted that this will produce the *exact same output* as in the previous section.

Adding labels
-------------

Labels can be applied to any layer using a :ref:`text symbolizer <cartography.ysld.reference.symbolizers.text>`. Typically you will want to use some data attribute as the label text, usually a name.

#. Add a text symbolizer with a basic label using the ``NAME`` attribute:
   
   .. code-block:: yaml
   
      name: countries
      title: Countries style
      abstract: countries of the world
      feature-styles:
       - name: name
         rules:
         - title: countries
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: ${
                   recode(MAPCOLOR7,
                     1, '#FFC3C3', 2, '#FFE3C3', 3, '#FFFFC3', 4, '#C3FFE3',
                     5, '#C3FFFF', 6, '#C3C3FF', 7, '#BFC3FF')
                 }
               fill-opacity: 0.5
           - text:
               label: ${NAME}

#. After this change, the map will look like:

   .. figure:: img/poly_label_basic.png

#. The default labeling parameters are not ideal, but a number of styling options are available. Add the following attributes to the text symbolizer:

   .. list-table::
      :class: non-responsive
      :widths: 40 60 
      :header-rows: 1

      * - Parameter
        - Description
      * - ``label: ${strToUpperCase(NAME)}``
        - Change the label text to uppercase
      * - ``font-size: 14``
        - Change the font size to 14
      * - ``font-family: SansSerif``
        - Change the font to SansSerif
      * - ``font-weight: bold``
        - Make the font bold
      * - ``fill-color: '#333333'``
        - Change the font color to dark gray

#. This gives a much nicer font style, but the label placement is still poor. We can use some additional options to fix this:

   .. list-table::
      :class: non-responsive
      :widths: 40 60 
      :header-rows: 1

      * - Parameter
        - Description
      * - ``x-autoWrap: 100``
        - Wrap any labels wider than 100 pixels
      * - ``x-maxDisplacement: 200``
        - Allow labels to shift up to 200 pixels to maintain best placement
      * - ``x-goodnessOfFit: 0.8``
        - Only show labels with 0.8 or better fit
      * - ``x-labelPriority: ${10-LABELRANK}``
        - Select labels based on priority (uses the ``LABELRANK`` attribute of the data to determine this).

Final style
-----------

The full style now looks like this::

   .. code-block:: yaml
   
      name: countries
      title: Countries style
      abstract: countries of the world
      feature-styles:
       - name: name
         rules:
         - title: countries
           symbolizers:
           - polygon:
               stroke-color: '#777777'
               stroke-dasharray: '4 4'
               stroke-width: 0.5
               fill-color: ${
                   recode(MAPCOLOR7,
                     1, '#FFC3C3', 2, '#FFE3C3', 3, '#FFFFC3', 4, '#C3FFE3',
                     5, '#C3FFFF', 6, '#C3C3FF', 7, '#BFC3FF')
                 }
               fill-opacity: 0.5
           - text:
              label: ${strToUpperCase(NAME)}
              font-size: 14
              font-family: SansSerif
              font-weight: bold
              fill-color: '#333333'
              x-autoWrap: 100
              x-maxDisplacement: 200
              x-goodnessOfFit: 0.8
              x-labelPriority: ${10-LABELRANK}

With these additions, the labels now appear much clearer:

.. figure:: img/poly_label_options.png

   Completed countries style

.. note:: :download:`Download the final polygon style <files/ysldtut_poly.ysld>`

Continue on to :ref:`cartography.ysld.tutorial.point`.
