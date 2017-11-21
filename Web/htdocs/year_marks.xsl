<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version = '1.0' 
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method="html"/>

<xsl:template match="status">
</xsl:template>

<xsl:template match="year_marks">
	<table cellspacing="0" align="center" border="1"><caption><strong>Оценки учащегося</strong></caption>
		<xsl:apply-templates select="header"/>
		<xsl:apply-templates select="subheader"/>
		<xsl:apply-templates select="marks"/>
	</table>
</xsl:template>

<xsl:template match="header">
	<tr>
	<xsl:for-each select="column">
		<td align="center">
		<xsl:attribute name="colspan"><xsl:value-of select="@SubCols"/></xsl:attribute>
		<strong>
		<xsl:attribute name="style">border-bottom-width:2</xsl:attribute>
		&#160;<xsl:value-of select="@name"/>
		</strong>
		</td>
	</xsl:for-each>
	</tr>
</xsl:template>

<xsl:template match="subheader">
	<tr>
	<xsl:for-each select="column">
		<td align="center">
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
			<td align="center">
			&#160;<xsl:value-of select="@name"/>
			</td>
			<xsl:for-each select="m">
				<td align="center">
				&#160;<xsl:value-of select="@v"/>
				<xsl:for-each select="sm">
					<xsl:choose>
						<xsl:when test="(@d!='')">
							<span class="title"><xsl:value-of select="@v"/><em><xsl:apply-templates select="@d"/><i></i></em></span>
						</xsl:when> 
					<xsl:otherwise>
						<xsl:value-of select="@v"/>
					</xsl:otherwise> 
					</xsl:choose>

					<xsl:if test="not (position()=last())"> 
						<xsl:text>; </xsl:text> 
					</xsl:if> 
					
				</xsl:for-each>
				</td>
			</xsl:for-each>
		</tr>
	</xsl:for-each>
</xsl:template>

<xsl:template match="@d"> 

	<xsl:variable name="Da"> 
               <xsl:value-of select="."/>
	</xsl:variable>

       <xsl:value-of select="concat(substring(string($Da),9,2),'.',substring(string($Da),6,2),'.',substring(string($Da),1,4))"/> 
</xsl:template>

</xsl:stylesheet>
