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

import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.AxisType;
import com.github.abel533.echarts.code.LineType;
import com.github.abel533.echarts.code.PointerType;
import com.github.abel533.echarts.code.SeriesType;
import com.github.abel533.echarts.code.Symbol;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Line;
import com.github.abel533.echarts.style.LineStyle;

public class EChartsLineDoubleNumTag extends BodyTagSupport {
	private static final long serialVersionUID = 1L;
	private String id;
	private String title;
	private String subtitle;
	private String xAxisName;
	private String yAxisName;
	private Map<String, Integer> yAxisIndex;
	private Map<String, Double[][]> axisDataArr;

	@Override
	public int doStartTag() throws JspException {
		return BodyTag.EVAL_BODY_BUFFERED;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int doEndTag() throws JspException {
		StringBuffer sb = new StringBuffer();
		sb.append("<script type='text/javascript'>");
		sb.append("require([ 'echarts', 'echarts/chart/line'], function(ec) {");
		sb.append("var myChart= ec.init(document.getElementById('" + id + "'));");
		// 创建GsonOption对象，即为json字符串
		GsonOption option = new GsonOption();

		/**
		 * tooltip : { trigger: 'axis' }
		 */
		option.tooltip().trigger(Trigger.axis);
		option.tooltip().axisPointer().show(true).type(PointerType.cross).lineStyle(new LineStyle().type(LineType.dashed).width(1));

		/**
		 * title : { 'text':'2002全国宏观经济关联分析（GDP vs 房地产）', 'subtext':'数据来自国家统计局'
		 * }
		 */
		option.title(title, subtitle);

		/**
		 * toolbox: { show : true, feature : { mark : {show: true}, dataZoom :
		 * {show: true}, dataView : {show: true}, magicType : {show: true, type:
		 * ['line', 'bar', 'stack', 'tiled']}, restore : {show: true},
		 * saveAsImage : {show: true} } }
		 */
		// 工具栏
		option.toolbox().show(true).feature(
				// Tool.mark,
				Tool.dataZoom,
				// Tool.dataView,
				// new MagicType(Magic.line, Magic.bar,Magic.stack,Magic.tiled),
				// Tool.restore,
				Tool.saveAsImage);
		option.calculable(true);
		option.dataZoom().show(true).realtime(true).start(0).end(100);

		/**
		 * xAxis : [ { type: 'value' } ]
		 */
		// X轴数据设置类型
		ValueAxis valueAxis = new ValueAxis();
		valueAxis.type(AxisType.value);
		valueAxis.name(xAxisName);
		option.xAxis(valueAxis);

		// Y轴数据设置类型
		CategoryAxis categoryAxis = new CategoryAxis();
		categoryAxis.type(AxisType.value);
		categoryAxis.name(yAxisName);
		option.yAxis(categoryAxis);

		for (String xtitle : axisDataArr.keySet()) {
			option.legend().data(xtitle);
		}

		for (String mapkey : axisDataArr.keySet()) {
			Line line = new Line();
			// 显示直线，而不是密密麻麻的点，一点都不好看
			line.name(mapkey).type(SeriesType.line).symbol(Symbol.none);
			Object[][] dataArr = (Double[][]) axisDataArr.get(mapkey);
			for (int num = 0; num < dataArr.length; num++) {
				line.data().add(dataArr[num]);
			}

			if (yAxisIndex != null && yAxisIndex.get(mapkey) != null) {
				line.yAxisIndex(yAxisIndex.get(mapkey));
			} else {
				line.yAxisIndex(0);
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
			e.printStackTrace();
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

	public String getxAxisName() {
		return xAxisName;
	}

	public void setxAxisName(String xAxisName) {
		this.xAxisName = xAxisName;
	}

	public String getyAxisName() {
		return yAxisName;
	}

	public void setyAxisName(String yAxisName) {
		this.yAxisName = yAxisName;
	}

	public Map<String, Integer> getyAxisIndex() {
		return yAxisIndex;
	}

	public void setyAxisIndex(Map<String, Integer> yAxisIndex) {
		this.yAxisIndex = yAxisIndex;
	}

	public Map<String, Double[][]> getAxisDataArr() {
		return axisDataArr;
	}

	public void setAxisDataArr(Map<String, Double[][]> axisDataArr) {
		this.axisDataArr = axisDataArr;
	}

}
