package com.aoshi.controller.manage.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.common.asenum.ApiParam;
import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.yp.YpPublicService;

/**
 * 基础功能Controller
 * 
 * @author yangyanchao
 * @date 2016年10月27日
 */
@Controller
@RequestMapping("/yp/admin/public")
public class YpPublicController extends BaseController {

	private final static String PAGE_PATH = "manage/yp/public/";

	@Autowired
	private YpPublicService YpPublicService;

	/**
	 * 获取行业分类列表
	 * 
	 * @author yangyanchao
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/getShopTypeList")
	public Object getShopTypeList() {
		return YpPublicService.getTypeList(this);
	}

	/**
	 * 添加行业信息H5
	 * 
	 * @author yangyanchao
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/goEditShopTypePage")
	public Object goEditTypePage() {

		initialized();
		addViewData("action", pd.getParaForPositiveInteger(ApiParam.ACTION));
		return renderView(PAGE_PATH + "save_shop_type");
	}

	/**
	 * 添加行业信息
	 * 
	 * @author yangyanchao
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/addType")
	@ResponseBody
	public Object addShopType() {

		return YpPublicService.addType(this);
	}

	/**
	 * 删除行业分类
	 * 
	 * @author yangyanchao
	 * @date 2016年10月27日
	 * @return
	 */
	/*
	 * @RequestMapping("/deleteTypeOfShop")
	 * 
	 * @ResponseBody public Object deleteTypeOfShop() { return
	 * YpPublicService.deleteTypeOfShop(this); }
	 */

	/**
	 * 获取服务内容分类
	 * 
	 * @author yangyanchao
	 * @date 2016年10月27日
	 * @return
	 */
	@RequestMapping("/getServiceTypeList")
	public Object getServiceTypeList() {
		return YpPublicService.getServiceTypeList(this);
	}

	/**
	 * 添加服务内容信息H5
	 * 
	 * @author yangyanchao
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/goEditServiceTypePage")
	public Object goEditServiceTypePage() {

		initialized();
		addViewData("action", pd.getParaForPositiveInteger(ApiParam.ACTION));
		return renderView(PAGE_PATH + "save_service_type");
	}

	/**
	 * 添加服务内容
	 * 
	 * @author yangyanchao
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/addServiceType")
	@ResponseBody
	public Object addServiceType() {

		return YpPublicService.addServiceType(this);
	}
}
