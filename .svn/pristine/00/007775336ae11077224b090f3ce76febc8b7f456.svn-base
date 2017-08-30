package com.aoshi.controller.business.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.business.yp.RecordVisitService;

/**
 * 访问记录管理 Controller
 * 
 * @author huangxw
 * @date 2016年10月18日
 * @return
 */
@Controller
@RequestMapping("/yp/business/recordVisit")
public class RecordVisitController extends BaseController {
	
	@Autowired
	private RecordVisitService recordVisitService;
	
	
	/**
	 * 访问记录列表
	 * 
	 * @author huangxwe	
	 * @date 2016年9月1日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return recordVisitService.listAll(this);
	}
	
}
