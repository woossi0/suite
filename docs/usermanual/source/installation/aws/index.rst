.. _installation.aws:

Installing OpenGeo Suite for AWS
====================================

The OpenGeo Suite is available as for use with Amazon's Amazon Web Service (AWS).

Pricing plans
-------------

There are two pricing options for purchasing the OpenGeo Suite on AWS: **Hourly** and **Monthly**. There is no difference in the software in either option.

On the Hourly plan, you pay only for each hour in which your instance is running. This option is best for those who are just testing the software out, and don't plan on keeping the instance up and running constantly.

On the Monthly plan, you pay a fixed monthly fee for instance usage, regardless of instance uptime. This option is best for those who are building an instance that will be staying online permanently.

The Hourly plan, if left on over an entire month, will end up being more expensive than the Monthly plan.

.. note:: Both the hourly and monthly plan pricing do not include additional AWS charges such as data transfer fees. 

Instance options
----------------

Beyond the pricing plans, there are also three instance sizes. This determination can affect the price as well. The instance sizes are detailed below:

.. list-table::
   :header-rows: 1
   :stub-columns: 1

   * - Name
     - Standard Large
     - Standard XL
     - High Memory XL
   * - Memory
     - 7.5 GiB
     - 15 GiB
     - 17.1 GiB
   * - CPU
     - 4 EC2 Compute Units (2 virtual cores with 2 EC2 Compute Units each)
     - 8 EC2 Compute Units (4 virtual cores with 2 EC2 Compute Units each)
     - 6.5 EC2 Compute Units (2 virtual cores with 3.25 EC2 Compute Units each)
   * - Storage
     - 850 GB instance storage
     - 1690 GB instance storage
     - 420 GB instance storage
   * - Platform
     - 64-bit
     - 64-bit
     - 64-bit
   * - I/O performance
     - High
     - High
     - Moderate
   * - AWS instance type
     - m1.large
     - m1.xlarge
     - m2.large

More details about instance sizes can be found on Amazon's `Amazon EC2 Instance Types <http://aws.amazon.com/ec2/instance-types/>`_ page.

Purchasing
----------

.. todo:: Will there be a main page?

.. warning:: You need to have an Amazon Web Services (AWS) account with EC2 enabled in order to use the OpenGeo Suite for AWS. Amazon has detailed instructions on how to sign up for AWS/EC2 at http://aws.amazon.com/documentation/ec2/.

#. Navigate to http://aws.amazon.com and log in by clicking :guilabel:`My Account / Console` and then :guilabel:`My account`. 

   .. figure:: img/signin.png

      *Signing in to AWS*

#. Navigate to the appropriate page:

   * `Hourly plan <https://aws.amazon.com/marketplace/pp/B00ED5D1TA>`_
   * `Monthly plan <https://aws.amazon.com/marketplace/pp/B00ED5EGP8>`_

   .. note:: All screenshots on this page will show the Hourly plans, but the details are the same for both.

   .. figure:: img/front.png

      Front page of OpenGeo Suite for AWS offering

#. Click :guilabel:`Continue`. Don't worry about any of the options on the Pricing Details box; you'll have the ability to make those settings on the next page.

#. The following page contains settings, divided into five boxes: :guilabel:`Version`, :guilabel:`Region`, :guilabel:`EC2 instance type`, :guilabel:`Security group`, and :guilabel:`Key Pair`. These boxes and be expanded by clicking them.

   .. figure:: img/settings.png

      Settings page

   .. note:: Those familiar with AWS can also click the tab that says "Launch with EC2 Console", and continue their configuration manually. For most people, the instructions here for the "1-Click Launch" will be sufficient.

#. **Version**. Most people will leave this option with the default (latest) version.

   .. figure:: img/settings-version.png

      Version box

#. **Region**. Select the region you want the instance to be running in, which is typically the location closest to where your users are likely to be or where your are located.

   .. note:: Learn more about `AWS regions <http://aws.amazon.com/about-aws/globalinfrastructure/>`_.

   .. figure:: img/settings-region.png

      Region box

#. **EC2 instance type**. Choose from "Standard Large", "Standard XL", or "High-Memory XL". Refer to the above chart for the differences between the versions.

   .. figure:: img/settings-instancetype.png

      EC2 instance type box

#. **Security Group**. We recommend using the standard security group that should already selected, which includes port openings at 22, 80, and 8080. Most people should not change anything in this section.

   .. figure:: img/settings-secgroup.png

      Security Group box

#. **Key Pair**. In order to be able to connect to your instance via SSH/terminal, you will need to select a saved key pair. 

   .. figure:: img/settings-keypairblank.png

      Key pair box

   #. If you don't have a key pair in your account, click the :guilabel:`Visit the Amazon EC2 Console` link the :guilabel:`Key pair` box.

      .. figure:: img/keypairstart.png

         Key pair page with no key pairs

   #. You will be taken to a screen where you can create a new key pair. Click :guilabel:`Create key pair`.

      .. figure:: img/keypaircreate.png

         Creating a key pair

   #. A key pair will be generated, and the private portion of the pair will automatically be downloaded onto your system.

      .. warning:: Don't lose this file, otherwise your key pair will be useless!

      .. figure:: img/keypaircreated.png

         Key pair successfully created

      .. figure:: img/settings-keypairfilled.png

         Key pair box with key pair listed

#. Now back at the :guilabel:`Launch on EC2 page`, all options should be properly set. Click :guilabel:`Accept terms and Launch with 1-Click`.

   .. note:: If you skipped the creation of the key pair, you will see a warning. We recommend creating a key pair now, even if you don't anticipate connecting to the instance via SSH or the terminal, so you will have the option of doing so at a later date.

      .. figure:: img/nokeypair.png

         Warning when key pair creation was skipped

#. If everything went well, you should see a note indicating success. Your instance will be available after a short period of time.

   .. figure:: img/success.png

      OpenGeo Suite successfully launched

#. Click on :guilabel:`Your Software` to see the status of your purchase.

   .. figure:: img/subscriptions.png

      Waiting for OpenGeo Suite to be ready

.. todo:: More details about what happens after purchase.

SSH access
----------

.. todo:: Not verified as part of AWS Marketplace

.. note:: This step requires that port 22 was opened in the Security Group created during the launching of your instance and that a key pair was generated.

Linux / Mac OS X
~~~~~~~~~~~~~~~~

You may connect to this instance via SSH using the ``ssh`` command:

.. code-block:: console

   ssh -i yourkey.pem ubuntu@<Public DNS>

For example:

.. code-block:: console

   ssh -i yourkey.pem ubuntu@ec2-23-20-179-35.compute-1.amazonaws.com

where :file:`yourkey.pem` is the name of the downloaded key file.

Windows
~~~~~~~

You may connect to this instance via SSH using `PuTTY <http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html>`_, but you will need to convert your key to a format that PuTTY understands. This is done with `PuTTYgen <http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html>`_:

#. Run PuTTYgen.

#. Click :guilabel:`Load` ("Load an existing private key").

#. Select the key file.

#. After loading, click :guilabel:`Save private key`. This is the key to use when connecting with PuTTY. it will have a ``.ppk`` file extension.

To connect with PuTTY, make sure to load the ``.ppk`` file under :menuselection:`Connection --> SSH --> Auth` in the box titled :guilabel:`Private key file for authentication`. Once done, enter the host name, and connect as user ``ubuntu``.

To connect with PuTTY using the command line:

.. code-block:: console

   putty -i yourkey.ppk -ssh ubuntu@<Public DNS>

For example:

.. code-block:: console

   putty -i yourkey.ppk -ssh ubuntu@ec2-23-20-179-35.compute-1.amazonaws.com

where :file:`yourkey.ppk` is the name of the key file created by PuTTYgen.

PostGIS
-------

.. todo:: Not verified as part of AWS Marketplace

There is no web-based access to PostGIS, but there are two ways to connect to manage PostGIS:

* Using the command-line utility ``psql`` via SSH.
* Using a local copy of ``pgAdmin III`` via an SSH tunnel.

Starting/stopping services
--------------------------

.. todo:: Not verified as part of AWS Marketplace

There are two system services used in the OpenGeo Suite:  **Apache Tomcat** (for GeoServer and all other webapps) and **PostgreSQL** (for PostGIS). While these services are started by default when the instance is instantiated, here are the commands to stop and start these services should it become necessary:

For PostGIS:

.. code-block:: console

   service postgresql-9.2 stop
   service postgresql-9.2 start

For Tomcat:

.. code-block:: console

   service tomcat5 stop
   service tomcat5 start

For more information
--------------------

Full documentation is available at the following URL from your instance::

  http://<Public DNS>:8080/opengeo-docs/

Please `contact OpenGeo <http://opengeo.org/about/contact/>`_ for more information.

