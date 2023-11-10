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
                <title>Sonic the Hedgehog (IDW)</title>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/> 
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::titleStmt/title"/></h1>
                <div id="readingView">
                    <xsl:apply-templates select="descendant::body"/>
                </div>
            </body>
        </html>
    </xsl:template> 
    
    <xsl:template match="body">
        <xsl:apply-templates select="./div[@type='page']"/>
    </xsl:template>
    
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="{@xml:id}">
            <p>
                <xsl:apply-templates select="descendant::cbml:panel | p"/>
            </p>
        </section>
    </xsl:template>
    
    <xsl:template match="cbml:balloon">
        <br/>
            <xsl:value-of select="@who ! substring-after(.,'#') ! upper-case(.)"/>: <xsl:apply-templates select="text()"/>
    </xsl:template>
    
    <xsl:template match="note[@type='panelDesc']">
        <br/>
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="cbml:caption">
        <br/>
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

</xsl:stylesheet>