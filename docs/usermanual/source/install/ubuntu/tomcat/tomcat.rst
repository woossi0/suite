.. _install.ubuntu.tomcat.tomcat:

Tomcat Installation
===================

The Tomcat Application server is used to host the Boundless Suite web applications. Tomcat itself is a Java application, and some care will be required to configure it appropriately for use.

#. Create a new ``tomcat`` group, and user::
   
     $ sudo group add tomcat
     $ sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

#. Visit the Apache website:
   
   * `Tomcat Windows Service Installer <http://tomcat.apache.org/download-80.cgi>`_ 
   
   And copy the link to the :file:`tar.gz` download.
   
   .. warning: Boundless Suite requires a recent version of Tomcat supporting Servlet 3.

#. Down load the :file:`tar.gz` file using curl.::
      
      $ cd /tmp
      $ curl -O http://apachemirror.ovidiudan.com/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz

#. Install into :file:`/opt/tomcat` folder::
      
      $ sudo mkdir /opt/tomcat
      $ sudo targ xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
      $ cd /opt/tomcat

#. Set permissions appropriately:

      $ sudo chgrp -R tomcat conf
      $ sudo chmod g+rwx conf
      $ sudo chmod g+r conf/*
      $ sudo chown -R tomcat webapps/ work/ temp/ logs/

.. Found the following useful so far:
   
   * https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-16-04

#. Define the tomcat8 service ...

#. Adjust the firewall::
      
      $ sudo ufw allow 8080

#. Provide a ``manager-gui`` user by editing the :file:`config/tomcat-users.xml` with an additional user::
           
           <user username="admin" password="******" roles="manager-gui" />
   
   .. note:: The Tomcat administrator role ``manager-gui`` is required to interact wit the :guilabel:`Tomcat Manager` used to deploy and monitor Boundless Suite web applications.

#. Memory ...

#. Additional :guilabel:`Java Options` to optimize memory management for the larger requests expected when working with geospatial data.::
          
          -XX:SoftRefLRUPolicyMSPerMB=36000
          -XX:-UsePerfData
