package com.aoshi.controller.base;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.common.asenum.UserTypeEnum;
import com.aoshi.dao.AsBaseMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.entity.Page;
import com.aoshi.entity.R;
import com.aoshi.entity.system.User;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.util.Conditions;
import com.aoshi.util.Const;
import com.aoshi.util.PageData;
import com.aoshi.util.UuidUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class BaseController {
	@Autowired
	private AsUserMapper asUserMapper;
	protected Logger logger = Logger.getLogger(this.getClass());

	// 入参数据对象
	public PageData pd;
	// 视图处理对象
	public ModelAndView mv;
	public HttpServletRequest req;

	private Page page;

	private PageInfo<Object> pageInfo;

	/**
	 * 初始化业务变量
	 * 
	 * @author yangyanchao
	 * @date 2016年6月24日
	 */
	public void initialized() {
		req = getRequest();
		pd = getPageData();
		mv = getModelAndView();
		mv.addObject("pd", pd);
		mv.addObject(Const.SESSION_QX, getUQX()); // 按钮权限
	}

	/**
	 * 基础通用查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月27日
	 * @param dao
	 *            模块DAO
	 */
	protected void pageQueryModule(AsBaseMapper dao) {
		this.pageQueryModule(dao, "select_all", true);
	}

	/**
	 * 分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年7月22日
	 * @param dao
	 * @param methodName
	 * @param isBindPageInfo
	 *            是否绑定到ModelAndView
	 * @return
	 */
	public List<Object> pageQueryModule(AsBaseMapper dao, String methodName, boolean isBindPageInfo) {

		return pageQueryModule(dao, methodName, isBindPageInfo, pd);
	}

	public List<Object> pageQueryModule(AsBaseMapper dao, String methodName, boolean isBindPageInfo, Map<Object, Object> conditions) {

		page = new Page();

		int currentPage = pd.getIntRequired("pageNum");
		if (currentPage == 0) {
			currentPage = pd.getIntRequired("currentPage");
		}
		if (currentPage == 0) {
			currentPage = 1;
		}

		int showCount = pd.getIntRequired("pageSize");
		if (showCount == 0) {
			showCount = pd.getIntRequired("showCount");
		}
		if (showCount == 0) {
			showCount = 10;
		}
		//		showCount = 3000;

		page.setCurrentPage(currentPage);
		page.setShowCount(showCount);
		page.setPd(pd);

		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());

		List<Object> list = new ArrayList<Object>();
		try {
			Method method = dao.getClass().getDeclaredMethod(methodName, new Object().getClass());
			list = (List<Object>) method.invoke(dao, conditions);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (isBindPageInfo) {
			pageInfo = new PageInfo<Object>(list);
			page.setEntityOrField(true);
			page.setTotalResult((int) pageInfo.getTotal());
			mv.addObject("pageInfo", pageInfo);
			mv.addObject("list", list);
			mv.addObject("page", page);
		}

		mv.addObject("currentPage", currentPage);
		mv.addObject("showCount", showCount);

		return list;
	}

	/**
	 * 重置分页信息
	 * 
	 * @author yangyanchao
	 * @date 2016年10月24日
	 * @param list
	 */
	public void resetPageInfo(List<Object> list, int counts) {
		pageInfo = new PageInfo<Object>(list);
		pageInfo.setTotal(counts);
		page.setEntityOrField(true);
		page.setTotalResult(counts);
		mv.addObject("pageInfo", pageInfo);
		mv.addObject("page", page);
	}

	/**
	 * 非分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月28日
	 * @param dao
	 *            模块DAO
	 */
	protected List<Object> queryModule(AsBaseMapper dao) {
		return this.queryModule(dao, "select_all", true);
	}

	/**
	 * 通用非分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月29日
	 * @param dao
	 * @param methodName
	 *            方法名
	 * @param isBindPageInfo
	 *            是否把信息绑定到ModelAndView
	 */
	public List<Object> queryModule(AsBaseMapper dao, String methodName, boolean isBindPageInfo) {

		return queryModule(dao, methodName, isBindPageInfo, pd);
	}

	/**
	 * 通用非分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月29日
	 * @param dao
	 * @param methodName
	 *            方法名
	 * @param isBindPageInfo
	 *            是否把信息绑定到ModelAndView
	 * @param conditions
	 *            自定义Where条件
	 */
	public List<Object> queryModule(AsBaseMapper dao, String methodName, boolean isBindPageInfo, Map<Object, Object> conditions) {

		List<Object> list = new ArrayList<Object>();
		try {
			Method method = dao.getClass().getDeclaredMethod(methodName, new Object().getClass());
			list = (List<Object>) method.invoke(dao, conditions);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (isBindPageInfo) {
			mv.addObject("list", list);
		}

		return list;
	}

	/**
	 * 得到PageData
	 */
	public PageData getPageData() {
		return new PageData(this.getRequest());
	}

	/**
	 * 得到ModelAndView
	 */
	public ModelAndView getModelAndView() {
		return new ModelAndView();
	}

	/**
	 * 得到request对象
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		return request;
	}

	/**
	 * 得到32位的uuid
	 * 
	 * @return
	 */
	public String get32UUID() {

		return UuidUtil.get32UUID();
	}

	/**
	 * 得到分页列表的信息
	 */
	public Page getPage() {

		return new Page();
	}

	public static void logBefore(Logger logger, String interfaceName) {
		logger.info("");
		logger.info("start");
		logger.info(interfaceName);
	}

	public static void logAfter(Logger logger) {
		logger.info("end");
		logger.info("");
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

	private Map<String, String> getUQX() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cha", "1");
		map.put("edit", "1");
		map.put("add", "1");
		map.put("del", "1");
		map.put("adds", "1");
		map.put("dels", "1");
		map.put("edits", "1");
		map.put("chas", "1");
		return map;
	}

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
	 * 给PageData容器添加元素
	 * 
	 * @author yangyanchao
	 * @date 2016年7月14日
	 * @param k
	 * @param v
	 * @return
	 */
	public BaseController addField(String k, Object v) {
		pd.put(k, v);
		return this;
	}

	/**
	 * 获取PageData指定值
	 * 
	 * @author yangyanchao
	 * @date 2016年7月20日
	 * @param k
	 * @return
	 */
	public Object getField(String k) {
		return pd.get(k);
	}

	/**
	 * 删除PageData容器指定元素
	 * 
	 * @author yangyanchao
	 * @date 2016年7月14日
	 * @param k
	 * @return
	 */
	public BaseController removeField(String k) {
		pd.remove(k);
		return this;
	}

	/**
	 * 默认接口执行成功返回消息
	 * 
	 * @author yangyanchao
	 * @date 2016年7月21日
	 * @return
	 */
	public Object renderSuccess() {
		return renderSuccess(0);
	}

	/**
	 * 默认接口执行成功返回消息,自定义消息
	 * 
	 * @author yangyanchao
	 * @date 2016年7月21日
	 * @param iR
	 * @return
	 */
	public Object renderSuccess(R iR) {
		return renderSuccess(0, iR);
	}

	/**
	 * 
	 * @author yangyanchao
	 * @date 2016年7月21日
	 * @param msgType
	 *            0.JSON 1.H5
	 * @return
	 */
	public Object renderSuccess(int msgType) {

		if (msgType == 0) {
			return JSONObject.fromObject(new R(0, "操作成功"));
		} else if (msgType == 1) {
			mv.setViewName("opera_result");
			mv.addObject("result", JSONObject.fromObject(new R()));
			return mv;
		} else {
			logger.error(String.format("默认成功消息返回类型错误 msgType # [%s]", msgType));
			ValidatorBreakException.NOT_TRUE(false);
			return null;
		}
	}

	/**
	 * 默认接口执行成功返回消息,自定义消息
	 * 
	 * @author yangyanchao
	 * @date 2016年7月21日
	 * @param msgType
	 * @param iR
	 * @return
	 */
	public Object renderSuccess(int msgType, R iR) {
		if (msgType == 0) {
			return JSONObject.fromObject(iR);
		} else if (msgType == 1) {
			mv.setViewName("opera_result");
			mv.addObject("result", JSONObject.fromObject(iR));
			return mv;
		} else if (msgType == 3) {
			return JSONObject.fromObject(iR);
		}else {
			logger.error(String.format("默认成功消息返回类型错误 msgType # [%s]", msgType));
			ValidatorBreakException.NOT_TRUE(false);
			return null;
		}
	}

	/**
	 * 绑定视图数据
	 * 
	 * @author yangyanchao
	 * @date 2016年7月22日
	 * @param key
	 *            键
	 * @param value
	 *            值
	 * @return
	 */
	public BaseController addViewData(String key, Object value) {
		mv.addObject(key, value);
		return this;
	}

	/**
	 * 返回视图
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @param viewName
	 * @return
	 */
	public Object renderView(String viewName) {
		mv.setViewName(viewName);
		return mv;
	}

	/**
	 * 判断是否是最高管理员
	 * 
	 * @author luhuajiang
	 * @return
	 */
	public boolean isAdmin() {
		User userInfo = getCurrentUser();
		// 判断该帐号是否管理员
		Conditions user = (Conditions) asUserMapper.findByUserId(Integer.parseInt(userInfo.getNewUserId()));
		ValidatorBreakException.NOT_NULL(user);
		UserTypeEnum uType = UserTypeEnum.GET(user.getInt("type"));
		if (UserTypeEnum.ADMIN == uType && user.getStr("account").equals("admin")) {

			return true;
		}
		return false;
	}

	/**
	 * 判断是否是管理员
	 * 
	 * @author luhuajiang
	 * @return
	 */
	public boolean isRoomAdmin() {
		User userInfo = getCurrentUser();
		// 判断该帐号是否管理员
		Conditions user = (Conditions) asUserMapper.findByUserId(Integer.parseInt(userInfo.getNewUserId()));
		ValidatorBreakException.NOT_NULL(user);
		UserTypeEnum uType = UserTypeEnum.GET(user.getInt("type"));
		if (UserTypeEnum.ADMIN == uType || UserTypeEnum.OPERATIONMANAGER == uType) {
			return true;
		}
		return false;
	}
}
