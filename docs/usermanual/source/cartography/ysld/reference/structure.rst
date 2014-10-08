.. _cartography.ysld.reference.structure:

Structure
=========

Here is a simple example of a YSLD style containing a single rule inside a single feature style::

   name: style_example
   title: An example of YSLD styling
   abstract: Used in the User Manual of OpenGeo Suite
   feature-styles:
   - rules:
     - name: all
       title: Every feature will be styled this way
       symbolizers:
       - polygon:
           fill-color: 808080
           fill-opacity: 0.5
           stroke-color: 000000
           stroke-opacity: 0.75

This would style every polygon feature in a given layer with the given RGB color codes (a medium gray for a fill and black for the outline), with the given opacities for both fill and stroke being given in decimals indicating percentage (so 0.5 is 50% opaque).

.. note:: For more details on syntax, please see the section on :ref:`symbolizers <cartography.ysld.reference.symbolizers>`.

The structure of a typical YSLD file is as follows:

* Variable definitions (if any)
* Header (name, title, etc.)
* Feature style(s)

Regarding feature styles and their content:

* A :ref:`feature style <cartography.ysld.reference.featurestyles>` is a block that can contain one or many rules.
* A :ref:`rule <cartography.ysld.reference.rules>` is a directive that can contain one or many :ref:`symbolizers <cartography.ysld.reference.symbolizers>`.
* A rule applies to all features unless made to be selective by the use of a :ref:`filter <cartography.ysld.reference.filters>`.

**The basic unit of a style is the symbolizer.** This contains the actual visualization for individual features.

.. warning:: FIGURE NEEDED


Property syntax
---------------

Individual statements (or directives) in a YSLD styling document are designed as key-value, or property-value pairs of the following form::

   <property>: <value>

The ``<property>`` is a string denoting the property name, while the ``<value>`` can be one of a number of different types depending on context. These different types require slightly different markup, as shown in the following table:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 10 20 20 50

   * - Type
     - Syntax
     - Example
     - Notes
   * - Integer
     - Value only
     - ``12``
     - Quotes allowed as well
   * - Float
     - Value only
     - ``0.75``
     - Quotes allowed as well
   * - Text
     - Quotes
     - ``'Title'``
     - Spaces, colons, and other special characters are allowed
   * - Color
     - Six-digits (hex) / rgb(r,g,b) (Decimal)
     - ``808080`` / ``rgb(255,0,255)``
     - Used when specifying RGB colors. For hex: ``rrggbb`` or ``'#rrggbb'`` is allowed. For decimal: ``rgb(rrr,ggg,bbb)`` with each ordinate having a value from 0 to 255.
   * - Tuple
     - Parentheses
     - ``(0,15000)``
     - Entries in the the tuple may be left blank to mean unbounded (such as ``(,15000)``)
   * - :ref:`Filter <cartography.ysld.reference.filters>`
     - Brackets for attribute, quotes for attribute value
     - ``[type] = 'road'``
     - Single or double quotes allowed

.. note::

   Regarding the use of quotation marks:

   Quotes are only required when the first character of the value is ambiguous. For example, when the first character of the value is a ``#``, quotes are required, as it could signify an RGB color value or be a string.

   When quotes are used, either single or double quotes are allowed.

Expressions
-----------

Throughout the reference guide, there are references to values that are denoted by ``<expression>``. An **expression** is a flexible term meaning that the value can be one of the following kinds of objects:

* Literal (scalar or string)
* Attribute (usually denoted by ``[attribute]``)
* :ref:`Function <cartography.ysld.reference.functions>`

If using a function, it must evaluate to match the type expected by the property.

Mappings and lists
------------------

.. note:: The following discussion is taken from basic YAML syntax. Please refer to the `YAML specification <http://yaml.org/spec/1.2/spec.html>`_ if necessary.

There are three types of objects in a YSLD document:

#. **Scalar**, a simple value
#. **Mapping**, a collection of key-value (property-value) pairs
#. **List**, any collection of objects. A list can contain mappings, scalars, and even other lists.

**Lists require dashes for every entry, while mappings do not**.

For example, a :ref:`symbolizer <cartography.ysld.reference.symbolizers>` block is a list, so every entry requires its own dash::

  - symbolizer:
    - polygon:
        ...
    - text:
        ...

The ``point:`` and ``text:`` objects (the individual symbolizers themselves) are mappings, and as such, the contents do not require dashes, only indents::

  - polygon:
      stroke-color: 808080
      fill-color: ff0000

The dash next to ``polygon`` means that the item itself is contained in a list, not that it contains a list. And **the placement of the dash is at the same level of indentation as the list title.**

It is sometimes not obvious whether an object should be a list (and use dashes) or a mapping (and not use dashes), so please refer to this table if unsure:

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Object
     - Type
   * - :ref:`Feature style <cartography.ysld.reference.featurestyles>`
     - List
   * - :ref:`Rule <cartography.ysld.reference.rules>`
     - List
   * - :ref:`Symbolizer <cartography.ysld.reference.symbolizers>` block
     - List
   * - Individual symbolizers (contents)
     - Mapping
   * - :ref:`Transform <cartography.ysld.reference.transforms>`
     - Mapping
   * - Color table (for raster symbolizers)
     - List

Indentation
-----------

Indentation is very important in YSLD. All directives must be indented to its proper place to ensure proper hierarchy. **Improper indentation will cause a styled to be rendered incorrectly, or not at all.**

For example, the polygon symbolizer, since it is a mapping, contains certain parameters inside it, such as the color of the fill and stroke. These must be indented such that they are "inside" the polygon block.

In this example, the following markup is **correct**::

       - polygon:
           fill-color: 808080
           fill-opacity: 0.5
           stroke-color: 000000
           stroke-opacity: 0.75

The parameters inside the polygon (symbolizer) are indented, meaning that they are referencing the symbolizer and are not "outside it."

Compare to the following **incorrect** markup::

       - polygon:
         fill-color: 808080
         fill-opacity: 0.5
         stroke-color: 000000
         stroke-opacity: 0.75

The parameters that are relevant to the polygon block here need to be contained inside that block. Without the parameters being indented, they are at the same "level" as the polygon block, and so will not be interpreted correctly.

.. note:: For more details on symbolizer syntax, please see the section on :ref:`symbolizers <cartography.ysld.reference.symbolizers>`.

Comments
--------

Comments are allowed in YSLD, both for descriptive reasons and to remove certain styling directives without deleting them outright. Comments are indicated by a ``#`` as the first non-whitespace character in a line. For example::

  # This is a line symbolizer
  - line:
      stroke-color: #000000
      stroke-width: 2
      #stroke-width: 3

The above would display the lines with width of ``2``; the line showing a width of ``3`` is commented out.

Comment blocks do not exist, so each line of a comment will need to be indicated as such::

  - line:
      stroke-color: #000000
      stroke-width: 2
  #- line:
  #    stroke-color: #ff0000
  #    stroke-width: 3


Single object syntax
--------------------

.. warning:: MENTION SINGLE-ELEMENT SHORT SYNTAX

