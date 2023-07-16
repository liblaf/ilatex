MAKEFLAGS += --jobs

PROJECT := ilatex

CONFIG    := $(CURDIR)/config
DEMO      := $(CURDIR)/demo
DOCS      := $(CURDIR)/docs
SCRIPTS   := $(CURDIR)/scripts
SRC       := $(CURDIR)/src
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
TARGET_LIST        += $(SRC_LIST:$(SRC)/%=$(TEXMFHOME)/tex/latex/$(PROJECT)/%)

INSTALL_OPTIONS     := -D --mode="u=rw,go=r" --no-target-directory --verbose
LATEXINDENT_OPTIONS := --overwriteIfDifferent --silent --local --cruft=$(TMP) --modifylinebreaks --GCString
LATEXMK             := env TEXINPUTS=$(SRC): latexmk
LATEXMK_OPTIONS     := -xelatex -file-line-error -interaction=nonstopmode -shell-escape

all:

clean: $(DEMO_LIST:$(CURDIR)/%=clean-$(CURDIR)/%)
	@ $(RM) --recursive --verbose $(DOCS)/demo

docs: $(DOCS_LIST)

docs-build: docs
	mkdocs build

docs-gh-deploy: docs
	mkdocs gh-deploy --force --no-history

docs-serve: docs
	mkdocs serve

install: $(TARGET_LIST)
	texhash

pretty: prettier latexindent

pkg-to-subsection: $(SCRIPTS)/pkg-to-subsection.py $(CONFIG)/pkgs.yaml | $(DEMO)/article/manual/pkg
	python $< --config=$(CONFIG)/pkgs.yaml --pkg-dir=$|

setup: $(DOCS)/requirements.txt
	pip install --requirement=$<

#####################
# Auxiliary Targets #
#####################

ALWAYS:

$(DEMO)/%.pdf: $(DEMO)/%.tex ALWAYS
	cd $(@D) && $(LATEXMK) $(LATEXMK_OPTIONS) $<

$(DOCS)/demo/%.pdf: $(DEMO)/%.pdf
	@ install $(INSTALL_OPTIONS) $< $@

$(LATEXINDENT_CONFIG): $(CURDIR)/.latexindent.yaml
	@ install $(INSTALL_OPTIONS) $< $@

$(HOME)/.indentconfig.yaml: $(LATEXINDENT_CONFIG)
	echo 'paths:' > $@
	echo '  - $(LATEXINDENT_CONFIG)' >> $@

$(TEXMFHOME)/tex/latex/$(PROJECT)/%: $(SRC)/%
	@ install $(INSTALL_OPTIONS) $< $@

clean-$(CURDIR)/%: $(CURDIR)/%
	@ $(RM) --recursive --verbose $(<D)/_minted-*
	@ $(RM) --recursive --verbose $(<D)/*.bbl
	@ $(RM) --recursive --verbose $(<D)/*.listing
	@ $(RM) --recursive --verbose $(<D)/*.nav
	@ $(RM) --recursive --verbose $(<D)/*.run.xml
	@ $(RM) --recursive --verbose $(<D)/*.snm
	@ $(RM) --recursive --verbose $(<D)/indent.log
	cd $(<D) && $(LATEXMK) $(LATEXMK_OPTIONS) -C $<

latexindent: $(DEMO_LIST:$(CURDIR)/%=latexindent-$(CURDIR)/%) $(SRC_LIST:$(CURDIR)/%=latexindent-$(CURDIR)/%)

latexindent-$(CURDIR)/%: $(CURDIR)/%
	latexindent $(LATEXINDENT_OPTIONS) $<

prettier: $(CURDIR)/.gitignore
	prettier --write --ignore-path=$< $(CURDIR)
