/*
Boundless Server release bundler.
POC- Nick Stires

Build requirements:
(none)

Source repos:
* https://github.com/boundlessgeo/suite

Artifacts out:
WORKSPACE/archive/
*/

pipeline {

  agent {
    label 'jenkins-slave-01.boundlessgeo.com'
  }

  stages {
  	stage('Prep') {
      steps {
        makeDir("$WORKSPACE/archive/")
        setEnvs()
        prepStage()
      }
    }

    stage('Bundle') {
      steps {
        script {
          productPackages = ['composer', 'dashboard', 'docs', 'geoserver', 'geowebcache', 'gs-appschema', 'gs-arcsde', 'gs-cloudwatch', 'gs-cluster', 'gs-csw', 'gs-db2', 'gs-gdal', 'gs-geogig', 'gs-geomesa-accumulo', 'gs-grib', 'gs-gsr', 'gs-inspire', 'gs-jdbcconfig', 'gs-jdbcstore', 'gs-jp2k', 'gs-mongodb', 'gs-netcdf', 'gs-netcdf-out', 'gs-oracle', 'gs-printng', 'gs-script', 'gs-sqlserver', 'gs-vectortiles', 'wpsbuilder', 'quickview']
          for (int i = 0; i < productPackages.size(); i++) {
            gatherProduct("${productPackages[i]}")
          }
        }

        script {
          tomcatPackages = ['tomcat8', 'tomcat8-manager']
          for (int i = 0; i < tomcatPackages.size(); i++) {
            gatherTomcat("${tomcatPackages[i]}")
          }
        }

        gatherDependencies()
        gatherGroupDescriptors()
        gatherWARs()
        zipBundle()
      }
    }

    stage('Fetch') {
      steps {
        fetch()
        archiveArtifacts artifacts: "archive/*", fingerprint: true
      }
    }

    stage('Cleanup') {
      steps {
        cleanup()
      }
    }
  }
}

def makeDir(def dir) {
  dirCheck = sh (script: "test -d ${dir} && echo '1' || echo '0' ", returnStdout: true).trim()
  if (dirCheck=='1') {
    echo "Cleaning contents of following directory: $dir"
    sh "rm -rf $dir"
  }
  sh "mkdir -p $dir"
}

def setEnvs() {
  env.DATE_TIME_STAMP = sh (script: "date +%Y%m%d%H%M", returnStdout:true).trim()
  env.BRANDING = 'boundless-server'
  env.ARCHIVE_BASENAME = 'BoundlessServer'
  env.SERVER_VERSION = sh (script: "grep server.version= $WORKSPACE/suite/build/build.properties | sed 's:server.version=::'", returnStdout: true).trim()
  env.SOURCE_ROOT = "/var/www/repo/suite/stable"
  env.STAGE = "${ARCHIVE_BASENAME}-${SERVER_VERSION}-${DATE_TIME_STAMP}"
  env.EL6_STAGE = "/tmp/${STAGE}/el/6/x86_64"
  env.EL7_STAGE = "/tmp/${STAGE}/el/7/x86_64"
  env.TRUSTY_STAGE = "/tmp/${STAGE}/ubuntu/deb/14"
  env.XENIAL_STAGE = "/tmp/${STAGE}/ubuntu/deb/16"
  env.WAR_STAGE = "/tmp/${STAGE}/wars"
}

def prepStage() {
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      mkdir -p ${EL6_STAGE}
      mkdir -p ${EL7_STAGE}
      mkdir -p ${TRUSTY_STAGE}
      mkdir -p ${XENIAL_STAGE}
      mkdir -p ${WAR_STAGE}
    '
  """
}

def gatherProduct(def product) {
  packageFileEL6 = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/el/6/${BRANDING}-${product}-${SERVER_VERSION}* | sort -rV | head -1'", returnStdout:true).trim()
  packageFileEL7 = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/el/7/${BRANDING}-${product}-${SERVER_VERSION}* | sort -rV | head -1'", returnStdout:true).trim()
  packageFileTrusty = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/ubuntu/14/${BRANDING}-${product}_${SERVER_VERSION}* | sort -rV | head -1'", returnStdout:true).trim()
  packageFileXenial = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/ubuntu/16/${BRANDING}-${product}_${SERVER_VERSION}* | sort -rV | head -1'", returnStdout:true).trim()
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      cp -p ${packageFileEL6} ${EL6_STAGE}
      cp -p ${packageFileEL7} ${EL7_STAGE}
      cp -p ${packageFileTrusty} ${TRUSTY_STAGE}
      cp -p ${packageFileXenial} ${XENIAL_STAGE}
    '
  """
}

def gatherTomcat(def tomcat) {
  packageFileEL6 = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/el/6/${BRANDING}-${tomcat}-[0-9]* | sort -rV | head -1'", returnStdout:true).trim()
  packageFileEL7 = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/el/7/${BRANDING}-${tomcat}-[0-9]* | sort -rV | head -1'", returnStdout:true).trim()
  packageFileTrusty = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/ubuntu/14/${BRANDING}-${tomcat}_[0-9]* | sort -rV | head -1'", returnStdout:true).trim()
  packageFileXenial = sh (script: "ssh root@priv-repo.boundlessgeo.com 'ls ${SOURCE_ROOT}/ubuntu/16/${BRANDING}-${tomcat}_[0-9]* | sort -rV | head -1'", returnStdout:true).trim()
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      cp -p ${packageFileEL6} ${EL6_STAGE}
      cp -p ${packageFileEL7} ${EL7_STAGE}
      cp -p ${packageFileTrusty} ${TRUSTY_STAGE}
      cp -p ${packageFileXenial} ${XENIAL_STAGE}
    '
  """
}

def gatherDependencies() {
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      shopt -s extglob
      cp -p ${SOURCE_ROOT}/el/6/!(${BRANDING}*) ${EL6_STAGE}
      cp -p ${SOURCE_ROOT}/el/7/!(${BRANDING}*) ${EL7_STAGE}
      cp -p ${SOURCE_ROOT}/ubuntu/14/!(${BRANDING}*) ${TRUSTY_STAGE}
      cp -p ${SOURCE_ROOT}/ubuntu/16/!(${BRANDING}*) ${XENIAL_STAGE}
    '
  """
}

def gatherGroupDescriptors() {
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      shopt -s extglob
      cp -p ${SOURCE_ROOT}/el/6/*.xml $EL6_STAGE
      cp -p ${SOURCE_ROOT}/el/7/*.xml $EL7_STAGE
    '
  """
}

def gatherWARs() {
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      cp -p ${SOURCE_ROOT}/war/* $WAR_STAGE
    '
  """
}

def zipBundle() {
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      cd /tmp
      tar -czpf ${STAGE}.tgz ${STAGE}
    '
  """
}

def fetch() {
  sh """
    scp root@priv-repo.boundlessgeo.com:/tmp/${STAGE}.tgz ${WORKSPACE}/archive/
  """
}

def cleanup() {
  sh """
    ssh root@priv-repo.boundlessgeo.com '
      cd /tmp
      rm -rf ${STAGE}
      rm -f ${STAGE}.tgz
    '
  """
}
