.. _install.mac.tomcat.before:

Before you start
================

If you are upgrading from a previous version, please be aware that you must **locate and backup the data directory and remove prior versions of the application** first.

.. include:: include/sysreq.txt

Upgrading from OpenGeo Suite 4.8 or earlier
-------------------------------------------

.. warning:: PostGIS is not available with the application server-based installation of Boundless Suite. These installation instructions do not cover the migration of PostGIS databases at this time.

#. Please make a backup of all your data and configuration prior to upgrading.

#. Shutdown all OpenGeo Suite services by navigating to :menuselection:`Menu Bar`, right-clicking the **GeoServer** and **PostGIS** icons, and using the :guilabel:`Quit` option.

   .. figure:: img/before_extquit.png
  
       Shutting down GeoServer

#. Navigate to the GeoServer data directory, by default it is located inside :file:`~/Library/Application Support/GeoServer/`.

   .. note:: You can find your data directory by running GeoServer and selecting :guilabel:`Open GeoServer Data Directory` from the GeoServer icon in the OS X menu bar.

#. Create an archive of the :file:`data_dir` folder. You can do this by selecting the :file:`data_dir` folder and right click to :menuselection:`Compress "data_dir"` action.

#. Repeat this for the :file:`gwc_cache` folder.

#. Backup these archives to a safe location.

#. Uninstall GeoServer by downloading the free AppCleaner utility from `FreeMacSoft <http://www.freemacsoft.net/appcleaner/>`_. Extract the file and run it.

#. Drag the :guilabel:`GeoServer` and :guilabel:`GeoServer Extensions` applications into the AppCleaner window. Click the :guilabel:`Delete` button.

   .. figure:: img/before_appcleaner.png

       Uninstalling GeoServer

   .. warning:: This will delete your settings and data. If you do not want to delete your data:

      * Back up your GeoServer data directory, as described above, by copying it to a safe location.
      * Back up your PostGIS database to a safe location by following the instructions in the :ref:`dataadmin.pgDBAdmin.backup` section.
