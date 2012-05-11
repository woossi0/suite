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

:: Create takes no arguments
if "x%~2"=="x" goto Usage
set COMMAND="%~1"
set APP_PATH="%~2"
goto Run


:Debug

::Debug takes [g|p]
if "x%~2"=="x" goto Usage
set COMMAND="%~1"
shift

:: Must be an even number of arguments
:: (Two for each command flag, one for command, one for app-path)
set /a ARGCOUNT = 0
for %%a in (%*) do set /a ARGCOUNT += 1
set /a ARGODD = "%ARGCOUNT% %% 2"
if %ARGODD% == 1 goto Usage
goto DebugFlagLoop

:DebugFlagLoop
:: Sets all of the command flags (ant arguments)
:: And whatever remains should be the app-path

:: Checking for a valid flag
rem TODO What about bad flags?
set flagvalid=0
if "%~1"=="-g" set flagvalid=1
if "%~1"=="-p" set flagvalid=1
if not "%flagvalid%"=="1" (
  :: Must be one arg remaining, otherwise fail
  rem TODO Edge case - Any valid flags after app-path are ignored
  rem but don't cause an error:
  rem Ex:  -p 9090 myapp -g http://geoserver 
  rem TODO The logic below seems exactly backwards, but works.
  if not "x%~1"=="%~1" (
    if not "x%~2"=="%~2" (
      goto DebugPath
    ) else (
      goto Usage
    )
  )
)

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

:: Keep going until one arg left
goto DebugFlagLoop


:DebugPath
:: First argument is not a flag, so must assume that
:: it's the app-path.
set APP_PATH="%~1"
goto Run


:Deploy
:: Deploy takes [c|u|s|p|d]
if "x%~2"=="x" goto Usage
set COMMAND="%~1"
shift


:DeployFlagLoop
rem TODO: Same issues as in DebugFlagLoop

:: Checking for a valid flag
set flagvalid=0
if "%~1"=="-c" set flagvalid=1
if "%~1"=="-u" set flagvalid=1
if "%~1"=="-s" set flagvalid=1
if "%~1"=="-p" set flagvalid=1
if "%~1"=="-d" set flagvalid=1
if not "%flagvalid%"=="1" (
  :: Must be one arg remaining, otherwise fail
  if not "x%~1"=="%~1" (
    if not "x%~2"=="%~2" (
      goto DeployPath
    ) else (
      goto Usage
    )
  )
)


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

:: Keep going until one arg left
goto DeployFlagLoop

:DeployPath
:: First argument is not a flag, so must assume that
:: it's the app-path.
set APP_PATH="%~1"
goto Run


:Usage
echo suite-sdk: Create, debug, and deploy, map applications.
echo Usage: suite-sdk [command] [options] [app-path]
echo Example:  suite-sdk debug -p 9090 myapp
exit /b

:Run
ant -e -f %SDK_HOME%\build.xml -Dsdk.home=%SDK_HOME% -Dbasedir=. %COMMAND% -Dapp.path=%APP_PATH% %ANT_ARGS%

