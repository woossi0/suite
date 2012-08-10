/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.demo;

import static org.geoserver.ows.util.ResponseUtils.*;
import static org.geoserver.web.demo.OpenGeoPreviewProvider.*;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;

import org.apache.wicket.Component;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.markup.html.link.ExternalLink;
import org.apache.wicket.markup.html.panel.Fragment;
import org.apache.wicket.markup.repeater.RepeatingView;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.geoserver.web.GeoServerBasePage;
import org.geoserver.web.demo.PreviewLayer.PreviewLayerType;
import org.geoserver.web.wicket.GeoServerTablePanel;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;
import org.geoserver.wfs.WFSGetFeatureOutputFormat;
import org.geoserver.wms.GetMapOutputFormat;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.opengis.referencing.crs.CoordinateReferenceSystem;

/**
 * Shows a paged list of the available layers and points to previews in various formats
 */
@SuppressWarnings("serial")
public class OpenGeoMapPreviewPage extends GeoServerBasePage {
    private final static LinkTemplate geoexplorer;
    private final static LinkTemplate googleEarth;
    private final static LinkTemplate openLayers;
   
    private static final List<LinkTemplate> applicationLinkTemplates;
    static {
    	CoordinateReferenceSystem EPSG_3857 = null;
        try {
            EPSG_3857 = CRS.decode("EPSG:3857");
        } catch (Exception e) {
            LOGGER.log(Level.FINER, e.getMessage(), e);
        }
    	
    	String base = System.getProperty("opengeo.geoexplorer.url", "/geoexplorer").replaceFirst("/$", "");
    	geoexplorer = new GeoExplorerLinkTemplate(base, EPSG_3857);
    	googleEarth = new StringFormattingLinkTemplate(true, "Google Earth", "../wms/kml?layers=%s");
    	openLayers = new WMSLinkTemplate("OpenLayers", false, "&format=application/openlayers");

    	List<LinkTemplate> builder = new ArrayList<LinkTemplate>();
    	builder.add(openLayers);
    	builder.add(googleEarth);
    	builder.add(geoexplorer);
    	applicationLinkTemplates = Collections.unmodifiableList(builder);
    }
    
    OpenGeoPreviewProvider provider = new OpenGeoPreviewProvider();

    GeoServerTablePanel<OpenGeoPreviewLayer> table;

    public OpenGeoMapPreviewPage() {
    	final List<LinkTemplate> templates = new ArrayList<LinkTemplate>();
    	templates.addAll(applicationLinkTemplates);
    	templates.addAll(wfsLinkTemplates());
    	templates.addAll(wmsLinkTemplates());    	
        // build the table
        table = new GeoServerTablePanel<OpenGeoPreviewLayer>("table", provider) {

            @Override
            @SuppressWarnings("rawtypes")
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
                } else if (property == LINKS) {
                	Fragment f = new Fragment(id, "exlink", OpenGeoMapPreviewPage.this);
                    RepeatingView view = new RepeatingView("link");
                    for (LinkTemplate tpl : templates) {
                    	if (tpl.appliesToLayer(layer)) {
	                    	Label label = new Label(view.newChildId(), new Model<String>(tpl.label()));
	                    	label.add(new SimpleAttributeModifier("value", tpl.linkForLayer(layer)));
	                    	view.add(label);
                    	}
                    }
                    f.add(view);
                    
                    return f;
                }
                return null;
            }

        };
        table.setOutputMarkupId(true);
        add(table);
    }

    private List<LinkTemplate> wmsLinkTemplates() {
    	List<LinkTemplate> linkTemplates = new ArrayList<LinkTemplate>();
    	for (GetMapOutputFormat f : getGeoServerApplication().getBeansOfType(GetMapOutputFormat.class)) {
    		linkTemplates.add(new WMSLinkTemplate(translate("format.wms.", f.getMimeType()), true, "&format=" + f.getMimeType()));
    	}
    	return Collections.unmodifiableList(linkTemplates);
    }
    
    private List<LinkTemplate> wfsLinkTemplates() {
    	List<LinkTemplate> linkTemplates = new ArrayList<LinkTemplate>();
    	for (WFSGetFeatureOutputFormat format : getGeoServerApplication().getBeansOfType(WFSGetFeatureOutputFormat.class)) {
    		for (String type : format.getOutputFormats()) {
    			linkTemplates.add(new WFSLinkTemplate(translate("format.wfs.", type), true, "&maxfeatures=50&outputformat=" + urlEncode(type)));
    		}
    	}
    	return Collections.unmodifiableList(linkTemplates);
    }
    
    private String translate(String prefix, String key) {
    	try {
    		return getLocalizer().getString(prefix + key, this);
    	} catch (Exception e) {
    		LOGGER.log(Level.INFO, e.getMessage());
    		return key;
    	}
    }
    		    
    private static class StringFormattingLinkTemplate implements LinkTemplate, Serializable {
    	private final String labelText;
    	private final boolean isExternal;
    	private final String format;

    	public StringFormattingLinkTemplate(boolean isExternal, String labelText, String format) {
    		this.isExternal = isExternal;
    		this.labelText = labelText;
    		this.format = format;
    	}
    	
    	public boolean appliesToLayer(OpenGeoPreviewLayer layer) {
    		return true;
    	}
    	
    	public boolean isExternalLink(OpenGeoPreviewLayer layer) {
    		return isExternal;
    	}
    	
    	public String linkForLayer(OpenGeoPreviewLayer layer) {
    		return String.format(Locale.ENGLISH, format, urlEncode(layer.getName()));
    	}
    	
    	public String label() {
    		return labelText;
    	}
    }
    
    private static class WMSLinkTemplate implements LinkTemplate, Serializable {
    	private final String labelText;
    	private final boolean isExternal;
    	private final String extraParams;
    	
    	public WMSLinkTemplate(String labelText, boolean isExternal, String extraParams) {
    		this.labelText = labelText;
    		this.isExternal = isExternal;
    		this.extraParams = extraParams;
    	}
    	
    	public boolean appliesToLayer(OpenGeoPreviewLayer layer) {
    		return true;
    	}
    	
    	public boolean isExternalLink(OpenGeoPreviewLayer layer) {
    		return isExternal;
    	}
    	
    	public String linkForLayer(OpenGeoPreviewLayer layer) {
    		return layer.getWmsLink() + extraParams;
    	}
    	
    	public String label() {
    		return labelText;
    	}
    }
    
    private static class WFSLinkTemplate implements LinkTemplate, Serializable {
    	private final String labelText;
    	private final boolean isExternal;
    	private final String extraParams;
    	
    	public WFSLinkTemplate(String labelText, boolean isExternal, String extraParams) {
    		this.labelText = labelText;
    		this.isExternal = isExternal;
    		this.extraParams = extraParams;
    	}
    	
    	public boolean appliesToLayer(OpenGeoPreviewLayer layer) {
    		return layer.getType() == PreviewLayerType.Vector;
    	}
    	
    	public boolean isExternalLink(OpenGeoPreviewLayer layer) {
    		return isExternal;
    	}
    	
    	public String linkForLayer(OpenGeoPreviewLayer layer) {
    		return layer.getBaseUrl("ows") + "?service=WFS&version=1.0.0&request=GetFeature&typeName="
    		          + urlEncode(layer.getName()) + extraParams;
    	}
    	
    	public String label() {
    		return labelText;
    	}
    }

    private static class GeoExplorerLinkTemplate implements LinkTemplate, Serializable {
    	private final String base;
    	private final CoordinateReferenceSystem webMercator;
    	
    	public GeoExplorerLinkTemplate(String base, CoordinateReferenceSystem webMercator) {
    		this.base = base;
    		this.webMercator = webMercator;
    	}
    	
    	public boolean appliesToLayer(OpenGeoPreviewLayer layer) {
    	    return true;
    	}
    	
    	public boolean isExternalLink(OpenGeoPreviewLayer layer) {
    	    return false;
    	}
    	
    	public String linkForLayer(OpenGeoPreviewLayer layer) {
    		ReferencedEnvelope env = null;
    		String boundsAsQueryParam = null;
    		
    		if (layer.getType() == PreviewLayerType.Group) {
    			env = layer.getLayerGroup().getBounds();
    		} else {
    			env = layer.getLayer().getResource().getLatLonBoundingBox();
    		}
    		
    		if (env != null) {
    			try {
    			    env = env.transform(webMercator, true);
    			    boundsAsQueryParam = String.format(Locale.ENGLISH, "&bbox=%f,%f,%f,%f", env.getMinX(), env.getMinY(), env.getMaxX(), env.getMaxY());
    			} catch (Exception e) {
    				LOGGER.log(Level.WARNING, "Unable to reproject layer " + layer.getName() + "to spherical mercator");
    			}
    		}
    		
    		return base + "/composer/?layers=" + urlEncode(layer.getName()) + (boundsAsQueryParam == null ? "" : "&" + boundsAsQueryParam);
    	}
    	
    	public String label() {
    		return "GeoExplorer";
    	}
    }
}
