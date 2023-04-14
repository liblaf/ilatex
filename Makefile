CONFIG_DIR := $(CURDIR)/config
DEMO_DIR   := $(CURDIR)/demo
DOCS_DIR   := $(CURDIR)/docs
SCRIPT_DIR := $(CURDIR)/script
SRC_DIR    := $(CURDIR)/src
TEXMFHOME  != kpsewhich -var-value=TEXMFHOME
TMP_DIR    := /tmp

DEMO_SRC_LIST :=
DEMO_SRC_LIST += $(DEMO_DIR)/article/chinese/chinese.tex
DEMO_SRC_LIST += $(DEMO_DIR)/article/default/default.tex
DEMO_SRC_LIST += $(DEMO_DIR)/article/two-column/two-column.tex
DEMO_SRC_LIST += $(DEMO_DIR)/work/default/default.tex
SRC_LIST      := $(wildcard $(SRC_DIR)/*)

DEMO_PDF_LIST := $(patsubst $(DEMO_DIR)/%.tex, $(DOCS_DIR)/demo/%.pdf, $(DEMO_SRC_LIST))
TARGET_LIST   := $(patsubst $(SRC_DIR)/%, $(TEXMFHOME)/tex/latex/%, $(SRC_LIST))

LATEXMK_OPTIONS := -xelatex -file-line-error -interaction=nonstopmode -shell-escape

all: docs install

clean:
	$(RM) --recursive $(DOCS_DIR)/demo
	$(RM) $(DOCS_DIR)/index.md
	git clean -d --force -X

docs: $(DOCS_DIR)/index.md $(DEMO_PDF_LIST)

docs-gh-deploy: docs
	mkdocs gh-deploy --force --no-history

docs-serve: docs
	mkdocs serve

install: $(TARGET_LIST)
	texhash

pretty: $(DEMO_SRC_LIST) $(SRC_LIST)
	$(foreach src, $^, latexindent --overwrite --local --cruft=$(TMP_DIR) --modifylinebreaks --GCString $(src);)
	$(MAKE) --directory=$(SCRIPT_DIR) pretty

package-to-subsection: $(SCRIPT_DIR)/package-to-subsection.py $(CONFIG_DIR)/packages.yaml | $(DEMO_DIR)/article/default/package
	python $< --config $(CONFIG_DIR)/packages.yaml --package-dir $|

pip: $(CURDIR)/requirements.txt $(DOCS_DIR)/requirements.txt $(SCRIPT_DIR)/requirements.txt
	$(foreach req, $^, pip install --requirement $(req);)

$(DEMO_DIR)/%.pdf: $(DEMO_DIR)/%.tex install
	cd $(dir $<) && latexmk $(LATEXMK_OPTIONS) $<

$(DEMO_DIR)/article/default/default.tex: package-to-subsection

$(DEMO_DIR)/article/default/package:
	mkdir --parents $@

$(DOCS_DIR)/demo/%.pdf: $(DEMO_DIR)/%.pdf
	install -D --mode=u=rw,go=r --no-target-directory $< $@

$(DOCS_DIR)/index.md: $(CURDIR)/README.md
	install -D --mode=u=rw,go=r --no-target-directory $< $@

$(TEXMFHOME)/tex/latex/%: $(SRC_DIR)/%
	install -D --mode=u=rw,go=r --no-target-directory $< $@
