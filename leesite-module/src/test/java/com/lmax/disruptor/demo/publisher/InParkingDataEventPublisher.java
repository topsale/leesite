package com.lmax.disruptor.demo.publisher;

import com.lmax.disruptor.EventTranslatorOneArg;
import com.lmax.disruptor.RingBuffer;

/**
 * 4.发布事件类实现（生产者，对应 TestP1C1C2C3 中的 P1）
 * Disruptor 要求 RingBuffer.publish 必须得到调用，如果发生异常也一样要调用publish ，
 * 那么，很显然这个时候需要调用者在事件处理的实现上来判断事件携带的数据是否是正确的或者完整的
 * Created by Lusifer on 2017/5/4.
 */
public class InParkingDataEventPublisher {
	private final RingBuffer<InParkingDataEvent> ringBuffer;

	public InParkingDataEventPublisher(RingBuffer<InParkingDataEvent> ringBuffer) {
		this.ringBuffer = ringBuffer;
	}

	/**
	 * 该方法将 ringBuffer 中的消息，转换成 java 对象格式，方便消费者直接操作 Event 对象
	 */
	private static final EventTranslatorOneArg<InParkingDataEvent, String> TRANSLATOR = new EventTranslatorOneArg<InParkingDataEvent, String>() {
		@Override
		public void translateTo(InParkingDataEvent event, long sequence, String carLicense) {
			event.setCarLicense(carLicense);
			System.out.println("Thread ID " + Thread.currentThread().getId() + " 写完一个 Event");
		}
	};

	public void onData(String carLicense) {
		ringBuffer.publishEvent(TRANSLATOR, carLicense);
	}
}