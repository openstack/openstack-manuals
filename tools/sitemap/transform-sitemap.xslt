<?xml version="1.0"?>
<!-- Use this transform on a sitemap.xml file generated from freesitemapgenerator.com -->
<!-- It removes the /trunk URLs and the release URLs that you indicate below, here it's folsom -->
<xsl:stylesheet version="1.0"
    xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- template match equals any other url element, keep -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- discard any url/loc that refer to trunk or folsom -->
    <xsl:template match="sm:url[starts-with(./sm:loc,'http://docs.openstack.org/trunk')]"/>
    <xsl:template match="sm:url[starts-with(./sm:loc,'http://docs.openstack.org/folsom')]"/>
    
</xsl:stylesheet>