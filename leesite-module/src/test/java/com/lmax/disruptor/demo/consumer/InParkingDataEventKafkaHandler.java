package com.lmax.disruptor.demo.consumer;


import com.lmax.disruptor.EventHandler;
import com.lmax.disruptor.demo.publisher.InParkingDataEvent;

/**
 * 3.定义事件处理的具体实现，这里是模拟 Kafka 操作（对应 TestP1C1C2C3 中的 C1）
 * Created by Lusifer on 2017/5/4.
 */
public class InParkingDataEventKafkaHandler implements EventHandler<InParkingDataEvent> {
	@Override
	public void onEvent(InParkingDataEvent event, long sequence, boolean endOfBatch) throws Exception {
		long threadId = Thread.currentThread().getId();
		String carLicense = event.getCarLicense();
		System.out.println(String.format("Thread ID %s send %s in plaza message to kafka ...", threadId, carLicense));
	}
}
