.. _installation.war:

.. warning:: Document status: **Requires copyedit review (MP)**

Installing the OpenGeo Suite Production WAR bundle
==================================================

.. note:: The Production WAR bundle is only available as part of the OpenGeo Suite Enterprise Edition. 

In addition to being available through installers and packages, the OpenGeo Suite is available as a OS-independent collection of web applications, or servlets. This collection is useful for administrators who wish to manage the OpenGeo Suite in their existing infrastructure, and want the flexibility of a custom deployment. Because this bundle is often used in a :ref:`sysadmin.production` environment, and because the applications themselves are distributed in a .WAR format, they are known as **Production WARs**.

The individual applications shipped as part of the Production WAR bundle are:

* GeoServer
* GeoExplorer
* GeoWebCache
* :ref:`Recipe Book <recipes>`
* :ref:`Dashboard <dashboard>`

PostGIS, not being a web application, is not included in this bundle. Those wishing to use PostGIS as part of their instance of the OpenGeo Suite install should use the packages (:ref:`CentOS <installation.linux.centos.postgis>` or :ref:`Ubuntu <installation.linux.ubuntu.postgis>`) or the :ref:`Windows <installation.windows>` or :ref:`Mac OS X <installation.osx>` installers.

.. note:: For more about how to optimize your system, please see the section on :ref:`sysadmin`.


Installing a servlet container
------------------------------

.. note:: If you already have a servlet container installed, you may skip to the next section.

The OpenGeo Suite is compatible when many different servlet containers, among them Jetty, JBoss, and WebSphere. But by far, the platform that is most recommended is to use `Apache Tomcat <http://tomcat.apache.org/>`_. Tomcat is available for all operating systems and is a stable and well-tested solution.

Most of the instructions will assume that Tomcat is being used. Many of the tips can be applied to other servlet containers though, with minimal effort.

Adding the WARs to the servlet container
----------------------------------------

In most cases, web applications are deployed by copying the individual WAR files to a servlet container's :file:`webapps` directory. It may be necessary to restart the container service afterwards. Otherwise, please see your servlet container's instructions for how to deploy web applications.

.. todo:: More probably needs to be said here.

Installation strategies
-----------------------

The benefit to using the Production WAR bundle is in its flexibility. Unlike a monolithic installer, one can install pieces of the OpenGeo Suite as needed. The following showcases some strategies for managing your infrastructure. The most important point is that *not all applications need to be deployed on the same machine*, or even at all. 

Split GeoServer and GeoWebCache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GeoWebCache can act as a proxy between GeoServer and a client. It may be advantageous to place GeoWebCache in a servlet container that is externally facing, as it only hosts images and contains no data. You can then host GeoServer in a non-public facing manner such that only GeoWebCache can access it. This helps secure your data via your network.

Multiple GeoServers
~~~~~~~~~~~~~~~~~~~

It is possible to deploy multiple copies of GeoServer in the same servlet container. This can be used to employ a "round robin" strategy for handling requests. One can go further and use multiple servlet containers to host GeoServer instances, making your system more redundant and fault tolerant.

Separate PostGIS and GeoServer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One common and recommended strategy is to ensure that PostGIS and GeoServer are not on the same server. This is primarily for security reasons, to prevent PostGIS from being able to be accessed from the web. That PostGIS is a separate install in the Production WARs makes this option more straightforward.
