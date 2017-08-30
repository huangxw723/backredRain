package com.aoshi.controller.manage;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.VipCouponService;

@Controller
@RequestMapping("/vipCoupon")
public class VipCouponController extends BaseController {
	
	@Autowired private VipCouponService couponSerice;
	
	/**
	 * 获取所有会员优惠券列表
	 * @return
	 */
	@RequestMapping("/couponListAll")
	public Object getCoupoList(){
		return couponSerice.getCouponList(this);
	}
	
	/**
	 * 删除操作
	 * @param prizeId
	 * @return
	 */
	@RequestMapping("/del")
	@ResponseBody
	public Object delCoupon(Integer prizeId){
		Map<String, Object> map =new HashMap<String, Object>();
		int result =couponSerice.updateCoupon(prizeId);
		if(result >0){
			map.put("status", 0);
			map.put("msg", "操作成功！");
		}else {
			map.put("status", 1);
			map.put("msg", "操作失败！");
		}
		return map;
	} 

}
