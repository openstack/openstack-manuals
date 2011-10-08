<?xml version="1.0" encoding="UTF-8"?>

<fop version="1.0">
    <!-- Base URL for resolving relative URLs -->
    <base>.</base>

    <!-- Source resolution in dpi (dots/pixels per inch) for determining the size of pixels in SVG and bitmap images, default: 72dpi -->
    <source-resolution>90</source-resolution>
    <!-- Target resolution in dpi (dots/pixels per inch) for specifying the target resolution for generated bitmaps, default: 72dpi -->
    <target-resolution>90</target-resolution>

    <!-- Default page-height and page-width, in case
         value is specified as auto -->
    <default-page-settings height="11in" width="8.26in"/>

    <renderers>
        <renderer mime="application/pdf">
            <filterList>
                <!-- provides compression using zlib flate (default is on) -->
                <value>flate</value>

                <!-- encodes binary data into printable ascii characters (default off)
                     This provides about a 4:5 expansion of data size -->
                <!-- <value>ascii-85</value> -->

                <!-- encodes binary data with hex representation (default off)
                     This filter is not recommended as it doubles the data size -->
                <!-- <value>ascii-hex</value> -->
            </filterList>
            <fonts>
                <directory recursive="true">$fontPath$</directory>
            </fonts>
        </renderer>
    </renderers>
</fop>
