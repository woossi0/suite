.. _dataadmin.importer.apireference:

.. warning:: Document status: **Requires Technical Review (JD)**

Layer Importer REST API reference
=================================

The GeoServer Layer Importer :term:`REST` :term:`API` provides a CRUD interface (create, read, update, delete) for importing data. The following section describes the Layer Importer REST API model.

Representations
---------------

All entities in this API are represented as :term:`JSON`.

.. _imports:


Imports
^^^^^^^

.. _import_collection:

An import is the top level object of the Layer Importer API model. 

.. figure:: img/REST_dm.png

   *Layer Importer REST API model*

An import collection is represented with the following structure:

.. code-block :: json

   {
     "imports": [
       {
         "id": 0,
         "href": "http://<host>:<port>/geoserver/rest/imports/0"
       }, 
       {
          "id": 1,
          "href": "http://<host>:<port>/geoserver/rest/imports/1"
        }, 
       ...
      ]
     }

Each object in the ``imports`` array has the following attributes:

* id—Globally unique identifier for the import
* href—URI pointing to the import

.. _import:

An individual import is represented with the following structure:

.. code-block :: json

	 {
	   "import": {
	     "id": 1
	     "tasks": [
	        //array of task objects
	     ] 
	   }
	 }

An ``import`` object has the following attributes:

* id—Globally unique identifier for the import.
* state—Current state of the import. See :ref:`import states <import_state>`. 
* tasks—:ref:`tasks <tasks>` that compose the import

.. _import_state:

An import may be in one of the following states:

* PENDING—Initial state for an import indicating that the import is newly created and yet to be processed
* READY—Import has been processed without issue and is ready to be executed
* RUNNING—Import is currently executing
* INCOMPLETE—Import can't be processed due to one or more tasks being incomplete - see :ref:`task states <task_state>`
* COMPLETE—Import has executed successfully

.. _tasks:


Tasks
^^^^^

A task represents a unit of work within an import operation. An individual ``task`` is represented with the following structure:

.. code-block:: json

	 {
	   "task": {
		 "id": <taskId>,
		 "state": "<state>", 
		 "href": "http://<host>:<port>/geoserver/rest/imports/<importId>/tasks/<taskId>", 
		 "source": {
		    // source representation, see below
		 },
	     "target": {
	        // store representation from GeoServer restconfig
	     }, 
	     "items": [
	        // array of item objects
	     ]
	   }
	 }

A ``task`` object has the following attributes:

* id—Unique identifier for the task (relative to the containing import)
* state—Current state of the task - see :ref:`task states <task_state>`
* href—URI pointing to the task
* source—Data to be imported - see :ref:`task source <task_source>`
* target—Store the data for task will be imported into - see :ref:`task target <task_target>`
* items—:ref:`Items <items>` that are part of the task

.. _task_state:

A task may be in one of the following states:

* PENDING—Initial state for an task, indicating that the task is newly created and yet to be processed
* READY—Task has been processed without issue and is ready to be executed
* RUNNING—Task is currently executing
* INCOMPLETE—Task can't be processed due to one or more items being incomplete - see :ref:`item state <item_state>`
* COMPLETE—Task has executed successfully

.. _task_source:

Source
""""""

The source of a task is the data that will be imported. The structure of the source is dependent on the type of source. The different source types are:

* file—Single file (Shapefile, GeoTIFF, and so on)
* directory—Directory of files
* database—Relational database

A ``source`` object is represented with the following structure:

.. code-block:: json

   {
     "source": {
          "type": "file"
          "format": "<Shapefile|GeoTIFF|PostGIS|...>", 
             // source specific attributes
        }
   }

All ``source`` objects have the following attributes:

* type—Data source type
* format—Data type or format of the source

.. _source_file:

Specific import sources have additional attributes. A ``file`` import source has the following attributes:

* file—Primary spatial file
* prj—Supplementary ``.prj`` file defining the projection of the data
* other—Additional files that supplement the primary file. For example, shapefiles include
  ``.dbf`` and ``.shx`` files.
* location—Path of directory containing the file

A ``directory`` source has the following attributes:

* location—Path of the directory
* files—Array of file objects - see :ref:`source files <source_file>`

.. _task_target:

Target
""""""

The target of a task is the destination store (data store, coverage store, and so on) that the task data source will import into. The structure of the target is dependent on the type store, which in turn depends on the type of data source. For vector data, the data store target is represented as follows.

.. code-block:: json

   {
     "target": {
        "dataStore": {
           // same representation as GeoServer restconfig
        }
     }
   }

Similarly, for raster data the target is represented as a coverage store target.

.. code-block:: json 

   {
     "target": {
        "coverageStore": {
           // same representation as GeoServer restconfig
        }
     }
   }

.. _items:

Items
^^^^^

An item represents a layer or resource to be imported as part of a task. An individual ``item`` is represented with the following structure.

.. code-block:: json 

	 {
	   "item": {
	     "id": <itemId>, 
	     "state": "COMPLETE", 
	     "href": "http://<host>:<port>/geoserver/rest/imports/<importId>/tasks/<taskId>/items/<itemId>", 
	     "layer": {
	        // same representation as GeoServer restconfig
	     },
	     "resource": {
	        // same representation as GeoServer restconfig
	     } 
	   }
	 }

An ``item`` object has the following attributes:

* id—Unique identifier for the item, relative to the containing task
* state—Current state of the item 
* href—URI pointing to the item
* layer—Geoserver layer that publishes the item after it has been imported
* resource—Underlying resource for the publishing layer

.. _item_state:

An item may be in one of the following states:

* PENDING—Initial state for an item, indicating that the task is newly created and yet to be processed
* READY—Item has been processed without issue and is ready to be executed
* RUNNING—Item is currently executing
* NO_CRS—Projection for the item could not be determined from the data
* NO_BOUNDS—Spatial extent of the item could not be determined from the data or is too expensive to compute
* ERROR—Error occurred during import execution
* COMPLETE—Item has executed successfully

If an item is in a ``NO_CRS`` or ``NO_BOUNDS`` state, then the client should modify the item configuration (via PUT) with the necessary information. 

.. _item_layer:

Layer
"""""

The layer of an item represents the GeoServer configuration that will be used to publish the data. A layer is represented in the same way as in the GeoServer RESTful configuration API (restconfig).

.. code-block:: json

  {
    "layer": {
      "layer": {
        "name": "<layerName>",
        "type": "<VECTOR|RASTER>",
        "defaultStyle": {
           // same representation as GeoServer restconfig
       } 
     }
  }

.. _item_resource:

Resource
""""""""

The resource of an item represents the data configuration underlying the layer/publishing configuration discussed above. The type of resource depends on the type of data. The resource of a vector item is a feature type, whereas the resource of a raster item is a coverage. A resource is represented in the same way as in the GeoServer RESTful configuration API (restconfig).

.. code-block:: json

   {
     "resource": {
       "featureType": {
         "name": "...", 
         "nativeName": "...", 
         "title": "...", 
         "srs": "...", 
         "nativeCRS": {...}, 
         "projectionPolicy": "...", 
         "n ativeBoundingBox": {...}, 
         "latLonBoundingBox": {...},
         ...
       }
     }
   }
   {
     "resource": {
       "coverage": {
         "name": "...", 
         "nativeName": "...", 
         "title": "...", 
         "srs": "...", 
         "nativeCRS": {...}, 
         "projectionPolicy": "...", 
         "nativeBoundingBox": {...}, 
         "latLonBoundingBox": {...},
         ...
         "dimensions": {...},
         "interpolationMethods": {...},
         ...
       }
     }
   }

Operations
----------

Imports
^^^^^^^

/imports
""""""""

.. list-table::
   :header-rows: 1

   * - Method
     - Action
     - Status Code/Headers
     - Input
     - Output
   * - GET
     - Retrieve all imports
     - 200
     - n/a
     - :ref:`Import Collection <import_collection>`
   * - POST
     - Create a new import
     - 201 with Location header
     - n/a
     - :ref:`Imports <import>`

/imports/<importId>
"""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - Method
     - Action
     - Status Code/Headers
     - Input
     - Output
   * - GET
     - Retrieve import with id <importId>
     - 200
     - n/a
     - :ref:`Imports <import>`
   * - POST
     - Execute import with id <importId>
     - 204
     - n/a
     - n/a
   * - PUT
     - Create import with proposed id <importId>. If the proposed id is
       ahead of the current (next) id, the current id will be advanced. If the
       proposed id is less than or equal to the current id, the current will be
       used. This allows an external system to dictate the id management.
     - 201 with Location header
     - n/a
     - :ref:`Imports <import>`
   * - DELETE
     - Remove import with id <importId>
     - 200
     - n/a
     - n/a

Tasks
^^^^^

/imports/<importId>/tasks
"""""""""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - Method
     - Action
     - Status Code/Headers
     - Input
     - Output
   * - GET
     - Retrieve all tasks for import with id <importId>
     - 200
     - n/a
     - Task Collection <tasks>`
   * - POST
     - Create a new task
     - 201 with Location header
     - :ref:`Multipart form data <file_upload>`
     - :ref:`Tasks <tasks>`

.. _file_upload:

To create a new task within an import, a client may upload file(s) to the ``tasks`` collection
via a multipart form. The ``Content-Type`` header should have a value of "multipart/form-data"
(optionally with a subtype). 

/imports/<importId>/task/<taskId>
"""""""""""""""""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - Method
     - Action
     - Status Code/Headers
     - Input
     - Output
   * - GET
     - Retrieve task with id <taskId> within import with id <importId>
     - 200
     - n/a
     - `Task <task>`
   * - PUT
     - Modify task with id <taskId> within import with id <importId>
     - 200
     - `Task <tasks>`
     - `Task <tasks>`
   * - DELETE
     - Remove task with id <taskId> within import with id <importId>
     - 200
     - n/a
     - n/a

Items
^^^^^

/imports/<importId>/tasks/<taskId>/items
""""""""""""""""""""""""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - Method
     - Action
     - Status Code/Headers
     - Input
     - Output
   * - GET
     - Retrieve all items within import/task <importId>/<taskId>
     - 200
     - n/a
     - :ref:`Item Collection <items>`

/imports/<importId>/tasks/<taskId>/items/<itemId>
"""""""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - Method
     - Action
     - Status Code/Headers
     - Input
     - Output
   * - GET
     - Retrieve item with id <item> within import/task <importId>/<taskId>
     - 200
     - n/a
     - :ref:`Item <items>`
   * - PUT
     - Modify task with id <itemId> within import/task <importId>/<taskId>
     - 200
     - :ref:`Item <items>`
     - :ref:`Item <items>`
   * - DELETE
     - Remove item with id <itemId> within import/task <importId>/<taskId>
     - 200
     - n/a
     - n/a







