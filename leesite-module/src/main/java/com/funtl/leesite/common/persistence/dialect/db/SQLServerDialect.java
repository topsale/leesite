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

package com.funtl.leesite.common.persistence.dialect.db;


import com.funtl.leesite.common.persistence.dialect.Dialect;

/**
 * MSSQLServer 数据库实现分页方言
 *
 * @author poplar.yfyang
 * @version 1.0 2010-10-10 下午12:31
 * @since JDK 1.5
 */
public class SQLServerDialect implements Dialect {

	public boolean supportsLimit() {
		return true;
	}

	static int getAfterSelectInsertPoint(String sql) {
		int selectIndex = sql.toLowerCase().indexOf("select");
		final int selectDistinctIndex = sql.toLowerCase().indexOf("select distinct");
		return selectIndex + (selectDistinctIndex == selectIndex ? 15 : 6);
	}

	public String getLimitString(String sql, int offset, int limit) {
		return getLimit(sql, offset, limit);
	}

	/**
	 * 将sql变成分页sql语句,提供将offset及limit使用占位符号(placeholder)替换.
	 * <pre>
	 * 如mysql
	 * dialect.getLimitString("select * from user", 12, ":offset",0,":limit") 将返回
	 * select * from user limit :offset,:limit
	 * </pre>
	 *
	 * @param sql    实际SQL语句
	 * @param offset 分页开始纪录条数
	 * @param limit  分页每页显示纪录条数
	 * @return 包含占位符的分页sql
	 */
	public String getLimit(String sql, int offset, int limit) {
		if (offset > 0) {
			throw new UnsupportedOperationException("sql server has no offset");
		}
		return new StringBuffer(sql.length() + 8).append(sql).insert(getAfterSelectInsertPoint(sql), " top " + limit).toString();
	}


}
