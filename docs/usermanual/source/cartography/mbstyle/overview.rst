.. _cartography.mbstyle.overview:

MBStyle Overview
================

.. _cartography.mbstyle.quickstart:

Syntax
------

MBStyle is based on the `MapBox Style Specification <https://www.mapbox.com/mapbox-gl-js/style-spec/>`__.

The language is based on `JSON <http://json.org/>`__. A MBStyle is a JSON object which consists of global properties, sources (which define the data to be styled), and layers (which define the styling to apply).

For example::

    {
        "version": 8,
        "name": "countries",
        "sources": {
            "cite_countries": {
                "type": "vector",
                "tiles": [
                  "http://localhost:8080/geoserver/gwc/service/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&LAYER=cite:countries&STYLE=&TILEMATRIX=EPSG:900913:{z}&TILEMATRIXSET=EPSG:900913&FORMAT=application/vnd.mapbox-vector-tile&TILECOL={x}&TILEROW={y}"
                ],
                "minZoom": 0,
                "maxZoom": 14
            }
        },
        "layers": [
            {
                "id": "countries-fill",
                "source": "cite_countries",
                "source-layer": "countries",
                "type": "fill",
                "paint": {
                    "fill-color": "#FFC3C3",
                    "fill-outline-color": "#777777",
                    "fill-opacity": 0.5
                }
            },
            {
                "id": "label",
                "source": "cite_countries",
                "source-layer": "countries",
                "type": "symbol",
                "layout": {
                   "text-field": ["get", "NAME"]
                }

            }
        ]
    }

At the top of the style there are two global properties:

* ``version`` - the version of the MapBox Style Specification this style conforms to.
* ``name`` - the name of the style.

Following this, there is a map of named ``sources``. Each source defines the data to be styled. The ``sources`` section is only used by client-side applications and is ignored by GeoServer when rendering layers server-side. Instead, GeoServer uses the layer you have associated the style with (or the layer name in ``source-layer``, if you are using `style groups <../../geoserver/styling/sld/working.html#style-layer-descriptor-styles>`__). In this example, we have a single vector tile source named ``cite_countries``.

Finally, there is the list of ``layers``. This defines what styling to apply to the data. Each layer only applies to a single ``source-layer`` from a single ``source``. In this example, ``countries`` is the only ``source-layer`` in the source, but if your source is a layer group it could contain multiple ``source-layers``).

Each layer also has a ``type``. This defines what kind of styling it applies. In the example, we have a ``fill`` layer, providing a fill and an outline, and a ``symbol`` layer, providing a label. Other types of layers include ``line``, ``circle``, and ``raster``.

For full details on all options, refer to the `MapBox Style Specification <https://www.mapbox.com/mapbox-gl-js/style-spec/>`__. Also reference the `geoserver fork <../../geoserver/styling/mbstyle/reference/spec.html#expressions>`__ of the specification, which is not updated as regularily, but includes details on exactly what features are supported by GeoServer.

For more examples, and a walkthrough of how to make your own MBStyles, refer to the :ref:`MBStyle tutorial <cartography.mbstyle.tutorial>`.

Client-side styling
-------------------

The MBStyle language was designed primarily as a client side styling language for use with vector data such as vector tiles.

GeoServer supports MBStyle styles so that you can use the same styling language both server-side and client-side. Styles saved in GeoServer can be accessed from ``http://localhost:8080/geoserver/styles`` endpoint for use with client-side applications.

For an example of how to use a MBStyle created in GeoServer with a client-side application, see the :ref:`final section of the MBStyle Tutorial <cartography.mbstyle.tutorial.map.client>`.

Raster support
--------------

Because MBStyle is designed primarly for client-side vector styling, it has very limited raster styling capabilities. If you need to do significant raster styling, you should use :ref:`YSLD <cartography.ysld>` (or SLD) instead.

.. _cartography.mbstyle.expressions:

Expressions
-----------

In the Mapbox Style Specification, the value for any layout property, paint property, or filter may be specified as an expression. Expressions define how one or more feature property value and/or the current zoom level are combined using logical, mathematical, string, or color operations to produce the appropriate style property value or filter decision.

.. note:: Not all expressions are supported in Boundless Server.

   *"rgba", "to-rgba", "properties", "heatmap-density", "interpolate", "let", "var"* are currently unsupported or under development.

Usage
~~~~~

This section gives a quick overview of expression syntax and a working example, to see a full list of expressions and their uses refer to `MapBox Style Specification <https://www.mapbox.com/mapbox-gl-js/style-spec/>`__.

MBStyle expressions uses a Lisp-like syntax, represented using JSON arrays. Expressions follow this format::

   [expression_name, argument_0, argument_1, ...]

The expression_name is the expression operator. For example, you would use `*` to multiply two arguments or 'case' to create conditional logic. For a complete list of all available expressions see the Mapbox Style Specification.

The arguments are either literal (numbers, strings, or boolean values) or else themselves expressions. The number of arguments varies based on the expression.

Here’s one example using an expression to perform a basic arithmetic expression (π * 3\ :sup:`2`\ )::

   ['*', ['pi'], ['^', 3, 2]]

This example is using a ``'*'`` expression to multiply two arguments. The first argument is ``'pi'``, which is an expression that returns the mathematical constant π. The second arguement is another expression: a ``'^'`` expression with two arguments of its own. It will return 3\ :sup:`2`\ , and the result will be multiplied by π.
