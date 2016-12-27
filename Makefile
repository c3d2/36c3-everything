index.html: index.unhyphenated.html
	sed -f hyphenate.sed < $< > $@

index.unhyphenated.html: index.xsl everything.schedule.xml speakers.xml
	xsltproc $< everything.schedule.xml > $@

everything.schedule.xml:
	wget -O $@ https://fahrplan.events.ccc.de/congress/2016/Fahrplan/everything.schedule.xml

speakers.json:
	wget -O $@ https://fahrplan.events.ccc.de/congress/2016/Fahrplan/speakers.json

speakers.xml: speakers.json node_modules/js2xmlparser
	node -e 'console.log(require("js2xmlparser").parse("speakers", JSON.parse(require("fs").readFileSync("speakers.json"))))' > $@

node_modules/%:
	npm i `echo $@ | sed -e 's/node_modules\///'`
