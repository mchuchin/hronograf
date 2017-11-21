<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version = '1.0' 
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method="html"/>

<xsl:template match="status">
</xsl:template>

<xsl:template match="rating">
	<table cellspacing="0" align="center" border="1">
		<caption><strong>���������� ������������ ���������. ������: <xsl:value-of select="@period"/></strong></caption>
		<tr>
			<td rowspan="2" align="center"><Strong>�������</Strong></td>
			<td colspan="3" align="center">������� ���� �� ������</td>
			<td colspan="3" align="center">����� ����������� ������, ������� ����������</td>
		</tr><tr>
			<td align="center">���. �� ������</td>
			<td align="center"><b>���������</b></td>
			<td align="center">����. �� ������</td>
			<td align="center">����</td>
			<td align="center"><strong>����� ��</strong></td>
			<td align="center">����</td>
		</tr>

		<xsl:apply-templates select="subjects"/>
	</table>
</xsl:template>

<xsl:template match="subjects">
	<xsl:for-each select="subj">
	<tr>
			<xsl:if test="position() mod 2 = 1">
				<xsl:attribute name="bgcolor">#e8e8e8</xsl:attribute>
			</xsl:if>

		<td align="left"><strong>&#160;<xsl:value-of select="@name"/></strong></td>
		<td align="center">&#160;<xsl:value-of select="@min"/></td>
		<td align="center"><strong>&#160;<xsl:value-of select="@st"/></strong></td>
		<td align="center">&#160;<xsl:value-of select="@max"/></td>
		<td align="center">&#160;<xsl:value-of select="@lw"/></td>
		<td align="center"><strong>&#160;<xsl:value-of select="@sm"/></strong></td>
		<td align="center">&#160;<xsl:value-of select="@bt"/></td>
	</tr>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
