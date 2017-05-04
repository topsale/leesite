package com.lmax.disruptor.demo;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.YieldingWaitStrategy;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.EventHandlerGroup;
import com.lmax.disruptor.dsl.ProducerType;

/**
 * 定义用于事件处理的线程池, 指定等待策略, 启动 Disruptor,执行完毕后关闭Disruptor
 * Created by Lusifer on 2017/5/4.
 */
public class TestP1C1C2C3 {
	private static final int LOOP = 10; // 模拟10辆车入场
	//	private static final int LOOP = 10000; // 模拟10000辆车入场

	public static void main(String[] args) throws InterruptedException {
		//		example1();
		example2();
	}

	private static void example1() {
		long beginTime = System.currentTimeMillis();

		// Executor that will be used to construct new threads for consumers
		ExecutorService executor = Executors.newCachedThreadPool();

		// The factory for the event
		InParkingDataEventFactory factory = new InParkingDataEventFactory();

		// Specify the size of the ring buffer, must be power of 2.
		int bufferSize = 1024;

		// Construct the Disruptor
		Disruptor<InParkingDataEvent> disruptor = new Disruptor<>(factory, bufferSize, executor);

		// Connect the handler
		disruptor.handleEventsWith(new InParkingDataEventKafkaHandler());

		// Start the Disruptor, starts all threads running
		disruptor.start();

		// Get the ring buffer from the Disruptor to be used for publishing.
		RingBuffer<InParkingDataEvent> ringBuffer = disruptor.getRingBuffer();

		// Get the ring buffer from the Disruptor to be used for publishing.
		InParkingDataEventPublisher publisher = new InParkingDataEventPublisher(ringBuffer);
		for (int i = 0; i < LOOP; i++) {
			int num = (int) (Math.random() * 8000);
			num = num + 1000;
			String sendString = "粤B" + num;
			ByteBuffer sendBuffer = ByteBuffer.wrap(sendString.getBytes(StandardCharsets.UTF_16));
			publisher.onData(sendBuffer);

			try {
				Thread.sleep(1000L);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		disruptor.shutdown();
		executor.shutdown();
		System.out.println("总耗时：" + (System.currentTimeMillis() - beginTime));
	}

	private static void example2() {
		long beginTime = System.currentTimeMillis();

		int bufferSize = 1024;
		// Disruptor 交给线程池来处理，共计 p1, c1, c2, c3 四个线程
		ExecutorService executor = Executors.newFixedThreadPool(4);

		// 构造缓冲区与事件生成
		InParkingDataEventFactory factory = new InParkingDataEventFactory();
		// ProducerType.SINGLE 单生产者
		// YieldingWaitStrategy 在多次循环尝试不成功后，选择让出CPU，等待下次调。平衡了延迟和CPU资源占用，但延迟也比较均匀。
		Disruptor<InParkingDataEvent> disruptor = new Disruptor<>(factory, bufferSize, executor, ProducerType.SINGLE, new YieldingWaitStrategy());

		// 使用 Disruptor 创建消费者组
		EventHandlerGroup<InParkingDataEvent> handlerGroup = disruptor.handleEventsWith(new InParkingDataEventKafkaHandler(), new InParkingDataEventDbHandler());

		InParkingDataEventSmsHandler smsHandler = new InParkingDataEventSmsHandler();
		// 声明在C1,C2完事之后发送短信消息，也就是流程走到C3
		handlerGroup.then(smsHandler);

		disruptor.start(); // 启动

		RingBuffer<InParkingDataEvent> ringBuffer = disruptor.getRingBuffer();
		// 生产者准备
		InParkingDataEventPublisher publisher = new InParkingDataEventPublisher(ringBuffer);
		for (int i = 0; i < LOOP; i++) {
			int num = (int) (Math.random() * 8000);
			num = num + 1000;
			String sendString = "粤B" + num;
			ByteBuffer sendBuffer = ByteBuffer.wrap(sendString.getBytes(StandardCharsets.UTF_16));
			publisher.onData(sendBuffer);

			try {
				Thread.sleep(1000L);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		disruptor.shutdown();
		executor.shutdown();

		System.out.println("总耗时：" + (System.currentTimeMillis() - beginTime));
	}
}
