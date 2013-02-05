<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
    xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
    xmlns="http://www.opengis.net/sld" 
    xmlns:ogc="http://www.opengis.net/ogc" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <NamedLayer>
    <Name>rivers_lakes_centerlines</Name>
    <UserStyle>
      <Title>Rivers</Title>
      <FeatureTypeStyle>
        <Rule>
          <MinScaleDenominator> 4000000 </MinScaleDenominator>
          <MaxScaleDenominator> 20800512 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#99B3CC</CssParameter>
              <CssParameter name="stroke-width">1.1</CssParameter>    
            </Stroke>
          </LineSymbolizer>
         </Rule>
        
        <Rule>
          <MinScaleDenominator>  500000 </MinScaleDenominator>
          <MaxScaleDenominator> 4000000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#99B3CC</CssParameter>
              <CssParameter name="stroke-width">1.75</CssParameter>    
            </Stroke>
          </LineSymbolizer>
         </Rule>
        
         <Rule>
         <MinScaleDenominator> 846 </MinScaleDenominator>
         <MaxScaleDenominator> 500000 </MaxScaleDenominator>
         <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#99B3CC</CssParameter>
              <CssParameter name="stroke-width">2.5</CssParameter>    
            </Stroke>
          </LineSymbolizer>
         </Rule>  
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>