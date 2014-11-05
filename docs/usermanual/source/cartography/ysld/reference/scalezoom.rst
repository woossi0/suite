.. _cartography.ysld.reference.scalezoom:

Scale and zoom
==============

It is common for different :ref:`rules <cartography.ysld.reference.rules>` to be applied at different zoom levels on a web map. 

For example, on a roads layer, you would not not want to display every single road when viewing the whole world. Or perhaps you may wish to styles the same features differently depending on the zoom level. For example: a cities layer styled using points at low zoom levels (when "zoomed out") and with polygon borders at higher zoom levels ("zoomed in").

.. todo:: ADD FIGURE

YSLD allows rules to be applied depending on the the scale or zoom level. You can specify by scale, or you can define zoom levels in terms of scales and specify by zoom level.

Scale syntax
------------

The syntax for using a scale conditional parameter in a rule is::

  rules:
  - ...
    scale: (<min>,<max>)
    ...

where:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 10 50 20

   * - Attribute
     - Required?
     - Description
     - Default value
   * - ``min``
     - No
     - The minimum scale (inclusive) for which the rule will be applied. Value is a number, either decimal or integer.
     - ``0``
   * - ``max``
     - No
     - The maximum scale (exclusive) for which the rule will be applied. Value is a number, either decimal or integer.
     - ``infinite``

.. note:: It is not possible to use an expression for any of these values.

Either the ``min`` and ``max`` values can omitted. For example::

  scale: (,<max>)

will make the rule apply for any zoom level that includes scales lower than the ``max`` scale. Also::

  scale: (<min>,)

will make the rule apply for any zoom level that includes scales higher than the ``min`` scale.

If the scale parameter is omitted entirely, then the rule will apply at all scales.

Scale examples
--------------

Three rules, all applicable at different scales::

  rule:
  - name: low_scale
    scale: (,100000)
    symbolizers:
    - line:
        stroke-width: 3
        stroke-color: 0165cd
  - name: medium_scale
    scale: (100000,200000)
    symbolizers:
    - line:
        stroke-width: 2
        stroke-color: 0165cd
  - name: high_scale
    scale: (200000,)
    symbolizers:
    - line:
        stroke-width: 1
        stroke-color: 0165cd

This example will display lines with:

* A stroke width of 3 at scales less than 100,000 (``low_scale``)
* A stroke width of 2 at scales between 100,000 and 200,000 (``medium_scale``)
* A stroke width of 1 at scales greater than 200,000 (``high_scale``)

Given the rules above, the following arbirtrary sample scales would map to the rules as follows:

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Rule
   * - ``50000``
     - ``low_scale``
   * - ``100000``
     - ``medium_scale``
   * - ``150000``
     - ``medium_scale``
   * - ``200000``
     - ``high_scale``
   * - ``300000``
     - ``high_scale``

Note the edge cases, since the ``min`` value is inclusive and the ``max`` value is exclusive.

Scientific notation for scales
------------------------------

To make comprehension easier and to lessen the chance of errors, scale values can be expressed in scientific notation.

So a scale of ``500000000``, which is equal to 5 × 10^8 (a 5 with eight zeros), can be replaced by ``5e8``.

Relationship between scale and zoom
-----------------------------------

When working with web maps, often it is more convenient to talk about zoom levels instead of scales. The relationship between zoom and scale is context dependent.

For example, for EPSG:4326 with world boundaries, zoom level 0 (completely zoomed out) corresponds to a scale of approximately 279,541,000 with each subsequent zoom level having half the scale value. For EPSG:3857 (Web Mercator) with world boundaries, zoom level 0 corresponds to a scale of approximately 559,082,000, again with each subsequent zoom level having half the scale value.

But since zoom levels are discrete (0, 1, 2, etc.) and scale levels are continuous, it's actually a range of scale levels that corresponds to a given zoom level.

For example, if you have a situation where a zoom level 0 corresponds to a scale of 1,000,000 (and each subsequent zoom level is half that scale, as is common), you can set the scale values of your rules to be:

* ``scale: (750000,1500000)`` (includes 1,000,000)
* ``scale: (340000,750000)`` (includes 500,000)
* ``scale: (160000,340000)`` (includes 250,000)
* ``scale: (80000,160000)`` (includes 125,000)
* etc.

Also be aware of the inverse relationship between scale and zoom; **as the zoom level increases, the scale decreases.**

When styling web maps, typically the choice of zoom levels (and therefore scales) are set in advance. Because of this, **it can be more useful to define style rules as being dependent on the zoom level instead of the scale level**.

With YSLD, there is a lot of flexibility in terms of specifying zoom levels. You can:

* Specify an initial scale, and have it calculate all subsequent scale levels.
* Specify a list of scales, and have each correspond to a list of zoom levels.
* Specify a name for a common gridset, and have all the scales and zoom levels be automatically defined.

When a collection of zoom levels is inferred from a list of scales, it is understood that the scale level is actually the "middle" of the scale range. 

Zoom syntax
-----------

In order to use zoom levels, they must be defined globally for the entire style, above any :ref:`cartography.ysld.reference.featurestyles` or :ref:`cartography.ysld.reference.rules`.

The full syntax for using a zoom level parameter in a style is::

  grid:
    initial-scale: <value>
    initial-level: <integer>
    ratio: <integer>
    scales:
    - <value>
    - <value>
    - ...
    name: <string>

where:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 10 50 20

   * - Property
     - Required?
     - Description
     - Default value
   * - ``initial-scale``
     - No
     - Specifies the scale to be used for a specific zoom level, which is by default zoom level 0. Cannot be used with ``scales`` or ``name``.
     - N/A
   * - ``initial-level``
     - No
     - Modifies the ``initial-scale`` value to apply to a different zoom level from 0.
     - ``0``
   * - ``ratio``
     - No
     - Specifies the multiplier value between scales in adjacent zoom levels. A value of ``2`` means that each increase in zoom level will indicate a change of scale by a factor of 1/2.
     - ``2``
   * - ``scales``
     - No
     - A list of ordered discrete scale values. Typically the first value is defined to be zoom level 0, unless ``initial-level`` is used. This is most often used for zoom levels that are not regular scale multiples of each other. Can't be used with ``initial-scale`` or ``name``.
     - N/A
   * - ``name``
     - No
     - A name of an existing commonly-used spatial reference system in GeoServer. Can also be a name of a GeoWebCache gridset. Options are ``EPSG:4326`` or ``EPSG:3857``, or any defined gridset name in GeoWebCache. If a duplicate name exists, the GeoWebCache gridset will take priority. Can't be used with ``initial-scale`` or ``scales``.
     - N/A

Inside a rule, the syntax for using these zoom levels is::

  rules:
  - ...
    zoom: (<min>, <max>)
    ...

where:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 10 50 20

   * - Attribute
     - Required?
     - Description
     - Default value
   * - ``min``
     - No
     - The minimum zoom level for which the rule will be applied. Value is an integer.
     - ``0``
   * - ``max``
     - No
     - The maximum zoom level for which the rule will be applied. Value is an integer.
     - ``infinite``

.. note:: It is not possible to use an expression for any of these values.

As with scales, either the ``min`` and ``max`` values can omitted. For example::

  zoom: (,<max>)

will make the rule apply for any zoom level less than or equal to the ``max`` zoom level. Also::

  zoom: (<min>,)

will make the rule apply for any zoom level greater than or equal to the ``min`` zoom level.

The ``scale`` and ``zoom`` parameters should not be used together in a rule (but if used, the ``scale`` takes priority over ``zoom``).

Zoom examples
-------------

Initial scale
~~~~~~~~~~~~~

Defining zoom levels based on an initial scale::

  grid:
    initial-scale: 6000000

.. note::

   Using scientific notation::

     grid:
       initial-scale: 6e6

would define zoom levels as follows:

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Zoom level
   * - ``6000000``
     - ``0``
   * - ``3000000``
     - ``1``
   * - ``1500000``
     - ``2``
   * - ``750000``
     - ``3``
   * - ``<previous_scale> / 2``
     - ``<previous_zoom> + 1``

One could define the following three rules::

  rules:
  - name: low_zoom
    zoom: (0,2)
    symbolizers:
    - line:
        stroke-width: 1
        stroke-color: 0165cd       
  - name: medium_zoom
    zoom: (3,5)
    symbolizers:
    - line:
        stroke-width: 2
        stroke-color: 0165cd       
  - name: high_zoom
    zoom: (6,)
    symbolizers:
    - line:
        stroke-width: 3
        stroke-color: 0165cd       

This example will display lines with:

* A stroke width of 1 at zoom levels 0-2 (``low_zoom``)
* A stroke width of 2 at zoom levels 3-5 (``medium_zoom``)
* A stroke width of 3 at zoom levels 6 and greater (``high_zoom``)

Adding the ``initial-level`` parameter would change the definitions of the zoom levels::

  grid:
    initial-scale: 6000000
    initial-level: 2

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Zoom level
   * - ``24000000``
     - ``0``
   * - ``12000000``
     - ``1``
   * - ``6000000``
     - ``2``
   * - ``3000000``
     - ``3``
   * - ``<previous_scale> / 2``
     - ``<previous_zoom> + 1``

Setting the ratio would adjust the multiplier between scales in adjacent zoom levels::

  grid:
    initial-scale: 6000000
    ratio: 4

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Zoom level
   * - ``6000000``
     - ``0``
   * - ``1500000``
     - ``1``
   * - ``375000``
     - ``2``
   * - ``93750``
     - ``3``
   * - ``<previous_scale> / 4``
     - ``<previous_zoom> + 1``

List of scales
~~~~~~~~~~~~~~

Defining zoom levels based on a list of scales::

  grid:
    scales:
    - 1000000
    - 500000
    - 100000
    - 50000
    - 10000

.. note::

   Using scientific notation::

     grid:
       scales:
       - 1e6
       - 5e5
       - 1e5
       - 5e4
       - 1e4

would define the list of zoom levels explicitly and completely:

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Zoom level
   * - ``1000000``
     - ``0``
   * - ``500000``
     - ``1``
   * - ``100000``
     - ``2``
   * - ``50000``
     - ``3``
   * - ``10000``
     - ``4``

Named gridset
~~~~~~~~~~~~~

Given the existing named gridset of ``EPSG:3857``::

  name: EPSG:3857

This defines zoom levels as the following (rounded to the nearest whole number below):

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Zoom level
   * - ``559082264``
     - ``0``
   * - ``279541132``
     - ``1``
   * - ``139770566``
     - ``2``
   * - ``69885283``
     - ``3``
   * - ``34942641``
     - ``4``
   * - ``17471321``
     - ``5``
   * - ``8735660``
     - ``6``
   * - ``4367830``
     - ``7``
   * - ``2183915``
     - ``8``
   * - ``<previous_scale> / 2``
     - ``<previous_zoom> + 1``

For the existing name gridset of ``EPSG:4326``::

  name: EPSG:4326

This defines zoom levels as the following (below rounded to the nearest whole number):

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Scale
     - Zoom level
   * - ``279541132``
     - ``0``
   * - ``139770566``
     - ``1``
   * - ``69885283``
     - ``2``
   * - ``34942641``
     - ``3``
   * - ``17471321``
     - ``4``
   * - ``8735660``
     - ``5``
   * - ``4367830``
     - ``6``
   * - ``2183915``
     - ``7``
   * - ``1091958``
     - ``8``
   * - ``<previous_scale> / 2``
     - ``<previous_zoom> + 1``
