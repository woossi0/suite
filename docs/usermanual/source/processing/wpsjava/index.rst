.. _processing.wpsjava:

Creating WPS processes with Java
================================

A Web Processing Service (WPS) process is able to perform almost any kind of computation.  The OpenGeo Suite comes with many built in WPS processes in GeoServer, however, the real power in WPS is in its extensibility.  This section will describe how to create a new WPS process in Java, as well as how deploy it.

Overview
--------

A WPS process is a **Java class** that provides an ``execute`` method. The ``execute`` method accepts parameters which correspond to the WPS parameters, and it returns a value which becomes the output of the process.  The class must also provide metadata to specify things like the process name and description, as well as the names and descriptions of the process parameters.  The class is instantiated each time it is called, so the class can contain state (instance variables) if required.

.. todo:: An diagram of this would be excellent.  

GeoTools, a set of Java libraries underlying GeoServer, provides a convenient framework for building process classes with a minimum of boilerplate code.  Some benefits to  GeoTools are:

* uses Java annotations to specify the metadata
* infers the types of process parameters and outputs via reflection
* automatically handles the complex interplay between XML representations and Java objects at runtime

GeoServer includes many useful libraries that can be leveraged in a process, in addition to the full set of GeoTools libraries.  A process can also use external Java libraries if necessary, but if so, the external libraries will need to be specifically deployed along side the process.

To create a custom WPS process, you will need to create a new Java project, either with an `IDE <http://en.wikipedia.org/wiki/Integrated_development_environment>`_ or from the command line. This tutorial will assume that you are using `Eclipse <http://www.eclipse.org>`_, a very popular IDE.  Others, like `Netbeans <http://www.netbeans.org>`_, `IntelliJ IDEA <http://www.jetbrains.com/idea/>`_, or (for the brave) purely command-line Java tools can work just as well.

`Maven <http://maven.apache.org>`_ will also be used to build GeoTools and GeoServer, and is recommended for dependency management and project building.  


About the process
-----------------

We will create a process called ``gs:splitPolygon`` in a class called ``wps-demo``.  This process will split a polygon by a line.  Both the line and the polygon will be inputs, and the result will be a multipolygon?

.. todo:: Is ``wps-demo`` a class, a package, or something else?

.. todo:: Are the input and output geometries written above correct?


Create the Java Project
-----------------------

First, use Maven to create the project.  In order to do that, we'll use the `Maven Archetype plugin <http://maven.apache.org/archetype/maven-archetype-plugin/>`_, a Maven project templating toolkit. As a custom WPS process is packaged as a regular JAR file, no special configuration is necessary for this project.  Type the following on a console:

.. code-block:: console

   mvn archetype:generate

This will start the generation of the project, including the creation of a valid Maven POM (:file:`pom.xml`) file describing the project.  As this is a simple project, you shouldn't have to choose any special number from the list of available archetypes. You should however, fill out the project metadata as follows:

.. todo:: List of available archetypes?  Screenshot of this?

.. code-block:: console

   groupId: org.opengeo.suite.extension.wps
   artifactId: wps-demo
   version: 1.0-SNAPSHOT
   package: org.opengeo.suite.extension.wps.gs

.. note:: The rightmost part of the package name defines the **namespace** of the WPS process being created (``gs`` in this case, a pre-existing namespace in GeoServer).  

You should end up with a project named ``wps-demo``, inside which you will be able to find the POM file. Add the following dependencies to this file:

.. code-block:: xml

   <dependency>
      <groupId>org.geotools</groupId>
      <artifactId>gt-process</artifactId>
      <version>8-SNAPSHOT</version>
   </dependency>
   <dependency>
      <groupId>org.geotools</groupId>
      <artifactId>gt-geometry</artifactId>
      <version>8-SNAPSHOT</version>
    </dependency>

.. todo:: This version number above seems wrong.  The number in the About GeoServer on the hosted Suite instance is ``2.7-SNAPSHOT (rev -1)``.  Should it be ``2.8-SNAPSHOT`` in the code?

Please ensure that the GeoTools version matches the one used by the OpenGeo Suite. You can check the version of GeoServer and GeoTools by clicking on the :guilabel:`About Geoserver` section at the bottom of the :guilabel:`About & Status` section of the `GeoServer Web Admin Interface <../../../geoserver/webadmin/>`_.

.. todo:: Yes, the above link will be wrong for a while.

.. figure:: img/gt-version.png

   *GeoServer showing GeoTools version 2.7-SNAPSHOT*

The entire POM file should look like this:

.. code-block:: xml

 <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>org.opengeo.suite.extension.wps</groupId>
  <artifactId>wps-demo</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>jar</packaging>

  <name>wps-demo</name>
  <url>http://maven.apache.org</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>org.geotools</groupId>
      <artifactId>gt-process</artifactId>
      <version>8-SNAPSHOT</version>
    </dependency>
    <dependency>
      <groupId>org.geotools</groupId>
      <artifactId>gt-geometry</artifactId>
      <version>8-SNAPSHOT</version>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
  <repositories>
   <repository>
    <id>opengeo</id>
      <url>http://repo.opengeo.org</url>
   </repository>
  </repositories>
 </project>

Now that we have the project definition and dependencies set up, we can create the Eclipse project by going into the :file:`wps-demo` directory and issuing the following command:

.. code-block:: console

  mvn eclipse:eclipse

.. todo:: The following sentence is unclear.  What context is "workspace" being used here?

This will create an Eclipse Java project that we can import into a workspace in order to start working on the code. The initial project structure should look like this:

.. figure:: img/project-structure.png

   *Initial Eclipse project structure*


Create custom functionality
---------------------------

The previous steps have created a package, ``org.opengeo.suite.extension.wps.gs``, where inside we will implement the custom WPS functionality.  Next, create another package that will contain helper methods for our functionality, called ``org.geotools.geometry.jts``.

.. todo:: Where is this done?  What are we creating?  Why is it called ``org.geotools.geometry.jts``?  Should say more here.

Next add a class called ``PolygonTools`` with the following code.  This class contains two methods: one to polygonize a set of Geometries (``polygonize(Geometry geometry)``) and one to split a polygon with a line (``splitPolygon(Geometry poly, Geometry line)``).

.. code-block:: java
  
  package org.geotools.geometry.jts;

  import java.util.ArrayList;
  import java.util.Collection;
  import java.util.List;

  import com.vividsolutions.jts.geom.Geometry;
  import com.vividsolutions.jts.geom.GeometryFactory;
  import com.vividsolutions.jts.geom.Polygon;
  import com.vividsolutions.jts.geom.util.LineStringExtracter;
  import com.vividsolutions.jts.operation.polygonize.Polygonizer;

  public class PolygonTools {

    public static Geometry polygonize(Geometry geometry) {
        List lines = LineStringExtracter.getLines(geometry);
        Polygonizer polygonizer = new Polygonizer();
        polygonizer.add(lines);
        Collection polys = polygonizer.getPolygons();
        Polygon[] polyArray = GeometryFactory.toPolygonArray(polys);
        return geometry.getFactory().createGeometryCollection(polyArray);
    }

    public static Geometry splitPolygon(Geometry poly, Geometry line) {
        Geometry nodedLinework = poly.getBoundary().union(line);
        Geometry polys = polygonize(nodedLinework);

        // Only keep polygons which are inside the input
        List output = new ArrayList();
        for (int i = 0; i < polys.getNumGeometries(); i++) {
            Polygon candpoly = (Polygon) polys.getGeometryN(i);
            if (poly.contains(candpoly.getInteriorPoint())) {
                output.add(candpoly);
            }
        }
        return poly.getFactory().createGeometryCollection(GeometryFactory.toGeometryArray(output));
    }
  }


With this class in place, now we can implement a WPS process. Create a class called ``SplitPolygonProcess`` that will have a method called ``execute``, and add it to ``org.geotools.process.geometry.gs`` with the following code:

.. todo:: Is all of the above done in the following code, or are there other steps not explicitly done?

.. code-block:: java 

  package org.geotools.process.geometry.gs;

  import org.geotools.geometry.jts.PolygonTools;
  import org.geotools.process.factory.DescribeParameter;
  import org.geotools.process.factory.DescribeProcess;
  import org.geotools.process.factory.DescribeResult;
  import org.geotools.process.gs.GSProcess;

  import com.vividsolutions.jts.geom.Geometry;

  /**
   * Splits a Polygon (which may contain holes) by a LineString.
   *  
   */

  @DescribeProcess(title = "splitPolygon",
  		   description = "Splits a Polygon (which may contain holes) by a LineString")
  public class SplitPolygonProcess implements GSProcess {

    @DescribeResult(name = "result", description = "The collection of result polygons")
    public Geometry execute(
          @DescribeParameter(name = "polygon", description = "The polygon to be split") Geometry poly,
          @DescribeParameter(name = "line", description = "The line to split by") Geometry line)
          throws Exception {
        return PolygonTools.splitPolygon(poly, line);
    }
  }

.. todo:: This code has very long lines.  Can you adjust it so that it gives better output?  Maybe fewer indents?  I don't want to mess it up accidentally.

The ``execute`` method takes two parameters of the Geometry type: a polygon to be split and the line that will split the polygon.

There is also some metadata embedded with the source code by using Java annotations.  This provides the process metadata to be included with the WPS capabilities document.  The metadata parameters are the following:

* ``DescribeProcess`` - gives the WPS process a name and a short description of what it does
* ``DescribeResult`` - gives a short description of the expected outcome of executing this process
* ``DescribeParameter`` - for each input parameter that the execute method accepts,  provides the name that will be exposed in the capabilities document, as well as a short description of what this parameter is

The ``execute`` method contains the logic of the WPS process and will be called when the input request is parsed and sent to the WPS module. In this case, we are wrapping a simple method in an auxiliary class:

     ``PolygonTools.splitPolygon(poly, line);``

.. todo:: Input request?  Please say more.


Configure GeoServer
-------------------

The process is now ready to be deployed, but GeoServer needs to be instructed on how to access these classes when required.

.. todo:: Please provide a link to Dependency Injection.  I couldn't find a good one.

.. todo:: Spring Beans?  What are those?  Not referenced anywhere here.

.. todo:: Is there a better phrase to use than "start up"?  "deploy" "build" "generate" "access"?

GeoServer uses the Dependency Injection mechanism present in its `Spring Framework <http://www.springsource.org/spring-framework/>`_, allowing it to only start up components that are going to be used. For GeoServer to pick up new Spring Beans, we need to configure their names and classes where their functionality resides. Add the following :file:`applicationContext.xml` file in :file:`src/main/resources` to achieve this:

.. todo:: src/main/resources of where?

.. code-block:: xml

  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">
  <beans>
    <bean id="splitPolygon" class="org.opengeo.suite.extension.wps.gs.SplitPolygonProcess"/>
  </beans>

Your final project structure should look something like this:

.. figure:: img/final-project-structure.png

   *Final Eclipse project structure*


Build, deploy, and test
-----------------------

In order to build your custom process, run the following command from the root of your project:

.. code-block:: console
  
  mvn clean install

This will clean previous runs, compile your code, execute any unit tests that you might have created (which is highly recommended, by the way), and create a JAR file in the :file:`target` directory.

.. todo:: We should either say more about creating unit tests here, or not mention them at all, as it seems odd to mention them here and here only.

.. todo:: What will the file be called?

Copy this JAR file inside the ``webapps/geoserver/WEB-INF/lib`` directory and then restart GeoServer.  Once GeoServer is running again, you can verify that the new process was deployed successfully by running the WPS Request Builder.  The WPS Request Builder is a utility that can run tests of existing WPS processes through the UI.  You can access this utility by navigating to the :guilabel:`WPS Request Builder` inside the :guilabel:`Demos` section of the `GeoServer Web Admin Interface <../../../geoserver/webadmin/>`_.  

Once in the WPS request builder, select the process called ``gs:splitPolygon`` from the dropdown. The request builder will generate the necessary interface to be able to test the process, based on the parameters and expected outputs described in the capabilities of the process.

.. todo:: Would be nice to have a screenshot of the WPS request builder with the new process in the drop down selected.

An example of a request using the WPS Request Builder with our custom Split Polygon WPS process is shown below, taking a polygon and a line as parameters to the request

.. figure:: img/request-builder.png

   *Newly created process in WPS request builder*

.. todo:: Output?  Result?  Visualizations?  Some final piece here would be good.

.. todo:: web-project-config.png was unlinked in this doc.  Should it be?