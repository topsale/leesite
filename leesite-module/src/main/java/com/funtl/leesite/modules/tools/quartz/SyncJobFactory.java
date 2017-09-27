package com.funtl.leesite.modules.tools.quartz;

import com.funtl.leesite.common.utils.httpclient.HttpClientUtil;
import com.funtl.leesite.common.utils.httpclient.common.HttpConfig;
import com.funtl.leesite.common.utils.httpclient.exception.HttpProcessException;
import com.funtl.leesite.modules.tools.entity.QrtzScheduleJob;

import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.PersistJobDataAfterExecution;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * 同步任务工厂
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/27 14:47
 * @name SyncJobFactory
 */
@PersistJobDataAfterExecution
@DisallowConcurrentExecution
public class SyncJobFactory extends QuartzJobBean {

	private static final Logger logger = LoggerFactory.getLogger(SyncJobFactory.class);

	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		JobDataMap mergedJobDataMap = context.getMergedJobDataMap();
		QrtzScheduleJob scheduleJob = (QrtzScheduleJob) mergedJobDataMap.get(QrtzScheduleJob.JOB_PARAM_KEY);
		logger.debug("SyncJobFactory execute: {} {}", scheduleJob.getJobName(), scheduleJob);

		try {
			String result = HttpClientUtil.get(HttpConfig.custom().url(scheduleJob.getUrl()));
			logger.debug("SyncJobFactory result: {}", result);
		} catch (HttpProcessException e) {
			logger.error("{}:{}", e.getClass().getName(), e.getMessage());
		}
	}
}
