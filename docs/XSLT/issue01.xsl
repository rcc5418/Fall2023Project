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
                <title><xsl:apply-templates select="descendant::titleStmt/title"/></title>
                <link rel="icon" type="image/x-icon" href="images/small_ring.png" />
                <link rel="stylesheet" type="text/css" href="webstyle.css"/> 
            </head>
            <body>
                <h1 style="text-align: center">
                    <xsl:apply-templates select="descendant::titleStmt/title"/>
                </h1>
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
                Page <xsl:value-of select ="@xml:id ! substring-after(.,'_')"/>
                <xsl:apply-templates select="descendant::cbml:panel | p | figure[@type='pageImage']"/>
                <br/>
            </p>    
        </section>    
    </xsl:template>
    
    <xsl:template match="div[@type='page']/p">
        <br/>
            <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="div[@type='page']/figure/figDesc">
        <br/>
        <em>
            <xsl:apply-templates/>
        </em>
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
    
    <xsl:template match = "sound">
        <br/>
        <span class="sound">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="figure[@type='pageImage']">
        <br/>
        <img class="pageImage" src="{@rend}"/>
    </xsl:template>

</xsl:stylesheet>