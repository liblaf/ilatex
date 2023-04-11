DEMO_DIR  := $(CURDIR)/demo
DOCS_DIR  := $(CURDIR)/docs
SRC_DIR   := $(CURDIR)/src
TEXMFHOME != kpsewhich --var-value TEXMFHOME
TMP_DIR   := /tmp

DEMO_SRC_LIST != find $(DEMO_DIR) -name '*.tex'
SRC_LIST      := $(wildcard $(SRC_DIR)/*)

DEMO_PDF_LIST := $(patsubst $(DEMO_DIR)/%.tex, $(DOCS_DIR)/demo/%.pdf, $(DEMO_SRC_LIST))
TARGET_LIST   := $(patsubst $(SRC_DIR)/%, $(TEXMFHOME)/tex/latex/%, $(SRC_LIST))

LATEXMK_OPTIONS := -xelatex -file-line-error -interaction=nonstopmode -shell-escape

all: docs install

clean:
	$(RM) --recursive $(DOCS_DIR)/demo
	$(RM) $(DOCS_DIR)/index.md

docs: $(DOCS_DIR)/index.md $(DEMO_PDF_LIST)

docs-gh-deploy: docs
	mkdocs gh-deploy --force --no-history

docs-serve: docs
	mkdocs serve

install: $(TARGET_LIST)
	texhash

pretty: $(SRC_LIST)
	$(foreach src, $^, latexindent --overwrite --local --cruft=$(TMP_DIR) --modifylinebreaks --GCString $(src);)

$(DOCS_DIR)/demo/%.pdf: $(DEMO_DIR)/%.tex install
	latexmk $(LATEXMK_OPTIONS) -output-directory=$(dir $@) $<

$(DOCS_DIR)/index.md: $(CURDIR)/README.md
	install -D --mode=u=rw,go=r --no-target-directory $< $@

$(TEXMFHOME)/tex/latex/%: $(SRC_DIR)/%
	install -D --mode=u=rw,go=r --no-target-directory $< $@
