package com.lmax.disruptor.demo;

import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.YieldingWaitStrategy;
import com.lmax.disruptor.demo.consumer.InParkingDataEventDbHandler;
import com.lmax.disruptor.demo.consumer.InParkingDataEventKafkaHandler;
import com.lmax.disruptor.demo.consumer.InParkingDataEventSmsHandler;
import com.lmax.disruptor.demo.publisher.InParkingDataEvent;
import com.lmax.disruptor.demo.publisher.InParkingDataEventFactory;
import com.lmax.disruptor.demo.publisher.InParkingDataEventPublisher;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.EventHandlerGroup;
import com.lmax.disruptor.dsl.ProducerType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 多线程模式
 * Created by Lusifer on 2017/5/27.
 */
public final class InParkingMultiDisruptor {
	private static Logger logger = LoggerFactory.getLogger(InParkingMultiDisruptor.class);

	// 指定 ringBuffer 字节大小, 必须是 2 的倍数
	private static final int BUFFER_SIZE = 1024;

	private ThreadFactory threadFactory;
	private InParkingDataEventFactory factory;
	private Disruptor<InParkingDataEvent> disruptor;
	private RingBuffer<InParkingDataEvent> ringBuffer;
	private InParkingDataEventPublisher publisher;

	private InParkingMultiDisruptor() {
		// 执行器，用于构造消费者线程
		threadFactory = Executors.defaultThreadFactory();
		threadFactory = Executors.defaultThreadFactory();
		// 指定事件工厂
		factory = new InParkingDataEventFactory();

		/**
		 * 多线程模式
		 * YieldingWaitStrategy 在多次循环尝试不成功后，选择让出CPU，等待下次调。平衡了延迟和CPU资源占用，但延迟也比较均匀
		 */
		disruptor = new Disruptor<InParkingDataEvent>(factory, BUFFER_SIZE, threadFactory, ProducerType.MULTI, new YieldingWaitStrategy());

		// 使用 Disruptor 创建消费者组
		EventHandlerGroup<InParkingDataEvent> handlerGroup = disruptor.handleEventsWith(new InParkingDataEventKafkaHandler(), new InParkingDataEventDbHandler());
		InParkingDataEventSmsHandler smsHandler = new InParkingDataEventSmsHandler();
		// 声明在 C1,C2 完事之后发送短信消息，也就是流程走到 C3
		handlerGroup.then(smsHandler);

		// 启动 disruptor 线程
		disruptor.start();

		// 获取 ringBuffer 环，用于接取生产者生产的事件
		ringBuffer = disruptor.getRingBuffer();

		// 为 ringBuffer 指定事件生产者
		publisher = new InParkingDataEventPublisher(ringBuffer);

		logger.debug("Created InParkingMultiDisruptor.");
	}

	public void publish(String carLicense) {
		publisher.onData(carLicense);
	}

	/**
	 * 服务器关闭时别忘记调用
	 */
	public void shutdown() {
		disruptor.shutdown();
	}

	/**
	 * 静态初始化器，由 JVM 来保证线程安全
	 */
	private static class SingletonHolder {
		private static InParkingMultiDisruptor instance = new InParkingMultiDisruptor();
	}

	public static InParkingMultiDisruptor getInstance() {
		return InParkingMultiDisruptor.SingletonHolder.instance;
	}
}
