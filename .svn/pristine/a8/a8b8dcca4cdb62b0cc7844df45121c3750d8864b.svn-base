package com.aoshi.controller.system;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsUser;
import com.aoshi.entity.system.Menu;
import com.aoshi.entity.system.User;
import com.aoshi.service.system.MenuService;
import com.aoshi.service.system.RoleService;
import com.aoshi.service.system.UserService;
import com.aoshi.util.Const;
import com.aoshi.util.PageData;
import com.aoshi.util.Tools;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 * 总入口
 */
@Controller
public class LoginController extends BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private AsUserMapper asUserMapper;

	@Autowired
	private AsShopMapper asShopMapper;

	/**
	 * 获取登录用户的IP
	 * 
	 * @throws Exception
	 */
	public void getRemortIP(String USERNAME) throws Exception {
		PageData pd = new PageData();
		HttpServletRequest request = this.getRequest();
		String ip = "";
		if (request.getHeader("x-forwarded-for") == null) {
			ip = request.getRemoteAddr();
		} else {
			ip = request.getHeader("x-forwarded-for");
		}
		pd.put("USERNAME", USERNAME);
		pd.put("IP", ip);
		userService.saveIP(pd);
	}

	/**
	 * 访问登录页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/login_toLogin")
	public ModelAndView toLogin() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("system/admin/login");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 访问管理员登录页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/login_managerlogin")
	public ModelAndView toManagerLogin() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MANAGERNAME", Tools.readTxtFile(Const.MANAGERNAME)); // 读取系统名称
		mv.setViewName("system/admin/managerlogin");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 登录
	 * 
	 * @author yangyanchao
	 * @date 2016年10月19日
	 * @return
	 */
	@RequestMapping(value = "/login_login", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Object login() {
		return userService.login(this);
	}

	/**
	 * 后台首页
	 * 
	 * @author yangyanchao
	 * @date 2016年10月19日
	 * @return
	 */
	@RequestMapping(value = "/main/{changeMenu}")
	public Object homePage(@PathVariable("changeMenu") String changeMenu) {
		return userService.homePage(this, changeMenu);
	}

	/**
	 * 进入tab标签
	 * 
	 * @return
	 */
	@RequestMapping(value = "/tab")
	public String tab() {
		return "system/admin/tab";
	}

	/**
	 * 进入首页后的默认页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login_default")
	public ModelAndView defaultPage() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd.put("menu_type", "2");
		List<Menu> menuList = menuService.listMenuByType(pd);
		mv.addObject("isRoomAdmin",isRoomAdmin());
		if (isRoomAdmin()) {
			for (Menu menu : menuList) {
				if (StringUtils.equals(menu.getMENU_NAME(), "大转盘")) {
					mv.addObject("a", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "摇一摇")) {
					mv.addObject("b", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "积分商城")) {
					mv.addObject("c", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "资讯管理")) {
					mv.addObject("d", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "优惠券")) {
					mv.addObject("e", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "平台活动")) {
					mv.addObject("f", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "会员管理")) {
					mv.addObject("g", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "链接管理")) {
					mv.addObject("h", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "系统管理")) {
					mv.addObject("i", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "导航管理")) {
					mv.addObject("j", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "基础管理")) {
					mv.addObject("k", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "资料审核")) {
					mv.addObject("l", menu);
				}
			}
		}else {
			for (Menu menu : menuList) {
				// 判断该商户类型 1:商场 2:商户
				User userInfo = getCurrentUser();
				AsShop asShop =  asShopMapper.shopIdByuserId(Integer.parseInt(userInfo.getNewUserId()));
				if(null != asShop){
					if(asShop.getType().equals(1)){
						if (StringUtils.equals(menu.getMENU_NAME(), "商户管理-业主")) {
							mv.addObject("a", menu);
							mv.addObject("shake",false);
						}
					}
					if(asShop.getType().equals(2)){
						if (StringUtils.equals(menu.getMENU_NAME(), "商户管理-店长")) {
							mv.addObject("a", menu);
							mv.addObject("shake",false);
						}
					}
				}
				AsUser asUser = asUserMapper.getUserByUserId(Integer.parseInt(userInfo.getNewUserId()));
				if (null != asUser){
					if ("ascmMallManager".equals(asUser.getAccount())){
						if (StringUtils.equals(menu.getMENU_NAME(), "摇一摇")) {
							mv.addObject("a", menu);
							mv.addObject("shake",true);
						}
					}
				}

				if (StringUtils.equals(menu.getMENU_NAME(), "大转盘")) {
					mv.addObject("b", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "优惠券")) {
					mv.addObject("c", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "员工管理")) {
					mv.addObject("d", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "链接管理")) {
					mv.addObject("e", menu);
				}
				if (StringUtils.equals(menu.getMENU_NAME(), "商户活动")) {
					mv.addObject("f", menu);
				}

			}

		}
		mv.setViewName("system/admin/backstage");
		return mv;
	}

	/**
	 * 用户注销
	 * @return
	 */
	@RequestMapping(value = "/logout")
	public ModelAndView logout() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();

		// shiro管理的session
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();

		session.removeAttribute(Const.SESSION_USER);
		session.removeAttribute(Const.SESSION_ROLE_RIGHTS);
		session.removeAttribute(Const.SESSION_allmenuList);
		session.removeAttribute(Const.SESSION_menuList);
		session.removeAttribute(Const.SESSION_QX);
		session.removeAttribute(Const.SESSION_userpds);
		session.removeAttribute(Const.SESSION_USERNAME);
		session.removeAttribute(Const.SESSION_USERROL);
		session.removeAttribute("changeMenu");

		// shiro销毁登录
		Subject subject = SecurityUtils.getSubject();
		subject.logout();

		pd = this.getPageData();
		String msg = pd.getString("msg");
		pd.put("msg", msg);

		pd.put("SYSNAME", Tools.readTxtFile(Const.SYSNAME)); // 读取系统名称
		mv.setViewName("system/admin/login");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 获取用户权限
	 */
	public Map<String, String> getUQX(Session session) {
		PageData pd = new PageData();
		Map<String, String> map = new HashMap<String, String>();
		try {
			String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();
			pd.put(Const.SESSION_USERNAME, USERNAME);
			String ROLE_ID = userService.findByUId(pd).get("ROLE_ID").toString();

			pd.put("ROLE_ID", ROLE_ID);

			PageData pd2 = new PageData();
			pd2.put(Const.SESSION_USERNAME, USERNAME);
			pd2.put("ROLE_ID", ROLE_ID);

			pd = roleService.findObjectById(pd);

			pd2 = roleService.findGLbyrid(pd2);
			if (null != pd2) {
				map.put("FX_QX", pd2.get("FX_QX").toString());
				map.put("FW_QX", pd2.get("FW_QX").toString());
				map.put("QX1", pd2.get("QX1").toString());
				map.put("QX2", pd2.get("QX2").toString());
				map.put("QX3", pd2.get("QX3").toString());
				map.put("QX4", pd2.get("QX4").toString());
			}

			map.put("adds", pd.getString("ADD_QX"));
			map.put("dels", pd.getString("DEL_QX"));
			map.put("edits", pd.getString("EDIT_QX"));
			map.put("chas", pd.getString("CHA_QX"));

			// System.out.println(map);

			this.getRemortIP(USERNAME);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return map;
	}

}
