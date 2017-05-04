package com.funtl.leesite.common.context;

import freemarker.template.Template;

import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.mail.internet.MimeMessage;

import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.modules.config.entity.ConfigMail;
import com.funtl.leesite.modules.config.service.ConfigMailService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

/**
 * Spring邮件发送工具
 * Created by Lusifer on 2017/5/4.
 */
@Component
public class SpringMailSender {
	private static final Logger logger = LoggerFactory.getLogger(SpringMailSender.class);

	private JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
	private SimpleMailMessage simpleMailMessage = new SimpleMailMessage();

	@Autowired
	private FreeMarkerConfigurer freeMarkerConfigurer;
	@Autowired
	private TaskExecutor taskMailExecutor;

	private ConfigMailService configMailService = SpringContextHolder.getBean(ConfigMailService.class);

	/**
	 * 初始化参数
	 */
	private void initParams() throws AddressException {
		ConfigMail configMail = configMailService.get("1");
		javaMailSender.setHost(configMail.getMailHost()); // 主机
		javaMailSender.setPort(configMail.getMailPort()); // 端口
		javaMailSender.setUsername(configMail.getMailUsername()); // 邮箱用户名
		javaMailSender.setPassword(configMail.getMailPassword()); // 邮箱密码

		// 设置Properties属性
		Properties properties = System.getProperties();
		properties.put("mail.smtp.auth", "true");
		// 设置启动SSL/TLS
		if (configMail.getMailSsl().equals("1")) {
			properties.put("mail.smtp.ssl", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.ssl.trust", configMail.getMailHost());
		} else {
			properties.put("mail.smtp.ssl", "false");
			properties.put("mail.smtp.starttls.enable", "false");
		}
		javaMailSender.setJavaMailProperties(properties);

		simpleMailMessage.setFrom(configMail.getMailFrom().concat("<" + configMail.getMailUsername() + ">")); // 发件人地址，使用昵称的方式发送
	}

	/**
	 * 构建邮件内容，发送邮件
	 *
	 * @param to       收件人
	 * @param subject  邮件主题
	 * @param template 邮件模板名称
	 * @param map      邮件模板占位符参数
	 * @param isAsync  是否异步发送
	 */
	public String send(String to, String subject, String template, Map<String, Object> map, boolean isAsync) {
		String content = "";

		try {
			initParams();
			// 从FreeMarker模板生成邮件内容
			Template templateFile = freeMarkerConfigurer.getConfiguration().getTemplate("/".concat(template.concat(".ftl")));
			// 模板中用${XXX}站位，map中key为XXX的value会替换占位符内容
			content = FreeMarkerTemplateUtils.processTemplateIntoString(templateFile, map);

			// 异步发送邮件
			if (isAsync) {
				this.taskMailExecutor.execute(new SendMailThread(to, subject, content));
			} else {
				sendMail(to, subject, content);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}

		return "OK";
	}

	/**
	 * 内部线程类，利用线程池异步发邮件。
	 */
	private class SendMailThread implements Runnable {
		private String to;
		private String subject;
		private String content;

		private SendMailThread(String to, String subject, String content) {
			super();
			this.to = to;
			this.subject = subject;
			this.content = content;
		}

		@Override
		public void run() {
			sendMail(to, subject, content);
		}
	}

	/**
	 * 发送邮件
	 *
	 * @param to      收件人邮箱
	 * @param subject 邮件主题
	 * @param content 邮件内容
	 */
	private void sendMail(String to, String subject, String content) {
		try {
			MimeMessage message = javaMailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(simpleMailMessage.getFrom());
			if (subject != null) {
				messageHelper.setSubject(subject);
			} else {
				messageHelper.setSubject(simpleMailMessage.getSubject());
			}
			messageHelper.setTo(to);
			messageHelper.setText(content, true);
			javaMailSender.send(message);
		} catch (MessagingException e) {
			logger.error("邮件发送失败");
			e.printStackTrace();
		}
	}
}
