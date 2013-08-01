.. _installation.war:


Installing the OpenGeo Suite Production WAR bundle
==================================================

In addition to being available through installers and packages, the OpenGeo Suite is available as an operating system independent collection of web applications, or servlets. This collection may be useful for administrators who wish to manage the OpenGeo Suite within their existing infrastructure, and want the flexibility of a custom deployment. As this bundle is often used in a :ref:`sysadmin.production` environment, and the applications themselves are distributed in a .WAR (Web Archive) format, they are known as **Production WARs**.

The individual applications shipped as part of the Production WAR bundle are:

* GeoServer
* GeoExplorer
* GeoWebCache
* :ref:`Recipe Book <recipes>`
* :ref:`Dashboard <dashboard>`

As PostGIS is not a web application, it is not included in this bundle. If you want to use PostGIS as part of your OpenGeo Suite installation, you should use the :ref:`CentOS <installation.linux.centos.postgis>` or :ref:`Ubuntu <installation.linux.ubuntu.postgis>` packages, or the :ref:`Windows <installation.windows>` or :ref:`Mac OS X <installation.osx>` installers.

.. note:: For further information on optimizing your system, please see the section on :ref:`sysadmin`.


Installing a servlet container
------------------------------

.. note:: If you already have a servlet container installed, you may skip to the next section.

The OpenGeo Suite is compatible with a number of servlet containers, among them Jetty, JBoss, and WebSphere. One of the most popular platforms is `Apache Tomcat <http://tomcat.apache.org/>`_. Tomcat is available for all operating systems and is a stable and well-tested solution.

The following sections will assume that Tomcat is used, although most of the instructions and recommended strategies will also apply to other servlet containers with minimal additional effort.


Adding the WARs to the servlet container
----------------------------------------

Web applications are usually deployed by copying the individual WAR files to a servlet container's :file:`webapps` directory. You may have to restart the container service afterwards. Otherwise, please see your servlet container's instructions for further information on deploying web applications.

.. todo:: More probably needs to be said here.

Installation strategies
-----------------------

The main benefit of the Production WAR bundle is its flexibility. Unlike a monolithic installer, you can install individual components of the OpenGeo Suite as needed. The most important point to note is *not all applications need to be deployed on the same machine*, or even installed at all. 

The following installation strategies and configuration options are available.


Split GeoServer and GeoWebCache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GeoWebCache can act as a proxy between GeoServer and a client. It may be advantageous to place GeoWebCache in an public facing servlet container, as it only hosts images and contains no data. You can then host GeoServer in a non-public facing implementation such that only GeoWebCache can access it. This provides a level of security for your data. 

Multiple GeoServers
~~~~~~~~~~~~~~~~~~~

It is possible to deploy multiple copies of GeoServer in the same servlet container. This may be used to implement a "round robin" strategy for handling requests. You could go further and use multiple servlet containers to host GeoServer instances, making your system more fault tolerant.

Separate PostGIS and GeoServer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A recommended installation strategy is to ensure PostGIS and GeoServer are not installed on the same server. This is primarily for security reasons, to prevent PostGIS from being accessed via the web. Give that PostGIS is a separate installation in the Production WARs, this configuration is straightforward to implement.

