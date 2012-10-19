.. _sysadmin.caching:

Tile caching
============

Tile caching is the act of saving rendered images of data output from WMS GetMap operations. Using Tile Caching in a deployment can greatly increase the functionality and flexibility of any OpenGeo Suite deployment.

This section will discuss the many considerations to using tile caching in a server deployment.


.. toctree::
   :maxdepth: 2

   seeding/index

::
   georssexpire
   optimization


::

    * Principles
    * best practices, preseeding
    * Metatile discussion, tradeoffs, labeling
    * Optimization (png8's, check GS Paletted images tutorial, etc)
    * Quotas and disk management
    * Automation
      * GWC Job Manager REST API
      * Expiration based on GeoRSS
    * Custom gridsets

