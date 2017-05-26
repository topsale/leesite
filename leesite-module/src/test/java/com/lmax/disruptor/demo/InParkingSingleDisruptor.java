package com.lmax.disruptor.demo;

import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

import com.lmax.disruptor.BlockingWaitStrategy;
import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.demo.consumer.InParkingDataEventDbHandler;
import com.lmax.disruptor.demo.publisher.InParkingDataEvent;
import com.lmax.disruptor.demo.publisher.InParkingDataEventFactory;
import com.lmax.disruptor.demo.publisher.InParkingDataEventPublisher;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.ProducerType;

/**
 * 单线程模式
 * Created by Lusifer on 2017/5/27.
 */
public final class InParkingSingleDisruptor {
	// 指定 ringBuffer 字节大小, 必须是 2 的倍数
	private static final int BUFFER_SIZE = 1024;

	private static InParkingSingleDisruptor instance;
	public static synchronized InParkingSingleDisruptor getInstance() {
		if (instance == null) {
			synchronized (InParkingSingleDisruptor.class) {
				if (instance == null) {
					instance = new InParkingSingleDisruptor();
				}
			}
		}
		return instance;
	}

	private ThreadFactory threadFactory;
	private InParkingDataEventFactory factory;
	private Disruptor<InParkingDataEvent> disruptor;
	private RingBuffer<InParkingDataEvent> ringBuffer;
	private InParkingDataEventPublisher publisher;

	private InParkingSingleDisruptor() {
		// 执行器，用于构造消费者线程
		threadFactory = Executors.defaultThreadFactory();threadFactory = Executors.defaultThreadFactory();
		// 指定事件工厂
		factory = new InParkingDataEventFactory();

		// 单线程模式，获取额外的性能
		disruptor = new Disruptor<InParkingDataEvent>(factory, BUFFER_SIZE, threadFactory, ProducerType.SINGLE, new BlockingWaitStrategy());
		// 设置事件业务处理器 -> 消费者
		disruptor.handleEventsWith(new InParkingDataEventDbHandler());
		// 启动 disruptor 线程
		disruptor.start();

		// 获取 ringBuffer 环，用于接取生产者生产的事件
		ringBuffer = disruptor.getRingBuffer();

		// 为 ringBuffer 指定事件生产者
		publisher = new InParkingDataEventPublisher(ringBuffer);
	}

	public void publish(String carLicense) {
		publisher.onData(carLicense);
	}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		disruptor.shutdown();
	}
}
