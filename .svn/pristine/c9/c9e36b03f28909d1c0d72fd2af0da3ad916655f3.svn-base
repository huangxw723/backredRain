package com.aoshi.service.business.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsYpScreenDomainMapper;
import com.aoshi.dao.AsYpScreenInfoMapper;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;

@Service
public class BusinessScreenDomainService extends AsBaseService {

	private final static String PAGE_PATH = "business/yp/screenDomain/";

	@Autowired
	private AsYpScreenInfoMapper ypScreenInfoMapper;
	
	@Autowired
	private AsYpScreenDomainMapper  ypScreenDomainMapper;
	
	
	/**
	 * 查询云屏终端列表
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return	
	 */
	public Object listScreenPage(BaseController c) {

		initialized(c);
		pageQueryModule(ypScreenInfoMapper, "listScreenAll",
				true);
		return renderView(PAGE_PATH + "listScreenAll");
	}

	/**
	 * 查询云屏站点列表
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		addField("shopId", getUser().getAs_shop_id());
		pageQueryModule(ypScreenDomainMapper, "queryDomainAll",
				true);
		return renderView(PAGE_PATH + "listAll");
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
		ValidatorBreakException.NOT_TRUE(operaFlag,"操作成功!");
		return renderSuccess();
	}
}
