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
                <link rel="stylesheet" type="text/css" href="XSLTWebstyle.css"/> 
            </head>
            <body>
                <h1 style="text-align: center">
                    <xsl:apply-templates select="descendant::titleStmt/title"/>
                </h1>
                <h2 style="text-align: center">Table of Contents</h2>
                <table>
                    <tr>
                    <th>Page</th>
                    <th>Links to Panels</th>
                </tr>
                <xsl:apply-templates select=".//div[@type='page']" mode="toc"/>
                </table>
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
                Page <xsl:value-of select ="@xml:id ! substring-after(.,'_')"/><br/>
                <xsl:apply-templates select="descendant::cbml:panel | p | figure[@type='pageImage']"/>
        </section>    
    </xsl:template>
    
    <xsl:template match="div[@type='page']/p">
            <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type='page']" mode="toc">
        <tr>
            <td>Page <xsl:value-of select="@xml:id ! substring-after(.,'_')"/></td>
            <td>
                <xsl:choose>
                    <xsl:when test="count(.//cbml:panel) != 0">
                        Panels:
                        <ul>
                            <xsl:apply-templates select=".//cbml:panel" mode="toc"/>
                        </ul>
                    </xsl:when>
                    <xsl:otherwise>
                        This page has no panels. <a href="#{@xml:id}">Jump to page</a>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="div[@type='page']/figure/figDesc">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    
    <xsl:template match="cbml:balloon">
            <xsl:value-of select="@who ! substring-after(.,'#') ! upper-case(.)"/>: <xsl:apply-templates/>
        <br/>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <div class="panel" id="page_{parent::div/@xml:id ! substring-after(.,'_')}_panel_{@n}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="cbml:panel" mode="toc">
        <li>
            <a href="#page_{parent::div/@xml:id ! substring-after(.,'_')}_panel_{@n}">Panel <xsl:value-of select="@n"/></a>
        </li>
    </xsl:template>
    
    <xsl:template match="note[@type='panelDesc']">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="cbml:caption">
        <strong><xsl:apply-templates/></strong>
        <br/>
    </xsl:template>
    
    <xsl:template match = "sound">
        <span class="sound">
            <xsl:apply-templates/>
        </span>
        <br/>
    </xsl:template>
    
    <xsl:template match="figure[@type='pageImage']">
        <img class="pageImage" src="{@rend}"/>
    </xsl:template>
    
    <xsl:template match="cbml:balloon/emph[@rend='bold']">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>

</xsl:stylesheet>