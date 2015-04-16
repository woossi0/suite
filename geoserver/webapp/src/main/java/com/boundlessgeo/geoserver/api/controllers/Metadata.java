/* (c) 2014 Boundless, http://boundlessgeo.com
 * This code is licensed under the GPL 2.0 license.
 */
package com.boundlessgeo.geoserver.api.controllers;

import org.geoserver.catalog.Info;
import org.geoserver.catalog.MetadataMap;
import org.geoserver.catalog.PublishedInfo;
import org.geoserver.ows.util.OwsUtils;
import org.geotools.util.Converters;

import com.boundlessgeo.geoserver.AppConfiguration;

import java.util.Date;

/**
 * Utility class for dealing with api specific metadata.
 */
public class Metadata {

    static final String CREATED = "created";
    static final String MODIFIED = "modified";
    static final String IMPORTED = "imported";
    
    public static final String THUMBNAIL = "thumbnail";
    
    /**
     * Store file path for thumbnail.
     * 
     * @param layer or layergroup
     * @param path file path relative to {@link AppConfiguration#getCacheDir()}
     */
    public static void thumbnail(PublishedInfo obj, String path) {
        map(obj).put(THUMBNAIL, path);
    }
    
    /**
     * File path to thumbnail relative to {@link AppConfiguration#getCacheDir()}
     * 
     * @param layer or layergroup
     * @return absolute file path to thumbnail
     */
    public static String thumbnail(PublishedInfo obj) {
        return (String)map(obj).get(THUMBNAIL);
    }
    
    /**
     * Remove file path stored for thumbnail.
     * 
     * @param layer
     */
    public static void invalidateThumbnail(PublishedInfo layer) {
        Metadata.map(layer).remove(Metadata.THUMBNAIL);
    }
    
    public static void created(Info obj, Date created) {
        MetadataMap map = map(obj);
        map.put(CREATED, created);
        map.put(MODIFIED, created);
    }

    public static Date created(Info obj) {
        return Converters.convert(map(obj).get(CREATED), Date.class);
    }

    public static void modified(Info obj, Date created) {
        map(obj).put(MODIFIED, created);
    }

    public static Date modified(Info obj) {
        return Converters.convert(map(obj).get(MODIFIED), Date.class);
    }

    static MetadataMap map(Info obj) {
        Object map = OwsUtils.get(obj, "metadata");
        if (map != null && map instanceof MetadataMap) {
            return (MetadataMap) map;
        }
        return new MetadataMap();
    }
}
