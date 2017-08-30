package com.aoshi.controller.manage.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.yp.TemplateAdminService;

@Controller
@RequestMapping("/yp/admin/template")
public class TemplateAdminController extends BaseController {

	private final static String PAGE_PATH = "manage/yp/admin_template/";

	@Autowired
	private TemplateAdminService templateAdminService;

	@RequestMapping("/uploadTemplatePackagePath")
	public Object uploadTemplatePackagePath() {

		initialized();

		addViewData("action", OperaEnum.get(pd.getInt("action")).getId());

		return renderView(PAGE_PATH + "save");
	}

	@RequestMapping("/uploadTemplatePackage")
	@ResponseBody
	public Object uploadTemplatePackage() {

		return templateAdminService.uploadTemplatePackage_Tx(this);
	}
}
