# Adapted from draft-ietf-roll-entrollment-priority
DRAFT:=draft-ietf-roll-rnfd
VERSION:=$(shell ./getver ${DRAFT}.mkd )

${DRAFT}-${VERSION}.txt: ${DRAFT}.txt
	cp $< $@
#	git add ${DRAFT}-${VERSION}.txt ${DRAFT}.txt

${DRAFT}-${VERSION}.html: ${DRAFT}.html
	cp $< $@

${DRAFT}.xml: ${DRAFT}.mkd
	kramdown-rfc2629 $< >$@

${DRAFT}.txt: ${DRAFT}.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc $< $@

${DRAFT}.html: ${DRAFT}.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc --html -o $@ $<

version:
	@echo Version: ${VERSION}

clean:
	rm -f ${DRAFT}.txt ${DRAFT}.html ${DRAFT}.xml

mrproper:
	rm -f ${DRAFT}.txt ${DRAFT}-${VERSION}.txt ${DRAFT}-${VERSION}.html ${DRAFT}.html ${DRAFT}.xml

wip: ${DRAFT}.txt ${DRAFT}.html

prepare: ${DRAFT}-${VERSION}.txt
	git add $<

#submit: ${DRAFT}.xml
#	curl -S -F "user=mcr+ietf@sandelman.ca" -F "xml=@${DRAFT}.xml" https://datatracker.ietf.org/api/submit

.PRECIOUS: ${DRAFT}.xml
