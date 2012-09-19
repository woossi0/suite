<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0"
  xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
  xmlns="http://www.opengis.net/sld"
  xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <NamedLayer>
    <Name>contour_dem</Name>
    <UserStyle>
      <Title>Contour from DEM</Title>
      <Abstract>Extracts contours from DEM</Abstract>
      <FeatureTypeStyle>
        <Transformation>
          <ogc:Function name="gs:Contour">
            <ogc:Function name="parameter">
              <ogc:Literal>data</ogc:Literal>
            </ogc:Function>
            <ogc:Function name="parameter">
              <ogc:Literal>interval</ogc:Literal>
              <ogc:Literal>100</ogc:Literal>
            </ogc:Function>
            <ogc:Function name="parameter">
              <ogc:Literal>simplify</ogc:Literal>
              <ogc:Literal>true</ogc:Literal>
            </ogc:Function>   
            <ogc:Function name="parameter">
              <ogc:Literal>smooth</ogc:Literal>
              <ogc:Literal>true</ogc:Literal>
            </ogc:Function>   
          </ogc:Function>
        </Transformation>
        <Rule>
          <Name>rule</Name>
          <Title>Contour Line</Title>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#993300</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
