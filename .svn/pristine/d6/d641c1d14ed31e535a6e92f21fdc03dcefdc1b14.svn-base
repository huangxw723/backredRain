package com.aoshi.controller.manage.yp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.domain.AsBusinessModule;
import com.aoshi.domain.AsBusinessTemplate;
import com.aoshi.domain.AsImageSource;
import com.aoshi.domain.AsModuleShop;
import com.aoshi.domain.AsTemplateFixed;
import com.aoshi.domain.AsTemplateType;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.domain.AsYpTemplate;
import com.aoshi.domain.AsYpUserModule;
import com.aoshi.domain.AsYpUserTemplate;
import com.aoshi.domain.SysUser;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.Role;
import com.aoshi.entity.system.User;
import com.aoshi.service.manage.yp.ImageSourceService;
import com.aoshi.service.manage.yp.TemplateService;
import com.aoshi.service.system.RoleService;
import com.aoshi.service.system.UserService;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/yp/admin/template")
public class TemplateController {
	private static final String BASE_URL = "manage/yp/template/";
	@Autowired
	TemplateService templateService;
	@Autowired
	ImageSourceService imageSourceService;
	@Autowired
	RoleService roleService;
	@Autowired
	UserService userService;
	
	/**
	 * 模版添加页面
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("toAddTemplate")
	public String toAddTemplate(ModelMap map){
		return BASE_URL+"addTemplate";
	}
	
	/**
	 * 新增模版
	 * 
	 * @param moduleStr
	 * @return
	 */
	@RequestMapping("addTemplate")
	public String addTemplate(AsYpTemplate template){
		String userId = this.getCurrentUser().getUSER_ID();
		template.setAdminId(userId);
		template.setCreateTime(DateUtil.getTime());
		template.setStatus(0);
		
		templateService.addTemplate(template);
		return BASE_URL+"result";
	}
	
	/**
	 * 删除用户模版
	 * @param userTemplateId
	 * @return
	 */
	@RequestMapping("delTemplate")
	@ResponseBody
	public Map<String,Object> delTemplate(int userTemplateId){
		return templateService.delTemplateByPrimaryKey(userTemplateId);
	}
	
	@RequestMapping("templateSelect")
	public String templateSelect(ModelMap map){
		List<AsYpTemplate> templates = templateService.getTemplats();
		map.put("templates", templates);
		return BASE_URL+"templateSelect";
	}
	
	/**
	 * 获取模版列表
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("getTemplates")
	public String getTemplates(ModelMap map,
			@RequestParam(value="parentUserModuleId",required=false)Integer parentUserModuleId,
			@RequestParam(value="parentUserTemplateId",required=false)Integer parentUserTemplateId,
			@RequestParam(value="rootUserTemplateId",required=false)Integer rootUserTemplateId){
		List<AsYpTemplate> templates = templateService.getTemplats();
		
		if(parentUserModuleId != null){
			map.put("parentUserModuleId", parentUserModuleId);
		}
		if(parentUserTemplateId != null){
			map.put("parentUserTemplateId", parentUserTemplateId);
		}
		if(rootUserTemplateId != null){
			map.put("rootUserTemplateId", rootUserTemplateId);
		}
		
		map.put("templates", templates);
		return BASE_URL+"templates";
	}
	
	/**
	 * 用户模版
	 * @return
	 */
	@RequestMapping("getUserTemplates")
	public String getUserTemplates(ModelMap map){
		User user = this.getCurrentUser();
		List<AsYpUserTemplate> userTemplates = templateService.getUserTemplateByUserId(user.getNewUserId());
		map.put("userTemplates", userTemplates);
		return BASE_URL+"userTemplats";
	} 
	
	
	@RequestMapping("toEditUserTemplate")
	public String toEditUserTemplate(ModelMap map,AsYpUserTemplate asYpUserTemplate){
		AsYpUserTemplate userTemplate = templateService.getUserTemplateByPrimaryKey(asYpUserTemplate);
		List<AsYpUserModule> userModules = templateService.getUserModule(userTemplate);
		if(StringUtils.isEmpty(asYpUserTemplate.getRootUserTemplateId())){
			this.getTreeData(asYpUserTemplate.getUserTemplateId(),asYpUserTemplate.getUserTemplateId(),map);
		}else{
			this.getTreeData(asYpUserTemplate.getRootUserTemplateId(),asYpUserTemplate.getUserTemplateId(),map);
		}
		
		
		map.put("userModules", JSONArray.fromObject(userModules));
		map.put("userTemplate", userTemplate);
		
		return BASE_URL+userTemplate.getPath();
	}
	
	private void getTreeData(int rootUserTemplateId,int currentId,ModelMap map){
		if(rootUserTemplateId == 0){
			rootUserTemplateId = currentId;
		}
		AsYpUserTemplate treeData= templateService.getTreeData(rootUserTemplateId,currentId);
		List<AsYpBaseCategory> categories = templateService.getYpCategories();
		map.put("treeData", JSONObject.fromObject(treeData));
		map.put("rootUserTemplateId", rootUserTemplateId);
		map.put("categories",categories);
	}
	
	
	/**
	 * 选择模版
	 * @param map
	 * @param templateId
	 * @param parentUserModuleId
	 * @param parentUserTemplateId
	 * @param rootUserTemplateId
	 * @return
	 */
	@RequestMapping("selectTemplate")
	public String selectTemplate(ModelMap map,Integer templateId,
			@RequestParam(value="remark",required=false) Integer remark,HttpServletRequest request,
			@RequestParam(value="parentUserModuleId",required=false) Integer parentUserModuleId,
			@RequestParam(value="parentUserTemplateId",required=false) Integer parentUserTemplateId,
			@RequestParam(value="rootUserTemplateId",required=false)Integer rootUserTemplateId){
		Assert.notNull("templateId", "模版id不能为空");
		User user = this.getCurrentUser();
		int userId = Integer.parseInt(user.getNewUserId());
		StringBuffer url = request.getRequestURL();
		url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
		//request.getSession().setAttribute("remark", remark);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("templateId", templateId);
		param.put("userId", userId);
		param.put("parentUserModuleId", parentUserModuleId);
		param.put("parentUserTemplateId", parentUserTemplateId);
		param.put("rootUserTemplateId", rootUserTemplateId);
		param.put("url", url);
		
		AsYpUserTemplate userTemplate = templateService.selectTemplate(param);
		if(StringUtils.isEmpty(rootUserTemplateId)){
			this.getTreeData(userTemplate.getUserTemplateId(),userTemplate.getUserTemplateId(),map);
		}else{
			this.getTreeData(rootUserTemplateId,userTemplate.getUserTemplateId(),map);
		}
		
		
		map.put("userTemplate", userTemplate);
		return BASE_URL+userTemplate.getPath();
	}
	
	/**
	 * 保存模块内容
	 * @param moduleStr [{userTemplateId:1,content:"招商活动",position:1}]
	 * @param userTemplate
	 * @return
	 */
	@RequestMapping("saveModuleContent")
	public String saveModuleContent(ModelMap map,@RequestParam MultipartFile[] file,
			@RequestParam(value="rootUserTemplateId",required=false)Integer rootUserTemplateId,
			String moduleStr,AsYpUserTemplate userTemplate){
		List<AsYpUserModule> userModules = templateService.saveModuleContent(moduleStr,file);
		map.put("userModules", JSONArray.fromObject(userModules));
		map.put("userTemplate", userTemplate);
		if(StringUtils.isEmpty(rootUserTemplateId)){
			this.getTreeData(userTemplate.getUserTemplateId(),userTemplate.getUserTemplateId(), map);
		}else{
			this.getTreeData(rootUserTemplateId,userTemplate.getUserTemplateId(), map);
		}
		
		return BASE_URL+userTemplate.getPath();
	}
	
	/**
	 * 上传模块背景图
	 * @param file
	 * @return
	 *//*
	@RequestMapping(value="uploadIcon")
	@ResponseBody
	public Map<String,String> uploadIcon(@RequestParam MultipartFile file){
		return templateService.uploadIcon(file);
	}
	*/
	/**
	 * 保存模版的icon
	 * @param moduleStr [{icon:"ascmMall/goods/d380707ed23742319b6d9a2eccbdbedb.jpg",userModuleId:1}]
	 * @param userTemplate
	 * @return
	 */
	@RequestMapping("saveModuleIcon")
	public String updateModuleIcon(String moduleStr,AsYpUserTemplate userTemplate){
		templateService.updateModuleIcon(moduleStr);
		return BASE_URL+userTemplate.getPath();
	}
	
	
	
	
	
	
	
	/***************业态模版-begin*******************/
	
	
	/**
	 * 业态模版,用于显示，不可编辑
	 * @param map
	 * @return
	 */
	@RequestMapping("getBusinessSysTemplates")
	public String getBusinessSysTemplates(ModelMap map,
			@RequestParam(value="select",required=false) Integer select,
			@RequestParam(value="type",required=false) Integer typeId){
		List<AsTemplateType> types = templateService.getTemplateTypes();
		
		if(typeId == null){
			typeId = types.get(0).getTemplateTypeId();
		}
		//PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsBusinessTemplate> businessTemplates = templateService.getBusinessTemplates(typeId);
		if(select != null){
			map.put("select", select); // 按钮权限
		}
		//page.setPage(businessTemplates);
		map.put("businessTemplates", JSONArray.fromObject(businessTemplates));
		map.put("typeId", typeId);
		map.put("types", JSONArray.fromObject(types));
		return BASE_URL+"sysTemplates";
	}
	
	/**
	 * 业态模版，可编辑
	 * @param map
	 * @return
	 */
	@RequestMapping("getSysTemplates")
	public String getSysTemplates(ModelMap map,
			@RequestParam(value="select",required=false) Integer select,
			@RequestParam(value="type",required=false) Integer typeId){
		List<AsTemplateType> types = templateService.getTemplateTypes();
		
		if(typeId == null){
			typeId = types.get(0).getTemplateTypeId();
		}
		//PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsBusinessTemplate> businessTemplates = templateService.getBusinessTemplates(typeId);
		//page.setPage(businessTemplates);
		map.put("businessTemplates", JSONArray.fromObject(businessTemplates));
		if(select != null){
			map.put("select", select); // 按钮权限
		}
		map.put("typeId", typeId);
		map.put("types", JSONArray.fromObject(types));
		return BASE_URL+"businessTemplates";
	}
	
	@RequestMapping("getBusinessTemplateByType")
	@ResponseBody
	public Map<String,Object> getBusinessTemplateByType(int templateTypeId){
		Map<String,Object> data = new HashMap<>();
		//List<AsTemplateType> types = templateService.getTemplateTypes();
		
		
		List<AsBusinessTemplate> businessTemplates = templateService.getBusinessTemplates(templateTypeId);
		data.put("businessTemplates", businessTemplates);
		
		//data.put("typeId", templateTypeId);
		//data.put("types", types);
		return data;
	}
	
	@RequestMapping("getMyBusinessTemplates")
	public String getMyBusinessTemplates(ModelMap map){
		User user = this.getCurrentUser();
		List<AsBusinessTemplate> businessTemplates = templateService.getMyBusinessTemplates(user.getUSER_ID());
		map.put("businessTemplates", businessTemplates);
		return BASE_URL+"myBusinessTemplates";
	}
	
	@RequestMapping("toAddBusinessTemplate")
	public String toAddBusinessTemplate(ModelMap map){
		List<AsTemplateType> templateTypes = templateService.getTemplateTypes();
		map.put("templateTypes", templateTypes);
		return BASE_URL+"addBusinessTemplate";
	}
	
	@RequestMapping("toAddThirdLv")
	public String toAddThirdLv(ModelMap map){
		List<AsTemplateType> templateTypes = templateService.getTemplateTypes();
		List<AsBusinessTemplate> templates = templateService.getBusinessTemplateByLevel(2);
		map.put("templateTypes", templateTypes);
		map.put("templates", templates);
		return BASE_URL+"addThirdLv";
	}
	
	/**
	 * 添加三级模版
	 * @param template
	 * @param map
	 * @return
	 */
	@RequestMapping("addThirdLv")
	public String addThirdLv(AsBusinessTemplate template,ModelMap map){
		template.setParentBusinessModuleId(0);
		template.setRootBusinessTemplateId(0);
		template.setStatus(0);
		template.setCreateTime(DateUtil.getTime());
		templateService.addBusinessTemplate(template);
		return BASE_URL+"result";
	}
	
	@RequestMapping("addBusinessTemplate")
	public String addBusinessTemplate(AsBusinessTemplate template,ModelMap map){
		template.setParentBusinessModuleId(0);
		template.setParentBusinessTemplateId(0);
		template.setRootBusinessTemplateId(0);
		template.setStatus(0);
		template.setCreateTime(DateUtil.getTime());
		templateService.addBusinessTemplate(template);
		return BASE_URL+"result";
	}
	
	@RequestMapping("toEditBusinessTemplate")
	public String toEditBusinessTemplate(ModelMap map,AsBusinessTemplate template){
		AsBusinessTemplate businessTemplate = templateService.findBusinessTemplate(template.getBusinessTemplateId());
		Assert.notNull(businessTemplate);
		List<AsBusinessModule> businessModules = templateService.getBusinessModuleWithTemplate(businessTemplate);
		Integer rootId = businessTemplate.getRootBusinessTemplateId();
		if(rootId.equals(0) || rootId==null){
			getBusinessTreeData(businessTemplate.getBusinessTemplateId(), businessTemplate.getBusinessTemplateId(), map);
		}else{
			getBusinessTreeData(rootId, businessTemplate.getBusinessTemplateId(), map);
		}
		
		List<AsBusinessTemplate> templates = new ArrayList<AsBusinessTemplate>();
		if(businessTemplate.getLevel().equals(1)){
			templates = templateService.getBusinessTemplateByLevel(2);
			List<AsTemplateFixed> asTemplateFixeds = templateService.selectTemplateFixeds();
			map.put("templateFixeds", asTemplateFixeds);
		}else if(businessTemplate.getLevel().equals(2)){
			AsBusinessTemplate param = new AsBusinessTemplate();
			param.setParentBusinessTemplateId(businessTemplate.getBusinessTemplateId());
			
			templates = templateService.selectTemplateByAttr(param);
			if(templates.size()>0){
				map.put("defaultId", templates.get(0).getBusinessTemplateId());
			}
			
		}
		
		
		if(businessTemplate.getUserId() == null){
			map.put("show", true);//该角色是系统管理员，显示删除按钮
		}
		
		map.put("templates", templates);
		map.put("businessModules", JSONArray.fromObject(businessModules));
		map.put("businessTemplate", businessTemplate);
		
		return BASE_URL+businessTemplate.getPath();
	}
	
	@RequestMapping("selectBusinessTemplate")
	public String selectBusinessTemplate(ModelMap map,AsBusinessTemplate template){
		AsBusinessTemplate businessTemplate = templateService.findBusinessTemplate(template.getBusinessTemplateId());
		List<AsBusinessModule> modules = templateService.getBusinessModuleWithTemplate(businessTemplate);
		
		User user = this.getCurrentUser();
		businessTemplate.setBusinessTemplateId(null);
		businessTemplate.setUserId(user.getUSER_ID());
		businessTemplate.setIsSample(false);
		templateService.insertBusinessTemplate(businessTemplate,modules);
		map.put("flag", true);
		return BASE_URL+"result";
	}
	
	private void getBusinessTreeData(int rootBusinessTemplateId,int currentId,ModelMap map){
		if(rootBusinessTemplateId == 0){
			rootBusinessTemplateId = currentId;
		}
		AsBusinessTemplate treeData= templateService.getBusinessTreeData(rootBusinessTemplateId,currentId);
		map.put("treeData", JSONObject.fromObject(treeData));
		map.put("rootBusinessTemplateId", rootBusinessTemplateId);
	}
	
	@RequestMapping("toSelectImg")
	public String toSelectImg(int businessModuleId,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam(value="area",required=false)String area,
			ModelMap map){
		if(!StringUtils.isEmpty(type)){
			map.put("type", type);
		}
		if(!StringUtils.isEmpty(area)){
			map.put("area", area);
		}
		AsBusinessModule module = templateService.findModuleByBusinessModuleId(businessModuleId);
		if(module != null && module.getBackgroundImage() != null && module.getBackgroundImage() != ""){
			map.put("image", module.getBackgroundImage());
		}
		map.put("businessModuleId", businessModuleId);
		return BASE_URL+"selectImg";
	}
	
	@RequestMapping("toSelectInvestImg")
	public String toSelectInvestImg(int businessModuleId,int position,ModelMap map){
		AsBusinessModule param = new AsBusinessModule();
		param.setParentModuleId(businessModuleId);
		param.setPosition(position);
		
		AsBusinessModule module = templateService.selectBusinessModuleByParent(param);
		if(module != null){
			map.put("businessModuleId", module.getBusinessModuleId());
			map.put("image", module.getBackgroundImage());
		}
		map.put("parentModuleId", businessModuleId);
		map.put("position", position);
		return BASE_URL+"selectInvestImg";
	}
	
	@RequestMapping("toEditAd")
	public String toEditAd(int businessModuleId,
			ModelMap map){
		AsBusinessModule module = templateService.findModuleByBusinessModuleId(businessModuleId);
		map.put("businessModuleId", businessModuleId);
		map.put("content", module.getContent());
		return BASE_URL+"editAd";
	}
	
	/**
	 * 保存模块背景图片
	 * @param businessModuleId
	 * @param orign 0未做任何更改 1代表图片库 2代表本地图片
	 * @param file
	 * @param map
	 * @return
	 */
	@RequestMapping("saveImg")
	public String saveImg(int businessModuleId,int orign,
			@RequestParam(value="imgUrl",required=false)String imgUrl,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam MultipartFile file,ModelMap map){
		
		map.put("businessModuleId", businessModuleId);
		
		String img = templateService.saveImg(businessModuleId,type,file,imgUrl,orign);
		if(!"".equals(img)){
			map.put("flag", false);
			map.put("data", img);
		}
		return BASE_URL+"result";
	}
	
	/**
	 * 保存招商模版的图片
	 * @return
	 */
	@RequestMapping("saveInvestImg")
	public String saveInvestImg(@RequestParam(value="businessModuleId",required=false)Integer businessModuleId,
			@RequestParam(value="imgUrl",required=false)String imgUrl,int orign,
			@RequestParam(value="position",required=false)Integer position,
			Integer parentModuleId,
			@RequestParam MultipartFile file,ModelMap map){
		String img = templateService.saveInvestImg(parentModuleId,businessModuleId,position,file,imgUrl,orign);
		if(!"".equals(img)){
			map.put("flag", false);
			map.put("data", img);
		}
		return BASE_URL+"result";
	}
	
	/**
	 * 保存模块店铺信息
	 * @param shop
	 * @param imgUrl1
	 * @param orign1 图片来源  0代表默认  1代表图片库 2代表本地图片
	 * @param imgUrl2
	 * @param orign2 图片来源  0代表默认  1代表图片库 2代表本地图片
	 * @param imgfile
	 * @param logofile
	 * @param map
	 * @return
	 */
	@RequestMapping("saveShop")
	public String saveShop(AsModuleShop shop,
			@RequestParam(value="imgUrl1",required=false)String imgUrl1,int orign1,
			@RequestParam(value="imgUrl2",required=false)String imgUrl2,int orign2,
			@RequestParam MultipartFile imgfile,
			@RequestParam MultipartFile logofile,
			ModelMap map){
		int rs = templateService.saveShop(shop,imgfile,logofile,imgUrl1,imgUrl2,orign1,orign2);
		if(rs>0){
			map.put("flag", false);
		}
		return BASE_URL+"result";
	}
	
	@RequestMapping("delShopImg")
	@ResponseBody
	public Boolean delShopImg(int businessModuleId){
		return templateService.delShopImg(businessModuleId);
	}
	
	@RequestMapping("delShopLogo")
	@ResponseBody
	public Boolean delShopLogo(int businessModuleId){
		return templateService.delShopLogo(businessModuleId);
	}
	
	@RequestMapping("delBackgroundImg")
	@ResponseBody
	public Boolean delBackgroundImg(int businessModuleId){
		return templateService.delBackgroundImg(businessModuleId);
	}
	
	@RequestMapping("delFixedImg")
	@ResponseBody
	public Boolean delFixedImg(int templateFixedId){
		return templateService.delFixedImg(templateFixedId);
	}
	
	/**
	 * 保存模块背景图片
	 * @param businessModuleId
	 * @param file
	 * @param map
	 * @return
	 */
	@RequestMapping("saveVideo")
	public String saveVideo(int businessModuleId,
			@RequestParam(value="type",required=false)Integer type,
			@RequestParam MultipartFile file,ModelMap map){
		
		map.put("businessModuleId", businessModuleId);
		
		String img = templateService.saveVideo(businessModuleId,type,file);
		if(!"".equals(img)){
			map.put("flag", false);
			map.put("data", img);
		}
		return BASE_URL+"result";
	}
	
	
	/**
	 * 编辑并保存广告
	 * @param module
	 * @param map
	 * @return
	 */
	@RequestMapping("saveAd")
	public String saveAd(AsBusinessModule module,ModelMap map){
		module.setType(2);
		AsBusinessModule asBusinessModule = templateService.saveAd(module);
		map.put("data", asBusinessModule.getContent());
		map.put("flag", false);
		return BASE_URL+"result";
	}
	
	/**
	 * 
	 * @param moduleStr [{"businessModuleId":"19","rootBusinessTemplateId":rootBusinessTemplateId,"businessTemplateId":"16"},
	 * {"businessModuleId":"20","rootBusinessTemplateId":rootBusinessTemplateId,"businessTemplateId":"16"}]
	 * @return
	 */
	@RequestMapping("saveMyBusinessTemplate")
	@ResponseBody
	public boolean saveMyBusinessTemplate(String moduleStr){
		User user = this.getCurrentUser();
		return templateService.saveMyBusinessTemplate(moduleStr,user.getUSER_ID());
	}
	
	@RequestMapping("delBusinessTemplate")
	@ResponseBody
	public Map<String,Object> delBusinessTemplate(int businessTemplateId){
		return templateService.delBusinessTemplate(businessTemplateId);
	}
	
	/**
	 * 
	 * @param str [{"businessModuleId":1,"address":"一楼UM35","size":"30","shopType":"办公","rent":"3000"}]
	 * @return
	 */
	@RequestMapping("saveInvestment")
	@ResponseBody
	public int saveInvestment(String str){
		return templateService.saveInvestment(str);
	}
	
	/**
	 * 
	 * @param businessModuleId,type
	 * @return
	 */
	@RequestMapping("toEditShop")
	public String toEditShop(AsBusinessModule module,String key,ModelMap map){
		AsModuleShop shop = templateService.findModuleShop(module.getBusinessModuleId());
		map.put("key", key);
		map.put("type", module.getType());
		map.put("businessModuleId", module.getBusinessModuleId());
		if(shop!=null){
			map.put("shop", shop);
			return BASE_URL+"editShop";
		}else{
			return BASE_URL+"addShop";
		}
		
		
	}
	
	
	@RequestMapping("toSelectVideo")
	public String toSelectVideo(int businessModuleId,
			int type,ModelMap map){
		map.put("businessModuleId", businessModuleId);
		map.put("type", type);
		return BASE_URL+"selectVideo";
	}
	
	/**
	 * 添加模版的下一页数据
	 * @param businessTemplateId
	 * @return
	 */
	@RequestMapping("addNextPage")
	@ResponseBody
	public int addNextPage(int businessTemplateId){
		User user = this.getCurrentUser();
		return templateService.addNextPage(businessTemplateId,user.getUSER_ID());
	}
	
	@RequestMapping("delModule")
	@ResponseBody
	public Map<String,Object> delModule(int businessTemplateId,int pageNum,int pageSize){
		return templateService.delModule(businessTemplateId,pageNum,pageSize);
	}
	
	/**
	 * 新增样板模块
	 * @param map
	 * @return
	 */
	@RequestMapping("toAddSample")
	public String toAddSample(ModelMap map){
		AsBusinessTemplate template = new AsBusinessTemplate();
		template.setIsSample(true);
		List<AsBusinessTemplate> businessTemplates = templateService.selectTemplateByAttr(template);
		map.put("businessTemplates", JSONArray.fromObject(businessTemplates));
		return BASE_URL+"sampleTemplates";
	}
	
	@RequestMapping("selectSample")
	@ResponseBody
	public int selectSample(int businessTemplateId){
		return templateService.addSample(businessTemplateId);
	}
	
	@RequestMapping("myDomains")
	public String myDomains(Page page,HttpServletRequest request,ModelMap map){
		User user = this.getCurrentUser();
		
		StringBuffer url = request.getRequestURL();
		url.delete(url.length() - request.getRequestURI().length(), url.length()).append("/").toString();
		//
		
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		
		List<AsBusinessTemplate> businessTemplates = templateService.getMyBusinessTemplates(user.getUSER_ID());
		for(AsBusinessTemplate t:businessTemplates){
			String tempPath = url+"redRain/static/template/business/"+t.getPath()+".html?businessTemplateId="+t.getBusinessTemplateId();
			t.setTempPath(tempPath);
		}
		page.setPage(businessTemplates);
		map.put("businessTemplates", businessTemplates);
		return BASE_URL+"myDomains";
	}
	
	@RequestMapping("toEditTempName")
	public String toEditTempName(int businessTemplateId,ModelMap map){
		AsBusinessTemplate template = templateService.findBusinessTemplate(businessTemplateId);
		map.put("template", template);
		
		return BASE_URL+"editTempName";
	}
	
	@RequestMapping("updateTemplateName")
	public String updateTemplateName(AsBusinessTemplate template,ModelMap map){
		templateService.updateTemplate(template);
		map.put("flag", true);
		return BASE_URL+"result";
	}
	
	@RequestMapping("toSelectFixedImg")
	public String toSelectFixedImg(int templateFixedId,ModelMap map){
		AsTemplateFixed templateFixed = templateService.findTemplateFixed(templateFixedId);
		Assert.notNull(templateFixed);
		
		map.put("templateFixed", templateFixed);
		return BASE_URL+"selectFixedImg";
	}
	
	@RequestMapping("saveFixedImg")
	public String saveFixedImg(@RequestParam MultipartFile file,AsTemplateFixed templateFixed,ModelMap map){
		String data = templateService.saveFixedImg(file,templateFixed);
		map.put("data", data);
		map.put("flag", true);
		return BASE_URL+"result";
	}
	
	@RequestMapping("getImageSources")
	public String getImageSources(ModelMap map,Page page,AsImageSource asImageSource) throws Exception{
		User user = this.getCurrentUser();
		Role role = roleService.getRoleById(user.getROLE_ID());
		if(role.getIs_admin()!=1){
			asImageSource.setCreator(user.getUSERNAME());
		}
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsImageSource> images = imageSourceService.selectByAttr(asImageSource);
		List<AsTemplateType> templateTypes = templateService.getTemplateTypes();
		map.put("templateTypes", templateTypes);
		if(asImageSource.getTemplateTypeId() != null){
			map.put("templateTypeId", asImageSource.getTemplateTypeId());
		}
		if(asImageSource.getImageName() != null){
			map.put("imageName", asImageSource.getImageName());
		}
		page.setPage(images);
		map.put("currentPage", page.getCurrentPage());
		map.put("images", images);
		return BASE_URL+"imageSourceList";
	}
	
	@RequestMapping("toAddImageSource")
	public String toAddImageSource(ModelMap map){
		List<AsTemplateType> templateTypes = templateService.getTemplateTypes();
		map.put("templateTypes", templateTypes);
		return BASE_URL+"addImageSource";
	}
	
	@RequestMapping("saveImageSource")
	public String saveImageSource(AsImageSource imageSource,MultipartFile file,ModelMap map){
		imageSource.setCreator(this.getCurrentUser().getUSERNAME());
		imageSourceService.saveImageSource(imageSource,file);
		map.put("flag", true);
		return BASE_URL+"result";
	}
	
	@RequestMapping("toEditImageSource")
	public String toEditImageSource(int imageSourceId,ModelMap map){
		AsImageSource image = imageSourceService.selectByPrimaryKey(imageSourceId);
		List<AsTemplateType> templateTypes = templateService.getTemplateTypes();
		map.put("templateTypes", templateTypes);
		map.put("image", image);
		return BASE_URL+"editImageSource";
	}
	
	public String toAddUserBusinessTemplate(ModelMap map){
		Role role = roleService.findByRoleName("商家");
		List<User> users = userService.getUserByRoleId(role.getROLE_ID()); 
		return BASE_URL+"userList";
	}
	
	/**
	 * 删除我的模版
	 * @param businessTemplateId
	 * @return
	 */
	@RequestMapping("deleteDomain")
	@ResponseBody
	public int deleteDomain(int businessTemplateId){
		User user = this.getCurrentUser();
		return templateService.deleteDomain(businessTemplateId,user.getUSER_ID());
	}
	
	@RequestMapping("toSelectImgSource")
	public String toSelectImgSource(ModelMap map,Page page,AsImageSource asImageSource) throws Exception{
		User user = this.getCurrentUser();
		Role role = roleService.getRoleById(user.getROLE_ID());
		if(role.getIs_admin()!=1){
			asImageSource.setCreator(user.getUSERNAME());
		}
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsImageSource> images = imageSourceService.selectByAttr(asImageSource);
		List<AsTemplateType> templateTypes = templateService.getTemplateTypes();
		map.put("templateTypes", templateTypes);
		if(asImageSource.getTemplateTypeId() != null){
			map.put("templateTypeId", asImageSource.getTemplateTypeId());
		}
		if(asImageSource.getImageName() != null){
			map.put("imageName", asImageSource.getImageName());
		}
		page.setPage(images);
		map.put("currentPage", page.getCurrentPage());
		map.put("images", images);
		return BASE_URL+"selectImgSource";
	}
	
	/**************液态模版-end********************/
	
	/**
	 * 获取后台用户
	 * 
	 * @author luhuajiang
	 * @return
	 */
	public User getCurrentUser() {
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		return user;
	}
	
	
	/**
	 * 获取权限信息
	 * 
	 * @author yangyanchao
	 * @date 2016年6月24日
	 * @return
	 */
	protected Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	
	@RequestMapping("preview")
	public String preview(int businessTemplateId,String path,HttpServletRequest request){
		
		return "redirect:/static/template/business/"+path+".html?businessTemplateId="+businessTemplateId;
	}
	
	
}
