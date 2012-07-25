package org.geoserver.web.demo;

import org.geoserver.catalog.LayerGroupInfo;
import org.geoserver.catalog.LayerInfo;

public class OpenGeoPreviewLayer extends PreviewLayer {

    LayerInfo layer;
    LayerGroupInfo layerGroup;

    public OpenGeoPreviewLayer(LayerInfo layer) {
        super(layer);
        this.layer = layer;
    }

    public OpenGeoPreviewLayer(LayerGroupInfo layerGroup) {
        super(layerGroup);
        this.layerGroup = layerGroup;
    }

    public LayerInfo getLayer() {
        return layer;
    }

    public LayerGroupInfo getLayerGroup() {
        return layerGroup;
    }
}
