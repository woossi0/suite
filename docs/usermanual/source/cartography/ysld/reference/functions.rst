.. _cartography.ysld.reference.functions:

Functions
=========

Functions are additional operations that can be employed when calculating values for YSLD parameters. In most cases, a value for a parameter can be the output (result) of a function.

Syntax
------

Functions aren't a parameter to itself, but instead are used as a part of the values of a parameter, or indeed in any expression. So the syntax is very general, for example::

  <parameter>: <function>

Functions are evaluated at rendering time, so the output is passed as the parameter value and then rendered accordingly.

List of functions
-----------------

.. warning:: FULL LIST OF FUNCTIONS? WHICH ONES TO SPECIFY?

The full list of functions is very long, and can be found SOMEWHERE.

Examples
--------

Rounding a value::

  round([attribute])

Math operations like square root are available::

  sqrt([attribute])








.. warning:: INTERPOLATE, CATEGORIZE, RECODE

.. warning:: Function can be in lots of different places