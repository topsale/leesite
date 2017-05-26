package com.funtl.leesite.common.sms.consumer;

import com.funtl.leesite.common.sms.publisher.SmsValidateEvent;
import com.funtl.leesite.common.utils.CacheUtils;
import com.lmax.disruptor.EventHandler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 短信验证码消息处理
 * Created by Lusifer on 2017/5/27.
 */
public class SmsValidateEventHandler implements EventHandler<SmsValidateEvent> {
	private static final Logger logger = LoggerFactory.getLogger(SmsValidateEventHandler.class);

	@Override
	public void onEvent(SmsValidateEvent event, long sequence, boolean endOfBatch) throws Exception {
		SmsValidateEvent.Item item = event.getItem();
		String phoneNumber = item.getPhoneNumber();
		String code = item.getCode();
		String type = item.getType();

		if (SmsValidateEvent.Item.TYPE_PUT_CACHE.equals(type)) {
			pubCache(phoneNumber, code);
		} else if (SmsValidateEvent.Item.TYPE_REMOVE_CACHE.equals(type)) {
			removeCache(phoneNumber, code);
		}
	}

	/**
	 * 往缓存中放验证码
	 * @param phoneNumber
	 * @param code
	 */
	private void pubCache(String phoneNumber, String code) {
		logger.debug("生产短信验证码：手机号（{}），验证码（{}）", phoneNumber, code);
		CacheUtils.put("smsCache", phoneNumber, code);
	}

	/**
	 * 从缓存中删除验证码
	 * @param phoneNumber
	 * @param code
	 */
	private void removeCache(String phoneNumber, String code) {
		logger.debug("消费短信验证码：手机号（{}），验证码（{}）", phoneNumber, code);
		CacheUtils.remove("smsCache", phoneNumber);
	}
}
