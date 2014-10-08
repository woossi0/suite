.. _cartography.ysld.reference.featurestyles:

Feature Styles
==============

In YSLD, A Feature Style is a block of styling :ref:`Rules <cartography.ysld.reference.rules>`.

.. warning:: FIGURE NEEDED

**The purpose of a Feature Style is to specify drawing order.** The first Feature Style will always have its rules applied first, while the second Feature Style will be processed after that, etc.

.. note:: It is not possible to specify order of individual rules inside a Feature Style. If drawing order of individual rules is important, enclose each rule in a Feature Style.

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

Syntax
------

The following is the basic syntax of a Feature Style. Note that the contents of the block are not all expanded here.

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
   :widths: 20 10 70

   * - Property
     - Required?
     - Description
   * - ``name``
     - No
     - Internal reference to the feature style. It is recommended that the value be **lower case** and contain **no spaces**.
   * - ``title``
     - No
     - Human-readable name of the feature style. Exposed as a name for the group of rules contained in the feature style.
   * - ``abstract``
     - No
     - Longer description of the Feature Style.
   * - ``transform``
     - No
     - :ref:`Rendering transformation <cartography.ysld.reference.transforms>` information.
   * - ``rules``
     - Yes
     - List of styling :ref:`rules <cartography.ysld.reference.rules>`.

Examples
--------

.. warning:: SHOW EXAMPLES

.. warning:: MULTI LINE EXAMPLE (WITH |)