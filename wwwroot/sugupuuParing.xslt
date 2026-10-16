<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:param name="aasta" select="2026"/>
  <xsl:param name="otsing" select="'li'"/>
  <xsl:param name="pikkus" select="6"/>
  <xsl:template name="vanus">
    <xsl:choose><xsl:when test="@surm"><xsl:value-of select="@surm - @synd"/> (surres)</xsl:when>
    <xsl:otherwise><xsl:value-of select="$aasta - @synd"/></xsl:otherwise></xsl:choose>
  </xsl:template>
  <xsl:template name="vanem"><xsl:choose><xsl:when test="parent::lapsed"><xsl:value-of select="../../nimi"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></xsl:template>
  <xsl:template name="vanavanem"><xsl:choose><xsl:when test="../../parent::lapsed"><xsl:value-of select="../../../../nimi"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></xsl:template>
  <xsl:template name="vanemaVanus"><xsl:choose><xsl:when test="parent::lapsed"><xsl:value-of select="@synd - ../../@synd"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></xsl:template>
<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template match="/">
<p>Sugupuus on <xsl:value-of select="count(//inimene)"/> inimest. Charlesil on <xsl:value-of select="count(//inimene[nimi='Charles']/lapsed/inimene/lapsed/inimene)"/> lapselast.</p>
<h2>Sugupuu</h2><ul class="sugupuu"><xsl:apply-templates select="inimene"/></ul><h2>Kõik sünniaastad</h2><p><xsl:for-each select="//inimene"><xsl:value-of select="nimi"/>: <xsl:value-of select="@synd"/><xsl:if test="position()!=last()">; </xsl:if></xsl:for-each></p>
<h2>Vähemalt kahe lapsega inimesed</h2><p><xsl:for-each select="//inimene[count(lapsed/inimene) &gt;= 2]"><xsl:value-of select="nimi"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each></p>
<h2>Nimed, mis algavad tähega C</h2><ul><xsl:for-each select="//inimene[starts-with(nimi,'C')]"><li><xsl:value-of select="nimi"/></li></xsl:for-each></ul><h2>Parameetrite kasutamine</h2><h3>Nimed, mis sisaldavad teksti <strong><xsl:value-of select="$otsing"/></strong></h3>
<ul><xsl:for-each select="//inimene[contains(nimi, $otsing)]"><li><xsl:value-of select="nimi"/></li></xsl:for-each><xsl:if test="not(//inimene[contains(nimi, $otsing)])"><li>Ei leitud</li></xsl:if></ul>
<h3>Nimed, mis on pikemad kui <strong><xsl:value-of select="$pikkus"/></strong> märki</h3>
<ul><xsl:for-each select="//inimene[string-length(nimi) &gt; $pikkus]"><li><xsl:value-of select="nimi"/> (<xsl:value-of select="string-length(nimi)"/> märki)</li></xsl:for-each><xsl:if test="not(//inimene[string-length(nimi) &gt; $pikkus])"><li>Ei leitud</li></xsl:if></ul>
<p class="text-muted">Roheline taust: nimi on lühem kui 7 märki.</p>
<h2>Tabel</h2><div class="table-responsive"><table class="table table-striped"><thead><tr><th>Nimi</th><th>Sünniaasta</th><th>Surma-aasta</th><th>Vanus</th><th>Vanem</th><th>Vanavanem</th><th>Vanema vanus lapse sünnil</th><th>Lapsi</th></tr></thead><tbody>
<xsl:for-each select="//inimene">
<tr><td><xsl:if test="string-length(nimi)&lt;7"><xsl:attribute name="class">roheline</xsl:attribute></xsl:if><xsl:value-of select="nimi"/></td>
<td><xsl:value-of select="@synd"/></td><td><xsl:choose><xsl:when test="@surm"><xsl:value-of select="@surm"/></xsl:when><xsl:otherwise>-</xsl:otherwise></xsl:choose></td><td><xsl:call-template name="vanus"/></td>
<td><xsl:call-template name="vanem"/></td><td><xsl:call-template name="vanavanem"/></td><td><xsl:call-template name="vanemaVanus"/></td><td><xsl:value-of select="count(lapsed/inimene)"/></td></tr>
</xsl:for-each></tbody></table></div>
<p class="text-muted">Vanused on aastaarvude vahed (<xsl:value-of select="$aasta"/>). Näidatud on XML-is olevad sugulussidemed ja laste arv, mitte kogu kuninglik perekond.</p>
</xsl:template><xsl:template match="inimene"><li><xsl:value-of select="nimi"/> (<xsl:value-of select="@synd"/><xsl:if test="@surm">-<xsl:value-of select="@surm"/></xsl:if>, vanus <xsl:call-template name="vanus"/>)<xsl:if test="lapsed/inimene"><ul><xsl:apply-templates select="lapsed/inimene"/></ul></xsl:if></li></xsl:template></xsl:stylesheet>
