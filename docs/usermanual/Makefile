# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         =

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d build/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: help clean html dirhtml pickle json htmlhelp qthelp latex changes linkcheck doctest

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  basic      Basic standalone HTML Files"
	@echo "  enterprise Enterprise standalone HTML files"
	@echo "  latex      Basic LaTeX files, you can set PAPER=a4 or PAPER=letter"

clean:
	-rm -rf build/*

basic:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) -t basic build/basic
	@echo
	@echo "Basic build finished. The HTML pages are in build/html."

basic:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) -t enterprise build/enterprise
	@echo
	@echo "Enterprise build finished. The HTML pages are in build/enterprise."

latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) -t basic build/latex
	@echo
	@echo "Basic build finished; the LaTeX files are in build/latex."
	@echo "Run \`make all-pdf' or \`make all-ps' in that directory to" \
	      "run these through (pdf)latex."
