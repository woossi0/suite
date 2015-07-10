.. _webmaps.composer.keys:

Keyboard functions and shortcuts
================================

Navigating around the style editor interface is easy with the mouse, but there are some useful keyboard functions available that can make using Composer even easier.

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1

   * - Function
     - Shortcut
   * - Auto-complete
     - ``Ctrl-Enter``
   * - Code folding
     - ``Ctrl-,`` and ``Ctrl-.``
   * - Save
     - ``Ctrl-S``
   * - Select line
     - ``Shift-Up`` and ``Shift-Down``
   * - Increase/reduce indent
     - ``Tab`` and ``Shift-Tab``

This list can be retrieved by clicking the keyboard icon on the top right of the window.

.. figure:: img/keys_listicon.png

   Icon to show keyboard shortcuts

The resulting list will be displayed.

.. figure:: img/keys_list.png

   List of keyboard shortcuts

Auto-complete (``Ctrl-Enter``)
------------------------------

The style editor offers an easy way to explore and determine the correct syntax for functions by way of an auto-complete function.

Auto-complete is activated by pressing **Ctrl-Enter** (**Cmd-Enter** on OS X). A drop-down list will display showing a list of possible options. The location of the cursor and the context will determine what goes in this list.

.. figure:: img/keys_auto.png

   Auto-complete

This can also be useful during debugging, as you can verify if an option is in the right place by verifying that it appears in the appropriate list.

Not only does the auto-complete respect cursor location, but it also respects whether the expected option will be a list or a mapping.

When auto-complete is triggered on a list item (noted by the dash prefix), only list options will be shown:

.. figure:: img/keys_autolist.png

   Auto-complete on a list

Removing the dash and triggering auto-complete will show only mapping entries:

.. figure:: img/keys_automapping.png

   Auto-complete on a mapping

Code folding (``Ctrl-,`` and ``Ctrl-.``)
----------------------------------------

It can sometimes be useful to hide and display certain portions of the code. This is known as "code folding".

Code folding is activated by pressing **Ctrl-,** (**Cmd-,** on OS X). The code to be folded is dependent on where the cursor is.

When the cursor is on a line that contains a list entry (with the dash) the entire contents of that list entry will be folded.

.. figure:: img/keys_foldbefore.png

   List entry before folding

.. figure:: img/keys_foldafter.png

   List entry folded

When the cursor is on a line that is inside a mapping (no dash), then the contents of the *parent* will be folded. In this case, the cursor will move to the parent line from the (now-hidden) original line.

Code that is folded is indicated by a |doublearrow| at the end of a line, with a small arrow shown in the margin area to the left of the line. Placing the cursor on this line and pressing **Ctrl-.** (**Cmd-.** on OS X) will unfold the code. You can also click the |doublearrow| icon to unfold the code. Attempting to navigate into the folded region using the arrow keys will also unfold the code.

.. |doublearrow| image:: img/keys_doublearrow.png

As another indicator of code folding, the line numbers in the margin will become discontinuous.

.. note:: It is not possible to force folding using tokens or regions.

Save (``Ctrl-S``)
-----------------

Like many typical programs, you can save your progress by pressing **Ctrl-S** (**Cmd-S** on OS X).

If there are no errors, you will see a :guilabel:`Style saved` note at the top of the window.

.. figure:: img/saved.png

   Style saved

If there is an error, the line that contains the error will be highlighted, and any other details known about the error will be listed.

Select line (``Shift-Up`` and ``Shift-Down``)
---------------------------------------------

As in other programs, holding **Shift** and moving the cursor with the arrow keys will select all characters between the original cursor position and the new cursor position. By this method, **Shift-Up** will select the previous line and **Shift-Down** will select the next line. **Shift-Left** will select the previous character and **Shift-Right** will select the next character.


Increase/reduce indent (``Tab`` and ``Shift-Tab``)
--------------------------------------------------

It may be useful to change the indentation of a block of text. Pressing **Tab** will increase the indentation of all selected lines by two spaces. **Shift-Tab** will decrease the indentation of all selected lines by two spaces.
