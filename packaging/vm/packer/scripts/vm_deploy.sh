#!/bin/bash
# Script to deploy suite software on fresh Ubuntu Trusty install
# Boundless Internal software
# http://boundlessgeo.com/
# Maintainer- Nick Stires

if [ -z "$1" ]; then
  echo "Incorrect arguements provided."
  echo "Proper use is: vm_deploy.sh <version> <repo_login> <repo_password> <repo_dir>"
  exit 1
else
  SERVER_VERSION=$1
fi

if [ -z "$2" ]; then
  echo "Incorrect arguements provided."
  echo "Proper use is: vm_deploy.sh <version> <repo_login> <repo_password> <repo_dir>"
  exit 1
else
  REPO_LOGIN=$2
fi

if [ -z "$3" ]; then
  echo "Incorrect arguements provided."
  echo "Proper use is: vm_deploy.sh <version> <repo_login> <repo_password> <repo_dir>"
  exit 1
else
  REPO_PASSWORD=$3
fi

if [ -z "$3" ]; then
  echo "Incorrect arguements provided."
  echo "Proper use is: vm_deploy.sh <version> <repo_login> <repo_password> <repo_dir>"
  exit 1
else
  REPO_DIR=$4
fi

echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment

echo "Adding Boundless Test repo..."
echo "deb http://$REPO_LOGIN:$REPO_PASSWORD@priv-repo.boundlessgeo.com/suite/$REPO_DIR/ubuntu/16 ./" > /etc/apt/sources.list.d/boundless.list
apt-get -qq update

echo "Seeding local repository..."
mkdir /opt/boundless-repo
DEBIAN_FRONTEND=noninteractive apt-get install -qq -d -o=dir::cache=/opt/boundless-repo --allow-unauthenticated -y boundless-server-* gdal gdal-mrsid gdal-devel libgeos-dev libgeos-doc libgeotiff-dev libnetcdf-dev libproj-dev netcdf-dbg netcdf-doc pgadmin3 pgadmin3-data pgdg-keyring postgresql-9.6-postgis-2.5 postgis-2.5 postgresql-9.6 postgresql-client-9.6 postgresql-client-common postgresql-common proj proj-bin
sleep 2

echo "Installing local repository tools..."
apt-get install -qq apache2 dpkg-dev
sleep 2

echo "Configuring local repository..."
mkdir -p /var/www/repo/
ln -s /opt/boundless-repo/archives/ /var/www/repo/amd64
cd /var/www/repo/
sudo dpkg-scanpackages amd64 | gzip -9c > amd64/Packages.gz
sleep 2
sed -i 's|/var/www/html|/var/www/repo|' /etc/apache2/sites-available/000-default.conf
sed -i 's|Listen 80|Listen 127.0.0.1:80|' /etc/apache2/ports.conf
/etc/init.d/apache2 restart
echo "deb http://127.0.0.1/ amd64/" > /etc/apt/sources.list.d/boundless.list
apt-get -qq update
sleep 2

echo "Installing core products..."
apt-get -qq update
apt-get install -qq --allow-unauthenticated boundless-server-geoserver boundless-server-geowebcache boundless-server-dashboard boundless-server-quickview boundless-server-composer boundless-server-wpsbuilder boundless-server-docs boundless-server-gs-gdal boundless-server-gs-netcdf-out unzip
sleep 2
# Marlin hotfix for 1.2.0
mkdir -p /usr/share/tomcat9/lib
cp /opt/boundless/server/geoserver/WEB-INF/lib/marlin-0.9.3.jar /usr/share/tomcat9/lib/

/etc/init.d/tomcat9 restart
update-rc.d tomcat9 defaults

#remove installed packages to cut down the size
cd /var/www/repo/amd64
rm boundless-server-geoserver*.deb boundless-server-geowebcache*.deb boundless-server-dashboard*.deb boundless-server-quickview*.deb boundless-server-composer*.deb boundless-server-wpsbuilder*.deb boundless-server-docs*.deb
cd ..
sudo dpkg-scanpackages amd64 | gzip -9c > amd64/Packages.gz
apt-get -qq update
sleep 2

echo "Installing DB components..."
apt-get install -qq --allow-unauthenticated postgresql-9.6-postgis-2.5
sleep 10
sudo -u postgres psql postgres -c "alter user postgres password 'postgres'"
sed -i 's/postgres                                peer/postgres                                trust/' /etc/postgresql/9.6/main/pg_hba.conf
sed -i 's|local   all             all                                     peer|host    all             all             0.0.0.0/0               trust|' /etc/postgresql/9.6/main/pg_hba.conf
sed -i "s|#listen_addresses = 'localhost'|listen_addresses = '*'|" /etc/postgresql/9.6/main/postgresql.conf
service postgresql restart
sleep 1

# Set login banner
# Note- Docs URL to change to http://connect.boundlessgeo.com/docs/suite/latest/
echo "==============================================================================
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#:::::::::8@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@o::::::::::::::::@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@:::::::::::::::::::::@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@:::::::::::::::::::::::::@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@:::::::::::::::::::::::::::::@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@............*::::::::::::::::::::@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@*.................::::::::::::::::::8@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@*.................*@@@@::::::::::::::::::@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@*.................*@@@@@@@:::::::::::::::::::@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@*..................@@@@@@@@@@@::::::::::::::::::@@@@@@@@@@@@@@@
 @@@@@@@@@@@@..................@@@@@@@@@@@@@@@::::::::::::::::8@@@@@@@@@@@@@@
 @@@@@@@@@@..................@@@@@@@@@@@@@@@@@@@:::::::::::::::@@@:@@@@@@@@@@
 @@@@@@@:..................@@@@@@@@@@@@@@@@@@@@@@@:::::::::::::@@@@*o@@@@@@@@
 @@@@@:..................@@@@@@@@@@@@@@@@@@@@@@@@@@@:::::::::::@@@@***o@@@@@@
 @@@@..................@@@@@@@@@@@@@#8&88@@@@@@@@@@@@@:::::::::@@@@*****o@@@@
 @@*.................@@@@@@@@@@@@8&&&&&&&&&&8@@@@@@@@@@@::::::@@@@8*******@@@
 @................*@@@@@@@@@@@@8&&&&&&&&&&&&&&#@@@@@@@@@@@::::@@@@*********@@
 :...............@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&#@@@@@@@@@@@@:@@@@**********.@
 ..............@@@@@@@@@@@@@@8&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@************@
 ............@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&&8@@@@@@@@@@@@@@.*************@
 :.........*@@@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&8@@@@@@@@@@@@***************.@
 @........*@@@@@ooo@@@@@@@@@@@#&&&&&&&&&&&&&&&&@@@@@@@@@@@.****************@@
 @@*......*@@@@oooooo@@@@@@@@@@@&&&&&&&&&&&&8@@@@@@@@@@@.*****************@@@
 @@@#.....@@@@&oooooooo@@@@@@@@@@@@&88&88&@@@@@@@@@@@@******************o@@@@
 @@@@@*...@@@@ooooooooooo@@@@@@@@@@@@@@@@@@@@@@@@@@@******************8@@@@@@
 @@@@@@@*.#@@@ooooooooooooo@@@@@@@@@@@@@@@@@@@@@@@******************8@@@@@@@@
 @@@@@@@@@8@@@ooooooooooooooo@@@@@@@@@@@@@@@@@@@.*****************8@@@@@@@@@@
 @@@@@@@@@@@@@&oooooooooooooooo@@@@@@@@@@@@@@@******************8@@@@@@@@@@@@
 @@@@@@@@@@@@@@oooooooooooooooooo@@@@@@@@@@@******************8@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@&ooooooooooooooooo8@@@@@@@******************.@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@&ooooooooooooooooo8@@@8*****************.@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@&oooooooooooooooooo*****************8@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@&ooooooooooooooooooo************.@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@&oooooooooooooooooooooooooooo@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@&oooooooooooooooooooooooo@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@ooooooooooooooooooooo@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@8ooooooooooooooo&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ooooooooo@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
==============================================================================
Welcome to the Boundless Server $SERVER_VERSION virtual machine!

Useful commands:
sudo service tomcat9 start               (start Tomcat)
sudo service tomcat9 stop                (stop Tomcat)
sudo poweroff                            (shut down the virtual machine)
sudo apt-get install <package>           (install a package)
sudo /root/training.sh <on/off>          (toggle training mode on/off)

Useful directories:
/etc/tomcat9                             (tomcat config)
/opt/boundless/server                    (server application)
/var/opt/boundless/server/geoserver/data (GeoServer data directory)
/var/log/tomcat9                         (tomcat logs)
/media/sf_share                          (share directory between host and guest)

Boundless Server landing page can be found at:
http://localhost:8080/dashboard

Complete documentation can be found at:
http://localhost:8080/boundless-server-docs
OR
http://server.boundlessgeo.com/docs/$SERVER_VERSION

==============================================================================
" >> /etc/motd

echo "Hypervisor drivers added to separate script."
echo "Please refer to instructions for more details."

echo "Cleaning up logs and bash history..."
history -c
history -w
for log in `find /var/log/ -type f` /root/.bash_history ; do
  echo "" > $log
done

###################################################################################
# Training support
###################################################################################
echo "Moving data dir to /default-data in support of training material..."
mv /var/opt/boundless/server/geoserver/data /var/opt/boundless/server/geoserver/default-data

echo "Seeding training data-dir..."
chmod 755 /root/training.sh
wget https://s3.amazonaws.com/training-ova/training_data_directory.zip
unzip -o training_data_directory.zip -d /var/opt/boundless/server/geoserver/
mv /var/opt/boundless/server/geoserver/data /var/opt/boundless/server/geoserver/training-data
ln -s /var/opt/boundless/server/geoserver/training-data /var/opt/boundless/server/geoserver/data
rm -f training_data_directory.zip

# echo "Updating legacy security dir..."
# cp -pR /var/opt/boundless/server/geoserver/default-data/security /var/opt/boundless/server/geoserver/data/
chown -R tomcat9:tomcat9 /var/opt/boundless/server/geoserver

echo "Creating toggle for CORS..."
cp -p /etc/tomcat9/web.xml /etc/tomcat9/web.xml.default
cp -p /etc/tomcat9/web.xml /etc/tomcat9/web.xml.cors
sed -i '\|</web-app>|d' /etc/tomcat9/web.xml.cors
echo "
<filter>
  <filter-name>CorsFilter</filter-name>
  <filter-class>org.apache.catalina.filters.CorsFilter</filter-class>
<init-param>
    <param-name>cors.allowed.origins</param-name>
    <param-value>*</param-value>
  </init-param>
  <init-param>
    <param-name>cors.allowed.methods</param-name>
    <param-value>GET,POST,HEAD,OPTIONS,PUT</param-value>
  </init-param>
  <init-param>
    <param-name>cors.exposed.headers</param-name>
    <param-value>Access-Control-Allow-Origin,Access-Control-Allow-Methods</param-value>
  </init-param>
</filter>
<filter-mapping>
  <filter-name>CorsFilter</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
</web-app>" >> /etc/tomcat9/web.xml.cors

echo "Finished vm_deploy."
