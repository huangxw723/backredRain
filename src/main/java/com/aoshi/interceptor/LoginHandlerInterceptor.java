package com.aoshi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.aoshi.common.asannotation.Log;
import com.aoshi.dao.AsYpLogsMapper;
import com.aoshi.domain.AsYpLogs;
import com.aoshi.entity.system.User;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.IpUtil;
import com.aoshi.util.Jurisdiction;

/**
 * 全局拦截器
 * 
 * @author yangyanchao
 * @date 2016年8月5日
 */
public class LoginHandlerInterceptor extends HandlerInterceptorAdapter {
	static  Logger logger =    LoggerFactory.getLogger(LoginHandlerInterceptor.class);
	@Autowired
	AsYpLogsMapper asYpLogsMapper;
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String path = request.getServletPath();
		if (path.matches(Const.NO_INTERCEPTOR_PATH)) {
			return true;
		} else {
			// shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();
			Session session = currentUser.getSession();
			User user = (User) session.getAttribute(Const.SESSION_USER);

			if (user != null) {
				path = path.substring(1, path.length());
				boolean b = Jurisdiction.hasJurisdiction(path);
				if (!b) {
					response.sendRedirect(request.getContextPath()
							+ Const.LOGIN);
				}
				return b;
			} else {
				// 登陆过滤
				response.sendRedirect(request.getContextPath() + Const.LOGIN);
				return false;
			}
		}
	}
	/*public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {		
		
		String url = request.getRequestURI();
		User user = null;
		if (request.getSession() != null && request.getSession().getAttribute(Const.SESSION_USER) != null) {
			 user = (User) request.getSession().getAttribute(Const.SESSION_USER);
			
		}

	    Log operLog = getLog(handler);
	    if (operLog != null) {
//			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
	    	
		if (request.getSession() != null
				&& request.getSession().getAttribute(Const.SESSION_USER) != null && user!=null) {
			AsYpLogs logs = new AsYpLogs(Integer.parseInt(user
					.getNewUserId()), operLog.recordModule(),
					operLog.recordDescp(), DateUtil.getTime(),
					IpUtil.getIpAddr(request), user.getNAME());
			asYpLogsMapper.insertSelective(logs);
		}
		logger.debug("modelName = " + operLog.recordModule()
				+ " , value = " + operLog.recordDescp());
		}
		logger.debug(url + "****************************************************************");
	}*/

	/*private Log  getLog(Object handler){	
		
		Log log = null;
		try{
			if(handler  instanceof HandlerMethod){			
				log =((HandlerMethod) handler).getMethod().getAnnotation(Log.class);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	    return log ;
	}*/


}
