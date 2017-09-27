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
package com.funtl.leesite.modules.tools.service;

import java.util.List;

import com.funtl.leesite.common.persistence.Page;
import com.funtl.leesite.common.service.CrudService;
import com.funtl.leesite.modules.tools.constants.QuartzConstant;
import com.funtl.leesite.modules.tools.dao.QrtzScheduleJobDao;
import com.funtl.leesite.modules.tools.entity.QrtzScheduleJob;
import com.funtl.leesite.modules.tools.utils.ScheduleUtils;
import com.google.common.collect.Lists;

import org.apache.commons.collections.CollectionUtils;
import org.quartz.CronTrigger;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.impl.matchers.GroupMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 任务调度Service
 *
 * @author Lusifer
 * @version 2017-09-26
 */
@Service
@Transactional(readOnly = true)
public class QrtzScheduleJobService extends CrudService<QrtzScheduleJobDao, QrtzScheduleJob> {

	/**
	 * 调度工厂Bean
	 */
	@Autowired
	private Scheduler schedulerFactoryBean;

	@Transactional(readOnly = false)
	public void initScheduleJob() {
		List<QrtzScheduleJob> scheduleJobList = super.findList(new QrtzScheduleJob());
		if (CollectionUtils.isEmpty(scheduleJobList)) {
			return;
		}
		for (QrtzScheduleJob scheduleJob : scheduleJobList) {
			CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(schedulerFactoryBean, scheduleJob.getJobName(), scheduleJob.getJobGroup());

			// 不存在，创建一个
			if (cronTrigger == null) {
				ScheduleUtils.createScheduleJob(schedulerFactoryBean, scheduleJob);
			} else {
				// 已存在，那么更新相应的定时设置
				ScheduleUtils.updateScheduleJob(schedulerFactoryBean, scheduleJob);
			}
		}
	}

	public QrtzScheduleJob get(String id) {
		return super.get(id);
	}

	public List<QrtzScheduleJob> findList(QrtzScheduleJob qrtzScheduleJob) {
		List<QrtzScheduleJob> qrtzScheduleJobList = super.findList(qrtzScheduleJob);
		putScheduleJobValue(qrtzScheduleJobList);
		return qrtzScheduleJobList;
	}

	/**
	 * 获取正在运行的任务列表
	 * @return
	 */
	public List<QrtzScheduleJob> findNormal() {
		try {
			// 存放结果集
			List<QrtzScheduleJob> jobList = Lists.newArrayList();

			// 获取scheduler中的JobGroupName
			for (String group : schedulerFactoryBean.getJobGroupNames()) {
				// 获取JobKey 循环遍历JobKey
				for (JobKey jobKey : schedulerFactoryBean.getJobKeys(GroupMatcher.<JobKey>groupEquals(group))) {
					JobDetail jobDetail = schedulerFactoryBean.getJobDetail(jobKey);
					JobDataMap jobDataMap = jobDetail.getJobDataMap();
					QrtzScheduleJob scheduleJob = (QrtzScheduleJob) jobDataMap.get(QrtzScheduleJob.JOB_PARAM_KEY);
					List<? extends Trigger> triggers = schedulerFactoryBean.getTriggersOfJob(jobKey);
					Trigger trigger = triggers.iterator().next();
					Trigger.TriggerState triggerState = schedulerFactoryBean.getTriggerState(trigger.getKey());
					scheduleJob.setJobTrigger(trigger.getKey().getName());
					scheduleJob.setStatus("正常");
					if (trigger instanceof CronTrigger) {
						CronTrigger cronTrigger = (CronTrigger) trigger;
						String cronExpression = cronTrigger.getCronExpression();
						scheduleJob.setCronExpression(cronExpression);
					}
					// 获取正常运行的任务列表
					if ("NORMAL".equals(triggerState.name())) {
						jobList.add(scheduleJob);
					}
				}
			}
			return jobList;
		} catch (SchedulerException e) {
			e.printStackTrace();
			return null;
		}
	}

	public Page<QrtzScheduleJob> findPage(Page<QrtzScheduleJob> page, QrtzScheduleJob qrtzScheduleJob) {
		Page<QrtzScheduleJob> qrtzScheduleJobPage = super.findPage(page, qrtzScheduleJob);
		List<QrtzScheduleJob> qrtzScheduleJobList = qrtzScheduleJobPage.getList();
		putScheduleJobValue(qrtzScheduleJobList);
		qrtzScheduleJobPage.setList(qrtzScheduleJobList);
		return qrtzScheduleJobPage;
	}

	@Transactional(readOnly = false)
	public void save(QrtzScheduleJob qrtzScheduleJob) {
		if (qrtzScheduleJob.getIsNewRecord()) {
			ScheduleUtils.createScheduleJob(schedulerFactoryBean, qrtzScheduleJob);
		} else {
			ScheduleUtils.updateScheduleJob(schedulerFactoryBean, qrtzScheduleJob);
		}
		super.save(qrtzScheduleJob);
	}

	@Transactional(readOnly = false)
	public void delete(QrtzScheduleJob qrtzScheduleJob) {
		// 删除运行的任务
		ScheduleUtils.deleteScheduleJob(schedulerFactoryBean, qrtzScheduleJob.getJobName(), qrtzScheduleJob.getJobGroup());
		super.delete(qrtzScheduleJob);
	}

	/**
	 * 运行一次
	 *
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void runOnce(String id) {
		QrtzScheduleJob scheduleJob = super.get(id);
		ScheduleUtils.runOnce(schedulerFactoryBean, scheduleJob.getJobName(), scheduleJob.getJobGroup());
		super.save(scheduleJob);
	}

	/**
	 * 暂停任务
	 *
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void pauseJob(String id) {
		QrtzScheduleJob scheduleJob = super.get(id);
		ScheduleUtils.pauseJob(schedulerFactoryBean, scheduleJob.getJobName(), scheduleJob.getJobGroup());
		super.save(scheduleJob);
	}

	/**
	 * 恢复任务
	 *
	 * @param id
	 */
	@Transactional(readOnly = false)
	public void resumeJob(String id) {
		QrtzScheduleJob scheduleJob = super.get(id);
		ScheduleUtils.resumeJob(schedulerFactoryBean, scheduleJob.getJobName(), scheduleJob.getJobGroup());
		super.save(scheduleJob);
	}

	private void putScheduleJobValue(List<QrtzScheduleJob> qrtzScheduleJobList) {
		try {
			for (QrtzScheduleJob scheduleJob : qrtzScheduleJobList) {
				JobKey jobKey = ScheduleUtils.getJobKey(scheduleJob.getJobName(), scheduleJob.getJobGroup());
				List<? extends Trigger> triggers = schedulerFactoryBean.getTriggersOfJob(jobKey);
				if (CollectionUtils.isEmpty(triggers)) {
					continue;
				}

				// 这里一个任务可以有多个触发器， 但是我们一个任务对应一个触发器，所以只取第一个即可，清晰明了
				Trigger trigger = triggers.iterator().next();
				scheduleJob.setJobTrigger(trigger.getKey().getName());

				Trigger.TriggerState triggerState = schedulerFactoryBean.getTriggerState(trigger.getKey());
				String triggerStateName = triggerState.name();
				if (QuartzConstant.NONE.equals(triggerState.name())) {
					triggerStateName = "不存在";
				} else if (QuartzConstant.NORMAL.equals(triggerState.name())) {
					triggerStateName = "正常";
				} else if (QuartzConstant.PAUSED.equals(triggerState.name())) {
					triggerStateName = "暂停";
				} else if (QuartzConstant.COMPLETE.equals(triggerState.name())) {
					triggerStateName = "完成";
				} else if (QuartzConstant.ERROR.equals(triggerState.name())) {
					triggerStateName = "错误";
				} else if (QuartzConstant.BLOCKED.equals(triggerState.name())) {
					triggerStateName = "阻塞";
				} else if (QuartzConstant.NEW.equals(scheduleJob.getStatus())) {
					triggerStateName = "新建";
				}
				scheduleJob.setStatus(triggerStateName);

				if (trigger instanceof CronTrigger) {
					CronTrigger cronTrigger = (CronTrigger) trigger;
					String cronExpression = cronTrigger.getCronExpression();
					scheduleJob.setCronExpression(cronExpression);
				}
			}
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

}