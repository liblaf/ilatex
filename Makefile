SHELL     := /bin/bash
MAKEFLAGS += --jobs

NAME := ilatex

CONFIG    := config
DEMO      := demo
DOCS      := docs
SCRIPTS   := scripts
SRC       := src
TEXMFHOME != kpsewhich -var-value=TEXMFHOME
TMP       := /tmp

DEMO_LIST          != find $(DEMO) "(" -name "*.tex" -or -name "*.sty" -or -name "*.cls" -or -name "*.bib" ")"
DEMO_PDF_LIST      += $(DEMO)/article/chinese/chinese.pdf
DEMO_PDF_LIST      += $(DEMO)/article/default/default.pdf
DEMO_PDF_LIST      += $(DEMO)/article/manual/manual.pdf
DEMO_PDF_LIST      += $(DEMO)/beamer/default/default.pdf
DEMO_PDF_LIST      += $(DEMO)/work/chinese/chinese.pdf
DEMO_PDF_LIST      += $(DEMO)/work/default/default.pdf
DOCS_LIST          += $(DEMO_PDF_LIST:$(DEMO)/%.pdf=$(DOCS)/demo/%.pdf)
DOCS_LIST          += $(DOCS)/index.md
LATEXINDENT_CONFIG := $(HOME)/.config/latexindent/latexindent.yaml
SRC_LIST           != find $(SRC) "(" -name "*.tex" -or -name "*.sty" -or -name "*.cls" -or -name "*.bib" ")"
TARGET_LIST        += $(HOME)/.indentconfig.yaml
TARGET_LIST        += $(LATEXINDENT_CONFIG)
TARGET_LIST        += $(SRC_LIST:$(SRC)/%=$(TEXMFHOME)/tex/latex/$(NAME)/%)

INSTALL             := @ install
INSTALL_DATA        := $(INSTALL) -D --mode="u=rw,go=r" --no-target-directory --verbose
LATEXMK             := env TEXINPUTS=$(abspath $(SRC)): latexmk
LATEXMK_OPTIONS     := -xelatex -file-line-error -interaction=nonstopmode -shell-escape

all: docs

clean:
	@ $(RM) --recursive --verbose $(DOCS)/demo
	@ git clean -d --force -X

docs: $(DOCS_LIST)

docs-build: docs
	mkdocs build

docs-gh-deploy: docs
	mkdocs gh-deploy --force --no-history

docs-serve: docs
	mkdocs serve

install: $(TARGET_LIST)
	texhash

pkg-to-subsection: $(SCRIPTS)/pkg-to-subsection.py $(CONFIG)/pkgs.yaml | $(DEMO)/article/manual/pkg
	python $< --config=$(CONFIG)/pkgs.yaml --pkg-dir=$|

setup: $(DOCS)/requirements.txt $(SCRIPTS)/requirements.txt
	micromamba --yes --name=$(NAME) create python
	micromamba --name=$(NAME) run pip install $(^:%=--requirement=%)

###############
# Auxiliaries #
###############

$(DEMO)/%.pdf: $(DEMO)/%.tex
	cd $(@D) && $(LATEXMK) $(LATEXMK_OPTIONS) $(<F)

$(DOCS)/demo/%.pdf: $(DEMO)/%.pdf
	$(INSTALL_DATA) $< $@

$(LATEXINDENT_CONFIG): .latexindent.yaml
	$(INSTALL_DATA) $< $@

$(HOME)/.indentconfig.yaml: $(LATEXINDENT_CONFIG)
	echo 'paths:' > $@
	echo '  - $(LATEXINDENT_CONFIG)' >> $@

$(TEXMFHOME)/tex/latex/$(NAME)/%: $(SRC)/%
	$(INSTALL_DATA) $< $@
