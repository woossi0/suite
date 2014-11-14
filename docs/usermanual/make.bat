@ECHO OFF

REM Command file for Sphinx documentation

set SPHINXBUILD=sphinx-build
set ALLSPHINXOPTS=-d build/doctrees %SPHINXOPTS% source
if NOT "%PAPER%" == "" (
	set ALLSPHINXOPTS=-D latex_paper_size=%PAPER% %ALLSPHINXOPTS%
)

if "%1" == "" goto help

if "%1" == "help" (
	:help
	echo.Please use `make ^<target^>` where ^<target^> is one of
	echo.  html      to make standalone HTML files
	echo.  dirhtml   to make HTML files named index.html in directories
	echo.  pickle    to make pickle files
	echo.  json      to make JSON files
	echo.  htmlhelp  to make HTML files and a HTML help project
	echo.  qthelp    to make HTML files and a qthelp project
	echo.  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter
	echo.  text      to make plain text files 
	echo.  changes   to make an overview over all changed/added/deprecated items
	echo.  linkcheck to check all external links for integrity
	echo.  doctest   to run all doctests embedded in the documentation if enabled
	goto end
)

if "%1" == "clean" (
	for /d %%i in (build\*) do rmdir /q /s %%i
	del /q /s build\*
	goto end
)

if "%1" == "basic" (
	%SPHINXBUILD% -b html %ALLSPHINXOPTS% -t basic build/basic
	echo.
	echo.Enterprise build finished. The HTML pages are in build/basic.
	goto end
)

if "%1" == "enterprise" (
	%SPHINXBUILD% -b html %ALLSPHINXOPTS% -t enterprise build/enterprise
	echo.
	echo.Basic build finished. The HTML pages are in build/enterprise.
	goto end
)

if "%1" == "latex" (
	%SPHINXBUILD% -b latex %ALLSPHINXOPTS% -t basic build/latex
	echo.
	echo.Basic build finished; the LaTeX files are in build/latex.
	goto end
)

:end
