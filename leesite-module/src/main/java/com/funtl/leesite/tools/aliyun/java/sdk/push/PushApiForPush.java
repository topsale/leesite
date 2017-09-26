package com.funtl.leesite.tools.aliyun.java.sdk.push;

import com.aliyuncs.http.MethodType;
import com.aliyuncs.http.ProtocolType;
import com.aliyuncs.push.model.v20160801.PushRequest;
import com.aliyuncs.push.model.v20160801.PushResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 推送相关
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/23 15:09
 * @name PushApiForPush
 */
public class PushApiForPush extends PushConfig {
	private static final Logger logger = LoggerFactory.getLogger(PushApiForPush.class);

	/**
	 * 推送高级接口
	 * <p>
	 * 参见文档 https://help.aliyun.com/document_detail/48089.html
	 * //
	 *
	 * @param pushRequest
	 */
	public void advancedPush(PushRequest pushRequest) throws Exception {
		// 安全性比较高的内容建议使用HTTPS
		pushRequest.setProtocol(ProtocolType.HTTPS);
		// 内容较大的请求，使用POST请求
		pushRequest.setMethod(MethodType.POST);
		// 推送目标
		pushRequest.setAppKey(appKey);

		PushResponse pushResponse = client.getAcsResponse(pushRequest);
		logger.debug("RequestId: {}, MessageID: {}", pushResponse.getRequestId(), pushResponse.getMessageId());
	}

}
