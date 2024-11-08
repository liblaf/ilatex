SHELL := /bin/bash

NAME := ilatex

DATA      := data
DEMO      := demo
DOCS      := docs
SCRIPTS   := scripts
SRC_DIR   := src
TEXMFHOME != kpsewhich -var-value=TEXMFHOME
TMP       := /tmp

LATEXINDENT_CONFIG := $(HOME)/.config/latexindent/latexindent.yaml
SRC_LIST           != find $(SRC_DIR) "(" -name "*.tex" -or -name "*.sty" -or -name "*.cls" -or -name "*.bib" ")"
TARGET_LIST        += $(HOME)/.indentconfig.yaml
TARGET_LIST        += $(LATEXINDENT_CONFIG)
TARGET_LIST        += $(SRC_LIST:$(SRC_DIR)/%=$(TEXMFHOME)/tex/latex/$(NAME)/%)

INSTALL         := @ install
INSTALL_DATA    := $(INSTALL) -D --mode="u=rw,go=r" --no-target-directory --verbose
LATEXMK         := env TEXINPUTS=$(abspath $(SRC_DIR)): latexmk
LATEXMK_OPTIONS := -xelatex -file-line-error -interaction=nonstopmode -max-print-line=1000 -shell-escape

all:

clean:
	@ $(RM) --recursive --verbose $(DOCS)/demo
	@ git clean -d --force -X

install: $(TARGET_LIST)
	texhash

# -------------------------------- Auxiliaries ------------------------------- #

$(LATEXINDENT_CONFIG): .latexindent.yaml
	$(INSTALL_DATA) $< $@

$(HOME)/.indentconfig.yaml: $(LATEXINDENT_CONFIG)
	@ echo 'paths:' > $@
	@ echo '  - $(LATEXINDENT_CONFIG)' >> $@

$(TEXMFHOME)/tex/latex/$(NAME)/%: $(SRC_DIR)/%
	$(INSTALL_DATA) $< $@
