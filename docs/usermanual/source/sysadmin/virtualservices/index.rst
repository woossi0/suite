.. sysadmin.virtualservices:

Setting up a virtual service environment
========================================

Virtual services provide a custom endpoint for managing a subset of GeoServer content and services. Virtual services provide a way for system administrators to allow administration of specific sub-sections of the GeoServer catalog, and so reduce the need for a single administrator to have access to all resources.

Read more about `Virtual Services <../../geoserver/services/virtual-services.html>`_ in the GeoServer reference.

This tutorial will discuss how to implement a workflow and user scenario that utilizes virtual services.


Scenario
--------


Christina is working on the Lakes project. She wants to be able to load and administer all of the data related to her project, but does not need to know about or administer any other project. Her project has an application which will require access to WFS and WMS protocols.

.. todo:: Details?  Specific services?

Kenneth is working on the Traffic project. He too wants to be able to load and administer all of the data realted to his project, but does not need to know about or administer any other project. His project has an application which will require access to WMS and the REST interface.

.. todo:: Details?  Specific services?

.. todo:: Do we care about names of users?

As system administrator. you administer GeoServer, and so  have access to all the content and settings of the server, but you are not particularly interested in any specific work that is carried out by Christina or Kenneth.

At a high-level, to configure this, the following steps must be taken:

* Create two workspaces, ``lakes`` and ``traffic``
* Create two workspace administrator accounts, one for each workspace
* Configure these workspace accounts to have access to the proper workspace only
* Restrict global services to the administrator only


Creating workspaces
-------------------

First, configure the virtual service endpoints.

#. From the GeoServer web interface, log in to the administrator account.

#. Click on :guilabel:`Workspaces`.

#. Click on :guilabel:`Add new workspace`.

#. In the box titled :guilabel:`Name`, enter ``lakes``, and in the box titled :guilabel:`Namespace URI`, enter ``http://example.com/lakes``. Do not check the :guilabel:`Default Workspace` box. Click :guilabel:`Submit` when done.

#. Click on :guilabel:`Add new workspace` again. 

#. In the box titled :guilabel:`Name`, enter ``traffic``, and in the box titled :guilabel:`Namespace URI`, enter ``http://example.com/traffic``. Do not check the :guilabel:`Default Workspace` box. Click :guilabel:`Submit` when done.

#. To verify that the virtual service enpoints have been configured correctly, navigate to the following URLs::

      http://<geoserver_root>/lakes/wfs?request=GetCapabilities
      http://<geoserver_root>/traffic/wfs?request=GetCapabilities

   If a valid capablities document displays, the workspaces were set up correctly. If a 404 error page displays, please check the above steps for correctness.

Creating roles
--------------

The next step is to create the security roles that will be associated with the workspace administrator accounts.

#. From the GeoServer web interface, remain logged in to the administrator account.

#. Click :guilabel:`Users, Groups, and Roles` in the :guilabel:`Security` section.

#. Click the :guilabel:`default` role service, which maintains the list of roles.

#. Click the :guilabel:`Roles` tab, which will show the list of roles.

#. Click :guilabel:`Add new role`.

#. In the box titled :guilabel:`Name`, enter ``LAKESADMIN``. Leave all other fields blank. Click :guilabel:`Save` when done.

#. Click :guilabel:`Add new role` again.

#. In the box titled :guilabel:`Name`, enter ``TRAFFICADMIN``. Leave all other fields blank. Click :guilabel:`Save` when done.

Creating workspace administrator accounts
-----------------------------------------

The next step is two create workspace administrator accounts. These accounts will have the ability to manage a single workspace, but not have any access to any other workspaces. 

#. From the GeoServer web interface, remain logged in to the administrator account.

#. Click :guilabel:`Users, Groups, and Roles` in the :guilabel:`Security` section.

#. Click the :guilabel:`default` XML user/group service, which maintains the list of users.

#. Click on the :guilabel:`Users` tab to bring up the list of users.

#. Click on :guilabel:`Add new user`.

#. Fill out the form with the following information:

   * In the box titled :guilabel:`User name`, enter ``christy``

   * In the box titled :guilabel:`Password`, enter a suitable password.

   * In the box titled :guilabel:`Confirm Password`, enter a suitable password.

   * In the box titled :guilabel:`Roles taken from active role service: default`, select the :guilabel:`LAKESADMIN` entry and click the right arrow to move the role into the :guilabel:`Selected` box.

   * Leave all other fields blank, and click :guilabel:`Save` when done.

#. Click on :guilabel:`Add new user` again.

#. Fill out the form with the following information:

   * In the box titled :guilabel:`User name`, enter ``kenneth``

   * In the box titled :guilabel:`Password`, enter a suitable password.

   * In the box titled :guilabel:`Confirm Password`, enter a suitable password.

   * In the box titled :guilabel:`Roles taken from active role service: default`, select the :guilabel:`TRAFFICADMIN` entry and click the right arrow to move the role into the :guilabel:`Selected` box.

   * Leave all other fields blank, and click :guilabel:`Save` when done.

Securing roles
--------------

At this point, workspaces, roles, and users have been created, and roles have been associated with the users. The next step is to create security restrictions on those roles such that they will conform to the desired access rules.

Lakes admin
~~~~~~~~~~~

#. From the GeoServer web interface, remain logged in to the administrator account.

#. Click :guilabel:`Data` in the :guilabel:`Security` section.

#. Click :guilabel:`Add new rule`.

#. Fill out the form with the following information:

   * In the box titled :guilabel:`Workspace`, select ``lakes``.

   * In the box titled :guilabel:`Layer`, select ``*``.

   * In the box titled :guilabel:`Access Mode`, select ``Admin``.

   * In the area titled :guilabel:`Roles`, select the :guilabel:`LAKESADMIN` entry and click the right arrow to move the role into the :guilabel:`Selected` box. Repeat this process with the :guilabel:`Admin` and :guilabel:`GROUP_ADMIN` roles.

     .. todo:: This may not be necessary.

   * Click :guilabel:`Save` when done.

Traffic admin
~~~~~~~~~~~~~

#. Click :guilabel:`Add new rule` again.

#. Fill out the form with the following information:

   * In the box titled :guilabel:`Workspace`, select ``traffic``.

   * In the box titled :guilabel:`Layer`, select ``*``.

   * In the box titled :guilabel:`Access Mode`, select ``Admin``.

   * In the area titled :guilabel:`Roles`, select the :guilabel:`TRAFFICADMIN` entry and click the right arrow to move the role into the :guilabel:`Selected` box. Repeat this process with the :guilabel:`Admin` and :guilabel:`GROUP_ADMIN` roles.  

     .. todo:: This may not be necessary.

   * Click :guilabel:`Save` when done.

Allowing read-only access
~~~~~~~~~~~~~~~~~~~~~~~~~

The above has set administration of the workspaces, but has restricted even viewing of layers to those administrators. To open up these workspaces to anonymous read-only access:

#. Click :guilabel:`Add new rule` again.

#. Fill out the form with the following information:

   * In the box titled :guilabel:`Workspace`, select ``lakes``.

   * In the box titled :guilabel:`Layer`, select ``*``.

   * In the box titled :guilabel:`Access Mode`, select ``Read``.

   * In the area titled :guilabel:`Roles`, click the :guilabel:`Grant access to any role` box.

   * Click :guilabel:`Save` when done.

#. Click :guilabel:`Add new rule` again.

#. Fill out the form with the following information:

   * In the box titled :guilabel:`Workspace`, select ``traffic``.

   * In the box titled :guilabel:`Layer`, select ``*``.

   * In the box titled :guilabel:`Access Mode`, select ``Read``.

   * In the area titled :guilabel:`Roles`, click the :guilabel:`Grant access to any role` box.

   * Click :guilabel:`Save` when done.

Restricting global services
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now, restrict the global read-only services to be for authenticated users only.

#. Click the :guilabel:`*.*.r` rule.

#. Uncheck :guilabel:`Grant access to any role`.

#. In the area titled :guilabel:`Roles`, select the :guilabel:`ROLE_AUTHENTICATED` entry and click the right arrow to move the role into the :guilabel:`Selected` box.  (THIS DOESN'T WORK.)

#. Click :guilabel:`Save` when done.

#. Now, restrict write access to global services to be for the administrator only. Click the :guilabel:`*.*.w` rule.

#. Uncheck :guilabel:`Grant access to any role`.

#. In the area titled :guilabel:`Roles`, select the :guilabel:`Admin` entry and click the right arrow to move the role into the :guilabel:`Selected` box.  Repeat this process with the :guilabel:`GROUP_ADMIN` role. (HOW TO TEST?)

#. Click :guilabel:`Save` when done.

Verification
~~~~~~~~~~~~

To verify that the access rules have been applied properly, perform the following tasks:

#. Log out of the administrator account.

#. Navigate to these three URLs::

     http://<geoserver_root>/wfs?request=GetCapabilities
     http://<geoserver_root>/lakes/wfs?request=GetCapabilities
     http://<geoserver_root>/traffic/wfs?request=GetCapabilities

   All of them should yield a 404.

#. Now log in to the GeoServer web admin as ``christy`` using the password created earlier.

#. Navigate to the three URLs as above.  

.. todo::

   Questions and status:

   Created two roles, TRAFFICADMIN, LAKESADMIN
   Created two new users, and associated them with the appropriate role

   What about logging into the webadmin?

   What about mixing services and virtual services (access only WMS in this workspace)?

   What type of catalog mode should I use? (HIDE/MIXED/CHALLENGE)

   Does .a imply .w ?

   And now, the two warkspace administrators are free to log into the webadmin interface and load whatever data they wish.