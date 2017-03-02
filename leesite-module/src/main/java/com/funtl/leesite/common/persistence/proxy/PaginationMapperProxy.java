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

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.HashSet;
import java.util.Set;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.utils.Reflections;

import org.apache.ibatis.binding.BindingException;
import org.apache.ibatis.binding.MapperMethod;
import org.apache.ibatis.session.SqlSession;

/**
 * <p>
 * .
 * </p>
 *
 * @author poplar.yfyang
 * @version 1.0 2012-05-13 上午10:07
 * @since JDK 1.5
 */
public class PaginationMapperProxy implements InvocationHandler {


	private static final Set<String> OBJECT_METHODS = new HashSet<String>() {
		private static final long serialVersionUID = -1782950882770203583L;

		{
			add("toString");
			add("getClass");
			add("hashCode");
			add("equals");
			add("wait");
			add("notify");
			add("notifyAll");
		}
	};

	private boolean isObjectMethod(Method method) {
		return OBJECT_METHODS.contains(method.getName());
	}

	private final SqlSession sqlSession;

	private PaginationMapperProxy(final SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		if (isObjectMethod(method)) {
			return null;
		}
		final Class<?> declaringInterface = findDeclaringInterface(proxy, method);
		if (Page.class.isAssignableFrom(method.getReturnType())) {
			// 分页处理
			return new PaginationMapperMethod(declaringInterface, method, sqlSession).execute(args);
		}
		// 原处理方式
		final MapperMethod mapperMethod = new MapperMethod(declaringInterface, method, sqlSession.getConfiguration());
		final Object result = mapperMethod.execute(sqlSession, args);
		if (result == null && method.getReturnType().isPrimitive()) {
			throw new BindingException("Mapper method '" + method.getName() + "' (" + method.getDeclaringClass() + ") attempted to return null from a method with a primitive return type (" + method.getReturnType() + ").");
		}
		return result;
	}

	private Class<?> findDeclaringInterface(Object proxy, Method method) {
		Class<?> declaringInterface = null;
		for (Class<?> mapperFaces : proxy.getClass().getInterfaces()) {
			Method m = Reflections.getAccessibleMethod(mapperFaces, method.getName(), method.getParameterTypes());
			if (m != null) {
				declaringInterface = mapperFaces;
			}
		}
		if (declaringInterface == null) {
			throw new BindingException("Could not find interface with the given method " + method);
		}
		return declaringInterface;
	}

	@SuppressWarnings("unchecked")
	public static <T> T newMapperProxy(Class<T> mapperInterface, SqlSession sqlSession) {
		ClassLoader classLoader = mapperInterface.getClassLoader();
		Class<?>[] interfaces = new Class[]{mapperInterface};
		PaginationMapperProxy proxy = new PaginationMapperProxy(sqlSession);
		return (T) Proxy.newProxyInstance(classLoader, interfaces, proxy);
	}
}
