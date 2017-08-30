package com.aoshi.controller.manage.integration.order;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsCart;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.integration.order.CartService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 类名称：CartController 创建人：star 创建时间：2016-07-11
 */
@Controller
@RequestMapping(value = "/cart")
public class CartController extends BaseController {

	String menuUrl = "cart/list.do"; // 菜单地址(权限用)

	@Autowired
	private CartService cartService;

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) {
		logBefore(logger, "删除asCart");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		}
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			cartService.delete(pd.getInt("cartId"));
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 购物车列表页面
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) {
		logBefore(logger, "列表asCart");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("business/order/cartList");
		PageData pd = this.getPageData();
		try {
			page.setPd(pd);
			PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
			List<AsCart> cartList = cartService.list(pd);
			PageInfo<AsCart> pageInfo = new PageInfo<AsCart>(cartList);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("cartList", cartList);
			List<AsCart> cartUserList = cartService.listUser(new PageData());
			List<AsCart> cartGoodsList = cartService.listGoods(new PageData());
			List<AsCart> cartShopList = cartService.listShop(new PageData());
			mv.addObject("cartUserList", cartUserList);
			mv.addObject("cartGoodsList", cartGoodsList);
			mv.addObject("cartShopList", cartShopList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 批量删除购物车
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除asCart");
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
				String ids = pd.getString("ids");
				if (StringUtils.isNotBlank(ids)) {
					String cityIds[] = ids.split(",");
					cartService.deleteAll(cityIds);
					map.put("msg", "ok");
				} else {
					map.put("msg", "no");
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}

	/* ===============================权限================================== */

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
