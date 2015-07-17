.. _sysadmin.cloudwatch:

Monitoring GeoServer with CloudWatch
------------------------------------

CloudWatch is a monitoring service provided on Amazon Web Services. Using the `geoserver-cloudwatch` extension enables GeoServer to send performance metrics to CloudWatch.

#. Install `geoserver-cloudwatch`:
  * Ubuntu Linux: `apt-get install geoserver-cloudwatch`
  * RedHat/Centos Linux: `yum install geoserver-cloudwatch`
  * MacOS: ????
  * Windows: ????

#. Edit :file:`/usr/share/tomcat7/setenv.sh` and add the following block:
  .. code-block:: bash
    ### Interval in milliseconds at which to send metrics
    #GS_CW_INTERVAL=10000

    ### AWS Authentication
    export AWS_ACCESS_KEY_ID=MY_KEY        # EDIT THIS
    export AWS_SECRET_KEY=MY_SECRET_KEY    # EDIT THIS

    ### Instance specific settings
    export GS_CW_ENABLE_PER_INSTANCE_METRICS=true
    #export GS_CW_INSTANCE_ID=hal9000    # This overrides the AWS instance identifier

    ### EC2 Autoscaling
    #export GS_CW_AUTOSCALING_GROUP_NAME=testgroup

    ### JMX metrics
    #export GS_CW_JMX=true

    ### Geoserver metrics
    #export GS_CW_WATCH_WMS=true
    #export GS_CW_WATCH_WPS=true
    #export GS_CW_WATCH_WFS=true
    #export GS_CW_WATCH_CSW=true
    #export GS_CW_WATCH_OSW=true
    #export GS_CW_WATCH_WCS100=true
    #export GS_CW_WATCH_WCS111=true
    #export GS_CW_WATCH_WCS20=true
  Insert the AWS credentials.
  Uncomment (remove the leading '#') any metrics that you want to enable.
  Edit GS_CW_INSTANCE_ID if your server isn't running in EC2 or if you desire to override the instance ID.
  Set the GS_CW_AUTOSCALING_GROUP_NAME if the server is part of an EC2 autoscaling group.

#. Restart GeoServer

#. After a few minutes, confirm that metrics are being pushed to CloudWatch. You can access the CloudWatch panel at ``https://console.aws.amazon.com/cloudwatch/home``. Use the pulldown menu on the left to select :guilabel:`geoserver`. There should now be a list of metrics. Click on the checkboxes to add or remove them to the chart.
.. figure:: img/cloudwatch_panel.png
   :align: center
You can now monitor the load on your GeoServer instance or enable alarms to notify you of extreme events.