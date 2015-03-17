package com.boundlessgeo.geoserver.api.controllers;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;

import com.boundlessgeo.geoserver.Proj;
import com.boundlessgeo.geoserver.json.JSONObj;

public class IOTest {

    @Test
    public void TestProj() {
        
        //Test regurlar CRS
        String srs = "EPSG:4326";
        JSONObj obj = new JSONObj();
        IO.proj(obj, Proj.get().crs(srs), srs);
        assertEquals(srs, obj.str("srs"));
        assertNotNull(obj.get("wkt"));
        //Test complex CRS (Polar)
        srs = "EPSG:3031";
        obj = new JSONObj();
        IO.proj(obj, Proj.get().crs(srs), srs);
        assertEquals(srs, obj.str("srs"));
        assertNotNull(obj.get("wkt"));
    }

}
