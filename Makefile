# for pipefail
SHELL=/bin/bash
.SECONDARY:
.DELETE_ON_ERROR:

XSLTPROC = xsltproc

all: about-server check

contrib: about-server wiki

contributors: contrib

about-server:
	@$(XSLTPROC) -o help/about-server.txt ../tools/contrib_xsl/about-server.xsl ../tools/contrib_xsl/contributors.xml 
	@echo "The file about-server.txt was created successfully."

wiki:
	@$(XSLTPROC) ../tools/contrib_xsl/wiki.xsl ../tools/contrib_xsl/contributors.xml > ../wiki/Contributors.md
	@echo "Wiki generated"

check: check-xml check-png testxml

PNGS = $(shell find . -type f -name "*.png")
check-png: $(patsubst %.png,out/%.png.ok,${PNGS})
	find . -name '*.png.ok' -delete
	find . -name '*.png.out' -delete
	find ./out/ -type d -delete
out/%.png.ok: out/%.png.out
	grep '32-bit RGB+alpha, non-interlaced, ' $< > $@
out/%.png.out: %.png
	mkdir -p ${@D}
	set -e -o pipefail; \
	pngcheck $< > $@

check-xml:
	cd ../tools/testxml/ ; ./xsdcheck.sh ; cat errors.txt

testxml:
	cd ../tools/testxml/ ; ./testxml.py all

updates:
	cd ../tools/update/ ; ./createnew.sh

music:
	cd ../tools/update/ ; ./create_music.sh

license:
	cd ../tools/licensecheck/ ; ./clientdata.sh

icc:
	cd ../tools/imagescheck/ ; ./icccheck.sh

pipeline: check-xml
	cd ../tools/testxml/ ; ./testxml.py silent |grep -v "Checking"
	echo "Now using imagemagic to verify images..."
	cd ../tools/imagescheck/ ; ./icccheck.sh
	echo "Now run `make check-png` to check PNG images. Use `make contrib` if contributor list must be updated."
