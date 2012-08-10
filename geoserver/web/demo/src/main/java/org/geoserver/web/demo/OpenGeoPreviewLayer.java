package org.geoserver.web.demo;

import org.geoserver.catalog.LayerGroupInfo;
import org.geoserver.catalog.LayerInfo;

public class OpenGeoPreviewLayer extends PreviewLayer {

    private final LayerInfo layer;
    private final LayerGroupInfo layerGroup;

    public OpenGeoPreviewLayer(LayerInfo layer) {
        super(layer);
        this.layer = layer;
        this.layerGroup = null;
    }

    public OpenGeoPreviewLayer(LayerGroupInfo layerGroup) {
        super(layerGroup);
        this.layerGroup = layerGroup;
        this.layer = null;
    }

    public LayerInfo getLayer() {
        return layer;
    }

    public LayerGroupInfo getLayerGroup() {
        return layerGroup;
    }
}

interface LinkTemplate {
	boolean appliesToLayer(OpenGeoPreviewLayer layer);
	boolean isExternalLink(OpenGeoPreviewLayer layer);
	String linkForLayer(OpenGeoPreviewLayer layer);
	String label();
}