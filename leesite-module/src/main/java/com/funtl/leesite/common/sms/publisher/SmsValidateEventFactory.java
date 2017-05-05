package com.funtl.leesite.common.sms.publisher;

import com.lmax.disruptor.EventFactory;

/**
 * Created by Lusifer on 2017/5/5.
 */
public class SmsValidateEventFactory implements EventFactory<SmsValidateEvent> {
	@Override
	public SmsValidateEvent newInstance() {
		return new SmsValidateEvent();
	}
}
