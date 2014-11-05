.. _cartography.ysld.reference.filters:

Filters
=======

Filters are predicates that allow rules to be applied selectively.

A filter can take a great many different forms.

.. note:: A scale is a type of filter, but is :ref:`discussed separately <cartography.ysld.reference.scalezoom>`.

.. note:: For more information, please see the `GeoTools CQL documentation <http://docs.geotools.org/stable/userguide/library/cql/ecql.html>`_ and `GeoServer CQL tutorial <../../../geoserver/tutorials/cql/cql_tutorial.html>`_.

Syntax
------

The basic syntax of a filter is::

  rules:
    ...
    filter: ${<expression>}
    ...

where ``<expression>`` is any valid CQL/ECQL filter.

.. note:: Be aware that filters are applied to :ref:`rules <cartography.ysld.reference.rules>` and so appear inside them, but outside of any :ref:`symbolizers <cartography.ysld.reference.symbolizers>`.

Types of filters
----------------

As mentioned above, the filter can be any valid construction made with CQL/ECQL (Extended/Contextual Query Language).

CQL is written using a familiar text-based syntax with strong similarities to SQL statements. One can think of a CQL expression as the "WHERE" clause of a SQL statment.

The following are all standard filter constructions:

Object comparison
~~~~~~~~~~~~~~~~~

This filter will test to see if a comparison to an attribute is true. It has the following form::

  ${<attribute> <operator> <value>}

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
   * - ``<attribute>``
     - Yes
     - That to which something is going to be compared.
     - N/A
   * - ``<operator>``
     - Yes
     - Method of comparison. Valid operators are ``=``, ``<``, ``>``, ``<=``, ``>=``, ``LIKE``, ``ILIKE``, ``BETWEEN``, ``IS NULL``, and ``IN``. ``NOT`` can be added to invert the comparison.
     - N/A
   * - ``<value>``
     - Yes
     - That which the ``<attribute>`` is being compared to. Must be a static value such as a string or scalar, though it can also be an expression that evaluates to a static value. Cannot be another attribute. Can include mathematical operators such as ``+``, ``-``, ``*``, ``/``.
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
     - Equals
   * - ``<``
     - Less than (non-inclusive)
   * - ``>``
     - Greater than (non-inclusive)
   * - ``<=``
     - Less than or equal to (inclusive)
   * - ``>=``
     - Greater than or equal to (inclusive)
   * - ``LIKE``
     - Fuzzy matching for strings and other non-numeric attributes. Add ``%`` for multi-character wildcards, and ``_`` for single-character wilcards. 
   * - ``ILIKE``
     - Case-insensitive version of ``LIKE``
   * - ``BETWEEN``
     - Tests if a value that is between two given values.
   * - ``IS NULL``
     - For testing against a ``NULL`` value.
   * - ``IN``
     - Used when specifying a list. Must be contained in the list for the statement to be true.

Spatial filters
~~~~~~~~~~~~~~~

Filters can be spatial in nature. Any valid spatial construction in `WKT (Well Known Text) <http://en.wikipedia.org/wiki/Well-known_text>`_ can be used. Spatial filters include ``INTERSECTS``, ``DISJOINT``, ``CONTAINS``, ``WITHIN``, ``TOUCHES``, ``CROSSES``, ``EQUALS``, ``DWITHIN``, and ``BBOX``. For more details about these spatial filters and their syntax, please see the `GeoServer ECQL reference <../../../geoserver/filter/ecql_reference.html>`_ or `uDig CQL reference <http://udig.github.io/docs/user/concepts/Constraint%20Query%20Language.html>`_.

Compound statements
~~~~~~~~~~~~~~~~~~~

The filter can be a combination of statements. A common case is testing if the value of an attribute is greater than one value but less than another.

The syntax for creating compound statements is to use standard Boolean notation use as ``AND``, ``OR``, along with relevant parentheses.

For example, a filter where both statements need to be true would be::

  filter: ${<statement1> AND <statement2>}

A filter where either statement would need to be true would be::

  filter: ${<statement1> OR <statement2>}

Larger filters can be built up in this way::

  filter: ${(<statement1> OR <statement2>) AND <statement3> OR <statement4>}

In these examples, every ``statement`` is a valid filter.

In terms of precendence, ``AND`` conjunctions take precendence over ``OR`` conjunctions unless modified by parentheses. So, in the last example above, ``(<statement1> OR <statement2>)`` will be evaluated first, followed by the result of that ``AND <statement3>``, and finally the result of that ``OR <statement4>``

.. todo:: ADD EXAMPLES
