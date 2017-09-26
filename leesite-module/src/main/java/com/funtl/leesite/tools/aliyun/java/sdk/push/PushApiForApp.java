package com.funtl.leesite.tools.aliyun.java.sdk.push;

import java.util.List;

import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.push.model.v20160801.ListSummaryAppsRequest;
import com.aliyuncs.push.model.v20160801.ListSummaryAppsResponse;

/**
 * APP相关
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/23 14:10
 * @name PushApiForApp
 */
public class PushApiForApp extends PushConfig {
	/**
	 * APP概览列表
	 * 参考文档 ：https://help.aliyun.com/document_detail/48069.html
	 */
	public List<ListSummaryAppsResponse.SummaryAppInfo> listSummaryApps() throws ClientException {
		ListSummaryAppsRequest request = new ListSummaryAppsRequest();
		ListSummaryAppsResponse response = client.getAcsResponse(request);
		return response.getSummaryAppInfos();
	}
}
