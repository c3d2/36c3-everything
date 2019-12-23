all: 1.html 2.html 3.html 4.html

clean:
	rm -f ?.html everything.schedule.xml

%.html: day.xsl everything.schedule.xml
	xsltproc --param day $* $< everything.schedule.xml > $@

everything.schedule.xml:
	wget -O $@ https://github.com/voc/36C3_schedule/raw/master/everything.schedule.xml
