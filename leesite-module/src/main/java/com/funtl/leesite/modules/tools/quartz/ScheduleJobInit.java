package com.funtl.leesite.modules.tools.quartz;

import javax.annotation.PostConstruct;

import com.funtl.leesite.modules.tools.service.QrtzScheduleJobService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

/**
 * 定时任务初始化
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/27 15:10
 * @name ScheduleJobInit
 */
@Component
@Lazy(false)
public class ScheduleJobInit {

	/**
	 * 日志对象
	 */
	private static final Logger logger = LoggerFactory.getLogger(ScheduleJobInit.class);

	/**
	 * 定时任务service
	 */
	@Autowired
	private QrtzScheduleJobService qrtzScheduleJobService;

	/**
	 * 项目启动时初始化
	 */
	@PostConstruct
	public void init() {
		if (logger.isInfoEnabled()) {
			logger.info("init quartz begin.");
		}

		qrtzScheduleJobService.initScheduleJob();

		if (logger.isInfoEnabled()) {
			logger.info("init quartz end.");
		}
	}

}
