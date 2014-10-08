.. _cartography.ysld.reference.scale:

Scale
=====

It is common for different style :ref:`rules <cartography.ysld.reference.scale>` to be applied at different zoom levels on a web map. 

For example, on a roads layer, you would not not want to display every single road when viewing the whole world. Or perhaps, you may wish to styles the same features differently depending on the zoom level; for example: a cities layer styled using points at low zoom levels (when "zoomed out") and with city borders at higher zoom levels ("zoomed in").

YSLD includes a directive that allows rules to be applied depending on the scale.

Syntax
------

The syntax for using a scale conditional parameter in a rule is::

  rule:
    ...
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
     - The minimum scale for which the rule will be applied. Value is a number.
     - ``0``
   * - ``max``
     - No
     - The minimum scale for which the rule will be applied. Value is a number.
     - ``infinite``

.. note:: It is not possible to use an expression for the scale min and max values. Values must be explicit numbers.

Either the ``min`` and ``max`` values can omitted. For example::

  scale: (,max)

will make the rule apply for any zoom level that includes scales lower than the ``max`` scale (so including a certain zoom level and all higher zoom levels). Also::

  scale: (min,)

will make the rule apply for any zoom level that includes scales higher than the ``min`` scale (so from zoom level 0 to a certain zoom level).

If the scale parameter is omitted entirely, then the rule will apply at all zoom levels.


Scale vs. zoom
--------------

Web maps often use zoom levels to talk about display, and yet also talk about scale. The relationship between zoom and scale is wholly dependent on the coordinate reference system used (and the relationship between each zoom level).

For example, for EPSG:4326 with world boundaries, zoom level 0 (completely zoomed out) corresponds to a scale of 279,541,132, with each subsequent zoom level halving the scale value. For EPSG:3785 (Web Mercator), zoom level 0 corresponds to a scale of 559,082,264, again with each subsequent zoom level halving the scale value.

.. note:: Those scale values differ by a clean factor of 2, because EPSG:3785 fits the whole world into a half as much width as EPSG:4326.

It is difficult to calculate these values in advance. The best way to determine scale values for your layer based on zoom level is by viewing the OpenLayers Layer Preview for your layer. For each zoom level, you can retrieve the computed scale values, and then when making rules, ensure that that scale value is contained in the ``scale:`` value.

For example, if a particular zoom level corresponds to a scale of 100,000 (and each subsequent zoom level is half that scale), then you can set the scale values of your rules to be:

* ``scale: (75000,150000)`` (includes 100,000)
* ``scale: (34000,75000)`` (includes 50,000)
* ``scale: (16000,34000)`` (includes 25,000)
* ``scale: (8000,16000)`` (includes 12,500)
* etc.

Also be aware that there is an inverse relationship between scale and zoom; **as the zoom level increases, the scale decreases.**

