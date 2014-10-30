.. _cartography.ysld.reference.functions:

Functions
=========

Functions are additional operations that can be employed when calculating values for YSLD parameters. In most cases, a value for a parameter can be the output (result) of a function.

Functions can be used in most places in a style document.

Syntax
------

Functions aren't a parameter to itself, but instead are used as a part of the values of a parameter, or indeed in any expression. So the syntax is very general, for example::

  <parameter>: <function>

Functions are evaluated at rendering time, so the output is passed as the parameter value and then rendered accordingly.

List of functions
-----------------

.. warning:: FULL LIST OF FUNCTIONS? WHICH ONES TO SPECIFY?

The full list of functions is very long, and can be found SOMEWHERE.

The functions can be broken up into categories

Math functions
~~~~~~~~~~~~~~

Category 2
~~~~~~~~~~

Theming functions
~~~~~~~~~~~~~~~~~

There are three important functions that are often easier to use for theming than using rules, and can vastly simplify your style documents:

**Recode**: Attribute values are directly mapped to styling properties::

  recode(attribute,value1,result1,value2,result2,value3,result3,...)

This is equivalent to creating multiple rules with similar filters::

  rules:
  - ...
    filter: [attribute] = value1
    - ...
      <property>: result1
  - ...
    filter: [attribute] = value2
    - ...
      <property>: result2
  - ...
    filter: [attribute] = value3
    - ...
      <property>: result3

**Categorize**: Categories are defined using minimum and maximum ranges, and attribute values are sorted into the appropriate category::

  categorize(attribute,value1,category1,value2,category2,value3,category3,...)

.. warning:: ARE CATEGORIES MIN OR MAX? INCLUSIVE OR EXCLUSIVE? ORDERED?

This would create a situation where the ``attribute`` value, if less than ``value1`` will be given the result of ``category1``; if between ``value1`` and ``value2``, will be given the result of ``category2``;  if between ``value2`` and ``value3``, will be given the result of ``category3``, etc.

This is equivalent to creating the following multiple rules::

  rules:
  - ...
    filter: [attribute] < value1
    - ...
      <property>: category1
  - ...
    filter: [attribute] >= value1 AND [attribute] < value2
    - ...
      <property>: category2
  - ...
    filter: [attribute] >= value2 AND [attribute] < value3
    - ...
      <property>: category3


**Interpolate**: Used to smoothly theme quantitative data by calculating a styling property based on an attribute value. This is similar to Categorize, except that the values are continuous and not discrete::

  interpolate(attribute,value1,entry1,value2,entry2,...)

.. warning:: ARE THESE VALUES MIN OR MAX? INCLUSIVE OR EXCLUSIVE? ORDERED?

This would create a situation where the ``attribute`` value, if equal to ``value1`` will be given the result of ``entry1``; if halfway between ``value1`` and ``value2`` will be given a result of halfway in between ``entry1`` and ``entry2``; if three-quarts between ``value1`` and ``value2`` will be given a result of three-quarters in between ``entry1`` and ``entry2``, etc.

There is no equivalent to this function in vector styling. The closest to this in raster styling is the color ramp.


Examples
--------

Rounding a value::

  round([attribute])

Math operations like square root are available::

  sqrt([attribute])

A list of fill values based on discrete attribute values (using Recode)::

  fill: recode(color,1,ff0000,2,00ff00,3,0000ff,4,000000)
  stroke: 808080

The above symbolizer contents will color features differently, dependent on the value of the attribute ``color``. If the value is ``1``, the ``fill`` will be ``ff0000``; if the value is ``2``, the ``fill`` will be ``00ff00``, and so forth. In all cases, though, the stroke will be ``808080``.

A list of fills based on attribute values (using Categorize)::

  fill: categorize(option,0,ff0000,10,00ff00,20,0000ff,100,000000)
  stroke: 808080

The abolve symbolizer content will color features differently, dependent on the value of the attribute ``option``. If the value is SOMETHING...

A gradient of fills based on attribute values (using Interpolate)::

  fill: interpolate(color,0,ff0000,30,00ff00,60,0000ff,255,000000)
  stroke: 808080

The abolve symbolizer content will color features differently, dependent on the value of the attribute ``option``. If the value is SOMETHING...

