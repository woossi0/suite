.. _installation.aws:

Installing the OpenGeo Suite for Amazon AWS EC2
===============================================

The OpenGeo Suite is available as for use with Amazon's AWS EC2 service. The OpenGeo Suite is available in five tiers:

.. list-table::
   :widths: 20 20 20 20 20
   :header-rows: 1

   * - Name
     - Instance Size
     - Setup Fee
     - Cost per hour
     - Cost per month
   * - Dev Small
     - Standard Small
     - N/A
     - $0.13
     - N/A
   * - Dev Large
     - Standard Medium
     - N/A
     - $0.45
     - N/A
   * - Production 1 Small
     - Standard Medium
     - $500
     - N/A
     - $600
   * - Production 2 Medium
     - High Memory Extra Large
     - $750
     - N/A
     - $800
   * - Production 3 Large
     - Standard Extra Large
     - $1000
     - N/A
     - $1,150

Details about the Instance Size (number of CPUs, etc.) can be found on Amazon's `Amazon EC2 Instance Types <http://aws.amazon.com/ec2/instance-types/>`_ page.

.. note::

   For the tiers with an hourly charge (**Dev Small** and **Dev Large**), charges will only accrue when the instance is running. To avoid excess charges, **please make sure to Terminate your instance when it is not in use**. To terminate an instance, right-click the instance in the :guilabel:`Instances` list, and select :guilabel:`Terminate`. There is no commitment or minimum charge associated with either of these tiers.
   
   .. figure:: img/terminating.png

      *Terminating an instance*

Signing up
----------

The process for signing up for all tiers is exactly the same. Only the features and pricing differ.

.. warning:: In order to use the OpenGeo Suite Cloud Edition for Amazon Web Services (AWS), you need to have an Amazon Web Services (AWS) account which has EC2 access enabled. Amazon has detailed instructions on how to sign up for AWS/EC2 at http://aws.amazon.com/documentation/ec2/.

#. Navigate to the OpenGeo Suite Cloud page at http://opengeo.org/products/suite/cloud/. Select the tier you wish to purchase by clicking the appropriate link.

#. You will be redirected to Amazon's site, and be asked to log in to AWS. Enter your AWS account name and password and click :guilabel:`Sign in using our secure server`.

   .. figure:: img/signin.png

      *Signing in to AWS*

#. You will see a description of the product, including all initial and recurring charges. Please review the information, and then click :guilabel:`Place your order`.

   .. warning:: By clicking :guilabel:`Place your order`, you are committing to any charges associated with your purchase.

   .. figure:: img/placeyourorder.png

      *Reviewing order*

#. Once the sale is completed, the next step is to register your purchase with OpenGeo. Click the link that says :guilabel:`Please click here to get activation keys for all applications to which you are subscribed.`

   .. figure:: img/almostdone.png

      *Almost done*

#. Click :guilabel:`Generate Key` to generate an Activation Key.

   .. figure:: img/generatekey.png

      *Ready to generate Activation Key*

#. With the key generated, Click :guilabel:`Go to Application`.

   .. figure:: img/keygenerated.png

      *Activation Key generated*

#. You will be redirected to an OpenGeo registration page. Fill out the form to sign up for the OpenGeo support and to receive your AMI ID.

   .. figure:: img/regform.png

      *Registration form*

#. When done, click :guilabel:`Submit`.

   .. figure:: img/thankyouamazon.png

      *Please fill out this form to complete the sign up process*

#. You have now successfully purchased the OpenGeo Suite Cloud Edition. You will soon receive an email from OpenGeo containing helpful information, links, and other details about your purchase. Refer to this email below.

Logging in
----------

The next step is to launch your new OpenGeo Suite Cloud instance. This is done through Amazon's AWS console.

.. warning:: Amazon console pages are frequently redesigned, and so may not look identical to the screenshots below.

#. Navigate to http://aws.amazon.com.

#. Click :guilabel:`My Account / Console` and select :guilabel:`AWS Management Console`.

   .. figure:: img/consolelink.png

      *Click to go to the AWS Management Console*

#. To log in, use the same credentials you used when purchasing the OpenGeo Suite.

   .. figure:: img/signin.png

      *Signing in to AWS again*

#. You will be redirected to your main AWS console.

   .. figure:: img/consolepage.png

      *Viewing the default AWS console*

#. Click the EC2 link to go to the EC2 Dashboard.

   .. figure:: img/ec2dashboard.png

      *AWS EC2 Dashboard*

#. Make sure you are in the correct zone of where you'd like your instance to be launched. To change the zone, Click the zone name at the top right of the Dashboard and select the proper zone.

   .. note::

      The zones that are currently available for the OpenGeo Suite are:

      * US East (N. Virginia)
      * EU (Ireland)

   .. figure:: img/zoneselect.png

      *Selecting the zone*

#. Click :guilabel:`AMIs` on the left column, under :guilabel:`Images`. This will bring up a list of your AMIs. If you have just signed up for AWS, this list will be blank.

   .. figure:: img/amis.png

      *Viewing your list of AMIs*

#. You will need the AMI ID given to you when you registered. You can also see `the full list of AMI IDs <http://opengeo.org/products/suite/cloud/amazon/ami/>`_. Enter your AMI ID in the search box (next to :guilabel:`Viewing`). Change the select box titled :guilabel:`Viewing` to read :guilabel:`Public Images`. You should see an OpenGeo AMI show up in the list.

   .. note:: This process make take some time.

   .. figure:: img/foundami.png

      *OpenGeo Suite AMI found*

#. Select the AMI by clicking it, and then click the :guilabel:`Launch` button.

   .. figure:: img/launchami.png

      *Launching an AMI instance*

#. A dialog box will display asking for details. Ensure that the :guilabel:`Launch Instances` section is selected, but you should not need to change any settings here. Click :guilabel:`Continue`.

   .. figure:: img/requestinstance-instancetype.png

      *Launching an instance*

#. On the next page (Advanced Instance Options), leave the default settings as is and click :guilabel:`Continue`.

   .. figure:: img/requestinstance-advanced.png

      *Advanced instance options*

#. The next page allows you to configure the storage device for the instance. You can add EBS volume, instance store volumes, or edit th settings of the root volume. If you don't know what to do in this step or wish to leave the defaults, click :guilabel:`Continue`.

   .. figure:: img/requestinstance-storage.png

      *Storage device configuration*

#. The next page allows for the creation of tags for organizational purposes. This step is optional. Click :guilabel:`Continue`.

   .. figure:: img/requestinstance-tags.png

      *Tag creation page*

#. You will be asked to create a key pair. This is used to be able to connect securely (via SSH) to the instance after it launches. Enter a name for your key pair, then download it to your local machine, keeping it in a safe place. When done, click :guilabel:`Continue`.

   .. warning:: Save this key pair! Keys cannot be generated or retrieved at a later time. If you have any plans to connect via SSH or SCP on this instance in the future—and you almost certainly will want to—you will want to have a key pair already generated.

   .. figure:: img/requestinstance-keypair.png

      *Creating a keypair*

#. In order to open the proper ports for accessing the OpenGeo Suite, it is necessary to create a security group. From this page, Click :guilabel:`Create a New Security Group`.

   .. figure:: img/requestinstance-security.png

      *Security Group page*

   .. figure:: img/requestinstance-newsecgroup.png

      *New Security Group page*

#. On the New Security Group page, enter a :guilabel:`Group Name` and :guilabel:`Group Description` ("Ports"  is fine). Create the following new rules by entering in the information and clicking :guilabel:`Add Rule` after each entry.

   .. list-table::
      :header-rows: 1

      * - Rule name
        - Port range
        - Source
        - Usage
      * - HTTP
        - **80 (HTTP)**
        - ``0.0.0.0/0``
        - Default port for web server
      * - Custom TCP rule
        - **8080**
        - ``0.0.0.0/0``
        - Default port for web applications
      * - SSH
        - **22**
        - ``0.0.0.0/0``
        - Required for SSH access

   You may add other rules as desired. When finished click :guilabel:`Continue`.

   .. figure:: img/requestinstance-newsecgroupfinal.png

      *Creating a new Security Group*

#. Verify that all of the settings are correct then click :guilabel:`Launch`.

   .. figure:: img/requestinstance-review.png

      *Reviewing settings*

#. Now :guilabel:`Close` out of the dialog box and click the :guilabel:`Instances` link on the left hand column. You should see your instance in the process of being generated (with a State of :guilabel:`Pending`).

   .. figure:: img/instancepending.png

      *New instance pending*

#. When the instance is fully generated, its State will change to :guilabel:`Running` and its icon will turn from yellow to green. Click it to see the instance details. 

   .. figure:: img/instancedetails.png

      *Instance details*

#. Note the :guilabel:`Public DNS` entry. Use this to connect to the OpenGeo Suite Dashboard and begin using the OpenGeo Suite. In a new browser window, type the following URL:

   .. code-block:: console

      http://<Public DNS>:8080/dashboard/

   For example:

   .. code-block:: console

      http://ec2-23-20-179-35.compute-1.amazonaws.com:8080/dashboard/

   This will launch the Dashboard.

   .. figure:: img/dashboard.png

      *OpenGeo Suite Dashboard, showing a successful installation*

You are now set up and ready to go!

SSH access
----------

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

In the OpenGeo Suite Cloud Edition, there is no web-based access to PostGIS. (This is why the links to PostGIS show up as disabled in the Dashboard.)  There are two ways to connect to manage PostGIS:

* Using the command-line utility ``psql`` via SSH.
* Using a local copy of ``pgAdmin III`` via an SSH tunnel.

Starting/stopping services
--------------------------

There are two system services used in the OpenGeo Suite:  **Apache Tomcat** (for GeoServer and all other webapps) and **PostgreSQL** (for PostGIS). While these services are started by default when the instance is instantiated, here are the commands to stop and start these services should it become necessary:

For PostGIS:

.. code-block:: console

   service postgresql-8.4 stop
   service postgresql-8.4 start

For Tomcat:

.. code-block:: console

   service tomcat5 stop
   service tomcat5 start

For more information
--------------------

Full documentation is available at the following URL from your instance::

  http://<Public DNS>:8080/opengeo-docs/

Please `contact OpenGeo <http://opengeo.org/about/contact/>`_ for more information.

