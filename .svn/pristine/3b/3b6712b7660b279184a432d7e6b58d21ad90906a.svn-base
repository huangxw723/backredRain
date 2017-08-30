package com.aoshi.controller.manage.yp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsYpScreenInfoMapper;
import com.aoshi.service.manage.yp.YpScreenService;
import com.aoshi.util.Conditions;
import com.aoshi.util.ObjectExcelView;
import com.aoshi.util.PageData;

/**
 * 终端管理 Controller
 * 
 * @author huangxw
 * @date 2016年10月18日
 * @return
 */
@Controller
@RequestMapping("/yp/admin/ypScreenInfo")
public class YpScreenInfoController extends BaseController {
	
	@Autowired
	private YpScreenService screenService;
	
	@Autowired
	private AsYpScreenInfoMapper ypScreenInfoMapper;
	/**
	 * 查询终端列表
	 * 
	 * @author huangxwe	
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return screenService.listAll(this);
	}

	

	/**
	 *编辑审核
	 * 
	 * @author huangxw
	 * @date 2016年10月27日
	 * @return
	 */
	@RequestMapping("/operaSumbmit")
	@ResponseBody
	public Object operaSumbmit() {
		return screenService.operaSumbmit(this);
	}
	/**
	 * 页面跳转控制
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/page")
	public Object page() {
		return screenService.page(this);
	}
	
	/**
	 * 增删改查操作
	 * 
	 * @author huangxwe
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return screenService.opera(this);
	}
	/*
	 * 导出终端信息到EXCEL
	 * 
	 * @return
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel(BaseController c) {
				ModelAndView mv = this.getModelAndView();
				pd=this.getPageData();
				List<Conditions> userList = ypScreenInfoMapper.listScreenAll(pd);
				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();

				titles.add("序号"); 
				titles.add("终端号"); 
				titles.add("企业"); 
				titles.add("省份"); 
				titles.add("市"); 
				titles.add("行政区"); 
				titles.add("详细地址");  
				titles.add("绑定域名"); 
				titles.add("创建时间"); 
				titles.add("状态");  
				dataMap.put("titles", titles);

				List<PageData> varList = new ArrayList<PageData>();
				for (int i = 0; i < userList.size(); i++) {
				PageData vpd = new PageData();
				vpd.put("var1", i+1); // 1
				vpd.put("var2", userList.get(i).getStr("sn")); 
				vpd.put("var3", userList.get(i).getStr("name")); 
				vpd.put("var4", userList.get(i).getStr("province_name"));
				vpd.put("var5", userList.get(i).getStr("city_name")); 
				vpd.put("var6", userList.get(i).getStr("area_name"));
				vpd.put("var7", userList.get(i).getStr("address")); 
				vpd.put("var8", userList.get(i).getStr("url")); 
				vpd.put("var9", userList.get(i).getStr("createTime")); 
				vpd.put("var10", userList.get(i).getInt("status")==1?"审核通过":"审核不通过"); 
				varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
				mv = new ModelAndView(erv, dataMap);
				return mv;
	}
		
}
