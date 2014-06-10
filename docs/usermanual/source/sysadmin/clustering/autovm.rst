.. _sysadmin.clustering.autovm:

How to set up an OpenGeo Suite cluster in a virtual environment
===============================================================

This page will show how to automatically set up and configure a cluster of servers on `VMware <http://vmware.com>`_ or other virtual environment.

This script is available to Enterprise clients only. Please `contact us <http://boundlessgeo.com/about/contact-us/sales/>`_ to become an Enterprise client.

Prerequisites
-------------

* Machine running the script must use Ubuntu, Red Hat-based Linux or Mac OS X
* Python 2.7 or higher (not guaranteed on Python 3)
* Ansible 1.6.2 or higher (installed via `pip <https://pypi.python.org/pypi/pip>`_)
* Super user access
* VMWare or other virtual environment
* NFS Server that is already setup (v3 recommended v4 requires `this workaround <https://www.novell.com/support/kb/doc.php?id=7014266>` ) 

Setup
-----

Virtual environment
^^^^^^^^^^^^^^^^^^^

#. Set up five instances of Ubuntu 12.04 in VMware or other virtual environment. These will be configured by the script as:

   * 2 GeoServers
   * 2 Fileshares (PostgreSQL servers)
   * 1 NFS backend

#. Make note of the IP addresses for each of these servers as they will be needed later.

Packages
^^^^^^^^

#. *Mac OS X only:* Install ``pip``: 

   .. code-block:: bash
      
      sudo easy_install pip

#. Ansible must be installed via ``pip``. If you have Ansible installed through your standard package manager, run :command:`apt-get remove --purge ansible` first before running :command:`pip install ansible`.

#. Install the ``python-dev`` package through your package manager. For example, on Ubuntu:

   .. code-block:: bash

      apt-get install python-dev

#. Install `boto <https://pypi.python.org/pypi/boto/>`_ with ``pip``:

   .. code-block:: bash

      pip install boto

Clustering script
^^^^^^^^^^^^^^^^^

#. Download and extract the clustering script archive to a directory.

   .. note:: If you are an Enterprise client and do not have the script, please `let us know <http://boundlessgeo.com/about/contact-us/>`_.

#. Open the file :file:`hosted_vars/main.yml` in a text editor.

#. Enter in the five IP address that correspond to the five virtual machines::

      geoserver1_ip: 10.63.25.156
      geoserver2_ip: 10.95.184.118
      nfsserver_ip: 10.69.22.254
      postgres1_ip: 10.146.172.94
      postgres2_ip: 10.171.41.240

#. Save and close the file.

#. Open the file :file:`hosts.hosted` in a text editor.

#. Enter the same IP addresses here as well under their respective headers, with the exception of the NFS server, which is not needed in this file::

     [local]
     127.0.0.1

     [geoservers]
     10.63.25.156
     10.95.184.118

     [postgresservers]
     10.146.172.94
     10.171.41.240

#. Save and close the file.

Launching the cluster
---------------------

With setup complete, you can now launch the cluster.

#. Run the following command from the root of the clustering directory:

   .. code-block:: bash

      ansible-playbook ansible-playbook hosted-launch.yml -i hosts.hosted
   
   If you want to change the username that the script uses to log in, add ``--user=<username>`` to the command line. If you want to prompt for a password to login as that user, add ``-k``.

#. Details on the cluster will be available in the log file :file:`/tmp/informationoutput`.

Troubleshooting
---------------

If you encounter errors while running the script, you can run the script in "debug mode" by appending ``-vvvv`` to the command. The individual commands run by the script will be displayed in the terminal.

Shutting down the cluster
-------------------------

For security reasons, there is no script to shut down a cluster. Instead, you can shut down your instances manually.
