.. _cartography.ysld.why:

Advantages of YSLD
==================

There are many reasons to use the YSLD styling markup language over the SLD markup language:

* Easier to read
* More compact
* More flexible syntax
* Contains variables for reusable code
* Compatible with SLD

Easier to read
--------------

Compare the following style directives, both of which specify the fill color of a feature to be red.

SLD:

.. code-block:: xml

   <CssParameter name="fill">#ff0000</CssParameter>

YSLD::

    fill-color: #ff0000

In SLD, the XML-based nature of the content obscures the important aspects of the directive in the middle of the line. With YSLD, the attribute and the value are clearly marked and associated with no extraneous information, making comprehension easier.


More compact
------------

Individual style files of a sufficient complexity can easily grow to dozens of rules. (For example, a file that has ten different :ref:`attribute-based <cartography.ysld.reference.filters>` rules at ten different scales will have one hundred rules.) Therefore the length of each individual rule can drastically affect the length of the entire style.

Compare the follow style rules, which both specify the a point layer to be styled as a red circle with 8-pixel diameter and a 2-pixel black stroke:

SLD:

.. code-block:: xml

     <Rule>
       <PointSymbolizer>
         <Graphic>
           <Mark>
             <WellKnownName>circle</WellKnownName>
             <Fill>
               <CssParameter name="fill">#FF0000</CssParameter>
             </Fill>
             <Stroke>
               <CssParameter name="stroke">#000000</CssParameter>
               <CssParameter name="stroke-width">2</CssParameter>
             </Stroke>
           </Mark>
           <Size>8</Size>
         </Graphic>
       </PointSymbolizer>
     </Rule>

YSLD::

  rules:
  - symbolizers:
    - point:
        size: 8
        symbols:
        - mark:
            shape: circle
            fill-color: '#ff0000'
            stroke-color: '#000000'
            stroke-width: 2

.. warning:: VERIFY SYNTAX

While the SLD comes in at 300 characters, the YSLD equivalent comes in at about half that. Also, by not using an XML-based markup language, the removal of open and close tags make the document to look much simpler and be much more compact. 

More flexible syntax
--------------------

SLD, being an XML-based markup language, has a schema to which any style file needs to adhere. This means that not only are certain tags required, but the order of those tags are significant. This can cause confusion when the correct directives happen to be in the wrong order.

For example, take the following fill and stroke directives for a symbolizer. In SLD, this is valid:

.. code-block:: xml

   <Fill>
     <CssParameter name="fill">#ff0000</CssParameter>
   </Fill>
   <Stroke>
     <CssParameter name="stroke">#000000</CssParameter>
   </Stroke>                

while this is invalid:

.. code-block:: xml

   <Stroke>
     <CssParameter name="stroke">#000000</CssParameter>
   </Stroke>                
   <Fill>
     <CssParameter name="fill">#ff0000</CssParameter>
   </Fill>

YSLD, by contrast, does not require any of the directives to be ordered, so long as they are contained in the proper block.

For example, the following are both equally valid::

  fill-color: '#ff0000'
  stroke-color: '#000000'

and::

  stroke-color: '#000000'
  fill-color: '#ff0000'


Reusable code blocks inside files
---------------------------------

In SLD, if you have content that needs to be reused from rule to rule, you must manually generate the directives for each rule over and over. YSLD eliminates the need for redundant directives by introducing the ability to create :ref:`variables <cartography.ysld.reference.variables>` that can take the place of the same content.

For example, in SLD, multiple rules must share much of the same content:

.. code-block:: xml

     <Rule>
       <MinScaleDenominator>35000</MinScaleDenominator>
       <PointSymbolizer>
         <Graphic>
           <Mark>
             <WellKnownName>circle</WellKnownName>
             <Fill>
               <CssParameter name="fill">#FF0000</CssParameter>
             </Fill>
             <Stroke>
               <CssParameter name="stroke">#000000</CssParameter>
               <CssParameter name="stroke-width">2</CssParameter>
             </Stroke>
           </Mark>
           <Size>6</Size>
         </Graphic>
       </PointSymbolizer>
     </Rule>
     <Rule>
       <MaxScaleDenominator>35000</MaxScaleDenominator>
       <PointSymbolizer>
         <Graphic>
           <Mark>
             <WellKnownName>circle</WellKnownName>
             <Fill>
               <CssParameter name="fill">#FF0000</CssParameter>
             </Fill>
             <Stroke>
               <CssParameter name="stroke">#000000</CssParameter>
               <CssParameter name="stroke-width">3</CssParameter>
             </Stroke>
           </Mark>
           <Size>8</Size>
         </Graphic>
       </PointSymbolizer>
     </Rule>

In YSLD, all the directives that occur multiple times can be replaced with a variable:

::

  define: &variable
    shape: circle
    fill-color: '#ff0000'
    stroke-color: '#000000'

  rules:
  - scale (35000,)
    symbolizers:
    - point:
        size: 6
        symbols:
        - mark:
            >>: *variable
            stroke-width: 2
  - scale (,35000)
    symbolizers:
    - point:
        size: 8
        symbols:
        - mark:
            >>: *variable
            stroke-width: 3

.. warning:: VERIFY SYNTAX

Note the definition of ``variable`` at the top, and the variable substitution in the line ``>>: *variable``.

Compatible with SLD
-------------------

In addition to all of these advantage, YSLD maintains compatibility with existing SLD.

.. warning:: TALK ABOUT CONVERSION.
