package com.lmax.disruptor.demo.publisher;

import com.lmax.disruptor.EventFactory;

/**
 * 2.定义事件工厂
 * Created by Lusifer on 2017/5/4.
 */
public class InParkingDataEventFactory implements EventFactory<InParkingDataEvent> {
	@Override
	public InParkingDataEvent newInstance() {
		return new InParkingDataEvent();
	}
}
