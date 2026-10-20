<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
  <xsl:decimal-format name="euro" decimal-separator="," grouping-separator=" "/>
  <xsl:template match="/reisid">
    <h2>Lennureisid kestvuse järgi</h2>
    <xsl:for-each select="reis[transport='lennureis']">
      <xsl:sort select="suund/kestvus" data-type="number" order="descending"/>
      <h1><xsl:value-of select="suund/riik"/></h1>
      <ul>
        <li class="reisi-suund-rida">Riik: <xsl:value-of select="suund/riik"/></li>
        <li class="reisi-suund-rida">Kestvus: <xsl:value-of select="suund/kestvus"/> päeva
          <xsl:if test="suund/kestvus &gt; 7"><xsl:text> - </xsl:text><strong class="pikk-reis">Pikk reis</strong></xsl:if>
        </li>
        <li>Transport: <xsl:value-of select="transport"/></li>
        <li>Majutus: <xsl:value-of select="majutus"/></li>
        <li>Ekskursioonid: <xsl:value-of select="ekskursioonid"/></li>
        <li>Muud kulud: <xsl:value-of select="format-number(muudKulud,'0,00','euro')"/> €</li>
        <li>Hinnang: <xsl:value-of select="hinnang"/>/10</li>
        <li>Reisihind: <xsl:value-of select="format-number(reisihind,'0,00','euro')"/> €</li>
        <li>Kogumaksumus: <strong><xsl:value-of select="format-number(reisihind + muudKulud,'0,00','euro')"/> €</strong></li>
      </ul>
    </xsl:for-each>
    <h2>Kolm oma ülesannet</h2>
    <h3>1. Mitu lennureisi on XML-is?</h3>
    <p>Lennureise on <strong><xsl:value-of select="count(reis[transport='lennureis'])"/></strong>.</p>
    <h3>2. Leia reisid, mille hinnang on vähemalt 8.</h3>
    <ul><xsl:for-each select="reis[hinnang &gt;= 8]"><li><xsl:value-of select="suund/riik"/> - <xsl:value-of select="hinnang"/>/10</li></xsl:for-each></ul>
    <h3>3. Arvuta kõigi reiside keskmine kogumaksumus.</h3>
    <p>Keskmine kogumaksumus: <strong><xsl:value-of select="format-number((sum(reis/reisihind) + sum(reis/muudKulud)) div count(reis),'0,00','euro')"/> €</strong>.</p>
    <h2>Kõik reisid</h2>
    <p>Kogumaksumus = reisihind + muud kulud. Ekskursioonide lahtris on tegevuste nimed, mitte eraldi hind.</p>
    <div class="table-responsive"><table class="table reiside-tabel">
      <thead><tr><th>Riik</th><th>Kestvus (päeva)</th><th>Transport</th><th>Majutus</th><th>Ekskursioonid</th><th>Muud kulud (€)</th><th>Hinnang</th><th>Reisihind (€)</th><th>Kogumaksumus (€)</th></tr></thead>
      <tbody><xsl:for-each select="reis">
        <xsl:sort select="suund/kestvus" data-type="number" order="descending"/>
        <tr><xsl:attribute name="class"><xsl:choose><xsl:when test="position() mod 2 = 0">paaris</xsl:when><xsl:otherwise>paaritu</xsl:otherwise></xsl:choose></xsl:attribute>
          <td><span class="reisi-suund"><xsl:value-of select="suund/riik"/></span></td>
          <td><span class="reisi-suund"><xsl:value-of select="suund/kestvus"/></span></td>
          <td><xsl:value-of select="transport"/></td><td><xsl:value-of select="majutus"/></td><td><xsl:value-of select="ekskursioonid"/></td>
          <td><xsl:value-of select="format-number(muudKulud,'0,00','euro')"/></td><td><xsl:value-of select="hinnang"/>/10</td>
          <td><xsl:value-of select="format-number(reisihind,'0,00','euro')"/></td><td><xsl:value-of select="format-number(reisihind + muudKulud,'0,00','euro')"/></td>
        </tr>
      </xsl:for-each></tbody>
    </table></div>
  </xsl:template>
</xsl:stylesheet>
