package com.aoshi.controller.manage;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.PrizeTypeService;


/**
 * 奖品类型表模块Controller
 * 	
 * @author huangxuwen
 * @date 2016年9月1日
 */
@Controller
@RequestMapping(value = "/prizeType")
public class PrizeTypeController extends BaseController {

	String menuUrl = "prizeType/listPage.do"; // 菜单地址(权限用)

	@Resource(name = "prizeTypeService")
	private PrizeTypeService prizeTypeService;

	
	/**
	 * 奖品类型表页面
	 * 
	 * @author huangxuwen
     * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/listPage")
	public Object listPage() {
		
	return prizeTypeService.listPage(this);
	}
	
	/**
	 * 去添加页面
	 */
	@RequestMapping(value = "/goAdd")
	public Object AddPrizeTypePage() {
	return prizeTypeService.AddPrizeTypePage(this);
	}

	/**
	 * 添加保存奖品类型表
	 * 
	 * @author huangxuwen
     * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/save")
	public Object save() {
	return prizeTypeService.save(this);
	}
	
	/**
	 * 去修改更新类型页面
	 * @author huangxuwen
     * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/goEdit")
	public Object editUserPage() throws Exception {
		return prizeTypeService.editPrizePage(this);
	}
	
	/**
	 * huangxuwen
	 * @author huangxuwen
     * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/edit")
	public Object update() {
		return prizeTypeService.editPrize(this);
	}
	
	/**
	 * 删除
	 * @author huangxuwen
     * @date 2016年9月1日
	 * @return mv
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() throws Exception{
		return prizeTypeService.deletePrize(this);
	}
	
	public static void main(String[] args) {
		System.out.println("asd"+"1");
	}
}
