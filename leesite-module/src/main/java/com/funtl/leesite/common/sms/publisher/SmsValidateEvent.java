package com.funtl.leesite.common.sms.publisher;

/**
 * Created by Lusifer on 2017/5/5.
 */
public class SmsValidateEvent {
	private Item item;

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public static class Item {
		public static final String TYPE_PUT_CACHE = "put"; // 往缓存中放验证码
		public static final String TYPE_REMOVE_CACHE = "remove"; // 从缓存中删除验证码

		private String phoneNumber;
		private String code;
		private String type; // 处理方式，通过常量值判断

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

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}
	}
}
