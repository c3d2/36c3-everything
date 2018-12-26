index.html: index.unhyphenated.html
	sed -f hyphenate.sed < $< > $@

index.unhyphenated.html: index.xsl everything.schedule.xml
	xsltproc $< everything.schedule.xml > $@

everything.schedule.xml:
	wget -O $@ http://data.c3voc.de/35C3/everything.schedule.xml

node_modules/%:
	npm i `echo $@ | sed -e 's/node_modules\///'`
