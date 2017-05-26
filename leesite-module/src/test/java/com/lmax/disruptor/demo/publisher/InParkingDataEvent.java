package com.lmax.disruptor.demo.publisher;

/**
 * 1.定义事件
 * Created by Lusifer on 2017/5/4.
 */
public class InParkingDataEvent {
	private String carLicense;

	public String getCarLicense() {
		return carLicense;
	}

	public void setCarLicense(String carLicense) {
		this.carLicense = carLicense;
	}
}
