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

package com.funtl.leesite.common.security.shiro;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.tags.PermissionTag;

/**
 * Shiro HasAnyPermissions Tag.
 *
 * @author calvin
 */
public class HasAnyPermissionsTag extends PermissionTag {

	private static final long serialVersionUID = 1L;
	private static final String PERMISSION_NAMES_DELIMETER = ",";

	@Override
	protected boolean showTagBody(String permissionNames) {
		boolean hasAnyPermission = false;

		Subject subject = getSubject();

		if (subject != null) {
			// Iterate through permissions and check to see if the user has one of the permissions
			for (String permission : permissionNames.split(PERMISSION_NAMES_DELIMETER)) {

				if (subject.isPermitted(permission.trim())) {
					hasAnyPermission = true;
					break;
				}

			}
		}

		return hasAnyPermission;
	}

}
