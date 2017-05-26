package com.funtl.leesite.common.sms.publisher;

import com.lmax.disruptor.EventTranslatorOneArg;
import com.lmax.disruptor.RingBuffer;

/**
 * 短信验证码生产者
 * Created by Lusifer on 2017/5/5.
 */
public class SmsValidateEventPublisher {
	private final RingBuffer<SmsValidateEvent> ringBuffer;

	public SmsValidateEventPublisher(RingBuffer<SmsValidateEvent> ringBuffer) {
		this.ringBuffer = ringBuffer;
	}

	private static final EventTranslatorOneArg<SmsValidateEvent, SmsValidateEvent.Item> TRANSLATOR = new EventTranslatorOneArg<SmsValidateEvent, SmsValidateEvent.Item>() {
		@Override
		public void translateTo(SmsValidateEvent event, long sequence, SmsValidateEvent.Item item) {
			event.setItem(item);
		}
	};

	public void onData(SmsValidateEvent.Item item) {
		ringBuffer.publishEvent(TRANSLATOR, item);
	}
}
