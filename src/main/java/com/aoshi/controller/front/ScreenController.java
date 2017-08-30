package com.aoshi.controller.front;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.domain.AsBusinessModule;
import com.aoshi.domain.AsBusinessTemplate;
import com.aoshi.domain.AsTemplateFixed;
import com.aoshi.domain.AsYpUserModule;
import com.aoshi.domain.AsYpUserTemplate;
import com.aoshi.service.manage.yp.TemplateService;

@RequestMapping(value="static/template/")
@Controller
public class ScreenController {
	@Autowired
	TemplateService templateService;
	
	@RequestMapping(value="templateDetail/{shopId}/{number}/{userTemplateId}")
	public String templateDetail(@PathVariable int shopId,@PathVariable int number,@PathVariable int userTemplateId,
			HttpServletRequest request){
		StringBuffer url = request.getRequestURL();
		url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
		
		AsYpUserTemplate asYpUserTemplate = new AsYpUserTemplate();
		asYpUserTemplate.setUserTemplateId(userTemplateId);
		AsYpUserTemplate userTemplate = templateService.getUserTemplateByPrimaryKey(asYpUserTemplate);
		String path = userTemplate.getPath();
		return "redirect:"+url+"redRain/static/template/html/"+path+".html?userTemplateId="+userTemplateId;
	}
	
	/**
	 * 
	 * @param map
	 * @param asYpUserTemplate
	 * @return
	 */
	@RequestMapping("getUserTemplateById")
	@ResponseBody
	public Map<String,Object> getUserTemplateById(AsYpUserTemplate asYpUserTemplate){
		AsYpUserTemplate userTemplate = templateService.getUserTemplateByPrimaryKey(asYpUserTemplate);
		List<AsYpUserModule> userModules = templateService.getUserModule(userTemplate);
		
		Map<String,Object> map = new HashMap<>();
		map.put("userModules", userModules);
		map.put("userTemplate", userTemplate);
		
		return map;
	}
	
	@RequestMapping("getBusinessTemplateById")
	@ResponseBody
	public Map<String,Object> getBusinessTemplateById(int businessTemplateId){
		Map<String,Object> data = new HashMap<>();
		AsBusinessTemplate businessTemplate = new AsBusinessTemplate();
		businessTemplate.setBusinessTemplateId(businessTemplateId);
		AsBusinessTemplate template = templateService.findBusinessTemplate(businessTemplateId);
		List<AsBusinessModule> modules = templateService.getBusinessModuleWithTemplate(businessTemplate);
		if(template.getLevel().equals(1)){
			List<AsTemplateFixed> templateFixeds = templateService.selectTemplateFixeds();
			data.put("templateFixeds", templateFixeds);
		}
		
		
		data.put("templateName", template.getTemplateName());
		data.put("modules", modules);
		return data;
	}
}
