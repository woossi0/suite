@echo off

set COMMAND=
set APP_PATH=
set ANT_ARGS=

:: Find the full path of SDK_HOME 
pushd %~dp0..
set SDK_HOME=%cd%
popd

:: Determine if proper arguments have been supplied
if "x%~1"=="x" goto Usage
if "%~1"=="create" goto Create
if "%~1"=="debug" goto Debug
if "%~1"=="deploy" goto Deploy
goto Usage


:Create

:: Create take no arguments
if "x%~2"=="x" goto Usage
set COMMAND="%~1"
set APP_PATH="%~2"
goto Run


:Debug

::Debug takes [g|p]
if "x%~2"=="x" goto Usage
set COMMAND="%~1"
set APP_PATH="%~2"
shift && shift
if "x%~1"=="x" goto Run


:Debugloop

:: Just checking that there's some valid flag here
set flagvalid=0
if "%~1"=="-g" set flagvalid=1
if "%~1"=="-p" set flagvalid=1
if not "%flagvalid%"=="1" goto Usage 

if "%~1"=="-g" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dapp.proxy.geoserver=%2
  shift && shift
)

if "%~1"=="-p" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dapp.port=%2
  shift && shift
)

:: In lieu of a while loop
if not "x%~1"=="x" goto Debugloop

goto Run


:Deploy

:: Deploy takes [c|u|s|p|d]
if "x%~2"=="x" goto Usage
set COMMAND="%~1"
set APP_PATH="%~2"
shift && shift
if "x%~1"=="x" goto Run

:Deployloop

:: Just checking that there's some valid flag here
set flagvalid=0
if "%~1"=="-c" set flagvalid=1
if "%~1"=="-u" set flagvalid=1
if "%~1"=="-s" set flagvalid=1
if "%~1"=="-p" set flagvalid=1
if "%~1"=="-d" set flagvalid=1
if not "%flagvalid%"=="1" goto Usage

:: TODO Figure out which of these are required!

if "%~1"=="-c" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dsuite.container=%2
  shift && shift
)

if "%~1"=="-u" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dsuite.username=%2
  shift && shift
)

if "%~1"=="-s" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dsuite.password=%2
  shift && shift
)

if "%~1"=="-p" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dsuite.domain=%2
  shift && shift
)

if "%~1"=="-d" (
  if "x%~2"=="x" goto Usage
  set ANT_ARGS=%ANT_ARGS% -Dsuite.port=%2
  shift && shift
)

:: In lieu of a while loop
if not "x%~1"=="x" goto Debugloop

goto Run

:Usage
echo suite-sdk: Create, debug, and deploy, map applications.
echo   Usage coming soon. 
exit /b

:Run
ant -e -f %SDK_HOME%\build.xml -Dsdk.home=%SDK_HOME% -Dbasedir=. %COMMAND% -Dapp.path=%APP_PATH% %ANT_ARGS%

