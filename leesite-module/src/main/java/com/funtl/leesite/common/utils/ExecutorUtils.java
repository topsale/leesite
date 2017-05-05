package com.funtl.leesite.common.utils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 多线程工具
 * Created by Lusifer on 2017/5/5.
 */
public class ExecutorUtils {
	private static ExecutorService executorService;

	private ExecutorUtils() {
	}

	public synchronized static ExecutorService getCachedThreadPool() {
		if (executorService == null) {
			synchronized (ExecutorUtils.class) {
				if (executorService == null) {
					executorService = Executors.newCachedThreadPool();
				}
			}
		}
		return executorService;
	}
}
