SET buildroot=C:\build

set PERL_PATH=C:\asperl\bin
set PATH=C:\Perl\site\bin;C:\Perl\bin;%PERL_PATH%;%PATH%
set POSTGIS_UTILS=%buildroot%\postgis-win\pgsql\share\contrib\postgis-2.0\
mkdir %buildroot%\postgis_upgrade
mkdir %buildroot%\postgis_upgrade\scripts

%PERL_PATH%\perlapp.exe --shared public --norunlib --nologo --verbose --warnings --force --exe postgis_restore.exe %POSTGIS_UTILS%\postgis_restore.pl
copy %POSTGIS_UTILS%\postgis_restore.pl %buildroot%\postgis_upgrade\scripts\
echo "building postgis_restore.exe"


%PERL_PATH%\perlapp.exe --bind postgis_restore.exe[file=postgis_restore.exe,extract,mode=777] --shared public --norunlib --nologo --verbose --warnings --force --info "CompanyName=OpenGeo;FileDescription=Backs up databases from OpenGeo Suite 2.x (PostGIS 1.x) and restores to OpenGeo Suite 3.x (PostGIS 2.x).;FileVersion=1.0;OriginalFilename=postgis_upgrade.exe;ProductName=OpenGeo Suite PostGIS Upgrade Utility;ProductVersion=1.0" --exe postgis_upgrade.exe ..\..\installer\common\pgupgrade\postgis_upgrade.pl
copy ..\..\installer\common\pgupgrade\postgis_upgrade.pl %buildroot%\postgis_upgrade\scripts\
copy postgis_upgrade.exe %buildroot%\postgis_upgrade\
echo "building postgis_upgrade.exe"

cd %buildroot%
zip -r postgis_upgrade.zip postgis_upgrade
echo "Zipping exes"

scp -P 7777 -i C:\hudson\.ssh\installer_upload_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no postgis_upgrade.zip jetty@astromech.opengeo.org:/var/www/winbuilds
del postgis_upgrade.zip
echo "Uploaded zip to winbuilds"
