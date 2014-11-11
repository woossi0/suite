Upgrade
=======


Upgrade to Enterprise
---------------------

An upgrade to Suite 4.5 can be performed in place.

#. Download the additional *Composer* component.

#. Download the replacement:
   
   * dashboard.war
   * geoserver.war
   * opengeo-docs
   
#. Stop Tomcat

#. Remove the following files and directories:
   
   * webapps/dashboard.war
   * webapps/dashboard
   * webapps/opengeo-docs

#. Unpack the dashboard and documentation replacements into webapps:

   * dashboard.war
   * opengeo-docs

#. Unzip into composer.zip into the existing :file:`webapps/geoserver` folder

#. Restart Tomcat

#. Verify that dashboard contains an entry for *Composer* and that the link functions.

