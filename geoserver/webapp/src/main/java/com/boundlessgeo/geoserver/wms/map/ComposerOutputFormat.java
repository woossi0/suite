/* (c) 2015 Boundless, http://boundlessgeo.com
 * This code is licensed under the GPL 2.0 license.
 */
package com.boundlessgeo.geoserver.wms.map;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.IndexColorModel;
import java.awt.image.RenderedImage;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.geoserver.wms.GetMapRequest;
import org.geoserver.wms.MapProducerCapabilities;
import org.geoserver.wms.WMS;
import org.geoserver.wms.WMSMapContent;
import org.geoserver.wms.map.RenderedImageMap;
import org.geoserver.wms.map.RenderedImageMapOutputFormat;
import org.geotools.renderer.lite.StreamingRenderer;
import org.geotools.util.logging.Logging;

import com.boundlessgeo.geoserver.AppConfiguration;

/**
 * Extension of the regular png map output format. Invoked using {@code format=composer}
 * 
 * 
 * Includes {@code format_option=timeout:<timeout>}. Allows the user to specify a timeout in milliseconds.
 * If this, or the global WMS timeout is reached before the rendering completes, a partial image is returned.
 */
public class ComposerOutputFormat extends RenderedImageMapOutputFormat {
    
    AppConfiguration config;
    WMS wms;
    
    static final String FORMAT = "composer";
    static final String TYPE = "png";
    static final String MIME_TYPE = "image/png";
    
    static final Set<String> outputFormatNames = Collections.unmodifiableSet(new HashSet<String>(Arrays.asList(new String[] { FORMAT })));
    
    /** A logger for this class. */
    private static final Logger LOGGER = Logging.getLogger(ComposerOutputFormat.class);
    
    public ComposerOutputFormat(WMS wms, AppConfiguration config) {
        super(MIME_TYPE, new String[] {FORMAT}, wms);
        this.config = config;
        this.wms = wms;
    }
    
    //Only include format "composer" so as to not conflict with the regular PNG format
    @Override
    public Set<String> getOutputFormatNames() {
        return outputFormatNames;
    }
    
    /**
     * Produce the map. 
     */
    @Override
    public RenderedImageMap produceMap(final WMSMapContent mapContent, final boolean tiled) {
        //Need to track renderer, graphic, and preparedImage for this call to produceMap
        final InternalTimeoutOutputFormat localDelegate = 
                new InternalTimeoutOutputFormat(wms);
        return localDelegate.produceMap(mapContent, tiled);
    }
    
    @Override
    public MapProducerCapabilities getCapabilities(String format) {
        return super.getCapabilities(format);
    }
    /**
     * Wrapper class around RenderedImageMapOutputFormat that allows us to capture the 
     * StreaminRenderer and Graphics2D created by produceMap, so that we can halt/dispose these 
     * objects if we exceed the timeout threshold, and still return a partial image.
     * 
     * A new instance of this class should be instantiated for each call to produceMap.
     */
    protected class InternalTimeoutOutputFormat extends RenderedImageMapOutputFormat {
    
        protected WMSMapContent mapContent = null;
        protected StreamingRenderer renderer = null;
        protected Graphics2D graphic = null;
        protected RenderedImage preparedImage = null;
        
        protected RenderedImageMap map = null;
    
        InternalTimeoutOutputFormat(WMS wms) {
            super(MIME_TYPE, new String[] {FORMAT}, wms);
        }
        
        @Override
        public RenderedImageMap produceMap(final WMSMapContent mapContent, final boolean tiled) {
            this.mapContent = mapContent;
            final GetMapRequest request = mapContent.getRequest();
            RenderedImageMap map = null;
            this.map = null;
            
            int maxRenderingTime = wms.getMaxRenderingTime() * 1000;
            int localMaxRenderingTime = 0;
            
            Object timeoutOption = request.getFormatOptions().get("timeout");
            if (timeoutOption != null) {
                try {
                    localMaxRenderingTime = Integer.parseInt(timeoutOption.toString());
                } catch (NumberFormatException e) {
                    LOGGER.log(Level.WARNING,"Could not parse format_option \"timeout\": "+timeoutOption, e);
                }
            }
            if (maxRenderingTime == 0) {
                maxRenderingTime = localMaxRenderingTime;
            } else if (localMaxRenderingTime != 0) {
                maxRenderingTime = Math.min(maxRenderingTime, localMaxRenderingTime);
            }
            
            InternalTimeoutEnforcer timeout = new InternalTimeoutEnforcer(maxRenderingTime);
            timeout.start();
            try {
                map = super.produceMap(mapContent, tiled);
            /*} catch (ServiceException e) {
                LOGGER.log(Level.WARNING,"Service Exception. Returning partial image", e);*/
            } finally {
                timeout.stop();
            }
            if (timeout.timedOut) {
                LOGGER.log(Level.FINE,"Renderer timed out. Returning partial image");
            }
            if (map == null) {
                map = this.map;
            }
            //Clean up
            this.mapContent = null;
            this.renderer = null;
            this.graphic = null;
            this.preparedImage = null;
            this.map = null;
            
            return map;
        }
        
        //Ensure this format is never called externally
        @Override
        public Set<String> getOutputFormatNames() {
            return new HashSet<String>();
        }
        @Override
        public MapProducerCapabilities getCapabilities(String format) {
            return null;
        }
        
        @Override
        protected void onBeforeRender(StreamingRenderer renderer) {
            this.renderer = renderer;
        }
        
        @Override
        protected Graphics2D getGraphics(final boolean transparent, final Color bgColor,
                final RenderedImage preparedImage, final Map<RenderingHints.Key, Object> hintsMap) {
            this.graphic = super.getGraphics(transparent, bgColor, preparedImage, hintsMap);
            return this.graphic;
        }
        
        @Override
        protected RenderedImage prepareImage(int width, int height, IndexColorModel palette,
                boolean transparent) {
            this.preparedImage = super.prepareImage(width, height, palette, transparent);
            return this.preparedImage;
        }
        
        public class InternalTimeoutEnforcer {
            long timeout;
            Timer timer;
            boolean timedOut = false;
        
            public InternalTimeoutEnforcer(long timeout) {
                this.timeout = timeout;
            }
            /**
             * Starts checking the rendering timeout (if timeout is positive, does nothing otherwise)
             */
            public void start() {
                if(timer != null)
                    throw new IllegalStateException("The timeout enforcer has already been started");
                
                if(timeout > 0) {
                    timedOut = false;
                    timer = new Timer();
                    timer.schedule(new StopRenderingTask(), timeout);
                }
            }
            
            /**
             * Stops the timeout check
             */
            public void stop() {
                if(timer != null) {
                    timer.cancel();
                    timer.purge();
                    timer = null;
                }
            }
            
            /**
             * Returns true if the renderer has been stopped mid-way due to the timeout occurring
             */
            public boolean isTimedOut() {
                return timedOut;
            }
            
            class StopRenderingTask extends TimerTask {
                @Override
                public void run() {
                    // mark as timed out
                    timedOut = true;
                    
                    //Save the current image
                    map = buildMap(mapContent, preparedImage);
                    // ask gently...
                    renderer.stopRendering();
                    // ... but also be rude for extra measure (coverage rendering is
                    // an atomic call to the graphics, it cannot be stopped
                    // by the above)
                    graphic.dispose();
                    
                }
            }
        }
    }
}
