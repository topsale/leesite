package com.funtl.leesite.common.sms.publisher;

import java.nio.ByteBuffer;

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

	private static final EventTranslatorOneArg<SmsValidateEvent, ByteBuffer> TRANSLATOR = new EventTranslatorOneArg<SmsValidateEvent, ByteBuffer>() {
		@Override
		public void translateTo(SmsValidateEvent event, long sequence, ByteBuffer byteBuffer) {
			String[] str = byteBuffer.asCharBuffer().toString().trim().split(",");
			String phoneNumber = str[0];
			String code = str[1];

			event.setPhoneNumber(phoneNumber);
			event.setCode(code);
		}
	};

	public void onData(ByteBuffer byteBuffer) {
		ringBuffer.publishEvent(TRANSLATOR, byteBuffer);
	}
}
