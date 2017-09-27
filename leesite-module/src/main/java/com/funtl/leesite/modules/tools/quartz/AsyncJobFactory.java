package com.funtl.leesite.modules.tools.quartz;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

import com.funtl.leesite.common.utils.httpclient.HttpAsyncClientUtil;
import com.funtl.leesite.modules.tools.entity.QrtzScheduleJob;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * 异步任务工厂
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/27 14:46
 * @name AsyncJobFactory
 */
public class AsyncJobFactory extends QuartzJobBean {

	private static final Logger logger = LoggerFactory.getLogger(AsyncJobFactory.class);

	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		QrtzScheduleJob scheduleJob = (QrtzScheduleJob) context.getMergedJobDataMap().get(QrtzScheduleJob.JOB_PARAM_KEY);
		logger.debug("AsyncJobFactory execute: {} {}", scheduleJob.getJobName(), scheduleJob);

		try {
			AsyncJobFactoryHandler handler = new AsyncJobFactoryHandler();
			HttpAsyncClientUtil.send(scheduleJob.getUrl(), null, "utf-8", handler);
		} catch (KeyManagementException e) {
			logger.error("{}:{}", e.getClass().getName(), e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			logger.error("{}:{}", e.getClass().getName(), e.getMessage());
		} catch (IOException e) {
			logger.error("{}:{}", e.getClass().getName(), e.getMessage());
		}
	}

	static class AsyncJobFactoryHandler extends HttpAsyncClientUtil.AsyncHandler {
		@Override
		public Object failed(Exception e) {
			return super.failed(e);
		}

		@Override
		public Object completed(String respBody) {
			return super.completed(respBody);
		}

		@Override
		public Object cancelled() {
			return super.cancelled();
		}
	}
}
