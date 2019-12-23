<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  exclude-result-prefixes="xsl str">

  <xsl:param name="day"/>

  <xsl:template match="schedule">
    <html>
      <head>
        <title>
          <xsl:value-of select="conference/title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="style.css?20161227133700" />
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
      </head>
      <body>
        <xsl:apply-templates select="conference/title"/>
        <xsl:apply-templates select="day[@index=$day]"/>

        <script>
          function clickEvent(el) {
          console.log('toggle', el.classList);
            el.classList.toggle('expand');
          }
          for(var el of document.getElementsByTagName('article')) {
            (function(el) {
              el.onclick = clickEvent.bind(this, el);
            })(el);
          }
        </script>

        <footer>
          <p>
            By <a href="https://spaceboyz.net/~astro/">Astro</a>,
            (<a href="https://github.com/voc/36C3_schedule">data</a>,
            <a href="https://github.com/c3d2/36c3-everything">code</a>)
          </p>
        </footer>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="conference/title">
    <h1><xsl:value-of select="."/></h1>
  </xsl:template>

  <xsl:template match="schedule/day">
    <h2 id="day{@index}">
      Day <xsl:value-of select="@index"/>
      (<xsl:value-of select="@date"/>)
    </h2>

    <section>
      <xsl:for-each select="room/event">
        <xsl:sort select="date" order="ascending"/>
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </section>
  </xsl:template>

  <xsl:template match="event">
    <xsl:variable name="expandable">
      <xsl:if test="abstract and string-length(abstract) &gt; 0">
        expandable
      </xsl:if>
    </xsl:variable>
    <article class="{str:replace(str:replace(room, ' ', '_'), '.', '')} {$expandable}">
      <div class="meta">
        <p class="time">
          <xsl:value-of select="start"/>
          <span class="duration">
            <xsl:text>+</xsl:text>
            <xsl:value-of select="duration"/>
          </span>
        </p>
        <p class="room">
          <xsl:choose>
            <xsl:when test="starts-with(room, 'Assembly:')">
              <i>
                <xsl:value-of select="str:replace(room, 'Assembly:', '')"/>
              </i>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="room"/>
            </xsl:otherwise>
          </xsl:choose>
        </p>
      </div>

      <div class="header">
        <!--xsl:if test="logo and string-length(logo) &gt; 0">
          <img class="logo"
               src="{base_url}{logo}"/>
        </xsl:if-->
        <h3>
          <xsl:choose>
            <xsl:when test="url">
              <a href="{url}">
                <xsl:value-of select="title"/>
              </a>
            </xsl:when>
            <xsl:when test="links/link">
              <a href="{links/link[last()]}">
                <xsl:value-of select="title"/>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="title"/>
            </xsl:otherwise>
          </xsl:choose>
        </h3>
        <xsl:if test="subtitle and string-length(subtitle) &gt; 0">
          <h4>
            <xsl:value-of select="subtitle"/>
          </h4>
        </xsl:if>
      </div>
      <p class="abstract">
        <xsl:value-of select="abstract"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="description"/>
      </p>
      
      <ul class="speakers">
        <xsl:apply-templates select="persons"/>
      </ul>
    </article>
  </xsl:template>

  <xsl:template match="person">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="name">
          <xsl:value-of select="name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <li>
      <xsl:value-of select="$name"/>
    </li>
  </xsl:template>
</xsl:stylesheet>
