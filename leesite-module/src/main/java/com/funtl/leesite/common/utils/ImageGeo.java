/*
 * Copyright 2015-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.funtl.leesite.common.utils;

import java.io.File;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.lang.Rational;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.GpsDirectory;

public class ImageGeo {
	public double lat = 0.0;
	public double lon = 0.0;
	public double alt = 0.0;
	public boolean error = false;

	public ImageGeo(String filename) {
		try {
			error = false;
			File jpegFile = new File(filename);
			Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);

			GpsDirectory gpsdir = (GpsDirectory) metadata.getDirectory(GpsDirectory.class);
			Rational latpart[] = gpsdir.getRationalArray(GpsDirectory.TAG_GPS_LATITUDE);
			Rational lonpart[] = gpsdir.getRationalArray(GpsDirectory.TAG_GPS_LONGITUDE);
			String northing = gpsdir.getString(GpsDirectory.TAG_GPS_LATITUDE_REF);
			String easting = gpsdir.getString(GpsDirectory.TAG_GPS_LONGITUDE_REF);

			try {
				alt = gpsdir.getDouble(GpsDirectory.TAG_GPS_ALTITUDE);
			} catch (Exception ex) {
			}

			double latsign = 1.0d;
			if (northing.equalsIgnoreCase("S")) latsign = -1.0d;
			double lonsign = 1.0d;
			if (easting.equalsIgnoreCase("W")) lonsign = -1.0d;
			lat = (Math.abs(latpart[0].doubleValue()) + latpart[1].doubleValue() / 60.0d + latpart[2].doubleValue() / 3600.0d) * latsign;
			lon = (Math.abs(lonpart[0].doubleValue()) + lonpart[1].doubleValue() / 60.0d + lonpart[2].doubleValue() / 3600.0d) * lonsign;

			if (Double.isNaN(lat) || Double.isNaN(lon)) error = true;
		} catch (Exception ex) {
			error = true;
		}
		System.out.println(filename + ": (" + lat + ", " + lon + ")");
	}

	public static void main(String[] args) {
		ImageGeo imageGeo = new ImageGeo(ImageGeo.class.getResource("IMAG0068.jpg").getFile());
		System.out.println(imageGeo.lon + "," + imageGeo.lat);
	}

}
