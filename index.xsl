<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:str="http://exslt.org/strings"
  exclude-result-prefixes="xsl str">

  <xsl:variable name="speakers"
                select="document('speakers.xml')/speakers/schedule_speakers/speakers"/>
  
  <xsl:template match="schedule">
    <html>
      <head>
        <title>
          <xsl:value-of select="conference/title"/>
        </title>
        <link rel="stylesheet" type="text/css" href="style.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
      </head>
      <body>
        <xsl:apply-templates select="conference/title"/>
        <xsl:apply-templates select="day"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="conference/title">
    <h1><xsl:value-of select="."/></h1>

    <p class="toc">
      Jump to day
      <xsl:for-each select="/schedule/day">
        <xsl:text> </xsl:text>
        <a href="#day{@index}">
          <xsl:value-of select="@index"/>
        </a>
      </xsl:for-each>
    </p>
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
    <article class="{str:replace(str:replace(room, ' ', '_'), '.', '')}">
      <div class="meta">
        <p class="time">
          <xsl:value-of select="start"/>
          <span class="duration">
            <xsl:text>+</xsl:text>
            <xsl:value-of select="duration"/>
          </span>
        </p>
        <p class="room">
          <xsl:value-of select="room"/>
        </p>
      </div>
      
      <h3>
        <xsl:value-of select="title"/>
      </h3>
      <xsl:if test="subtitle and string-length(subtitle) &gt; 0">
        <h4>
          <xsl:value-of select="subtitle"/>
        </h4>
      </xsl:if>
      
      <ul class="speakers">
        <xsl:apply-templates select="persons"/>
      </ul>
    </article>
  </xsl:template>

  <xsl:template match="person">
    <xsl:variable name="id" select="@id"/>
    <xsl:variable name="speaker" select="$speakers[string(id) = $id]"/>

    <li>
      <xsl:choose>
        <xsl:when test="@href">
          <a href="{@href}">
            <xsl:value-of select="."/>
          </a>
        </xsl:when>
        <xsl:when test="@id">
          <xsl:if test="$speaker/image and not($speaker/image = 'null')">
            <img src="https://fahrplan.events.ccc.de/congress/2016/Fahrplan{$speaker/image}"/>
          </xsl:if>
          <xsl:value-of select="$speaker/public_name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </li>
  </xsl:template>
</xsl:stylesheet>
