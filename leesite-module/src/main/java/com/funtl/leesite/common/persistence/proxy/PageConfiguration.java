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

package com.funtl.leesite.common.persistence.proxy;

import org.apache.ibatis.binding.MapperRegistry;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;

/**
 * <p>
 * 自定义Mybatis的配置，扩展.
 * </p>
 *
 * @author poplar.yfyang
 * @version 1.0 2012-05-13 上午10:06
 * @since JDK 1.5
 */
public class PageConfiguration extends Configuration {

	protected MapperRegistry mapperRegistry = new PaginationMapperRegistry(this);

	@Override
	public <T> void addMapper(Class<T> type) {
		mapperRegistry.addMapper(type);
	}

	@Override
	public <T> T getMapper(Class<T> type, SqlSession sqlSession) {
		return mapperRegistry.getMapper(type, sqlSession);
	}

	@Override
	public boolean hasMapper(Class<?> type) {
		return mapperRegistry.hasMapper(type);
	}
}
