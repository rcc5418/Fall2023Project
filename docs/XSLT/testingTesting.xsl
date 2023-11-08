<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="cbml-collection" as="document-node()+" select="collection('../XML/Issues/?select=*.xml')"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>CBML TRANSFORM!!</title>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/>
            </head>
            <body>
                <h1>Comic Collection</h1> 
                <ul>
                    <xsl:apply-templates select="$cbml-collection//titleStmt"/>
                </ul>
            </body>
        </html>
    </xsl:template> 
    <xsl:template match="titleStmt">
        <li>
            <em><xsl:apply-templates select="title"></xsl:apply-templates></em>
        </li>
    </xsl:template>
    
</xsl:stylesheet>