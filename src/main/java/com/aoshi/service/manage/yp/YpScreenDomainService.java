package com.aoshi.service.manage.yp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Conditions;

@Service
public class YpScreenDomainService extends AsBaseService {

	private final static String PAGE_PATH = "manage/yp/ypScreenDomain/";
	
	@Autowired
	private AsYpScreenDomainMapper  ypScreenDomainMapper;
	
	@Autowired
	private AsShopMapper  asShopMapper;
	
	/**
	 * 查询站点列表
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		List<Object> domain= pageQueryModule(ypScreenDomainMapper, "queryDomainAll",
				true);
		addViewData("pd", pd);
		return renderView(PAGE_PATH + "auditlistAll");
	}

	/**
	 * 编辑审核
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object operaSumbmit(BaseController c) {
		initialized(c);
		operaFlag = ypScreenDomainMapper.updateStatus(pd)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "操作成功!");
		return renderSuccess();
	}
	
	/**
	 * 云屏站点审核页面
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object screenlistAll(BaseController c) {
		initialized(c);
		pageQueryModule(ypScreenDomainMapper, "listAllInfo",
				true);
		List<Conditions> shops = asShopMapper.getShopALL(null);// 站点
		addViewData("pd", pd);
		addViewData("shops", shops);
		return renderView(PAGE_PATH + "listAll");
	}
	

	/**
	 * 云屏子站点列表页面
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object screenChildDomainList(BaseController c) {
		initialized(c);
		pageQueryModule(ypScreenDomainMapper, "childDomainList",
				true);
		addViewData("pd", pd);
		return renderView(PAGE_PATH + "shopListAll");
    }
	
	/**
	 * 云屏子站点列表页面
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object screenList(BaseController c) {
		initialized(c);
		pageQueryModule(ypScreenDomainMapper, "getScreenPageById",
				true);
		return renderView(PAGE_PATH + "shopScreenAll");
    }
	
	/**
	 * 停用站点服务
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object updataDomain(BaseController c) {

		initialized(c);
		operaFlag = ypScreenDomainMapper.updateStatus(pd)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "操作成功!");
		return renderSuccess();
	}

	/**
	 * 查询店铺站点列表
	 * 
	 * @author yangyanchao
	 * @date 2016年11月1日
	 * @param c
	 * @return
	 */
	public Object getDomainByShopId(BaseController c) {

		initialized(c);

		return queryModule(ypScreenDomainMapper, "listAllBShopId", false);
	}
	
	/**
	 * 停用启用主站点服务
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object updataDomainStatus(BaseController c) {

		initialized(c);
		operaFlag = ypScreenDomainMapper.updateDomainStatus(pd)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "操作成功!");
		return renderSuccess();
	}
}
