# Boundless Server Packaging

Scripts and configuration used to build the packages for Boundless Server

## Directory

* `docker/` - Scripts and configuration for creating a docker image of Boundless Server. See the [README](./docker/README.md) for details.
* `el/` - Configuration for constructing Enterprise Linux (CentOS/RHEL) packages. All `.spec` files can be found in `el/SPECS`.
* `licenses/` - License files that are included in packages where applicable
* `slack_notif/` - Utilities for sending Slack notifications from Jenkins
* `tomcat-context/` - Tomcat configuration files used for the various WAR packages inlcuded in Boundless Server. The servlet context paths for each application are configured here.
* `ubuntu/` - Configuration for constructung Ubuntu packages. Since the Ubuntu packages are converted from the Enterprise Linux packages, this configuration consists solely of lists of conflicts, depends, and replaces.
* `vm/packer/` - Scripts and configuration for creating the Virtual Machine distribution of Boundless Server. See the [README](./vm/packer/README.md) for details.
* `windows/` - Windows-specific packaging artifacts. Currently unused.
* `bundle_release.sh` - Unused (?)
* `server-bex.groovy` - Jenkins Pipeline configuration for the [Boundless Server for Boundless Exchange build](https://jenkins.boundlessgeo.com/job/Server-BEx-pipeline/) (currently unused). Only builds the main geoserver war, with all applicable extensions included.
* `server-build.groovy` - Jenkins Pipeline configuration for the [main Boundless Server build](https://jenkins.boundlessgeo.com/view/Server/job/Server-multibranch/).
* `server-bundle-release.groovy` - Jenkins Pipeline configuration for the [Boundless Server Release bundle](https://jenkins.boundlessgeo.com/job/Server-release-bundle/).

## Pipeline Build

The main pipeline build is controlled by `server-build.groovy`. It runs on [jenkins.boundlessgeo.com](https://jenkins.boundlessgeo.com/view/Server/job/Server-multibranch/) and builds each active branch.

The build runs through the following steps:

1. Checkout from git, load configuration, and setup workspace.

2. Runs the Boundless Server ant build (split accross multiple steps). Each step also runs a SonarQube scan of the sourcecode

3. Packages the artifacts from the ant build into `BoundlessServer-war.zip` and `BoundlessServer-exts.zip`. These comprise the war distribution.

4. Runs OWASP dependency check on all JARs included WAR distribution.

5. Takes the two zipfiles from the WAR distribution, unzips them, and uses the contents of them plus the spec files in `el/SPECS` to create the Enterprise Linux `.rpm` files. These comprise the CentOS 6 and 7 distributions (The same RPMs are used for the two OSes).

6. Takes the RPMs, and uses [alien](https://github.com/mildred/alien) to convert them to debs. This comprises the Ubuntu 14 and 16 distributions. Note: this step primarily runs on priv-repo.boundlessgeo.com.

7. Copies the final WAR, CentOS, and Ubuntu artifacts to priv-repo.boundlessgeo.com.

8. Builds the Dockerfile in `docker/` and pushes it to [quay.io/boundlessgeo/server](quay.io/boundlessgeo/server).

9. Updates the demo instance on [demo-master.boundlessgeo.com](demo-master.boundlessgeo.com) to use the newly created CentOS packages, and restarts the demo server.

10. Sends a notification to the #suite-bots channel indicating the build is complete, with links to the final artifacts on [priv-repo.boundlessgeo.com.


## Procedures

The packaging config is spread across a number of files. This section covers what must be changed for common update tasks

### Disabe an extension package

For one reason or another, you may want to temporarily disable an extension package.
This can be done by removing the package from the approprate list in [build.properties](../build/build.properties):

* For a core geoserver extension, modify the `gs.exts_core` property.
* For a geoserver community module, modify the `gs.exts_comm` property.
* For a geoserver-exts module, modify the `gs-exts.exts` property.
* For an extension that does not fall into any of these categories (e.g. GSR, GeoMesa), modify the `external.exts` property. In this case, you will also need to comment out the appropriate build step in `server-build.groovy`, as each of these extensions have custom build configuration.

Some extensions (`app-schema`, `hz-cluster`, `python`) get renammed before they are added to the final war. In this case, you will need also need to modify the `packageWars()` section in `server-build.groovy`.

### Delete an extension package

If you need to permanently delete an extension package:

1. Follow the steps for disabling a package, above.

2. Delete the spec file for that package in `el/SPECS/`

3. Remove each mention of that package from all `.esv` files in `ubuntu/`

4. Remove each mention of that package from `server-bundle-release.groovy`

5. In cases where the package is being removed because it is now included in the default `geoserver.war`, add the removed package to the "Conflicts" and "Obsoletes" list in `el/SPECS/boundless-server-geoserver.spec`

### Add an extension package

1. Add the extension name to the approprate list in [build.properties](../build/build.properties):

    * For a core geoserver extension, modify the `gs.exts_core` property.
    * For a geoserver community module, modify the `gs.exts_comm` property.
    * For a geoserver-exts module, modify the `gs-exts.exts` property.
    * For an extension that does not fall into any of these categories (e.g. GSR, GeoMesa), modify the `external.exts` property. In this case, you will also need to add a new build step in `server-build.groovy`, as each of these extensions have custom build configuration.

2. Add a `.spec` file for the new extension package in `el/SPECS`. You can copy the file for an existing extension and modify as applicable (If you do this, you can remove the "Conflics" and "Obsoletes" lines, since this will be a brand new extension with no preexisting packages).

3. Add the new package and its dependencies to each `depends.esv` file under `ubuntu/`.

4. Add the new package to the package list in `server-bundle-release.groovy`.

### Regarding Tomcat

1. To build Tomcat, this step is done manually, outside of the pipeline build job. To build the tomcat rpm, use the [tomcat9.spec file](el/SPECS/boundless-server-tomcat9.spec). The required configuration files are located under [SOURCES](el/SOURCES/)

    * Run `rpmbuild -v -bb --clean tomcat9.spec` to create the rpm package

2. To build deb packages, use the files located under [ubuntu/deb/boundless-server-tomcat9](ubuntu/deb/boundless-server-tomcat9).

    * Run `debian/rules binary` to create the deb package
