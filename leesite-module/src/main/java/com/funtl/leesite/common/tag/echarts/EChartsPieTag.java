/*
 * Copyright 2015-2017 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.funtl.leesite.common.tag.echarts;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTag;
import javax.servlet.jsp.tagext.BodyTagSupport;
import javax.servlet.jsp.tagext.Tag;

import com.github.abel533.echarts.code.Orient;
import com.github.abel533.echarts.code.SeriesType;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.code.X;
import com.github.abel533.echarts.code.Y;
import com.github.abel533.echarts.data.Data;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Line;

public class EChartsPieTag extends BodyTagSupport {
	private static final long serialVersionUID = 1L;
	private String id;
	private String title;
	private String subtitle;
	private Map<String, Object> orientData;

	@Override
	public int doStartTag() throws JspException {
		return BodyTag.EVAL_BODY_BUFFERED;
	}

	@Override
	public int doEndTag() throws JspException {
		StringBuffer sb = new StringBuffer();
		sb.append("<script type='text/javascript'>");
		sb.append("require([ 'echarts', 'echarts/chart/pie'], function(ec) {");
		sb.append("var myChart= ec.init(document.getElementById('" + id + "'));");
		// 创建GsonOption对象，即为json字符串
		GsonOption option = new GsonOption();
		option.tooltip().trigger(Trigger.item).formatter("{a} <br/>{b} : {c} ({d}%)");
		option.title(title, subtitle);
		// 工具栏
		option.toolbox().show(true).feature(
				// Tool.mark,
				// Tool.dataView,
				Tool.saveAsImage
				// new MagicType(Magic.line, Magic.bar,Magic.stack,Magic.tiled),
				//		Tool.dataZoom, Tool.restore
		);
		option.calculable(true);

		// 数据轴封装并解析
		for (String xdata : orientData.keySet()) {
			option.legend().orient(Orient.horizontal).x(X.left).y(Y.bottom).data(xdata);
		}

		if (orientData != null) {
			Line line = new Line();
			line.name(title).type(SeriesType.pie);
			for (String title : orientData.keySet()) {
				Object value = orientData.get(title);
				Data data = new Data().name(title);
				data.value(value);
				line.data(data);
			}
			option.series(line);
		}
		sb.append("var option=" + option.toString() + ";");
		sb.append("myChart.setOption(option);");
		sb.append("});");
		sb.append("</script>");
		try {
			this.pageContext.getOut().write(sb.toString());
		} catch (IOException e) {
			System.err.print(e);
		}
		return Tag.EVAL_PAGE;// 继续处理页面
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public Map<String, Object> getOrientData() {
		return orientData;
	}

	public void setOrientData(Map<String, Object> orientData) {
		this.orientData = orientData;
	}

}
