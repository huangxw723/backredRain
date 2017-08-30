package com.aoshi.controller.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.VersionService;
	
/**
 * 广告管理 Controller
 * 
 * @author haungxw
 * @date 2016年9月2日
 */
@Controller
@RequestMapping("/version")
public class VersionController extends BaseController {

	@Autowired
	private VersionService versionService;

	/**
	 * 查询
	 * 
	 * @author haungxw
	 * @date 2016年9月2日
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return versionService.listAll(this);
	}
	
	
	/**
	 * 查询页面
	 * 
	 * @author haungxw
	 * @date 2016年9月2日
	 */
	@RequestMapping("/page")
	public Object page() {
		return versionService.list(this);
	}
	

	/**
	 * 广告增删改操作
	 * 
	 * @author haungxw
	 * @date 2016年9月2日
	 * @return
	 */
	@RequestMapping("/opera")
	@ResponseBody
	public Object opera() {
		return versionService.opera(this);
	}


	/**
	 * 删除广告
	 * 
	 * @author haungxw
	 * @date 2016年9月5日
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(BaseController c) {
		return versionService.delete(this);
	}

	

	
}
