package com.aoshi.service.business.yp;

import java.awt.Color;
import java.awt.Font;
import java.io.File;
import java.io.IOException;
import java.util.List;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.IntervalMarker;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.Layer;
import org.jfree.ui.LengthAdjustmentType;
import org.jfree.ui.TextAnchor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsYpRecordVisitMapper;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Conditions;

@Service
public class RecordVisitService extends AsBaseService {

	private final static String PAGE_PATH = "business/yp/record/";

	@Autowired
	private AsYpRecordVisitMapper asYpRecordVisitMapper;

	@Autowired
	private AsYpScreenDomainMapper ypScreenDomainMapper;

	/**
	 * 访问记录列表 折线图
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		List<String> datay = asYpRecordVisitMapper.listRecordy(pd);
		List<String> datax = asYpRecordVisitMapper.listRecordx(pd);
		addField("shopId", getUser().getAs_shop_id());
		List<Conditions> domains = ypScreenDomainMapper.listAll(pd);
		addViewData("domains", domains);
		addViewData("pd", pd);
		createChart(datay, datax);
		return renderView(PAGE_PATH + "listAll");
	}

	// 获得数据集
	public DefaultCategoryDataset createDataset(List<String> datay, List<String> datax) {

		DefaultCategoryDataset linedataset = new DefaultCategoryDataset();
		// 曲线名称
		String series = "";
		// 横轴名称(列名称)
		String[] time = new String[datax.size()];

		for (int i = 0; i < time.length; i++) {
			time[i] = datax.get(i);
		}
		// 随机添加数据值
		for (int i = 0; i < time.length; i++) {
			linedataset.addValue(Integer.parseInt(datay.get(i).toString()), // 值
					series, // 哪条数据线
					time[i]); // 对应的横轴
		}

		return linedataset;
	}

	// 生成图标对象JFreeChart
	/*
	 * 整个大的框架属于JFreeChart 坐标轴里的属于 Plot 其常用子类有：CategoryPlot, MultiplePiePlot,
	 * PiePlot , XYPlot
	 *
	 ***
	 */
	public void createChart(List<String> datay, List<String> datax) {

		try {
			// 定义图标对象
			JFreeChart chart = ChartFactory.createLineChart(null, // 报表题目，字符串类型
			"日期", // 横轴
			"访问量", // 纵轴
			this.createDataset(datay, datax), // 获得数据集
			PlotOrientation.VERTICAL, // 图标方向垂直
			true, // 显示图例
			false, // 不用生成工具
			false // 不用生成URL地址
			);
			// 整个大的框架属于chart 可以设置chart的背景颜色
			TextTitle textTitle = chart.getTitle();

			// 图例和其它乱码一样处理，更换字体。
			CategoryPlot plot = chart.getCategoryPlot(); // 获得图表区域对象

			CategoryAxis domainAxis = plot.getDomainAxis();

			domainAxis.setVisible(true);

			plot.setDomainAxis(domainAxis);

			ValueAxis rAxis = plot.getRangeAxis();

			/*------设置X轴坐标上的文字-----------*/
			domainAxis.setTickLabelFont(new Font("宋体", Font.PLAIN, 15));
			/*------设置X轴的标题文字------------*/
			domainAxis.setLabelFont(new Font("宋体", Font.PLAIN, 15));
			/*------设置Y轴坐标上的文字-----------*/
			rAxis.setTickLabelFont(new Font("宋体", Font.PLAIN, 15));
			/*------设置Y轴的标题文字------------*/
			rAxis.setLabelFont(new Font("黑体", Font.PLAIN, 15));

			// 生成图形
			// 图像属性部分
			plot.setBackgroundPaint(Color.white);
			plot.setDomainGridlinesVisible(true); // 设置背景网格线是否可见
			plot.setDomainGridlinePaint(Color.BLACK); // 设置背景网格线颜色
			plot.setRangeGridlinePaint(Color.GRAY);
			// plot.setNoDataMessage("没有数据");// 没有数据时显示的文字说明。
			// 数据轴属性部分
			NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
			rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
			rangeAxis.setAutoRangeIncludesZero(true); // 自动生成
			rangeAxis.setUpperMargin(0.20);
			rangeAxis.setLabelAngle(Math.PI / 2.0);
			rangeAxis.setAutoRange(false);
			// 数据渲染部分 主要是对折线做操作
			LineAndShapeRenderer renderer = (LineAndShapeRenderer) plot.getRenderer();
			renderer.setBaseItemLabelsVisible(true);
			renderer.setSeriesPaint(0, Color.black); // 设置折线的颜色
			renderer.setBaseShapesFilled(true);
			renderer.setBaseItemLabelsVisible(true);
			renderer.setBasePositiveItemLabelPosition(
					new ItemLabelPosition(ItemLabelAnchor.OUTSIDE12, TextAnchor.BASELINE_LEFT));
			renderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			/*
			 * 而XYPlot 对应的则是 ： StandardXYItemLabelGenerator
			 */
			renderer.setBaseItemLabelFont(new Font("Dialog", 1, 14)); // 设置提示折点数据形状
			plot.setRenderer(renderer);
			// 区域渲染部分
			double lowpress = 4.5;
			double uperpress = 8; // 设定正常血糖值的范围
			IntervalMarker inter = new IntervalMarker(lowpress, uperpress);
			inter.setLabelOffsetType(LengthAdjustmentType.EXPAND); // 范围调整——扩张
			inter.setPaint(Color.LIGHT_GRAY);// 域顏色

			inter.setLabelFont(new Font("SansSerif", 41, 14));
			inter.setLabelPaint(Color.RED);
			plot.addRangeMarker(inter, Layer.BACKGROUND); // 添加mark到图形
															// BACKGROUND使得数据折线在区域的前端
			String savePath = req.getSession().getServletContext().getRealPath("/upload");
			File file = new File(savePath);
			// 判断上传文件的保存目录是否存在
			if (!file.exists() && !file.isDirectory()) {
				System.out.println(savePath + "目录不存在，需要创建");
				// 创建目录
				file.mkdir();
			}
			// 创建文件输出流
			File fos_jpg = new File(savePath + "/" + "bloodSugarChart.jpg");

			addField("pathChart", "bloodSugarChart.jpg");
			System.out.println("上传路径：" + savePath + "/" + "bloodSugarChart.jpg");
			// 输出到哪个输出流
			ChartUtilities.saveChartAsJPEG(fos_jpg, chart, // 统计图表对象
															// rquest获取项目
					700, // 宽
					500 // 高
			);

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
