.. _cartography.ysld.reference.featurestyles:

Feature Styles
==============

In YSLD, A Feature Style is a block of styling :ref:`Rules <cartography.ysld.reference.rules>`.

.. todo:: FIGURE NEEDED

**The purpose of a Feature Style is to specify drawing order.** The first Feature Style will always have its rules applied first, while the second Feature Style will be processed after that, etc.

A Feature Style is a **top-level element** in a YSLD style.

Consider the following style heirarchy:

* Feature Style 1

  * Rule 1a
  * Rule 1b

* Feature Style 2

  * Rule 2a
  * Rule 2b
  * Rule 2c

In this case, the rules contained inside Feature Style 1 will be processed and their :ref:`symbolizers <cartography.ysld.reference.symbolizers>` drawn first. After Rule 1a and 1b are processed, the renderer will move on to Feature Style 2, where Rule 2a, 2b, and 2c will then be processed and their symbolizers drawn.

Drawing order
-------------

The order of feature styles is significant, and also the order of rules inside feature styles is significant.

Rules inside a feature style are all applied to each feature at once. After all of the rules in a feature style have been applied to each feature, the next feature style will start again, applying rules to each feature.

In this way, **using multiple feature styles is a way of specifying z-order**. The style from each feature style is also sometimes known as an additional style layer or "inner style layer".

Consider the same style heirarchy as above. Given a layer that contains three features, the rules will be applied in the following order:

#. Rule 1a is applied to the first feature, followed by rule 1b
#. Rule 1a is applied to the second feature, followed by rule 1b
#. Rule 1a is applied to the third feature, followed by rule 1b
#. Rule 2a is applied to the first feature, followed by rule 2b and then rule 2c
#. Rule 2a is applied to the second feature, followed by rule 2b and then rule 2c
#. Rule 2a is applied to the third feature, followed by rule 2b and then rule 2c

**If you need a rule to apply on top of other rules, use a second feature style.** A useful case for this is for lines representing bridges or overpasses. In order to ensure that the bridge lines always display on "top" of other lines (which in a display that includes, they would need to be applied using a second feature style.

.. todo:: FIGURES DEFINITELY NEEDED HERE 

Syntax
------

The following is the basic syntax of a feature style. Note that the contents of the block are not all expanded here.

::

   feature-styles:
   - name: <text>
     title: <text>
     abstract: <text>
     transform:
       ...
     rules:
     - ...

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
     - Internal reference to the feature style. It is recommended that the value be **lower case** and contain **no spaces**.
     - Blank
   * - ``title``
     - No
     - Human-readable name of the feature style. Exposed as a name for the group of rules contained in the feature style.
     - Blank
   * - ``abstract``
     - No
     - Longer description of the Feature Style.
     - Blank
   * - ``transform``
     - No
     - :ref:`Rendering transformation <cartography.ysld.reference.transforms>` information.
     - N/A
   * - ``rules``
     - Yes
     - List of styling :ref:`rules <cartography.ysld.reference.rules>`.
     - N/A

Short syntax
------------

When a style has a single feature style, it is possible to omit the syntax for the feature style and start at the first parameter inside.

So the following two complete styles are equivalent::

  feature-styles:
  - rules:
    - name: rule1
      scale: (,50000)
      symbolizers:
      - line:
          stroke-color: 000000
          stroke-width: 2
    - name: rule2
      scale: (50000,)
      symbolizers:
      - line:
          stroke-color: 000000
          stroke-width: 1

::

  rules:
  - name: rule1
    scale: (,50000)
    symbolizers:
    - line:
        stroke-color: 000000
        stroke-width: 2
  - name: rule2
    scale: (50000,)
    symbolizers:
    - line:
        stroke-color: 000000
        stroke-width: 1

Examples
--------

Road casing
~~~~~~~~~~~

This example shows how a smaller line can be drawn on top of a larger line, creating the effect of lines being drawn with a "border"::

  feature-styles:
  - name: outer
    title: Outer line
    rules:
    - name: outer_rule
      symbolizers:
      - line:
          stroke-color: 808080
          stroke-width: 8
  - name: inner
    title: Inner line
    rules:
    - name: inner_rule
      symbolizers:
      - line:
          stroke-color: 44ff88
          stroke-width: 6

In order to draw the inner lines always on top of the outer lines, the rule in encased in its own feature style. When drawn, the outer line has a width of 8 pixels and the inner line has a width of 6 pixels, so the line "border" is 1 pixel (on each side).

.. figure:: img/fs_roadcasing.png

   Example showing road casing
