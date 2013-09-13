.. _installation.linux.ubuntu.geoserver:

Installing GeoServer on Ubuntu
==============================

The easiest way to install and set up GeoServer is by :ref:`installing OpenGeo Suite <installation.linux.ubuntu.suite>`. OpenGeo Suite comes complete with GeoServer as well as a full geospatial software stack, including utilities, data, and documentation. That said, there are also individual packages for installing the components separately.

This page will describe how to install GeoServer on Ubuntu 12.04 (Precise). Ubuntu 10.04 (Lucid) will also work by specifying ``lucid`` instead of ``precise`` in the following commands.


Access the OpenGeo repository
-----------------------------

OpenGeo provides a repository for packages in APT (Debian/Ubuntu) format. To access this repository, you need to first import the OpenGeo GPG key in to your apt registry:

.. note:: You will need to run these commands on an account with root access.

.. code-block:: bash

   wget -qO- http://apt.opengeo.org/gpg.key | apt-key add -

Once added, you can add the OpenGeo APT repository (http://apt.opengeo.org) to your local list of repositories:

.. warning:: These commands contain links to **beta** packages. When the final version of the software is released, these links will change, so you will need to run these commands again.

Ubuntu 12.04 (Precise):

.. code-block:: console

   echo "deb http://apt.opengeo.org/beta/suite/v4/ubuntu/ precise main" > /etc/apt/sources.list.d/opengeo.list

Ubuntu 10.04 (Lucid):

.. code-block:: console

   echo "deb http://apt.opengeo.org/beta/suite/v4/ubuntu/ lucid main" > /etc/apt/sources.list.d/opengeo.list
      
Now update APT to pull in your changes:

.. code-block:: bash

   apt-get update

Search for packages from OpenGeo:

.. code-block:: bash

   apt-cache search opengeo

If the search command does not return any results, the repository was not added properly. Examine the output of the ``apt`` commands for any errors or warnings.

Package management
------------------

Now you can install GeoServer. The name of the package is :guilabel:`geoserver`:

.. code-block:: bash

   apt-get install geoserver


After installation
------------------

When completed, GeoServer will be installed as a servlet inside the local version of Tomcat. Assuming that Tomcat is running on the default port 8080, you can verify that GeoServer is installed by navigating to the following URL::

   http://localhost:8080/geoserver/

This will load the Web Administration interface. Most management of GeoServer functionality can be done from this interface.

.. note:: The default username and password for the GeoServer administrator account is **admin** / **geoserver**

For more information about GeoServer, please see the documentation.
