<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="3.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="#all"
  expand-text="yes">

  <xsl:output method="xml" indent="no"/>

  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:template name="xsl:initial-template">
    <xsl:variable name="input-uris" select="uri-collection('input-samples?select=*.xml')"/>
    <xsl:iterate select="$input-uris">
      <xsl:param name="failed-uris" as="xs:anyURI*" select="()"/>
      <xsl:on-completion>
        <xsl:if test="not(empty($failed-uris))">
          <xsl:result-document href="failed-uris.txt" method="text" item-separator="&#10;">
            <xsl:sequence select="$failed-uris"/>
          </xsl:result-document>
        </xsl:if>
      </xsl:on-completion>
      <xsl:try>
        <xsl:apply-templates select="doc(.)"/>
        <xsl:catch> 
          <xsl:next-iteration>
            <xsl:with-param name="failed-uris" select="$failed-uris, ."/>
          </xsl:next-iteration>
        </xsl:catch>
      </xsl:try>
    </xsl:iterate>
  </xsl:template>

</xsl:stylesheet>