package com.lmax.disruptor.demo.consumer;

import com.lmax.disruptor.EventHandler;
import com.lmax.disruptor.WorkHandler;
import com.lmax.disruptor.demo.publisher.InParkingDataEvent;

/**
 * 3.定义事件处理的具体实现，这里是模拟数据库操作（对应 TestP1C1C2C3 中的 C2）
 * 注意：消费者消费事件处理器，这处需要执行速度足够快。否则，会影响 ringBuffer 后续没空间加入新的数据。因此，不能做业务耗时操作。建议另外开始java 线程池处理消息
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
		System.out.println("value:" + event.getCarLicense() + " sequence:" + sequence + " endOfBatch:" + endOfBatch);
		this.onEvent(event);
	}
}
