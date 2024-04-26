BUILD_DIR=build
OPTIONS=-outdir=$(BUILD_DIR) -pdf -interaction=nonstopmode
-include local.mk
PDFS ?= example-empty.pdf example.pdf example-monthly.pdf 
OUTPUT=$(addprefix $(BUILD_DIR)/, $(PDFS))

all: $(OUTPUT)

build/print-%.tex: ${BUILD_DIR}/%.pdf
	/usr/bin/echo -e "\\documentclass[twoside,a4paper]{article}\n\\usepackage{pdfpages}\n\\\begin{document}\n\\pagestyle{plain}\n\\includepdf[pages={-},nup=1x2,landscape,signature=4]{$<}\n\\\end{document}" > $@

display: $(OUTPUT)
	xdg-open $<

$(BUILD_DIR)/%.pdf: %.tex
	latexmk $(OPTIONS) $<

$(BUILD_DIR)/%.pdf: $(BUILD_DIR)/%.tex
	latexmk $(OPTIONS) $<

clean:
	latexmk $(OPTIONS) -c

distclean:
	rm -rf $(BUILD_DIR)

.SECONDARY:

.PHONY: all clean distclean
