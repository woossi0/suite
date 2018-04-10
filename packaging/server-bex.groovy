/*
Boundless Server for Boundless Exchange.
POC- Nick Stires

Build requirements:
* nvm
* npm
** 2.15.9 (default)
** 6.11.3 (available)

Source repos:
* https://github.com/boundlessgeo/suite
* https://github.com/boundlessgeo/exchange

Artifacts out:
WORKSPACE/archive/
*/

pipeline {

  agent {
    label 'jenkins-slave-01.boundlessgeo.com'
  }

  stages {
  	stage('Init') {
      steps {
        makeDir("$WORKSPACE/archive/")
        setEnvs()
        gitCheckoutRecursive()
        gitCheckout('exchange','master')

        antBuild('suite/build/versions.xml','set-versions')
      }
    }

    stage('Build') {
      steps {
        antBuild('suite/geoserver/webapp/build.xml','clean build assemble publish')
      }
    }

    stage('Package') {
      steps {
        script {
          sh """
            unzip /var/www/server/core/${BEX_BRANCH}/master/geoserver/boundless-server-geoserver-latest.zip -d $WORKSPACE/archive/
            mv $WORKSPACE/archive/geoserver.war $WORKSPACE/archive/geoserver_bex_${ARTIFACT_VERSION}.war
          """
        }
        archiveArtifacts artifacts: "archive/geoserver_bex_*.war", fingerprint: true
      }
    }

    stage('Docker') {
      steps {
        script {
          sh """
            cd $WORKSPACE/exchange/docker/geoserver/
            docker build -t quay.io/boundlessgeo/bex-geoserver-k8s:latest-${ARTIFACT_VERSION} .
            docker push quay.io/boundlessgeo/bex-geoserver-k8s:latest-${ARTIFACT_VERSION}
          """
        }
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
  env.GS_MAJOR_VERSION = sh (script: "grep gs.major_version suite/build/build.properties | sed 's|gs.major_version=||'", returnStdout: true).trim()
  env.SERVER_VERSION = sh (script: "grep server.version= $WORKSPACE/suite/build/build.properties | sed 's:server.version=::'", returnStdout: true).trim()
  env.DATE_TIME_STAMP = sh (script: "date +%Y%m%d%H%M", returnStdout: true).trim()
  env.MINOR_VERSION = "SNAPSHOT${DATE_TIME_STAMP}-${BUILD_NUMBER}"
  env.ARTIFACT_VERSION = "${GS_MAJOR_VERSION}-${SERVER_VERSION}"
  env.SERVER_BUILD_CAT = "master"
  env.BEX_BRANCH = sh (script: "cd suite; git show -s --pretty=%d HEAD | sed 's| (HEAD, origin/||' | sed 's|)||'", returnStdout: true).trim()
}

def gitCheckout(def repo, def branch) {
  sh """
    rm -rf $repo
    git clone "git@github.com:boundlessgeo/${repo}.git"
    cd $repo
    git checkout $branch
  """
}

def gitCheckoutRecursive() {
  sh """
    cd $WORKSPACE/suite
    git reset --hard HEAD
    git submodule foreach git reset --hard HEAD || true
    git submodule update --init --recursive
  """
}

def antBuild(def buildFile, def antTargets) {
  workingDir = sh (script: "echo ${buildFile} | rev | cut -d / -f2- | rev", returnStdout:true).trim()
  antBuildFile = sh (script: "echo ${buildFile} | rev | cut -d / -f 1 | rev", returnStdout:true).trim()
  echo "workingDir = ${workingDir}"
  echo "antBuildFile = ${antBuildFile}"
  sh """
    cd $WORKSPACE/${workingDir}
    ant -v -file ${antBuildFile} \
    -Dsuite.minor_version=-$MINOR_VERSION \
    -Dsuite.build_cat=$SERVER_BUILD_CAT \
    -Dserver.build_cat=$SERVER_BUILD_CAT \
    -Dsuite.version=$SERVER_VERSION \
    -Dserver.version=$SERVER_VERSION \
    -Dgeonode=true \
    $antTargets
  """
}
