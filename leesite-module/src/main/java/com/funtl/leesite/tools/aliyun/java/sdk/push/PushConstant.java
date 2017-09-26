package com.funtl.leesite.tools.aliyun.java.sdk.push;

/**
 * 推送用常量
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/23 20:13
 * @name PushConstant
 */
public final class PushConstant {
	private PushConstant() {

	}

	/**
	 * 推送目标
	 */
	public static class Target {
		/**
		 * 按设备推送
		 */
		public static final String DEVICE = "DEVICE";

		/**
		 * 按别名推送
		 */
		public static final String ALIAS = "ALIAS";

		/**
		 * 按账号推送
		 */
		public static final String ACCOUNT = "ACCOUNT";

		/**
		 * 按标签推送
		 */
		public static final String TAG = "TAG";

		/**
		 * 广播推送
		 */
		public static final String ALL = "ALL";
	}

	/**
	 * 消息类型
	 */
	public static class PushType {
		/**
		 * 消息
		 */
		public static final String MESSAGE = "MESSAGE";

		/**
		 * 通知
		 */
		public static final String NOTICE = "NOTICE";
	}

	/**
	 * 设备类型
	 */
	public static class DeviceType {
		public static final String ANDROID = "ANDROID";
		public static final String iOS = "iOS";
		public static final String ALL = "ALL";
	}

	/**
	 * Android 点击通知后动作
	 */
	public static class AndroidOpenType {
		/**
		 * 打开应用
		 */
		public static final String APPLICATION = "APPLICATION";

		/**
		 * 打开指定页面
		 */
		public static final String ACTIVITY = "ACTIVITY";

		/**
		 * 打开指定网页
		 */
		public static final String URL = "URL";

		/**
		 * 无跳转
		 */
		public static final String NONE = "NONE";
	}

	/**
	 * Android 提醒方式
	 */
	public static class AndroidNotifyType {
		/**
		 * 震动
		 */
		public static final String VIBRATE = "VIBRATE";

		/**
		 * 声音
		 */
		public static final String SOUND = "SOUND";

		/**
		 * 声音和震动
		 */
		public static final String BOTH = "BOTH";

		/**
		 * 静音
		 */
		public static final String NONE = "NONE";
	}
}
