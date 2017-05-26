package com.funtl.leesite.common.sms;

import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

import com.funtl.leesite.common.sms.consumer.SmsValidateEventHandler;
import com.funtl.leesite.common.sms.publisher.SmsValidateEvent;
import com.funtl.leesite.common.sms.publisher.SmsValidateEventFactory;
import com.funtl.leesite.common.sms.publisher.SmsValidateEventPublisher;
import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.YieldingWaitStrategy;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.ProducerType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 短信验证码的 Disruptor
 * Created by Lusifer on 2017/5/27.
 */
public final class SmsValidateDisruptor {
	private static final Logger logger = LoggerFactory.getLogger(SmsValidateDisruptor.class);

	// 指定 ringBuffer 字节大小, 必须是 2 的倍数
	private static final int BUFFER_SIZE = 1024;

	private ThreadFactory threadFactory;
	private SmsValidateEventFactory factory;
	private Disruptor<SmsValidateEvent> disruptor;
	private RingBuffer<SmsValidateEvent> ringBuffer;
	private SmsValidateEventPublisher publisher;

	private SmsValidateDisruptor() {
		// 执行器，用于构造消费者线程
		threadFactory = Executors.defaultThreadFactory();
		// 指定事件工厂
		factory = new SmsValidateEventFactory();

		// 多线程模式
		disruptor = new Disruptor<SmsValidateEvent>(factory, BUFFER_SIZE, threadFactory, ProducerType.MULTI, new YieldingWaitStrategy());
		// 设置事件业务处理器 -> 消费者
		disruptor.handleEventsWith(new SmsValidateEventHandler());
		// 启动 disruptor 线程
		disruptor.start();

		// 获取 ringBuffer 环，用于接取生产者生产的事件
		ringBuffer = disruptor.getRingBuffer();
		// 为 ringBuffer 指定事件生产者
		publisher = new SmsValidateEventPublisher(ringBuffer);

		logger.debug("Created SmsValidateDisruptor.");
	}

	/**
	 * 生产消息
	 * @param item
	 */
	public void publish(SmsValidateEvent.Item item) {
		publisher.onData(item);
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
		private static SmsValidateDisruptor instance = new SmsValidateDisruptor();
	}

	public static SmsValidateDisruptor getInstance() {
		return SingletonHolder.instance;
	}
}
