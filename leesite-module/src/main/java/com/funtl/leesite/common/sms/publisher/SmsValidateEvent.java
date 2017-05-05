package com.funtl.leesite.common.sms.publisher;

/**
 * Created by Lusifer on 2017/5/5.
 */
public class SmsValidateEvent {
	private String phoneNumber;
	private String code;

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
