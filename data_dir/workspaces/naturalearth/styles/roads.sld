<?xml version="1.0" encoding="UTF-8"?><sld:StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml" version="1.0.0">
  <sld:NamedLayer>
    <sld:Name>Default Styler</sld:Name>
    <sld:UserStyle>
      <sld:Name>Default Styler</sld:Name>
      <sld:Title>Roads</sld:Title>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
    </ogc:Filter>
          <sld:MinScaleDenominator>1.0400256E7</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>2.0800512E7</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#F7D995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>5200128.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>1.0400256E7</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#F7D998</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>2600064.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>5200128.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#DDA939</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>2600064.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>5200128.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFC145</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>2600064.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>5200128.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#D9C995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>2600064.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>5200128.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFB89</sld:CssParameter>
              <sld:CssParameter name="stroke-width">.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>650016.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>2600064.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#DDA939</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>650016.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>2600064.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFC145</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>650016.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>2600064.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#D9C995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>650016.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>2600064.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFB89</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>162504.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>650016.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#DDA939</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">4</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>162504.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>650016.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFC145</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">2</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>162504.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>650016.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#D9C995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>162504.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>650016.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFB89</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
            <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Road</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>162504.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>650016.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#D9C995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.25</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Road</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>162504.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>650016.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFB89</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.33</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>846.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>162504.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#DDA939</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
      <ogc:Or>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Major Highway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Beltway</ogc:Literal>
        </ogc:PropertyIsEqualTo>
        <ogc:PropertyIsEqualTo>
    <ogc:PropertyName>type</ogc:PropertyName>
    <ogc:Literal>Bypass</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Or>
          </ogc:Filter>
          <sld:MinScaleDenominator>846.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>162504.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFC145</sld:CssParameter>
              <sld:CssParameter name="stroke-linecap">round</sld:CssParameter>
              <sld:CssParameter name="stroke-width">3</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>846.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>162504.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#D9C995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Secondary Highway</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>846.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>162504.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFB89</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Road</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>846.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>162504.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#D9C995</sld:CssParameter>
              <sld:CssParameter name="stroke-width">1.25</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:Rule>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>type</ogc:PropertyName>
              <ogc:Literal>Road</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <sld:MinScaleDenominator>846.0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>162504.0</sld:MaxScaleDenominator>
          <sld:LineSymbolizer>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFB89</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.33</sld:CssParameter>
            </sld:Stroke>
          </sld:LineSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>