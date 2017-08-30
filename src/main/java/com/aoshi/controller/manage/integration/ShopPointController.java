package com.aoshi.controller.manage.integration;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.integration.ShopPointService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/point")
public class ShopPointController extends BaseController {
	@Autowired
	private ShopPointService shopPointService;

	/**
	 * 获取积分配置信息
	 * 
	 * @author wangjs
	 * @date 2016年11月23日
	 * @return
	 */
	@RequestMapping(value = "/setpoint")
	public Object findAllAsDict() {

		return shopPointService.getSetPoint(this);
	}

	/**
	 * 修改积分配置
	 * 
	 * @author wangjs
	 * @date 2016年11月23日
	 * @return
	 */
	@RequestMapping(value = "/updatepoint")
	public Object updatepoint(String pointId, String pointValue){
			/*,String[] imgOldIds, String[] imgOldAdUrls,
			String[] imgNewAdurls, String imgNewOldAdUrls, String imgNewOldImgIds,
			@RequestParam(value = "oldNewFiles", required = true) MultipartFile[] oldNewFiles,
			@RequestParam(value = "files", required = true) MultipartFile[] files) {*/
		//shopPointService.updatePointTx(pointId, pointValue, files, imgOldIds, imgOldAdUrls, imgNewAdurls,imgNewOldImgIds,imgNewOldAdUrls,oldNewFiles);
		shopPointService.updatePointTx(pointId, pointValue);

		return shopPointService.getSetPoint(this);
	}

	/**
	 * 获取积分兑换比值
	 *
	 * @author tgb
	 * @date 2017年4月23日
	 * @return
	 */
	@RequestMapping(value = "getMoneyExchange")
	@ResponseBody
	public Integer getMoneyExchange() {
		return shopPointService.getMoneyExchange();
	}

}
