index.html: index.xsl everything.schedule.xml
	xsltproc $^ > $@

everything.schedule.xml:
	wget -O $@ https://fahrplan.events.ccc.de/congress/2016/Fahrplan/everything.schedule.xml
