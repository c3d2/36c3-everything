<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="xsl">

  <xsl:output method="xml"/>
  
  <xsl:template match="schedule">
    <schedule>
      <xsl:copy-of select="version"/>
      <xsl:copy-of select="conference"/>
      <xsl:apply-templates select="day"/>
    </schedule>
  </xsl:template>

  <xsl:template match="day">
    <day index="{@index}" date="{@date}">
      <xsl:for-each select="room/event">
        <xsl:sort select="date" order="ascending"/>
        <xsl:copy-of select="."/>
      </xsl:for-each>
    </day>
  </xsl:template>
</xsl:stylesheet>
