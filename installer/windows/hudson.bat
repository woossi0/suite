@echo off
:: This file is to be run on the Windows Hudson build machine only.
:: To build the Windows installer locally, run the buildexe.bat file.

:: Takes three parameters, but the fourth may be blank
:: hudson.bat %dist_path% %revision% %alias% %profile%
:: See Usage at bottom
if "x%2"=="x" goto Usage
if not "x%5"=="x" goto Usage
set dist_path=%1
set revision=%2
set alias=%3
set profile=%4

set REMOTE_WEB_ROOT=/var/www/winbuilds
set PATH=%PATH%;C:\Program Files\wget\bin;C:\Program Files\NSIS;C:\Program Files\Git\bin

:: This is where the actual build process happens
echo Calling build process...
echo.
call buildexe.bat %dist_path% %revision% %profile%

:: If buildexe.bat failed in some way
if not exist OpenGeo*.exe (
  echo Error: EXE creation failed
  exit /b 1
)

:: Name the file
:: Note #1: %id% is defined in buildexe.bat
set outfile=OpenGeoSuite-%id%-b%BUILD_NUMBER%.exe
ren OpenGeo*.exe %outfile%

:: Create output directory
set outpath=%REMOTE_WEB_ROOT%/%dist_path%

:: Move files into place
echo Moving the EXE into its proper place...
echo.
scp -P 7777 -i C:\hudson\.ssh\installer_upload_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no %outfile% jetty@astromech.opengeo.org:%outpath%

:: Copy to OpenGeoSuite-latest.exe and cleanup directory if latest
if "%profile%"=="ee" (
  set aliasedfile=OpenGeoSuite-ee-%alias%.exe
) else (
  set aliasedfile=OpenGeoSuite-%alias%.exe
)

echo Copying to %aliasedfile%
echo.
scp -P 7777 -i C:\hudson\.ssh\installer_upload_key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no %outfile% jetty@astromech.opengeo.org:%outpath%/%aliasedfile%
echo Deleting old files from the "latest" directory...
echo.
:: Keep only the most recent 7 builds (8 includes "latest")
for /f "skip=8" %%a in ('dir /b /o-d "%outpath%"') do del "%outpath%\%%a"

:: Final output
echo Summary:
echo.
echo The Hudson build number is: b%BUILD_NUMBER%
echo The files were built from: %dist_path%
echo The revision is: %rev% (%revision%) (%alias%)
echo The profile (if any) is: %profile% 
echo Output file is called: %outfile%
echo Output file saved to: %outpath%
echo Available for download at: http://suite.opengeo.org/winbuilds/%dist_path%/%outfile%
echo.
echo Done.
echo.

goto End


:Usage
echo.
echo This program requires following parameters:
echo.
echo Usage:
echo   hudson.bat dist_path revision alias [profile]
echo.
exit /b 1

:End
