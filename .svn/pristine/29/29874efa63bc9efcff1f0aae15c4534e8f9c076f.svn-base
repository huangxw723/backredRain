package com.aoshi.controller.manage.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.yp.YpScreenDomainService;

/**
 * 终端管理 Controller
 * 
 * @author huangxw
 * @date 2016年10月27日
 * @return
 */
@Controller
@RequestMapping("/yp/admin/ypScreenDomain")
public class YpScreenDomainController extends BaseController {
	
	@Autowired
	private YpScreenDomainService ypScreenDomainService;

	
	/**
	 * 内容站点审核页面
	 * 
	 * @author huangxwe
	 * @date 2016年10月27日
	 * @return
	 */
	@RequestMapping("/listAll")
	public Object listAll() {
		return ypScreenDomainService.listAll(this);
	}


	/**
	 * 编辑审核
	 * 
	 * @author huangxw
	 * @date 2016年10月27日
	 * @return
	 */
	@RequestMapping("/operaSumbmit")
	@ResponseBody
	public Object operaSumbmit() {
		return ypScreenDomainService.operaSumbmit(this);
	}
	
	
	
	/**
	 * 云屏站点页面
	 * 
	 * @author huangxwe
	 * @date 2016年10月27日
	 * @return
	 */
	@RequestMapping("/listScreenPage")
	public Object listScreenPage() {
		return ypScreenDomainService.screenlistAll(this);
	}
	
	/**
	 * 云屏子站点列表页面
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	@RequestMapping("/listShopAll")
	public Object listShopAll() {
		return ypScreenDomainService.screenChildDomainList(this);
	}
	
	/**
	 * 根据子站点id查询终端列表
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @param c
	 * @return
	 */
	@RequestMapping("/screenList")
	public Object screenList() {
		return ypScreenDomainService.screenList(this);
	}
	
	
	/**
	 * 停用或启用站点
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/updataDomain")
	@ResponseBody
	public Object updataDomain() {
		return ypScreenDomainService.updataDomain(this);
	}
	
	/**
	 * 查询店铺站点
	 * 
	 * @author yangyanchao
	 * @date 2016年11月1日
	 * @return
	 */
	@RequestMapping("/getDomainByShopId")
	@ResponseBody
	public Object getDomainByShopId() {
		return ypScreenDomainService.getDomainByShopId(this);
	}
	
	
	/**
	 * 停用或启用主站点
	 * 
	 * @author huangxw
	 * @date 2016年10月25日
	 * @return
	 */
	@RequestMapping("/updateDomainStatus")
	@ResponseBody
	public Object updateDomainStatus() {
		return ypScreenDomainService.updataDomainStatus(this);
	}
}
