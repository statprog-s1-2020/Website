SLIDE_RMD_FILES := $(wildcard static/slides/*.Rmd)
SLIDE_HTML_FILES  := $(subst Rmd,html,$(SLIDE_RMD_FILES))
SLIDE_PDF_FILES  := $(subst Rmd,pdf,$(SLIDE_RMD_FILES))

.PHONY: clean push build all pdf

build: $(SLIDE_HTML_FILES)
	hugo

all: build pdf

pdf: $(SLIDE_PDF_FILES)

open: build
	open docs/index.html

clean:
	rm -rf docs/
	rm -f static/slides/*.html

static/slides/%.html: static/slides/%.Rmd
	@Rscript -e "rmarkdown::render('$<')"
	
static/slides/%.pdf: static/slides/%.html
	@cd static/slides/; \
		Rscript -e "pagedown::chrome_print('$(<F)')"