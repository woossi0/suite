<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>boundary_lines_land</Name>
    <UserStyle>
      <Title>National Boundaries</Title>
      <FeatureTypeStyle>
  <!--z1-->     
        <Rule>
         <MinScaleDenominator> 2.0800512E7 </MinScaleDenominator>
           <MaxScaleDenominator> 1.0800512E8 </MaxScaleDenominator>
         <LineSymbolizer>
          <Stroke>
              <CssParameter name="stroke">#383537</CssParameter>
              <CssParameter name="stroke-width">0.1</CssParameter>
              <CssParameter name="stroke-linecap">round</CssParameter>
          </Stroke>
         </LineSymbolizer>
        </Rule>
      </FeatureTypeStyle>
      <FeatureTypeStyle> 
     
      <Rule>
         <MinScaleDenominator> 4.0800512E6</MinScaleDenominator>
         <MaxScaleDenominator>  2.0800512E7  </MaxScaleDenominator>
         <LineSymbolizer>
          <Stroke>
              <CssParameter name="stroke">#383537</CssParameter>
              <CssParameter name="stroke-width">0.5</CssParameter>
              <CssParameter name="stroke-linecap">round</CssParameter>
          </Stroke>
         </LineSymbolizer>
        </Rule>
      </FeatureTypeStyle>
      <FeatureTypeStyle> 
        
 <!--z2-z19-->     
        <Rule>
         <MinScaleDenominator> 846 </MinScaleDenominator>
         <MaxScaleDenominator> 4.0800512E6 </MaxScaleDenominator>
         <LineSymbolizer>
          <Stroke>
              <CssParameter name="stroke">#FFFFFF</CssParameter>
              <CssParameter name="stroke-width">5</CssParameter>
          </Stroke>
         </LineSymbolizer>
         <LineSymbolizer>
          <Stroke>
              <CssParameter name="stroke">#000000</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-linecap">round</CssParameter>
          </Stroke>
         </LineSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>