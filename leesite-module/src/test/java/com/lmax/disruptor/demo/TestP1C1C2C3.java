package com.lmax.disruptor.demo;

/**
 * 定义用于事件处理的线程池, 指定等待策略, 启动 Disruptor,执行完毕后关闭Disruptor
 * Created by Lusifer on 2017/5/4.
 */
public class TestP1C1C2C3 {
	private static final int LOOP = 10; // 模拟 10 辆车入场
//	private static final int LOOP = 10000000; // 模拟 10000000 辆车入场

	public static void main(String[] args) throws InterruptedException {
		example1();
		example2();
	}

	/**
	 * 简单案例
	 */
	private static void example1() {
		long beginTime = System.currentTimeMillis();

		for (int i = 0 ; i < LOOP ; i++) {
			int num = (int) (Math.random() * 8000);
			num = num + 1000;
			String sendString = "粤B" + num;
			InParkingSingleDisruptor.getInstance().publish(sendString);

			try {
				Thread.sleep(1000L);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		InParkingSingleDisruptor.getInstance().shutdown();
		System.out.println("总耗时：" + (System.currentTimeMillis() - beginTime));
	}

	/**
	 * 使用消费者组
	 */
	private static void example2() {
		long beginTime = System.currentTimeMillis();

		InParkingMultiDisruptor disruptor = InParkingMultiDisruptor.getInstance();

		for (int i = 0 ; i < LOOP ; i++) {
			int num = (int) (Math.random() * 8000);
			num = num + 1000;
			String sendString = "粤B" + num;
			InParkingMultiDisruptor.getInstance().publish(sendString);

			try {
				Thread.sleep(1000L);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		InParkingMultiDisruptor.getInstance().shutdown();
		System.out.println("总耗时：" + (System.currentTimeMillis() - beginTime));
	}
}
