package com.funtl.leesite.modules.tools.schedule;

import com.funtl.leesite.common.web.BaseController;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * 任务调度测试
 *
 * @author Lusifer
 * @version V1.0.0
 * @date 2017/9/27 18:43
 * @name QuartzTestController
 */
@RestController
@RequestMapping(value = "/schedule/test")
public class QuartzTestController extends BaseController {
	@RequestMapping(value = "sayHi", method = RequestMethod.GET)
	public String sayHi() {
		return "Hi Quartz.";
	}
}
