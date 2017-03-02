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

package com.funtl.leesite.common.mapper.adapters;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlType;

@XmlType(name = "MapConvertor")
@XmlAccessorType(XmlAccessType.FIELD)
public class MapConvertor {

	private List<MapEntry> entries = new ArrayList<MapEntry>();

	public void addEntry(MapEntry entry) {
		entries.add(entry);
	}

	public List<MapEntry> getEntries() {
		return entries;
	}

	public static class MapEntry {

		private String key;

		private Object value;

		public MapEntry() {
			super();
		}

		public MapEntry(Map.Entry<String, Object> entry) {
			super();
			this.key = entry.getKey();
			this.value = entry.getValue();
		}

		public MapEntry(String key, Object value) {
			super();
			this.key = key;
			this.value = value;
		}

		public String getKey() {
			return key;
		}

		public void setKey(String key) {
			this.key = key;
		}

		public Object getValue() {
			return value;
		}

		public void setValue(Object value) {
			this.value = value;
		}
	}
}  