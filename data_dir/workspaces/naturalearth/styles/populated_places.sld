<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>populated_places</Name>
    <UserStyle>
      <Title>Populated Places</Title>
      <FeatureTypeStyle>
 <!--z4-->     
        <Rule>
          <Name>Major Cities z4</Name>
          <Title>2500000+</Title>
           <ogc:Filter>
             <ogc:PropertyIsGreaterThanOrEqualTo>
               <ogc:PropertyName>pop_max</ogc:PropertyName>
               <ogc:Literal>2500000</ogc:Literal>
             </ogc:PropertyIsGreaterThanOrEqualTo>
           </ogc:Filter>      
          <MinScaleDenominator> 20800512 </MinScaleDenominator>
          <MaxScaleDenominator> 41601024 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>1</Size>
            </Graphic>
          </PointSymbolizer> 
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Sans Serif</CssParameter>
                <CssParameter name="font-size">9</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
 <!--z5-->       
        <Rule>
          <Name>Major Cities z5</Name>
          <Title>2500000+</Title>
           <ogc:Filter>
             <ogc:PropertyIsGreaterThanOrEqualTo>
               <ogc:PropertyName>pop_max</ogc:PropertyName>
               <ogc:Literal>2500000</ogc:Literal>
             </ogc:PropertyIsGreaterThanOrEqualTo>
           </ogc:Filter>      
          <MinScaleDenominator> 10400256 </MinScaleDenominator>
          <MaxScaleDenominator> 20800512 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>2</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">12</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
        <Rule>
          <Name>Large Cities z5</Name>
          <Title>2499999-500000</Title>
           <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>500000</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>2499999</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>      
          <MinScaleDenominator> 10400256 </MinScaleDenominator>
          <MaxScaleDenominator> 20800512 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1.5</CssParameter>
                </Stroke>
              </Mark>
              <Size>1.5</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">10</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>   
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
            <Fill>
                <CssParameter name="fill">#303030</CssParameter>
            </Fill> 
          </TextSymbolizer>
        </Rule>
 <!--z6-->       
        <Rule>
          <Name>Major Cities z6</Name>
          <Title>2500000+</Title>
           <ogc:Filter>
             <ogc:PropertyIsGreaterThanOrEqualTo>
               <ogc:PropertyName>pop_max</ogc:PropertyName>
               <ogc:Literal>2500000</ogc:Literal>
             </ogc:PropertyIsGreaterThanOrEqualTo>
           </ogc:Filter>      
          <MinScaleDenominator> 5200128 </MinScaleDenominator>
          <MaxScaleDenominator> 10400256 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>2</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">14</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
        <Rule>
          <Name>Large Cities z6</Name>
          <Title>2499999-500000</Title>
           <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>500000</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>2499999</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>      
          <MinScaleDenominator> 5200128 </MinScaleDenominator>
          <MaxScaleDenominator> 10400256 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1.5</CssParameter>
                </Stroke>
              </Mark>
              <Size>1.5</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">12</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>   
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
            <Fill>
                <CssParameter name="fill">#303030</CssParameter>
            </Fill> 
          </TextSymbolizer>
        </Rule>
        <Rule>
          <Name>Medium Cities z6</Name>
          <Title>499999-100000</Title>
           <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>100000</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>499999</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>      
          <MinScaleDenominator> 5200128 </MinScaleDenominator>
          <MaxScaleDenominator> 10400256 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>1</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">10</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>   
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
            <Fill>
                <CssParameter name="fill">#404040</CssParameter>
            </Fill> 
          </TextSymbolizer>
        </Rule>
 <!--z7-z19-->       
        <Rule>
          <Name>Major Cities z7</Name>
          <Title>2500000+</Title>
           <ogc:Filter>
             <ogc:PropertyIsGreaterThanOrEqualTo>
               <ogc:PropertyName>pop_max</ogc:PropertyName>
               <ogc:Literal>2500000</ogc:Literal>
             </ogc:PropertyIsGreaterThanOrEqualTo>
           </ogc:Filter>      
          <MinScaleDenominator> 846 </MinScaleDenominator>
          <MaxScaleDenominator> 5200128 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">2</CssParameter>
                </Stroke>
              </Mark>
              <Size>2</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">14</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
          </TextSymbolizer>
        </Rule>
        <Rule>
          <Name>Large Cities z7</Name>
          <Title>2499999-500000</Title>
           <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>500000</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>2499999</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>      
          <MinScaleDenominator> 846 </MinScaleDenominator>
          <MaxScaleDenominator> 5200128 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1.5</CssParameter>
                </Stroke>
              </Mark>
              <Size>1.5</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">12</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>   
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
            <Fill>
                <CssParameter name="fill">#303030</CssParameter>
            </Fill> 
          </TextSymbolizer>
        </Rule>
        <Rule>
          <Name>Medium Cities z7</Name>
          <Title>499999-100000</Title>
           <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>100000</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>499999</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>      
          <MinScaleDenominator> 846 </MinScaleDenominator>
          <MaxScaleDenominator> 5200128 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>1</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">10</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>   
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
            <Fill>
                <CssParameter name="fill">#404040</CssParameter>
            </Fill> 
          </TextSymbolizer>
        </Rule>
        <Rule>
          <Name>Small Cities z7</Name>
          <Title>99999-20000</Title>
           <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>20000</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThan>
                <ogc:PropertyName>pop_max</ogc:PropertyName>
                <ogc:Literal>99999</ogc:Literal>
              </ogc:PropertyIsLessThan>
            </ogc:And>
          </ogc:Filter>      
          <MinScaleDenominator> 846 </MinScaleDenominator>
          <MaxScaleDenominator> 5200128 </MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#FF0000</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                  <CssParameter name="stroke-width">1</CssParameter>
                </Stroke>
              </Mark>
              <Size>1</Size>
            </Graphic>
          </PointSymbolizer>  
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">9</CssParameter>
                <CssParameter name="font-style">normal</CssParameter>
                <CssParameter name="font-weight">normal</CssParameter>   
            </Font>
            <LabelPlacement>
                <PointPlacement>
                  <AnchorPoint>
                    <AnchorPointX>0.5</AnchorPointX>
                    <AnchorPointY>0.0</AnchorPointY>
                  </AnchorPoint>
                  <Displacement>
                    <DisplacementX>0</DisplacementX>
                    <DisplacementY>3</DisplacementY>
                  </Displacement>
                </PointPlacement>
            </LabelPlacement>
            <Halo>
              <Radius>1</Radius>
              <Fill>
                <CssParameter name="fill">#FFFFFF</CssParameter>
              </Fill>
            </Halo>
            <Fill>
                <CssParameter name="fill">#686868</CssParameter>
            </Fill> 
          </TextSymbolizer>
        </Rule>              
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>