<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:param name="aasta" select="2026"/>
  <xsl:param name="otsing" select="''"/>
  <xsl:param name="pikkus" select="''"/>
  <xsl:template name="vanus">
    <xsl:choose><xsl:when test="@surm"><xsl:value-of select="@surm - @synd"/> (surres)</xsl:when>
    <xsl:otherwise><xsl:value-of select="$aasta - @synd"/></xsl:otherwise></xsl:choose>
  </xsl:template>
  <xsl:template name="vanem"><xsl:choose><xsl:when test="parent::lapsed"><xsl:value-of select="../../nimi"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></xsl:template>
  <xsl:template name="vanavanem"><xsl:choose><xsl:when test="../../parent::lapsed"><xsl:value-of select="../../../../nimi"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></xsl:template>
  <xsl:template name="vanemaVanus"><xsl:choose><xsl:when test="parent::lapsed"><xsl:value-of select="@synd - ../../@synd"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></xsl:template>
<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:key name="koht" match="inimene" use="@elukoht"/>
<xsl:template match="/">
<p><xsl:for-each select="//inimene[roll='vanaema']"><xsl:value-of select="nimi"/>; <xsl:for-each select="lapsed/inimene"><xsl:value-of select="nimi"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each></xsl:for-each></p>
<p><strong>Inimesi elukoha järgi: </strong><xsl:for-each select="//inimene[generate-id()=generate-id(key('koht',@elukoht)[1])]"><xsl:value-of select="@elukoht"/> - <xsl:value-of select="count(key('koht',@elukoht))"/><xsl:if test="position()!=last()">; </xsl:if></xsl:for-each></p>
<p class="text-muted">Punane nimi sisaldab a-tähte. Kollane taust tähendab vähemalt kahte last.</p>
<h2>Tabel</h2><div class="table-responsive"><table class="table table-striped"><thead><tr><th>Nimi</th><th>Seos minuga</th><th>Sünniaasta</th><th>Vanus</th><th>Elukoht</th><th>Vanem</th><th>Vanavanem</th><th>Lapsi</th><th>Nime pikkus</th></tr></thead><tbody>
<xsl:for-each select="//inimene"><tr>
<td><xsl:attribute name="class"><xsl:if test="contains(translate(nimi,'A','a'),'a')">punane </xsl:if><xsl:if test="count(lapsed/inimene)&gt;=2">kollane</xsl:if></xsl:attribute><xsl:value-of select="nimi"/></td>
<td><xsl:value-of select="roll"/></td><td><xsl:value-of select="@synd"/></td><td><xsl:call-template name="vanus"/></td><td><xsl:value-of select="@elukoht"/></td>
<td><xsl:call-template name="vanem"/></td><td><xsl:call-template name="vanavanem"/></td><td><xsl:value-of select="count(lapsed/inimene)"/></td>
<td><xsl:value-of select="string-length(nimi)"/></td>
</tr></xsl:for-each></tbody></table></div>
<p class="text-muted">Vanus on aastaarvude vahe (<xsl:value-of select="$aasta"/>). Oma ülesanne: arvutada iga inimese nime pikkus. Andmetes on neli põlvkonda.</p>
</xsl:template></xsl:stylesheet>
