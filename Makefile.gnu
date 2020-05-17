.SUFFIXES:

MYSERVER=my.blog.site

PGOT-LOC=pgot -i ":src/inc" -d '{"siteurl":"$(shell pwd)/bld/loc","dfile":"index.html"}'
PGOT-PUB=pgot -i ":src/inc" -d '{"siteurl":"https://$(MYSERVER)","dfile":""}'
CHUF=chuf '|||md+' '|||md-' markdown

INC=$(shell find src -type f -name '*.igot')
GOT=$(shell find src -type f -name '*.got')
RAW=$(shell find -L src -type f -name '*.raw')
CPY=$(shell find -L src -type f -name '*.cpy')

all loc: $(RAW:src/%.raw=bld/loc/%) \
        $(CPY:src/%.cpy=bld/loc/%) \
        $(GOT:src/%.got=bld/loc/%.html)

pub:    $(RAW:src/%.raw=bld/pub/%) \
        $(CPY:src/%.cpy=bld/pub/%) \
        $(GOT:src/%.got=bld/pub/%.html)

bld/loc/% bld/pub/%: src/%.raw
	@mkdir -p $(@D)
	@echo "raw  -> $@"
	@cp $< $@

bld/loc/% bld/pub/%: src/%.cpy
	@mkdir -p $(@D)
	@echo "cpy  -> $@"
	@cp $< $@

bld/loc/%.html: src/%.got $(INC)
	@mkdir -p $(@D)
	@echo "pgot -> $@"
	@$(PGOT-LOC) $< | $(CHUF) > $@

bld/pub/%.html: src/%.got $(INC)
	@mkdir -p $(@D)
	@echo "pgot -> $@"
	@$(PGOT-PUB) $< | $(CHUF) > $@

cogit: bld/cogit.tar cogit-files.txt
	@ echo "Moving cogit tarball to release folder"
	mkdir -p ../makeht-release
	mv bld/cogit.tar ../makeht-release/makeht-cogit-$(shell date +"%Y-%m-%d").tar

CGTMP=cg.tmp
CGSRT=cgsrt.tmp

bld/cogit.tar: $(CGSRT)
	@mkdir -p $(@D)
	@echo "generating $@"
	@tar -T $< -cf $@ 

cogit-files.txt: $(CGSRT)
	@echo "generating $@"
	@while read CGFILE; do sha256sum -b "$$CGFILE"; done < $< > $@

$(CGSRT): $(RAW)
	@find src -type f -name '*.raw' > $(CGTMP)
	@sort < $(CGTMP) > $@
	@rm -f $(CGTMP)

clean:
	rm -Rf bld *.tmp

lint: loc
	@grep -n -r '<no value>' bld/loc/ || true

.PHONY: all loc pub clean lint
