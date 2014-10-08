.. _cartography.ysld.reference.rules:

Rules
=====

A rule is a **collection of styling directives**, primarily consisting of :ref:`symbolizers <cartography.ysld.reference.symbolizers>` combined with optional conditional statements.

* **If a conditional statement exists** in a rule, then the styling directives will only be carried out **if the conditional returns true**. Otherwise, the rule will be skipped.
* **If no conditional statement exists** in a rule, then the styling directive will **always be carried out**.

.. warning:: FIGURE NEEDED

The types of conditional statements available to rules are:

* :ref:`Filters <cartography.ysld.reference.filters>` for attribute-based rendering
* :ref:`Scale <cartography.ysld.reference.scale>` for scale-based rendering

Rules are contained within :ref:`feature styles <cartography.ysld.reference.featurestyles>`. There is no limit on the number of rules that can be created, and there is no restriction that all rules must be mutually exclusive (as in, some rules may apply to the same features).

Syntax
------

The following is the basic syntax of a rule. Note that the contents of the block are not all expanded; see the other sections for the relevant syntax.

::

     rules:
     - name: <text>
       title: <text>
       filter: <filter>
       else: <boolean>
       scale: (<min>,<max>)
       symbolizers:
       - <symbolizer>
           ...
       - <symbolizer>
           ...

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
   * - ``name``
     - No
     - Internal reference to the rule. It is recommended that the value be lower case and contain no spaces.
     - Blank
   * - ``title``
     - No
     - Human-readable description of what the rule accomplishes.
     - Blank
   * - ``filter``
     - No
     - :ref:`Filter <cartography.ysld.reference.filters>` expression which will need to evaluate to be true for the symbolizer(s) to be applied. Cannot be used with ``else``.
     - Blank (will apply to all features)
   * - ``else``
     - No
     - Specifies whether the rule will be an "else" rule. An else rule applies when, due to filters, no other rule applies. Options are ``true`` or ``false`` and must be lowercase. Cannot be used with ``filter``.
     - ``false``
   * - ``scale``
     - No
     - :ref:`Scale <cartography.ysld.reference.scale>` boundaries showing at what scales (related to zoom levels) the rule will be applied.
     - Visible at all scales
   * - ``symbolizers``
     - Yes
     - Block containing one or more :ref:`symbolizers <cartography.ysld.reference.symbolizers>`. These contain the actual visualization directives. If the filter returns true and the view is with the scale boundaries, these symbolizers will be applied.
     - N/A

.. warning:: NEED CLARIFICATION ON HOW SCALE WORKS WITH ELSE.

Examples
--------

Using ``filter`` and ``else`` together::

  rules:
  - name: small
    title: Small features
    filter: [type] = 'small'
    symbolizers:
    - ...
  - name: large
    title: Large features
    filter: [type] = 'large'
    symbolizers:
    - ...
  - name: else
    title: All other features
    else: true
    symbolizers:
    - ...

.. warning:: NEED MORE EXAMPLES
