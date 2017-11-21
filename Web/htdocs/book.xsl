<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version = '1.0' 
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method="html"/>

<xsl:template match="status">
</xsl:template>

<xsl:template match="data">
	<table align="center" class="bt1"><caption><strong>Дневник учащегося с <xsl:apply-templates select="@begin_date"/> по <xsl:apply-templates select="@end_date"/></strong></caption>
	<tr>
		<td style="border-width: 1px 1px 2px 1px;" align="center"><Strong>Дата</Strong></td>
		<td style="border-width: 1px 1px 2px 1px;"><Strong>Предмет</Strong></td>
		<td style="border-width: 1px 1px 2px 1px;"><Strong>Домашнее задание</Strong></td>
		<td style="border-width: 1px 1px 2px 1px;" align="center"><Strong>Оценки</Strong></td>
		<td style="border-width: 1px 1px 2px 1px;" align="center"><Strong>Запись в дневник</Strong></td>
		<td style="border-width: 1px 1px 2px 1px;" align="center"><Strong>Статус урока</Strong></td>
	</tr>
		<xsl:apply-templates select="day"/>
	</table>
</xsl:template>

<xsl:template match="day">
	<tr>
	<td style="border-width: 1px 1px 2px 1px;" align="center">
	<xsl:attribute name="rowspan"><xsl:value-of select="count(les)+1"/></xsl:attribute>
	<Strong><xsl:value-of select="@day_of_week"/></Strong>
	<br></br>
	<xsl:apply-templates select="@date"/>
	<br></br>



	<xsl:variable name = "htt" select = "sum(les/@dzt)"/>
	<xsl:if test="(floor(number($htt))!='0')">
		Д.З.:
		<xsl:value-of select="format-number(floor(number($htt) div 60), '#')"/>ч
		<xsl:value-of select="floor(number($htt) mod 60)"/>мин
	</xsl:if> 

	
	</td>
	</tr>

	<xsl:for-each select="les">
		<tr>
			<xsl:if test="position() mod 2 = 1">
				<xsl:attribute name="style">background-color: #e8e8e8</xsl:attribute>
			</xsl:if>
		<td>
			<xsl:if test="(position()=last())"> 
				<xsl:attribute name="style">border-width: 1px 1px 2px 1px;</xsl:attribute>
			</xsl:if> 
			<xsl:value-of select="@sbj"/>
		</td>

		<td>
			<xsl:if test="(position()=last())"> 
				<xsl:attribute name="style">border-width: 1px 1px 2px 1px;</xsl:attribute>
			</xsl:if> 
			<xsl:value-of select="@dz"/>

			<xsl:apply-templates select="@dzt"/>
		</td>

		<td align="center">
			<xsl:if test="(position()=last())"> 
				<xsl:attribute name="style">border-width: 1px 1px 2px 1px;</xsl:attribute>
			</xsl:if> 
			
			<xsl:for-each select="m">
				<xsl:value-of select="@v"/>
				<xsl:if test="(@r!='')">(<xsl:value-of select="@r"/>)</xsl:if>
				<xsl:value-of select="@s"/> 
				<xsl:if test="not (position()=last())"> 
					<xsl:text>, </xsl:text> 
				</xsl:if> 
			</xsl:for-each> 
		</td>
		<td align="center">
			<xsl:if test="(position()=last())"> 
				<xsl:attribute name="style">border-width: 1px 1px 2px 1px;</xsl:attribute>
			</xsl:if> 

			<xsl:for-each select="comm">
				<xsl:value-of select="@T"/>
			</xsl:for-each> 
		</td>
		<td align="center">
			<xsl:if test="(position()=last())"> 
				<xsl:attribute name="style">border-width: 1px 1px 2px 1px;</xsl:attribute>
			</xsl:if> 

			<xsl:if test="@done='-1'"> 
				Проведен
			</xsl:if> 
			<xsl:if test="@done!='-1'"> 
			</xsl:if> 
		</td>
		</tr>
	</xsl:for-each>		

</xsl:template>

<xsl:template match="@begin_date"> 

	<xsl:variable name="D"> 
               <xsl:value-of select="."/>
	</xsl:variable>

       <xsl:value-of select="concat(substring(string($D),9,2),'.',substring(string($D),6,2),'.',substring(string($D),1,4))"/> 
</xsl:template>

<xsl:template match="@end_date"> 
	<xsl:variable name="D"> 
               <xsl:value-of select="."/>
	</xsl:variable>

       <xsl:value-of select="concat(substring(string($D),9,2),'.',substring(string($D),6,2),'.',substring(string($D),1,4))"/> 
</xsl:template>

<xsl:template match="@date"> 

	<xsl:variable name="D"> 
               <xsl:value-of select="."/>
	</xsl:variable>

       <xsl:value-of select="concat(substring(string($D),9,2),'.',substring(string($D),6,2),'.',substring(string($D),1,4))"/> 
</xsl:template>

<xsl:template match="@dzt"> 

	<xsl:variable name="D" select="."/>

	(<xsl:if test="(format-number(floor(number($D) div 60), '#')!='0')"> 
		<xsl:value-of select="format-number(floor(number($D) div 60), '#')"/>ч
	</xsl:if> 
	<xsl:value-of select="number($D) mod 60"/> мин)
</xsl:template>

</xsl:stylesheet>
