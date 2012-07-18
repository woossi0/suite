/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.demo;

import static org.geoserver.ows.util.ResponseUtils.*;
import static org.geoserver.web.demo.OpenGeoPreviewProvider.*;

import java.util.logging.Level;

import org.apache.wicket.Component;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.markup.html.link.ExternalLink;
import org.apache.wicket.markup.html.panel.Fragment;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.geoserver.catalog.LayerInfo;
import org.geoserver.web.GeoServerBasePage;
import org.geoserver.web.demo.PreviewLayer.PreviewLayerType;
import org.geoserver.web.wicket.GeoServerTablePanel;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.opengis.referencing.crs.CoordinateReferenceSystem;

/**
 * Shows a paged list of the available layers and points to previews in various formats
 */
@SuppressWarnings("serial")
public class OpenGeoMapPreviewPage extends GeoServerBasePage {

    static CoordinateReferenceSystem EPSG_3857;
    static {
        try {
            EPSG_3857 = CRS.decode("EPSG:3857");
        } catch (Exception e) {
            LOGGER.log(Level.FINER, e.getMessage(), e);
        }
    }
    OpenGeoPreviewProvider provider = new OpenGeoPreviewProvider();

    GeoServerTablePanel<OpenGeoPreviewLayer> table;

    public OpenGeoMapPreviewPage() {
        // build the table
        table = new GeoServerTablePanel<OpenGeoPreviewLayer>("table", provider) {

            @Override
            protected Component getComponentForProperty(String id, final IModel itemModel,
                    Property<OpenGeoPreviewLayer> property) {
                OpenGeoPreviewLayer layer = (OpenGeoPreviewLayer) itemModel.getObject();

                if (property == TYPE) {
                    Fragment f = new Fragment(id, "iconFragment", OpenGeoMapPreviewPage.this);
                    f.add(new Image("layerIcon", layer.getTypeSpecificIcon()));
                    return f;
                } else if (property == NAME) {
                    return new Label(id, property.getModel(itemModel));
                } else if (property == TITLE) {
                    return new Label(id, property.getModel(itemModel));
                } else if (property == OL) {
                    final String olUrl = layer.getWmsLink() + "&format=application/openlayers";
                    Fragment f = new Fragment(id, "newpagelink", OpenGeoMapPreviewPage.this);
                    f.add(new ExternalLink("link", new Model(olUrl), new Model("OpenLayers")));
                    return f;
                } else if (property == GE) {
                    final String kmlUrl = "../wms/kml?layers=" + layer.getName();
                    Fragment f = new Fragment(id, "exlink", OpenGeoMapPreviewPage.this);
                    f.add(new ExternalLink("link", new Model(kmlUrl),  new Model("Google Earth")));
                    return f;
                } else if (property == GEOEXPLORER) {
                    // geoexplorer link
                    String gxpLink = 
                        System.getProperty("opengeo.geoexplorer.url", "/geoexplorer");
                    gxpLink = gxpLink.endsWith("/") ? gxpLink.substring(0,gxpLink.length()-1) : gxpLink;

                    gxpLink += "/composer/?layers=" + urlEncode(layer.getName());
                    ReferencedEnvelope env = null;
                    if (layer.getType() == PreviewLayerType.Group) {
                        env = layer.getLayerGroup().getBounds();
                    }
                    else {
                        env = layer.getLayer().getResource().getLatLonBoundingBox();
                    }
                    if (env != null) {
                        try {
                            env = env.transform(EPSG_3857, true);
                            if (env != null) {
                                gxpLink += "&bbox=" + urlEncode(String.format("%f,%f,%f,%f", 
                                    env.getMinX(), env.getMinY(), env.getMaxX(), env.getMaxY()));
                                //gxpLink += "&lazy=true";
                            }
                        }
                        catch(Exception e) {
                            LOGGER.log(Level.WARNING, "Unable to reproject to spherical mercator", e);
                        }
                    }

                    Fragment f = new Fragment(id, "newpagelink", OpenGeoMapPreviewPage.this);
                    f.add(new ExternalLink("link", new Model(gxpLink),  new Model("GeoExplorer")));
                    return f;
                }
                return null;
            }

        };
        table.setOutputMarkupId(true);
        add(table);
    }

}
