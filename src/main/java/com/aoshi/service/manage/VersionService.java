package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsVersionMapper;
import com.aoshi.domain.AsVersion;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;

/**
 * 全局版本操作 Service
 * 
 * @author huangxw
 * @date 2016年9月2日
 */
@Service
public class VersionService extends AsBaseService {

	private final static String PAGE_PATH = "manage/asVersion/";

	@Autowired
	private AsVersionMapper asVersionMapperr;
	
	
     /**
	 * 版本查询
	 * 
	 * @author haungxw
	 * @date 2016年9月2日
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		List<?> resultMap = pageQueryModule(asVersionMapperr, "listAll", true);
		addViewData("asversion",pd.getString("platform"));
		addViewData("adList",resultMap);
		return renderView(PAGE_PATH + "adList");
	}
	/**
	 * 版本查询
	 * 
	 * @author haungxw
	 * @date 2016年9月2日
	 */
	public Object list(BaseController c) {

		initialized(c);
		OperaEnum action = OperaEnum.get(pd.getIntRequired("action"));
		switch (action) {

		case ADD:
			break;

		case EDIT:

			int versionId = pd.getIntRequired("versionId");
			addField("versionId", versionId);
			AsVersion asAd = asVersionMapperr.getVersionById(pd);
			addViewData("pd", asAd);
			break;

		case QUERY:
			versionId = pd.getIntRequired("versionId");
			addField("versionId", versionId);
		    asAd=  asVersionMapperr.getVersionById(pd);			
			ValidatorBreakException.NOT_NULL(asAd, 1001, "系统繁忙", 1);
			addViewData("pd", asAd);
			break;

		default:
			ValidatorBreakException.NOT_TRUE(false);
		}
		addViewData("action", action.getId());
		return renderView(PAGE_PATH + "save");

	}	

	/**
	 * 版本增删改操作
	 * 
	 * @author haungxw
	 * @date 2016年9月2日
	 * @return
	 */
	public Object opera(BaseController c) {

		initialized(c);

		OperaEnum action = OperaEnum.get(pd.getIntRequired("action"));
		switch (action) {
		case ADD:
    
			
			String versionCode = pd.getStringRequired("versionCode");
			int platform = pd.getInt("platform");
			int isShow = pd.getInt("isShow");
			String downloadUrl = pd.getStringRequired("downloadUrl");
			int isUpdate = pd.getInt("isUpdate");
			int appType = pd.getInt("appType");
			String remark = pd.getStringRequired("remark");
	
			// 添加版本
			AsVersion asversion = new AsVersion();
			asversion.setVersionCode(versionCode);
			asversion.setPlatform(platform);
			asversion.setIsShow(isShow);
			asversion.setDownloadUrl(downloadUrl);
			asversion.setIsUpdate(isUpdate);
			asversion.setAppType(appType);
			asversion.setRemark(remark);
		
			
			operaFlag = asVersionMapperr.insertSelective(asversion) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			break;
			
		case EDIT:
			 versionCode = pd.getStringRequired("versionCode");
			 platform = pd.getInt("platform");
			 isShow = pd.getInt("isShow");
			 downloadUrl = pd.getStringRequired("downloadUrl");
			 isUpdate = pd.getInt("isUpdate");
			 appType = pd.getInt("appType");
			 remark = pd.getStringRequired("remark");
			 int versionId = pd.getInt("versionId");
	
			// 添加版本
			AsVersion aversion = new AsVersion();
			aversion.setVersionId(versionId);
			aversion.setVersionCode(versionCode);
			aversion.setPlatform(platform);
			aversion.setIsShow(isShow);
			aversion.setDownloadUrl(downloadUrl);
			aversion.setIsUpdate(isUpdate);
			aversion.setAppType(appType);
			aversion.setRemark(remark);
			operaFlag = asVersionMapperr.updateByPrimaryKeySelective(aversion) == 1;

			break;
			
		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		addViewData("action", action.getId());
		addViewData("otype", pd.getIntRequired("action"));
		return renderSuccess();
		
	}
	public Object delete(BaseController versionController) {

		initialized(c);

		operaFlag = asVersionMapperr.deleteByPrimaryKey(pd) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
}
