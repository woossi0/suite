How to set up an OpenGeo Suite cluster on VMware
================================================

This page will show how to automatically set up and configure a cluster of servers on `VMware <http://vmware.com>`_.

This script is available to Enterprise clients only. Please `contact us <http://boundlessgeo.com/about/contact-us/sales/>`_ to become an Enterprise client.

.. todo:: Say more about what the scripts will do.

Prerequisites
-------------

* Ubuntu or Red Hat-based Linux
* Python 2.7 or higher
* Ansible 1.6.2 or higher (installed via `pip <https://pypi.python.org/pypi/pip>`_)
* Java JDK 7 or higher (not a JRE)
* Super user access
* VMWare

.. todo:: Python 3? Check these

.. todo:: What version of VMware?

Setup
-----

.. todo:: VMware setup?

Packages
^^^^^^^^

#. Ansible must be installed via ``pip``. If you have Ansible installed through your standard package manager, run :command:`apt-get remove --purge ansible` first before running :command:`pip install ansible`.

#. Install the ``python-dev`` package through your package manager. For example, on Ubuntu:

   .. code-block:: bash

      apt-get install python-dev

#. Install `boto <https://pypi.python.org/pypi/boto/>`_ with ``pip``:

   .. code-block:: bash

      pip install boto

Java
^^^^

#. Set the ``$JAVA_HOME`` variable to the location of Java. For example:

   .. code-block:: bash

      export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386/jre

   .. note:: The command :command:`which java` may not give the true path. For more information on how to find the real location of Java, see the `Amazon EC2 documentation <http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/set-up-ec2-cli-linux.html#java_runtime_linux>`_.

#. To verify, type the following command:

   .. code-block:: bash

      $JAVA_HOME/bin/java -version

VMware
^^^^^^

#. Set up five instances of Ubuntu 12.04 in VMware. These will be configured by the script as:

   * 2 GeoServers
   * 2 Fileshares
   * 1 RDS backend


Clustering script
^^^^^^^^^^^^^^^^^

#. Download and extract the clustering script archive to a directory.

   .. note:: If you are an Enterprise client and do not have the script, please `send us a note and let us know <http://boundlessgeo.com/about/contact-us/>`_.

#. Open the file :file:`hosted_vars/main.yml` in a text editor.

#. Enter in the five IP address that correspond to the five virtual machines::

      geoserver1_ip: 10.63.25.156
      geoserver2_ip: 10.95.184.118
      nfsserver_ip: 10.69.22.254
      postgres1_ip: 10.146.172.94
      postgres2_ip: 10.171.41.240

#. Save and close the file.

#. Open the file :file:`hosts` in a text editor.

#. Enter in the same IP addresses here as well.

   .. todo:: Need more details.

#. Save and close the file.

Launching the cluster
---------------------

With setup complete, you can now launch the cluster.

#. Run the following command from the root of the clustering directory:

   .. code-block:: bash

      ansible-playbook ansible-playbook hosted-launch.yml -i hosts

#. Details on the cluster created will be available in the log file :file:`/tmp/informationoutput`.

Troubleshooting
---------------

If you encounter errors while running the script, you can run the script in "debug mode" by appending ``-vvvv`` to the command. The individual commands run by the script will be displayed in the terminal.

Shutting down the cluster
-------------------------

For security reasons, there is no script to shut down a cluster. Instead, you can shut down your VMware instances manually.
