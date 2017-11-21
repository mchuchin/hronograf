<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version = '1.0' 
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method="html"/>

<xsl:template match="status">
</xsl:template>

<xsl:template match="notes">
	<table align="center" class="bt1"><caption><strong>Записи в дневник учащегося</strong></caption>
	<tr>
		<td style="border-width: 1px 1px 2px 1px;" align="center"><Strong>Дата</Strong></td>
		<td style="border-width: 1px 1px 2px 1px;" align="center"><Strong>Запись</Strong></td>
	</tr>
		<xsl:apply-templates select="note"/>
	</table>
</xsl:template>

<xsl:template match="note">
	<tr>
		<xsl:if test="position() mod 2 = 1">
			<xsl:attribute name="style">background-color: #e8e8e8</xsl:attribute>
		</xsl:if>

		<td style="border-width: 1px 1px 2px 1px;" align="left">
			<xsl:apply-templates select="@Date"/>
		</td>
		<td style="border-width: 1px 1px 2px 1px;" align="left">
			<xsl:value-of select="@Text"/>
		</td>

	</tr>

</xsl:template>

<xsl:template match="@Date"> 

	<xsl:variable name="D"> 
               <xsl:value-of select="."/>
	</xsl:variable>

       <xsl:value-of select="concat(substring(string($D),9,2),'.',substring(string($D),6,2),'.',substring(string($D),1,4))"/> 
</xsl:template>

</xsl:stylesheet>
