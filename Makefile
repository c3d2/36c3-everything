all: 1.html 2.html 3.html 4.html

clean:
	rm -f ?.html *.xml

schedule.xml: everything.schedule.xml sort.xsl
	xsltproc sort.xsl $< > $@

%.html: schedule.xml day.xsl
	xsltproc --param day $* day.xsl $< > $@

everything.schedule.xml:
	wget -O $@ https://github.com/voc/36C3_schedule/raw/master/everything.schedule.xml
