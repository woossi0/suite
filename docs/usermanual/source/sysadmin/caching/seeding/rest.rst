.. _sysadmin.caching.seeding.rest:

Seeding a tile cache through the REST API
=========================================

.. warning:: Document status: **Needs Technical Review (MP)**

The tile caching system has a REST API that can start, stop, and monitor seed tasks.

.. note:: Read more about the `GeoWebCache REST API <../../geowebcache/rest/seed.html>`_. 

These examples will use the `cURL <http://curl.haxx.se>`_ utility, though any HTTP-capable tool or library can be used.

.. todo:: Should this page have examples on how to monitor existing tasks? Killing existing tasks?

Request parameters in XML file
------------------------------

#. Construct an XML tag structure with the following format:

   .. code-block:: xml

      <seedRequest>
        <name>LAYERNAME</name>
        <bounds>
          <coords>
            <double>MINX</double>
            <double>MINY</double>
            <double>MAXX</double>
            <double>MAXY</double>
          </coords>
        </bounds>
        <srs><number>SRS</number></srs>
        <zoomStart>START_ZOOM_LEVEL</zoomStart>
        <zoomStop>STOP_ZOOM_LEVEL</zoomStop>
        <format>IMAGE_FORMAT</format>
        <type>OPERATION</type>
        <threadCount>THREADS</threadCount>
      </seedRequest>

   where:

   * ``LAYERNAME``—Fully qualified layer name, including namespace prefix.
   * ``MINX``, ``MINY``, ``MAXX``, ``MAXY``—Minimum and maximum X and Y values for extent. Leave this section out if seeding the entire extent.
   * ``SRS``—SRS code for the layer. Must match a given grid set.
   * ``START_ZOOM_LEVEL``—Lowest zoom level to generate tiles. Usually 0.
   * ``STOP_ZOOM_LEVEL``—Highest zoom level to generate tiles. See :ref:`sysadmin.caching.seeding.considerations` for advice on determining which zoom levels to seed.
   * ``IMAGE_FORMAT``—Image format for tiles.
   * ``OPERATION``—Determines the operation. One of ``seed``, ``reseed``, or ``truncate``. Select :guilabel:`Seed` in most cases.
   * ``THREADS``—Number of concurrent threads to use in the seeding process. Value to use is system-dependent.

   .. todo:: Should say more about number of threads.

#. Save this file and run the following command:

   .. code-block:: console

      curl -v -u ADMINUSER:PASSWORD -XPOST -H "Content-type: text/xml" -T "FILE.xml" "http://GEOSERVER_URL/gwc/rest/seed/LAYERNAME.xml"

   where:

   * ``ADMINUSER``—User name with administrator role
   * ``PASSWORD``—Password for the admin user
   * ``FILE.xml``—File of the XML file created above with optional path
   * ``GEOSERVER_URL``—Location of GeoServer instance (such as `http://localhost:8080/geoserver/``)
   * ``LAYERNAME``—Fully qualified layer name (must match layer name in XML)

The result, if successful should look something like this:

.. code-block:: console

   * About to connect() to localhost port 8080 (#0)
   *   Trying 127.0.0.1...
   * connected
   * Connected to localhost (127.0.0.1) port 8080 (#0)
   * Server auth using Basic with user 'admin'
   > POST /geoserver/gwc/rest/seed/usa:states.xml HTTP/1.1
   > Authorization: Basic YWRtaW46Z2Vvc2VydmVy
   > User-Agent: curl/7.28.0
   > Host: localhost:8080
   > Accept: */*
   > Content-tpye: text/xml
   > Content-Length: 406
   > Expect: 100-continue
   >
   < HTTP/1.1 100 Continue
   * We are completely uploaded and fine
   < HTTP/1.1 200 OK

Parameters directly in request
------------------------------

It is also possible to embed the XML POST request directly in the command. The results should be identical.

#. Construct the XML in the request as follows:

   .. note:: The single command below is wrapped over multiple lines.

   .. code-block:: console
   
      curl -v -u ADMINUSER:PASSWORD -XPOST -H "Content-type: text/xml"
        -d "<seedRequest><name>LAYERNAME</name><bounds><coords><double>MINX</double><double>
        MINY</double><double>MAXX</double><double>MAXY</double></coords></bounds><srs><number>
        SRS</number></srs><zoomStart>START_ZOOM_LEVEL</zoomStart><zoomStop>STOP_ZOOM_LEVEL
        </zoomStop><format>IMAGE_FORMAT</format><type>OPERATION</type><threadCount>THREADS
        </threadCount></seedRequest>" "http://GEOSERVER_URL/gwc/rest/seed/LAYER_NAME.xml"

   where all of the variables are defined as above. Note that ``-d`` is used here, not ``-T`` as used above.

