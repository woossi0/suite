.. _cartography.ysld.reference.filters:

Filters
=======

Filters are predicates that allow rules to be applied selectively.

A filter can take a great many different forms.

.. note:: A scale is a type of filter, but is :ref:`discussed separately <cartography.ysld.reference.scale>`.

.. note:: For more information, please see the `GeoTools CQL documentation <http://docs.geotools.org/stable/userguide/library/cql/ecql.html>`_ and `GeoServer CQL tutorial <../../../geoserver/tutorials/cql/cql_tutorial.html>`_.

.. warning:: TEST INTERNAL LINK

.. warning:: WHAT ABOUT ELSE?

Syntax
------

The basic syntax of a filter is::

  rules:
    ...
    filter: <expression>
    ...

where ``<expression>`` is any valid CQL/ECQL filter.

.. note:: Be aware that filters are applied to :ref:`rules <cartography.ysld.reference.rules>` and so appear inside them, but outside of any :ref:`symbolizers <cartography.ysld.reference.symbolizers>`.

Types of filters
----------------

As mentioned above, the filter can be any valid construction made with CQL/ECQL (Extended/Contextual Query Language).

CQL is written using a familiar text-based syntax with strong similarities to SQL statements. One can think of a CQL expression as the "WHERE" clause of a SQL statment.

The following are all standard filter constructions:


Object comparison
^^^^^^^^^^^^^^^^^

This filter will test to see if a comparison to an attribute is true. It has the following form::

  [<object>] <operator> <value>

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
   * - ``<object>``
     - Yes
     - That to which something is going to be compared. Typically an attribute (``[name]``). Must be encased in brackets.
     - N/A
   * - ``<operator>``
     - Yes
     - Method of comparison. Valid operators are ``=``, ``<``, ``>``, ``<=``, ``>=``, ``LIKE``, ``ILIKE``, ``BETWEEN``, ``IS NULL``, ``IN``, ``EXISTS``, ``NOT``, OTHERS?
     - N/A
   * - ``<value>``
     - Yes
     - That which the ``<object>`` is being compared to. Must be a static value such as a string or scalar, though it can also be an expression that evaluates to a static value. Cannot be another attribute. Can include mathematical operators such as ``+``, ``-``, ``*``, ``/``.
     - N/A

The following is a desription of all available operators:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 80

   * - Operator
     - Description
   * - ``=``
     - Equals (TEXT OR VALUE?)
   * - ``<``
     - Less than (non-inclusive)
   * - ``>``
     - Greater than (non-inclusive)
   * - ``<=``
     - Less than or equal to (inclusive)
   * - ``>=``
     - Greater than or equal to (inclusive)
   * - ``LIKE``
     - Fuzzy matching. Add SOME CHARACTER to permit wildcards (DETAILS) %
   * - ``ILIKE``
     - Case-insensitive version of ``LIKE``
   * - ``BETWEEN``
     - Allows for a true case to be when a given object has a value that is between two given values
   * - ``IS NULL``
     - For testing against a ``NULL`` (not zero) value. (DIFFERENCE?) 
   * - ``IN``
     - Used when specifying a list. Object must be contained in the list for the statement to be true.
   * - ``EXISTS``
     - ???
   * - ANYTHING ELSE?
     - ???

.. warning:: BETTER WORD THAN OBJECT?


Spatial filters
^^^^^^^^^^^^^^^

Filters can be spatial as well. Any valid spatial construction in WKT (Well Known Text) can be used. Common spatial filters include ``INTERSECTS``, ``DISJOINT``, ``CONTAINS``, ``WITHIN``, ``TOUCHES``, ``CROSSES``, ``EQUALS``, ``DWITHIN``, and ``BBOX``. For more details about these spatial filters and their syntax, please see the `ECQL reference <../../../geoserver/filter/ecql_reference.html>`_

.. warning:: FULL LIST OF SPATIAL OPERATORS?



Compound statements
^^^^^^^^^^^^^^^^^^^

The filter can be a combination of statements. This is especially common when testing if the value of an attribute is greater than one value but less than another.

The syntax for creating compound statements is to use standard Boolean notation use as ``AND``, ``OR``, along with relevant parentheses.

For example, a filter where both statements need to be true would be::

  filter: <statement1> AND <statement2>

A filter where either statement would need to be true would be::

  filter: <statement1> OR <statement2>

Larger filters can be built up in this way::

  filter: (<statement1> OR <statement2>) AND <statement3>

In these examples, every ``<statement>`` is a valid filter.


.. warning:: WHICH TAKES PRECEDENCE, AND OR OR?   HAPPENS LEFT TO RIGHT



.. warning:: http://udig.github.io/docs/user/concepts/Constraint%20Query%20Language.html

