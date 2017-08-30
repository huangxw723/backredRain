package com.aoshi.service.manage.yp;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.dao.AsBusinessModuleMapper;
import com.aoshi.dao.AsBusinessTemplateMapper;
import com.aoshi.dao.AsModuleInvestmentMapper;
import com.aoshi.dao.AsModuleShopMapper;
import com.aoshi.dao.AsTemplateFixedMapper;
import com.aoshi.dao.AsTemplateTypeMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.dao.AsYpTemplateMapper;
import com.aoshi.dao.AsYpUserModuleMapper;
import com.aoshi.dao.AsYpUserTemplateMapper;
import com.aoshi.domain.AsBusinessModule;
import com.aoshi.domain.AsBusinessTemplate;
import com.aoshi.domain.AsModuleInvestment;
import com.aoshi.domain.AsModuleShop;
import com.aoshi.domain.AsTemplateFixed;
import com.aoshi.domain.AsTemplateType;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.domain.AsYpScreenDomain;
import com.aoshi.domain.AsYpTemplate;
import com.aoshi.domain.AsYpUserModule;
import com.aoshi.domain.AsYpUserTemplate;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;
import com.github.pagehelper.PageHelper;


@Service
@Transactional
public class TemplateService{
	@Autowired
	AsYpTemplateMapper asYpTemplateMapper;
	@Autowired
	AsYpUserTemplateMapper asYpUserTemplateMapper;
	@Autowired
	AsYpUserModuleMapper asYpUserModuleMapper;
	@Autowired
	AsYpScreenDomainMapper asYpScreenDomainMapper;
	@Autowired
	AsYpBaseCategoryMapper asYpBaseCategoryMapper;
	@Autowired
	AsBusinessTemplateMapper asBusinessTemplateMapper;
	@Autowired
	AsBusinessModuleMapper asBusinessModuleMapper;
	@Autowired
	AsTemplateTypeMapper asTemplateTypeMapper;
	@Autowired
	AsModuleInvestmentMapper asModuleInvestmentMapper;
	@Autowired
	AsModuleShopMapper asModuleShopMapper;
	@Autowired
	AsTemplateFixedMapper asTemplateFixedMapper;
	
	public List<AsYpTemplate> getTemplats(){
		return asYpTemplateMapper.getTemplats();
	}

	public AsYpUserTemplate selectTemplate(Map<String,Object> map) {
		// map里面的数据
		Integer templateId = (Integer) map.get("templateId");
		int userId = (Integer) map.get("userId");
		Integer parentUserModuleId = (Integer) map.get("parentUserModuleId");
		Integer parentUserTemplateId = (Integer) map.get("parentUserTemplateId");
		Integer rootUserTemplateId = (Integer)map.get("rootUserTemplateId");
		String url = map.get("url").toString();
		Integer shopId = 0;
		if(map.get("shopId") != null && map.get("shopId").toString() != "null"){
			shopId = (Integer)map.get("shopId");
		}
		
		
		AsYpTemplate template = asYpTemplateMapper.selectByPrimaryKey(templateId);
		Assert.notNull(template, "模版不能为空");
		parentUserModuleId = parentUserModuleId == null?0:parentUserModuleId;
		parentUserTemplateId = parentUserTemplateId==null?0:parentUserTemplateId;
		rootUserTemplateId = rootUserTemplateId == null?0:rootUserTemplateId;
		
		AsYpUserTemplate userTemplate = new AsYpUserTemplate();
		if(parentUserTemplateId != 0){
			AsYpUserTemplate parent = asYpUserTemplateMapper.selectByPrimaryKey(parentUserTemplateId);
				userTemplate.setIsBusiness(parent.getIsBusiness());
		}else{
			userTemplate.setIsBusiness(0);
		}
		userTemplate.setName(template.getName());
		userTemplate.setTemplateId(templateId);
		userTemplate.setPath(template.getPath());
		userTemplate.setPreview(template.getPreview());
		userTemplate.setUserId(userId);
		userTemplate.setStatus(0);
		userTemplate.setIsHome(template.getIsHome());
		userTemplate.setParentUserModuleId(parentUserModuleId);
		userTemplate.setParentUserTemplateId(parentUserTemplateId);
		userTemplate.setRootUserTemplateId(rootUserTemplateId);
		userTemplate.setCreateTime(DateUtil.getTime());
		asYpUserTemplateMapper.insertSelective(userTemplate);
		
		Map<String,Integer> rs = asYpUserTemplateMapper.countUserTemplate(userId);
		//如果是第一层模版，则生成站点数据
		if(parentUserModuleId == 0){
			AsYpScreenDomain domain = new AsYpScreenDomain();
			domain.setUrl(url+"redRain/static/template/templateDetail/"
					+shopId+"/"+rs.get("number")+"/"+userTemplate.getUserTemplateId());
			domain.setUserTemplateId(userTemplate.getUserTemplateId());
			domain.setUserId(userId);
			domain.setStatus(0);
			domain.setCreateTime(DateUtil.getTime());
			domain.setIsMain(0);
			domain.setShopId(shopId);
			asYpScreenDomainMapper.insertSelective(domain);
		}
		return userTemplate;
	}
	
	public int saveTemplate(String moduleStr,AsYpTemplate template) {
		template.setCreateTime(DateUtil.getTime());
		template.setStatus(0);
		int result = asYpTemplateMapper.insertSelective(template);
		if(result>0){
			JSONArray jsonArray = JSONArray.fromObject(moduleStr);
			for(int i=0;i<jsonArray.size();i++){
				JSONObject json = jsonArray.getJSONObject(i);
			}
		}
		return 0;
	}

	/**
	 * 获取服务分类统计
	 * 
	 * @author yangyanchao
	 * @date 2016年10月26日
	 * @param c
	 * @return
	 */
	/*public Object getTypeList(BaseController c) {

		initialized(c);

		pageQueryModule(asYpTypeStatisticsMapper, "getYpTypeList", true);
		
		return renderView(PAGE_PATH + "type_list");
	}*/
	
	
	public int addTemplate(AsYpTemplate template) {
		return asYpTemplateMapper.insertSelective(template);
	}
	
	
	/**
	 * [{userTemplateId:1,content:"招商活动",position:1}]
	 * @param template
	 * @return
	 */
	public List<AsYpUserModule> saveModuleContent(String moduleStr,MultipartFile[] files) {
		JSONArray jsonArray = JSONArray.fromObject(moduleStr);
		
		List<AsYpUserModule> userModules = new ArrayList<AsYpUserModule>();
		for(int i=0;i<jsonArray.size();i++){
			JSONObject json = jsonArray.getJSONObject(i);
			
			AsYpUserModule userModule = new AsYpUserModule();
			if(json.get("userModuleId") !=null&& !json.getString("userModuleId").equals("")){
				userModule.setUserModuleId(json.getInt("userModuleId"));
			}
			
			userModule.setUserTemplateId(json.getInt("userTemplateId"));
			userModule.setContent(json.getString("content"));
			userModule.setPosition(json.getInt("position"));
			userModule.setUserId(json.getInt("userId"));
			userModule.setType(json.getInt("type"));
			userModule.setStatus(0);
			userModule.setCreateTime(DateUtil.getTime());
			
			AsYpUserModule module = asYpUserModuleMapper.selectByPrimaryKey(userModule.getUserModuleId());
			
			boolean flag = false;
			String fileName = files[i].getOriginalFilename();
			String ftpFile = "";
			String ftpDir = Const.TEMPLATEPATHIMG;
			if(!StringUtils.isEmpty(fileName)){
				
				ftpFile = UuidUtil.get32UUID() + fileName.substring(fileName.indexOf("."),fileName.length());
				try {
					flag = ftpUpload(files[i].getBytes(), ftpFile,ftpDir);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			if(module == null){
				if(flag){
					userModule.setIcon(ftpDir+"/"+ftpFile);
				}
				asYpUserModuleMapper.insertSelective(userModule);
				
			}else{
				if(flag){
					userModule.setIcon(ftpDir+"/"+ftpFile);
				}
				asYpUserModuleMapper.updateByPrimaryKeySelective(userModule);
			}
			if( StringUtils.isEmpty(files[i].getOriginalFilename()) && module!=null){
				userModule.setIcon(module.getIcon());
			}
			userModules.add(userModule);
			
		}
		return userModules;
	}

	public int updateModuleIcon(String moduleStr) {
		JSONArray jsonArray = JSONArray.fromObject(moduleStr);
		for(int i=0;i<jsonArray.size();i++){
			JSONObject json = jsonArray.getJSONObject(i);
			
			AsYpUserModule userModule = new AsYpUserModule();
			userModule.setIcon(json.getString("icon"));
			userModule.setUserModuleId(json.getInt("userModuleId"));
			asYpUserModuleMapper.updateByPrimaryKeySelective(userModule);
		}
		return 1;
	}

	public Map<String,String> uploadIcon(MultipartFile file) {
		boolean flag = false;
		String ftpFile = UuidUtil.get32UUID() + ".jpg";;
		String ftpDir = Const.TEMPLATEPATHIMG;
		//商品主图
		//String arr[] = String.valueOf(asGoods.getGoodsImg()).split(",");
		//ftp上传
		if(!StringUtils.isEmpty(file.getOriginalFilename())){
			try {
				flag = ftpUpload(file.getBytes(), ftpFile,ftpDir);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		Map<String,String> map = new HashMap<String, String>();
		if(flag){
			map.put("icon", ftpDir+"/"+ftpFile);
			return map;
		}else{
			return null;
		}
		
	}
	
	/**
	 * 上传ftp
	 * @param bytes --文件
	 * @param ftpFile--图片地址
	 * @param ftpDir--ftp路径
	 * @return
	 */
	private boolean ftpUpload(byte[] bytes,String ftpFile,String ftpDir){
		String path = Const.FILEPATHIMGDIR + ftpDir;
		//byte[] bytes = Base64.decode(goodsImg);
		
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			ftpConManager.login(PropertyUtils.getFTP_URL(),
			PropertyUtils.getFTP_USERNAME(),
			PropertyUtils.getFTP_PASS());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ftpConManager.uploadFileByInputStreamExistDirecroty(new ByteArrayInputStream(bytes), path, ftpFile);
	}
	
	private boolean fileRemove(String path){
		//byte[] bytes = Base64.decode(goodsImg);
		
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			ftpConManager.login(PropertyUtils.getFTP_URL(),
			PropertyUtils.getFTP_USERNAME(),
			PropertyUtils.getFTP_PASS());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (ftpConManager.getFiles(Const.FILEPATHIMGDIR + path).length != 0) {
			return ftpConManager.removeFile(Const.FILEPATHIMGDIR + path);
		}
		return false;
	}

	public List<AsYpUserTemplate> getUserTemplateByUserId(String userId) {
		return asYpUserTemplateMapper.getUserTemplateByUserId(userId);
		
	}

	public AsYpUserTemplate getUserTemplateByPrimaryKey(AsYpUserTemplate asYpUserTemplate) {
		return asYpUserTemplateMapper.getUserTemplateByPrimaryKey(asYpUserTemplate);
	}

	public List<AsYpUserModule> getUserModule(AsYpUserTemplate asYpUserTemplate) {
		return asYpUserModuleMapper.selectByAttr(asYpUserTemplate);
	}

	public AsYpUserTemplate getTreeData(int rootUserTemplateId,int currentId) {
		AsYpUserTemplate userTemplate = asYpUserTemplateMapper.selectByPrimaryKey(rootUserTemplateId);
		if(rootUserTemplateId == currentId){
			userTemplate.setChecked(true);
		}
		List<AsYpUserTemplate> children = asYpUserTemplateMapper.selectByParentUserTemplateId(userTemplate.getUserTemplateId());
		if(children != null && children.size()>0){
			for(AsYpUserTemplate t:children){
				if(t.getUserTemplateId().equals(currentId)){
					t.setChecked(true);
				}
				List<AsYpUserTemplate> lastChildren = asYpUserTemplateMapper.selectByParentUserTemplateId(t.getUserTemplateId());
				for(AsYpUserTemplate last:lastChildren){
					if(last.getUserTemplateId().equals(currentId)){
						last.setChecked(true);
					}
				}
				t.setChildren(lastChildren);
			}
		}
		
		userTemplate.setChildren(children);
		return userTemplate;
		
	}

	public Map<String,Object> delTemplateByPrimaryKey(int userTemplateId) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		AsYpUserTemplate userTemplate = asYpUserTemplateMapper.selectByPrimaryKey(userTemplateId);
		Assert.notNull(userTemplate,"模版不存在");
		
		List<AsYpUserTemplate> userTemplates = asYpUserTemplateMapper.selectByParentUserTemplateId(userTemplateId);
		if(userTemplates.size()>0){
			map.put("msg", "请先删除子模版");
		}else{
			if(userTemplate.getIsBusiness().equals(1)){
				map.put("isBusiness", true);
			}
			int rs = asYpUserTemplateMapper.deleteByPrimaryKey(userTemplateId);
			if(rs>0){
				asYpUserModuleMapper.deleteByUserTemplateId(userTemplateId);
				asYpScreenDomainMapper.deleteByUserTemplateId(userTemplateId);
			}
			
		}
		if(!userTemplate.getParentUserTemplateId().equals(0)){
			AsYpUserTemplate template = asYpUserTemplateMapper.selectByPrimaryKey(userTemplate.getParentUserTemplateId());
			map.put("template", template);
		}
		return map;
	}
	

	

	public List<AsYpBaseCategory> getYpCategories() {
		return asYpBaseCategoryMapper.getYpCategories();
	}
	
	
	/**************业态模版相关逻辑*******************/
	
	public List<AsBusinessTemplate> getBusinessTemplates(Integer templateTypeId) {
		return asBusinessTemplateMapper.getBusinessTemplates(templateTypeId);
	}

	public int addBusinessTemplate(AsBusinessTemplate template) {
		
		int result = asBusinessTemplateMapper.insertSelective(template);
		if(result > 0){
			int number = template.getModuleNumber();
			
			for(int i=0;i<number;i++){
				AsBusinessModule module = new AsBusinessModule();
				module.setBusinessTemplateId(template.getBusinessTemplateId());
				module.setCreateTime(DateUtil.getTime());
				module.setPosition(i+1);
				module.setStatus(0);
				asBusinessModuleMapper.insertSelective(module);
			}
		}
		return result;
	}
	
	public List<AsBusinessTemplate> getMyBusinessTemplates(String userId) {
		return asBusinessTemplateMapper.getMyBusinessTemplates(userId);
	}
	
	public AsBusinessTemplate findBusinessTemplate(int businessTemplateId) {
		return asBusinessTemplateMapper.selectByPrimaryKey(businessTemplateId);
	}
	
	public List<AsBusinessModule> getBusinessModuleWithTemplate(AsBusinessTemplate businessTemplate) {
		return asBusinessModuleMapper.selectByBusinessTemplateIdWithTemplate(businessTemplate.getBusinessTemplateId());
	}
	
	public AsBusinessTemplate getBusinessTreeData(int rootUserTemplateId,int currentId) {
		AsBusinessTemplate businessTemplate = asBusinessTemplateMapper.selectByPrimaryKey(rootUserTemplateId);
		if(rootUserTemplateId == currentId){
			businessTemplate.setChecked(true);
		}
		List<AsBusinessTemplate> children = asBusinessTemplateMapper.selectByParentBusinessTemplateIdOrderByPosition(businessTemplate.getBusinessTemplateId());
		if(children != null && children.size()>0){
			for(AsBusinessTemplate t:children){
				if(t.getBusinessTemplateId().equals(currentId)){
					t.setChecked(true);
				}
				/*List<AsYpUserTemplate> lastChildren = asYpUserTemplateMapper.selectByParentUserTemplateId(t.getUserTemplateId());
				for(AsYpUserTemplate last:lastChildren){
					if(last.getUserTemplateId().equals(currentId)){
						last.setChecked(true);
					}
				}
				t.setChildren(lastChildren);*/
			}
		}
		
		businessTemplate.setChildren(children);
		return businessTemplate;
		
	}

	public AsBusinessTemplate insertBusinessTemplate(AsBusinessTemplate template,List<AsBusinessModule> modules) {
		
		template.setParentBusinessModuleId(0);
		template.setParentBusinessTemplateId(0);
		template.setRootBusinessTemplateId(0);
		template.setStatus(0);
		template.setCreateTime(DateUtil.getTime());
		
		int result = asBusinessTemplateMapper.insertSelective(template);
		if(result > 0){
			
			for(int i=0;i<modules.size();i++){
				AsBusinessModule module = modules.get(i);
				module.setBusinessModuleId(null);//id要重新生成
				
				module.setUserId(template.getUserId());
				module.setBusinessTemplateId(template.getBusinessTemplateId());
				module.setCreateTime(DateUtil.getTime());
				module.setStatus(0);
				asBusinessModuleMapper.insertSelective(module);
				
				/**模块下对应的模版{"rootBusinessTemplateId":103,"path":"template_recommend","templateName":"新品推荐",
				 "id":130,"userId":null}
				**/
				Map<String,Object> businessTemplate = module.getTemplate();
				if(businessTemplate == null){
					continue ;
				}
				int id = Integer.parseInt(businessTemplate.get("id").toString());
				String path = businessTemplate.get("path").toString();
				String templateName = businessTemplate.get("templateName").toString();
				
				AsBusinessTemplate temp = new AsBusinessTemplate();
				temp.setTemplateName(templateName);
				temp.setPath(path);
				temp.setParentBusinessTemplateId(template.getBusinessTemplateId());
				temp.setRootBusinessTemplateId(template.getBusinessTemplateId());
				temp.setLevel(2);
				temp.setStatus(0);
				temp.setParentBusinessModuleId(module.getBusinessModuleId());
				temp.setCreateTime(DateUtil.getTime());
				temp.setUserId(template.getUserId());
				temp.setTemplateTypeId(template.getTemplateTypeId());
				
				//TODO SAVE
				//模版相应的模块
				List<AsBusinessModule> businessModules = asBusinessModuleMapper.selectByBusinessTemplateIdWithTemplate(id);
				
				temp.setModuleNumber(businessModules.size());
				//保存二级模版
				asBusinessTemplateMapper.insertSelective(temp);
				
				//保存二级模版对应的模块内容
				for(int j=0;j<businessModules.size();j++){
					AsBusinessModule m = businessModules.get(j);
					List<AsBusinessModule> children = m.getChildren();
					m.setBusinessModuleId(null);//重新生成主键
					m.setBusinessTemplateId(temp.getBusinessTemplateId());
					m.setUserId(template.getUserId());
					m.setStatus(0);
					m.setCreateTime(DateUtil.getTime());
					asBusinessModuleMapper.insertSelective(m);
					if(children.size()>0){
						for(int k=0;k<children.size();k++){
							AsBusinessModule child = children.get(k);
							child.setBusinessModuleId(null);
							child.setParentModuleId(m.getBusinessModuleId());
							child.setCreateTime(DateUtil.getTime());
							child.setUserId(template.getUserId());
							asBusinessModuleMapper.insertSelective(child);
						}
					}
					AsModuleShop shop = m.getShop();
					AsModuleInvestment investMent = m.getInvestMent();
					if(shop != null){
						shop.setModuleShopId(null);;
						shop.setBusinessModuleId(m.getBusinessModuleId());
						asModuleShopMapper.insertSelective(shop);
					}
					if(investMent != null && !StringUtils.isEmpty(investMent.getAddress())){
						investMent.setModuleInvestmentId(null);
						investMent.setBusinessModuleId(m.getBusinessModuleId());
						asModuleInvestmentMapper.insertSelective(investMent);
					}
				}
			}
		}
		return template;
	}
	
	/**
	 * 保存招商模版图片
	 * @param businessModuleId
	 * @param file
	 * @param orign 0未做任何更改 1代表图片库 2代表本地图片
	 * @return
	 */
	public String saveInvestImg(int parentModuleId,Integer businessModuleId,Integer position,
			MultipartFile file,String imgUrl,int orign) {
		
		boolean flag = false;
		String fileName = file.getOriginalFilename();
		String ftpFile = "";
		String ftpDir = Const.TEMPLATEPATHIMG;
		if(orign == 2){
			if(!StringUtils.isEmpty(fileName)){
				
				ftpFile = UuidUtil.get32UUID() + fileName.substring(fileName.indexOf("."),fileName.length());
				try {
					flag = ftpUpload(file.getBytes(), ftpFile,ftpDir);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(flag){
				
				if(businessModuleId == null){
					AsBusinessModule module = new AsBusinessModule();
					module.setParentModuleId(parentModuleId);
					module.setPosition(position);
					module.setType(6);
					module.setBackgroundImage(ftpDir+"/"+ftpFile);
					asBusinessModuleMapper.insertSelective(module);
				}else{
					AsBusinessModule module = new AsBusinessModule();
					module.setBusinessModuleId(businessModuleId);
					module.setBackgroundImage(ftpDir+"/"+ftpFile);
					asBusinessModuleMapper.updateByPrimaryKeySelective(module);
				}
				
			}
			if(flag){
				return ftpDir+"/"+ftpFile;
				//return "ascmMall/ad/9a62e9eaa7c14a90a418d85018d1c500.jpg";
			}
		}else if(orign == 1){
			if(businessModuleId == null){
				AsBusinessModule module = new AsBusinessModule();
				module.setParentModuleId(parentModuleId);
				module.setPosition(position);
				module.setType(6);
				module.setBackgroundImage(imgUrl);
				asBusinessModuleMapper.insertSelective(module);
			}else{
				AsBusinessModule module = new AsBusinessModule();
				module.setBusinessModuleId(businessModuleId);
				module.setBackgroundImage(imgUrl);
				asBusinessModuleMapper.updateByPrimaryKeySelective(module);
			}
			
			return imgUrl;
		}
		
		return "";
	}
	
	/**
	 * @param businessModuleId
	 * @param type
	 * @param file
	 * @param orign 0未做任何更改 1代表图片库 2代表本地图片
	 * @return
	 */
	public String saveImg(int businessModuleId,Integer type, MultipartFile file,String imgUrl,int orign) {
		AsBusinessModule module = new AsBusinessModule();
		
		boolean flag = false;
		String fileName = file.getOriginalFilename();
		String ftpFile = "";
		String ftpDir = Const.SHOPFILEPATHIMG;
		if(orign == 2){
			if(!StringUtils.isEmpty(fileName)){
				
				ftpFile = UuidUtil.get32UUID() + fileName.substring(fileName.indexOf("."),fileName.length());
				try {
					flag = ftpUpload(file.getBytes(), ftpFile,ftpDir);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(flag){
				module.setType(type);
				module.setBusinessModuleId(businessModuleId);
				module.setBackgroundImage(ftpDir+"/"+ftpFile);
				asBusinessModuleMapper.updateByPrimaryKeySelective(module);
				return ftpDir+"/"+ftpFile;
			}
		}else if(orign == 1){
			module.setType(type);
			module.setBusinessModuleId(businessModuleId);
			module.setBackgroundImage(imgUrl);
			asBusinessModuleMapper.updateByPrimaryKeySelective(module);
			return imgUrl;
		}
		
		return "";
		
	}
	public String saveVideo(int businessModuleId,Integer type, MultipartFile file) {
		AsBusinessModule module = new AsBusinessModule();
		
		boolean flag = false;
		String fileName = file.getOriginalFilename();
		String ftpFile = "";
		String ftpDir = Const.TEMPLATEPATHIMG;
		if(!StringUtils.isEmpty(fileName)){
			
			ftpFile = UuidUtil.get32UUID() + fileName.substring(fileName.indexOf("."),fileName.length());
			try {
				flag = ftpUpload(file.getBytes(), ftpFile,ftpDir);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(flag){
			module.setType(type);
			module.setBusinessModuleId(businessModuleId);
			module.setContent(ftpDir+"/"+ftpFile);
			asBusinessModuleMapper.updateByPrimaryKeySelective(module);
			return ftpDir+"/"+ftpFile;
		}
		
		return "";
	}
	

	public AsBusinessModule saveAd(AsBusinessModule module) {
		asBusinessModuleMapper.updateByPrimaryKeySelective(module);
		return module;
		
	}

	public AsBusinessModule findModuleByBusinessModuleId(int businessModuleId) {
		return asBusinessModuleMapper.selectByPrimaryKey(businessModuleId);
	}

	public List<AsBusinessTemplate> getBusinessTemplateByLevel(int level) {
		return asBusinessTemplateMapper.getBusinessTemplateByLevel(level);
	}
	
	/**
	 * 
	 * @param moduleStr [{"businessModuleId":"19","rootBusinessTemplateId":1,"businessTemplateId":"16"},
	 * {"businessModuleId":"20","rootBusinessTemplateId":rootBusinessTemplateId,"businessTemplateId":"16"}]
	 * @param userId
	 * @return
	 */
	public boolean saveMyBusinessTemplate(String moduleStr,String userId) {
		JSONArray jsonArray = JSONArray.fromObject(moduleStr);
		for(int i=0;i<jsonArray.size();i++){
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			int businessModuleId = jsonObject.getInt("businessModuleId");
			int businessTemplateId = jsonObject.getInt("businessTemplateId");
			int rootBusinessTemplateId = jsonObject.getInt("rootBusinessTemplateId");
			
			AsBusinessTemplate template = asBusinessTemplateMapper.selectByPrimaryKey(businessTemplateId);//系统默认的模版
			//系统默认模版的子模版
			List<AsBusinessTemplate> templates = asBusinessTemplateMapper.selectByParentBusinessTemplateId(template.getBusinessTemplateId());
			
			//删除掉现有的模版，重新生成心的模版
			AsBusinessTemplate oldTemplate = asBusinessTemplateMapper.findByParentModuleId(businessModuleId);
			if(oldTemplate != null){
				List<AsBusinessModule> oldModules = asBusinessModuleMapper.selectByBusinessTemplateId(oldTemplate.getBusinessTemplateId());
				asBusinessTemplateMapper.deleteByPrimaryKey(oldTemplate.getBusinessTemplateId());
				
				//删除旧模版下的所有模块
				List<Integer> ids = new ArrayList<>();
				for(int j=0;j<oldModules.size();j++){
					ids.add(oldModules.get(j).getBusinessModuleId());
				}
				asBusinessModuleMapper.deleteByIds(ids);
			}
			
			
			Map<String,Object> param = new HashMap<>();
			param.put("businessTemplateId", businessTemplateId);
			param.put("sort", "asc");
			List<AsBusinessModule> modules = this.getBusinessModule(param);//系统默认生成的模块
			
			
			AsBusinessModule businessModule = asBusinessModuleMapper.selectByPrimaryKey(businessModuleId);
			
			template.setBusinessTemplateId(null);//需要重新生成新的id
			template.setParentBusinessTemplateId(businessModule.getBusinessTemplateId());
			template.setRootBusinessTemplateId(rootBusinessTemplateId);
			template.setParentBusinessModuleId(businessModuleId);
			//template.setUserId(userId);
			
			asBusinessTemplateMapper.insertSelective(template);
			for(int j=0;j<modules.size();j++){
				AsBusinessModule module = modules.get(j);
				module.setBusinessModuleId(null);//id要重新生成
				
				//module.setUserId(template.getUserId());
				module.setBusinessTemplateId(template.getBusinessTemplateId());
				module.setCreateTime(DateUtil.getTime());
				module.setStatus(0);
				asBusinessModuleMapper.insertSelective(module);
			}
			
			if(templates.size() > 0){
				for(int k=0;k<templates.size();k++){
					AsBusinessTemplate child = templates.get(k);
					child.setParentBusinessTemplateId(template.getParentBusinessTemplateId());
					child.setCreateTime(DateUtil.getTime());
					child.setRootBusinessTemplateId(rootBusinessTemplateId);
					asBusinessTemplateMapper.insertSelective(child);
				}
			}
			
		}
		return true;
	}

	private List<AsBusinessModule> getBusinessModule(Map<String,Object> map) {
		return asBusinessModuleMapper.selectBusinessModuleByTemplateId(map);
	}

	public List<AsTemplateType> getTemplateTypes() {
		return asTemplateTypeMapper.selectAll();
	}
	
	public Map<String,Object> delBusinessTemplate(int businessTemplateId) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		AsBusinessTemplate businessTemplate = asBusinessTemplateMapper.selectByPrimaryKey(businessTemplateId);
		Assert.notNull(businessTemplate,"模版不存在");
		/*if(businessTemplate.getLevel().equals(1)){
			map.put("msg", "不能删除首页模版");
			return map;
		}*/
		if(businessTemplate.getIsSample() != null && businessTemplate.getIsSample()){
			map.put("msg", "不能删除样板模版");
			return map;
		}
		List<AsBusinessTemplate> businessTemplates = asBusinessTemplateMapper.selectByParentBusinessTemplateId(businessTemplateId);
		if(businessTemplates.size()>0){
			map.put("msg", "请先删除子模版");
		}else{
			int rs = asBusinessTemplateMapper.deleteByPrimaryKey(businessTemplateId);
			if(rs>0){
				asBusinessModuleMapper.deleteByBusinessTemplateId(businessTemplateId);
			}
			map.put("rootBusinessTemplateId", businessTemplate.getRootBusinessTemplateId());
		}
		return map;
	}
	
	/**
	 * 
	 * @param str[{"businessModuleId":1,"address":"一楼UM35","size":"30","shopType":"办公","rent":"3000"}]
	 * @return
	 */
	public int saveInvestment(String str) {
		JSONArray array = JSONArray.fromObject(str);
		for(int i=0;i<array.size();i++){
			JSONObject json = array.getJSONObject(i);
			int businessModuleId = json.getInt("businessModuleId");
			String address = json.getString("address");
			double size = json.getDouble("size");
			String shopType = json.getString("shopType");
			double rent = json.getDouble("rent");
			
			AsModuleInvestment investment = asModuleInvestmentMapper.findByBusinessModuleId(businessModuleId);
			if(investment == null){
				investment = new AsModuleInvestment();
				investment.setBusinessModuleId(businessModuleId);
				investment.setAddress(address);
				investment.setSize(size);
				investment.setShopType(shopType);
				investment.setRent(rent);
				asModuleInvestmentMapper.insertSelective(investment);
			}else{
				investment.setAddress(address);
				investment.setSize(size);
				investment.setShopType(shopType);
				investment.setRent(rent);
				asModuleInvestmentMapper.updateByPrimaryKeySelective(investment);
			}
			
		}
		return 1;
	}

	public AsBusinessModule selectBusinessModuleByParent(AsBusinessModule param) {
		return asBusinessModuleMapper.selectBusinessModuleByParent(param);
	}
	
	/**
	 * 
	 * @param businessModuleId
	 * @return
	 */
	public AsModuleShop findModuleShop(Integer businessModuleId) {
		return asModuleShopMapper.findByModuleId(businessModuleId);
	}
	
	/**
	 * 
	 * @param shop
	 * @param imgfile
	 * @param logofile
	 * @param imgUrl1
	 * @param imgUrl2
	 * @param orign1 图片来源  0代表默认  1代表图片库 2代表本地图片
	 * @param orign2 图片来源  0代表默认  1代表图片库 2代表本地图片
	 * @return
	 */
	public int saveShop(AsModuleShop shop,MultipartFile imgfile,MultipartFile logofile,
			String imgUrl1,String imgUrl2,int orign1,int orign2) {
		boolean flag1 = false;
		String fileName1 = imgfile.getOriginalFilename();
		String ftpFile1 = "";
		String ftpDir1 = Const.TEMPLATEPATHIMG;
		if(orign1 == 2){
			if(!StringUtils.isEmpty(fileName1)){
				
				ftpFile1 = UuidUtil.get32UUID() + fileName1.substring(fileName1.indexOf("."),fileName1.length());
				try {
					flag1 = ftpUpload(imgfile.getBytes(), ftpFile1,ftpDir1);
					if(flag1){
						shop.setShopImage(ftpDir1+"/"+ftpFile1);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}else if(orign1 == 1){
			
		}
		
		if(orign2 == 2){
			boolean flag2 = false;
			String fileName2 = logofile.getOriginalFilename();
			String ftpFile2 = "";
			String ftpDir2 = Const.TEMPLATEPATHIMG;
			if(!StringUtils.isEmpty(fileName2)){
				
				ftpFile2 = UuidUtil.get32UUID() + fileName2.substring(fileName2.indexOf("."),fileName2.length());
				try {
					flag2 = ftpUpload(logofile.getBytes(), ftpFile2,ftpDir2);
					if(flag2){
						shop.setShopLogo(ftpDir2+"/"+ftpFile2);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		
		
		if(shop.getModuleShopId() == null){
			AsModuleShop moduleShop = asModuleShopMapper.findByModuleId(shop.getBusinessModuleId());
			if(moduleShop == null){
				asModuleShopMapper.insertSelective(shop);
			}else{
				asModuleShopMapper.updateByPrimaryKeySelective(shop);
			}
			
		}else{
			asModuleShopMapper.updateByPrimaryKeySelective(shop);
		}
		return 1;
	}
	
	public String saveFixedImg(MultipartFile file, AsTemplateFixed asTemplateFixed) {
		boolean flag = false;
		String fileName = file.getOriginalFilename();
		String ftpFile = "";
		String ftpDir = Const.TEMPLATEPATHIMG;
		if(!StringUtils.isEmpty(fileName)){
			
			ftpFile = UuidUtil.get32UUID() + fileName.substring(fileName.indexOf("."),fileName.length());
			try {
				flag = ftpUpload(file.getBytes(), ftpFile,ftpDir);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(flag){
			asTemplateFixed.setBackgroundImage(ftpDir+"/"+ftpFile);
			asTemplateFixedMapper.updateByPrimaryKey(asTemplateFixed);
			return ftpDir+"/"+ftpFile;
		}
		asTemplateFixedMapper.updateByPrimaryKey(asTemplateFixed);
		return "";
	}

	public int addNextPage(int businessTemplateId,String userId) {
		AsBusinessTemplate template = asBusinessTemplateMapper.selectByPrimaryKey(businessTemplateId);
		
		Map<String,Object> param = new HashMap<>();
		param.put("businessTemplateId", businessTemplateId);
		param.put("sort", "desc");
		List<AsBusinessModule> modules = asBusinessModuleMapper.selectBusinessModuleByTemplateId(param);
		
		int maxPosition = modules.get(0).getPosition();
		for(int i=0;i<template.getModuleNumber();i++){
			AsBusinessModule module = new AsBusinessModule();
			module.setBusinessTemplateId(businessTemplateId);
			module.setPosition(maxPosition+i+1);
			module.setUserId(userId);
			module.setStatus(0);
			module.setCreateTime(DateUtil.getTime());
			asBusinessModuleMapper.insertSelective(module);
		}
		return 1;
	}
	
	public Map<String,Object> delModule(int businessTemplateId,int pageNum,int pageSize) {
		List<Integer> ids = new ArrayList<>();
		Map<String,Object> data = new HashMap<>();
		
		PageHelper.startPage(pageNum, pageSize);
		Map<String,Object> param = new HashMap<>();
		param.put("businessTemplateId", businessTemplateId);
		param.put("sort", "asc");
		List<AsBusinessModule> modules = asBusinessModuleMapper.selectBusinessModuleByTemplateId(param);
		
		long amount = asBusinessModuleMapper.countByTemplateId(businessTemplateId).get("amount");;
		
		if(amount<= pageSize){
			data.put("status", 0);
			data.put("msg", "已经是最后一页");
			
			return data ;
		}
		for(int i=0;i<modules.size();i++){
			AsBusinessModule module = modules.get(i);
			ids.add(module.getBusinessModuleId());
		}
		asBusinessModuleMapper.deleteByIds(ids);
		//重新更新模块的位置
		
		List<AsBusinessModule> businessModules = asBusinessModuleMapper.selectBusinessModuleByTemplateId(param);
		
		for(int i=0;i<businessModules.size();i++){
			AsBusinessModule module = businessModules.get(i);
			module.setPosition(i+1);
			asBusinessModuleMapper.updateByPrimaryKeySelective(module);
		}
		data.put("status", 1);
		return data;
	}
	
	
	public boolean delShopImg(int businessModuleId) {
		AsModuleShop asModuleShop = asModuleShopMapper.findByModuleId(businessModuleId);
		Assert.notNull(asModuleShop);
		boolean rs = fileRemove(asModuleShop.getShopImage());
		if(rs){
			AsModuleShop temp = new AsModuleShop();
			temp.setModuleShopId(asModuleShop.getModuleShopId());
			temp.setShopImage("");
			return asModuleShopMapper.updateByPrimaryKeySelective(temp)>0;
		}
		return false;
		
	}
	public boolean delShopLogo(int businessModuleId) {
		AsModuleShop asModuleShop = asModuleShopMapper.findByModuleId(businessModuleId);
		Assert.notNull(asModuleShop);
		boolean rs = fileRemove(asModuleShop.getShopLogo());
		if(rs){
			AsModuleShop temp = new AsModuleShop();
			temp.setModuleShopId(asModuleShop.getModuleShopId());
			temp.setShopLogo("");
			return asModuleShopMapper.updateByPrimaryKeySelective(temp)>0;
		}
		return false;
	}
	
	public Boolean delFixedImg(int templateFixedId) {
		AsTemplateFixed fixed = asTemplateFixedMapper.selectByPrimaryKey(templateFixedId);
		Assert.notNull(fixed);
		boolean rs = fileRemove(fixed.getBackgroundImage());
		if(rs){
			AsTemplateFixed templateFixed = new AsTemplateFixed();
			templateFixed.setTemplateFixedId(templateFixedId);
			templateFixed.setBackgroundImage("");
			return asTemplateFixedMapper.updateByPrimaryKey(templateFixed)>0;
		}
		return false;
	}
	
	public Boolean delBackgroundImg(int businessModuleId) {
		AsBusinessModule module = asBusinessModuleMapper.selectByPrimaryKey(businessModuleId);
		Assert.notNull(module);
		boolean rs = fileRemove(module.getBackgroundImage());
		if(rs){
			AsBusinessModule temp = new AsBusinessModule();
			temp.setBusinessModuleId(businessModuleId);
			temp.setBackgroundImage("");
			return asBusinessModuleMapper.updateByPrimaryKeySelective(temp)>0;
		}
		return false;
	}
	
	public List<AsBusinessTemplate> selectTemplateByAttr(AsBusinessTemplate template) {
		return asBusinessTemplateMapper.selectTemplateByAttr(template);
	}
	
	public int addSample(int businessTemplateId) {
		AsBusinessTemplate template = asBusinessTemplateMapper.selectByPrimaryKey(businessTemplateId);
		template.setBusinessTemplateId(null);
		template.setIsSample(false);
		template.setCreateTime(DateUtil.getTime());
		return this.addBusinessTemplate(template);
	}
	
	public int updateTemplate(AsBusinessTemplate template) {
		return asBusinessTemplateMapper.updateByPrimaryKeySelective(template);
	}
	
	public List<AsTemplateFixed> selectTemplateFixeds() {
		return asTemplateFixedMapper.selectAll();
	}
	
	public AsTemplateFixed findTemplateFixed(int templateFixedId) {
		return asTemplateFixedMapper.selectByPrimaryKey(templateFixedId);
	}
	
	
	
	/**
	 * @param t
	 *//*
	public void test(AsBusinessTemplate t){
		Table table = t.getClass().getAnnotation(Table.class);
		Package p = t.getClass().getPackage();
		System.out.println(p.getName());
		
		if(table != null){
			System.out.println(table.value().toString());
		}
		Field filds[] = t.getClass().getDeclaredFields();
		for(Field f:filds){
			Id id = f.getAnnotation(Id.class);
			if(id != null){
				System.out.println(id.value());
			}
			
		}
	}
	*/
	
	public static void main(String[] args) {
		//Jedis jedis = new Jedis("192.168.1.127",6379);
		//jedis.set("data", "data");
		
		
		
		/*Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
		//Jedis Cluster will attempt to discover cluster nodes automatically
		jedisClusterNodes.add(new HostAndPort("192.168.1.127", 6379));
		jedisClusterNodes.add(new HostAndPort("192.168.1.127", 6378));

		JedisCluster jc = new JedisCluster(jedisClusterNodes);
		jc.set("foo", "bar");
		System.out.println("data Cluster == > " + jc.get("foo"));*/
		/*try {
			jc.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		/*String htmlStr = "<body><div><a href=''>我是链接</a><a href=''>我是链接1</a></div></body>";
		Document document = Jsoup.parse(htmlStr);
		Elements elements = document.select("a");
		for(Element e:elements){
			System.out.println(e.text());
		}*/
		
	}

	public int deleteDomain(int businessTemplateId,String userId) {
		AsBusinessTemplate template = asBusinessTemplateMapper.selectByPrimaryKey(businessTemplateId);//系统默认的模版
		//模版的子模版
		List<AsBusinessTemplate> templates = asBusinessTemplateMapper.selectByParentBusinessTemplateId(template.getBusinessTemplateId());
		
		List<AsBusinessModule> modules = asBusinessModuleMapper.selectByBusinessTemplateId(template.getBusinessTemplateId());
		/*//删除掉现有的模版，重新生成心的模版
		AsBusinessTemplate oldTemplate = asBusinessTemplateMapper.findByParentModuleId(businessModuleId);
		if(oldTemplate != null){
			List<AsBusinessModule> oldModules = asBusinessModuleMapper.selectByBusinessTemplateId(oldTemplate.getBusinessTemplateId());
			asBusinessTemplateMapper.deleteByPrimaryKey(oldTemplate.getBusinessTemplateId());
			
			//删除旧模版下的所有模块
			List<Integer> ids = new ArrayList<>();
			for(int j=0;j<oldModules.size();j++){
				ids.add(oldModules.get(j).getBusinessModuleId());
			}
			asBusinessModuleMapper.deleteByIds(ids);
		}*/
		return 0;
	}

	
}
