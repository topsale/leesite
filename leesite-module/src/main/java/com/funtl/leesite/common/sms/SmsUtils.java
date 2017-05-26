package com.funtl.leesite.common.sms;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;

import com.aliyun.mns.client.CloudAccount;
import com.aliyun.mns.client.CloudTopic;
import com.aliyun.mns.client.MNSClient;
import com.aliyun.mns.common.ServiceException;
import com.aliyun.mns.model.BatchSmsAttributes;
import com.aliyun.mns.model.MessageAttributes;
import com.aliyun.mns.model.RawTopicMessage;
import com.aliyun.mns.model.TopicMessage;
import com.funtl.leesite.common.sms.publisher.SmsValidateEvent;
import com.funtl.leesite.common.sms.publisher.SmsValidateEventFactory;
import com.funtl.leesite.common.utils.CacheUtils;
import com.funtl.leesite.common.utils.ExecutorUtils;
import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.modules.config.entity.ConfigSms;
import com.funtl.leesite.modules.config.entity.ConfigSmsTemplate;
import com.funtl.leesite.modules.config.service.ConfigSmsService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * 短信工具
 * Created by Lusifer on 2017/5/5.
 */
@Component
public class SmsUtils {
	private static final Logger logger = LoggerFactory.getLogger(SmsUtils.class);

	private ConfigSms configSms;
	private List<ConfigSmsTemplate> configSmsTemplates;
	private ConfigSmsService configSmsService = SpringContextHolder.getBean(ConfigSmsService.class);

	private MNSClient client;
	private CloudTopic topic;
	private RawTopicMessage msg;

	// 短信验证码生产消费
	private static final int BUFFER_SIZE = 1024;
	private ExecutorService executor;
	private SmsValidateEventFactory factory = new SmsValidateEventFactory();

	private void initParams() {
		configSms = configSmsService.get("1");
		configSmsTemplates = configSms.getConfigSmsTemplateList();

		executor = ExecutorUtils.getCachedThreadPool();

		/**
		 * Step 1. 获取主题引用
		 */
		CloudAccount account = new CloudAccount(configSms.getSmsAccessId(), configSms.getSmsAccessKey(), configSms.getSmsMnsEndpoint());
		client = account.getMNSClient();
		topic = client.getTopicRef(configSms.getSmsTopic());

		/**
		 * Step 2. 设置SMS消息体（必须）
		 *
		 * 注：目前暂时不支持消息内容为空，需要指定消息内容，不为空即可。
		 */
		msg = new RawTopicMessage();
		msg.setMessageBody("sms-message");
	}

	/**
	 * 发送测试已短信
	 * @param phoneNumber 手机号
	 * @return
	 */
	public String sendTest(String phoneNumber) {
		try {
			initParams();

			String templateCode = null;
			if (configSmsTemplates != null && configSmsTemplates.size() > 0) {
				for (ConfigSmsTemplate configSmsTemplate : configSmsTemplates) {
					if ("短信测试".equals(configSmsTemplate.getSmsTemplateName().trim())) {
						templateCode = configSmsTemplate.getSmsTemplateCode();
						break;
					}
				}
			}

			if (templateCode == null) {
				return "\"短信测试\"模板不存在，请检查";
			}

			/**
			 * Step 3. 生成SMS消息属性
			 */
			MessageAttributes messageAttributes = new MessageAttributes();
			BatchSmsAttributes batchSmsAttributes = new BatchSmsAttributes();
			// 3.1 设置发送短信的签名（SMSSignName）
			batchSmsAttributes.setFreeSignName(configSms.getSmsSignName());
			// 3.2 设置发送短信使用的模板（SMSTempateCode）
			batchSmsAttributes.setTemplateCode(templateCode);
			// 3.3 设置发送短信所使用的模板中参数对应的值（在短信模板中定义的，没有可以不用设置）
			BatchSmsAttributes.SmsReceiverParams smsReceiverParams = new BatchSmsAttributes.SmsReceiverParams();
			//		smsReceiverParams.setParam("$YourSMSTemplateParamKey1", "$value1");
			//		smsReceiverParams.setParam("$YourSMSTemplateParamKey2", "$value2");
			// 3.4 增加接收短信的号码
			batchSmsAttributes.addSmsReceiver(phoneNumber, smsReceiverParams);
			//		batchSmsAttributes.addSmsReceiver("$YourReceiverPhoneNumber2", smsReceiverParams);
			messageAttributes.setBatchSmsAttributes(batchSmsAttributes);

			/**
			 * Step 4. 发布SMS消息
			 */
			TopicMessage ret = topic.publishMessage(msg, messageAttributes);
			logger.debug("MessageId: {}", ret.getMessageId());
			logger.debug("MessageMD5: {}", ret.getMessageBodyMD5());
			return "OK";
		} catch (ServiceException se) {
			logger.error(se.getErrorCode() + se.getRequestId());
			logger.error(se.getMessage());
			se.printStackTrace();
			return se.getMessage();
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		} finally {
			client.close();
		}
	}

	/**
	 * 发送短信通知
	 * @param templateCode 模板编码
	 * @param templateParamKeyValue 短信模板中定义的参数键值
	 * @param phoneNumbers 手机号
	 * @return
	 */
	public String sendNotify(String templateCode, Map<String, String> templateParamKeyValue, String... phoneNumbers) {
		try {
			initParams();

			MessageAttributes messageAttributes = new MessageAttributes();
			BatchSmsAttributes batchSmsAttributes = new BatchSmsAttributes();
			batchSmsAttributes.setFreeSignName(configSms.getSmsSignName());
			batchSmsAttributes.setTemplateCode(templateCode);

			BatchSmsAttributes.SmsReceiverParams smsReceiverParams = new BatchSmsAttributes.SmsReceiverParams();
			if (templateParamKeyValue != null && templateParamKeyValue.size() > 0) {
				for (Map.Entry<String, String> entry : templateParamKeyValue.entrySet()) {
					smsReceiverParams.setParam(entry.getKey(), entry.getValue());
				}
			}

			for (String phoneNumber : phoneNumbers) {
				batchSmsAttributes.addSmsReceiver(phoneNumber, smsReceiverParams);
			}
			messageAttributes.setBatchSmsAttributes(batchSmsAttributes);

			TopicMessage ret = topic.publishMessage(msg, messageAttributes);
			logger.debug("MessageId: {}", ret.getMessageId());
			logger.debug("MessageMD5: {}", ret.getMessageBodyMD5());
			return "OK";
		} catch (ServiceException se) {
			logger.error(se.getErrorCode() + se.getRequestId());
			logger.error(se.getMessage());
			se.printStackTrace();
			return se.getMessage();
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		} finally {
			client.close();
		}
	}

	/**
	 * 发送短信验证码
	 * @param phoneNumber
	 * @param templateCode
	 * @param templateParamKeyValue
	 * @return
	 */
	public String sendValidate(String phoneNumber, String templateCode, Map<String, String> templateParamKeyValue) {
		try {
			initParams();

			MessageAttributes messageAttributes = new MessageAttributes();
			BatchSmsAttributes batchSmsAttributes = new BatchSmsAttributes();
			batchSmsAttributes.setFreeSignName(configSms.getSmsSignName());
			batchSmsAttributes.setTemplateCode(templateCode);

			BatchSmsAttributes.SmsReceiverParams smsReceiverParams = new BatchSmsAttributes.SmsReceiverParams();
			// 加入验证码参数
			String code = getRandomForSix();
			smsReceiverParams.setParam("code", code);
			if (templateParamKeyValue != null && templateParamKeyValue.size() > 0) {
				for (Map.Entry<String, String> entry : templateParamKeyValue.entrySet()) {
					smsReceiverParams.setParam(entry.getKey(), entry.getValue());
				}
			}

			batchSmsAttributes.addSmsReceiver(phoneNumber, smsReceiverParams);
			messageAttributes.setBatchSmsAttributes(batchSmsAttributes);

			TopicMessage ret = topic.publishMessage(msg, messageAttributes);
			logger.debug("MessageId: {}", ret.getMessageId());
			logger.debug("MessageMD5: {}", ret.getMessageBodyMD5());

			// 生产短信验证码
			SmsValidateEvent.Item item = new SmsValidateEvent.Item();
			item.setPhoneNumber(phoneNumber);
			item.setCode(code);
			item.setType(SmsValidateEvent.Item.TYPE_PUT_CACHE);
			SmsValidateDisruptor.getInstance().publish(item);

			return "OK";
		} catch (ServiceException se) {
			logger.error(se.getErrorCode() + se.getRequestId());
			logger.error(se.getMessage());
			se.printStackTrace();
			return se.getMessage();
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		} finally {
			client.close();
		}
	}

	/**
	 * 删除验证码
	 * @param phoneNumber
	 */
	public void removeValidate(String phoneNumber) {
		// 消费短信验证码
		SmsValidateEvent.Item item = new SmsValidateEvent.Item();
		item.setPhoneNumber(phoneNumber);
		item.setCode(String.valueOf(CacheUtils.get("smsCache", phoneNumber)));
		item.setType(SmsValidateEvent.Item.TYPE_REMOVE_CACHE);
		SmsValidateDisruptor.getInstance().publish(item);
	}

	/**
	 * 获取一个6位随机数 <br />
	 * 从100000 ~ 999999
	 *
	 * @return
	 */
	private String getRandomForSix() {
		return String.valueOf(100000 + (int) (Math.random() * 899999));
	}
}
