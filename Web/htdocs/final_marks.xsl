<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version = '1.0' 
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method="html"/>

<xsl:template match="status">
</xsl:template>


<xsl:template match="final_marks">
	<table cellspacing="0" align="center" border="1"><caption><strong>Итоговые оценки учащегося</strong></caption>
		<xsl:apply-templates select="cols"/>
		<xsl:apply-templates select="marks"/>
	</table>
</xsl:template>

<xsl:template match="cols">
	<tr>
	<xsl:for-each select="column">
		<td>
		<strong>
		<xsl:attribute name="style">border-bottom-width:2</xsl:attribute>
		&#160;<xsl:value-of select="@name"/>
		</strong>
		</td>
	</xsl:for-each>
	</tr>
</xsl:template>

<xsl:template match="marks">
	<xsl:for-each select="subject">
		<tr>
			<xsl:if test="position() mod 2 = 1">
				<xsl:attribute name="bgcolor">#e8e8e8</xsl:attribute>
			</xsl:if>
			<td>
			&#160;<xsl:value-of select="@name"/>
			</td>
	
			<xsl:for-each select="m">
				<td>
				&#160;<xsl:value-of select="@v"/>
				</td>
			</xsl:for-each>
		</tr>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
