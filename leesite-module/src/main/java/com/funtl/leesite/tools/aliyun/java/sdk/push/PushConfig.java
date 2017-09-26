package com.funtl.leesite.tools.aliyun.java.sdk.push;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.funtl.leesite.common.utils.SpringContextHolder;
import com.funtl.leesite.modules.aliyun.entity.ConfigAliyunPush;
import com.funtl.leesite.modules.aliyun.service.ConfigAliyunPushService;

/**
 * 阿里云推送配置
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/23 13:56
 * @name PushConfig
 */
public class PushConfig {
	protected static String region;
	protected static long appKey;

	protected static DefaultAcsClient client;

	protected static ConfigAliyunPushService configAliyunPushService = SpringContextHolder.getBean(ConfigAliyunPushService.class);

	static {
		try {
			init();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void init() throws Exception {
		ConfigAliyunPush configAliyunPush = configAliyunPushService.get("1");

		String accessKeyId = configAliyunPush.getAccessKeyId();
		String accessKeySecret = configAliyunPush.getAccessKeySecret();
		String key = configAliyunPush.getAppKey();

		region = configAliyunPush.getRegionId();
		appKey = Long.valueOf(key);

		IClientProfile profile = DefaultProfile.getProfile(region, accessKeyId, accessKeySecret);
		client = new DefaultAcsClient(profile);
	}
}
