package com.lmax.disruptor.demo;

import com.lmax.disruptor.EventHandler;
import com.lmax.disruptor.WorkHandler;

/**
 * 3.定义事件处理的具体实现，这里是模拟数据库操作（对应 TestP1C1C2C3 中的 C2）
 * Created by Lusifer on 2017/5/4.
 */
public class InParkingDataEventDbHandler implements EventHandler<InParkingDataEvent>, WorkHandler<InParkingDataEvent> {
	@Override
	public void onEvent(InParkingDataEvent event) throws Exception {
		long threadId = Thread.currentThread().getId();
		String carLicense = event.getCarLicense();
		System.out.println(String.format("Thread ID %s save %s into db ...", threadId, carLicense));
	}

	@Override
	public void onEvent(InParkingDataEvent event, long sequence, boolean endOfBatch) throws Exception {
		this.onEvent(event);
	}
}
