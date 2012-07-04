set -e
set -x

# load version info and utility functions
source hudson_config.sh


POSTGIS_UTILS=${buildroot}/postgis-win/pgsql/share/contrib/postgis-2.0/

mkdir -p ${buildroot}/postgis_restore
mkdir -p ${buildroot}/postgis_restore/scripts

perlapp --shared public --norunlib --nologo --verbose --warnings --force \
--exe postgis_restore.exe $POSTGIS_UTILS/postgis_restore.pl

cp $POSTGIS_UTILS/postgis_restore.pl ${buildroot}/postgis_restore/scripts/.
cp postgis_restore.exe ${buildroot}/postgis_restore/.
checkrc $? "building postgis_restore.exe"


perlapp --bind postgis_restore.exe[file=postgis_restore.exe,extract,mode=777] \
--shared public --norunlib --nologo --verbose --warnings --force \
--info "CompanyName=OpenGeo;FileDescription=Backs up databases from OpenGeo Suite 2.x (PostGIS 1.x) and restores to OpenGeo Suite 3.x (PostGIS 2.x).;FileVersion=1.0;OriginalFilename=postgis_upgrade.exe;ProductName=OpenGeo Suite PostGIS Upgrade Utility;ProductVersion=1.0" \
--exe postgis_upgrade.exe installer/common/pgupgrade/postgis_upgrade.pl

cp installer/common/pgupgrade/postgis_upgrade.pl ${buildroot}/postgis_restore/scripts/.
cp postgis_upgrade.exe ${buildroot}/postgis_restore/.
checkrc $? "building postgis_upgrade.exe"

(cd ${buildroot}; zip -vr postgis_upgrade.zip postgis_upgrade)
checkrc $? "Zipping exes"

scp -i /c/hudson/.ssh/installer_upload_key -P 7777 ${buildroot}/postgis_upgrade.zip \
-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
jetty@astromech.opengeo.org:/var/www/winbuilds

rm ${buildroot}/postgis_upgrade.zip
checkrc $? "Uploaded zip to winbuilds"
