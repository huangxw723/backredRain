package com.aoshi.interceptor;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.aoshi.common.asannotation.Log;
import com.aoshi.dao.AsYpLogsMapper;
import com.aoshi.domain.AsYpLogs;
import com.aoshi.entity.system.User;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.IpUtil;

@Component
@Aspect
public class LogAop {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	AsYpLogsMapper asYpLogsMapper;

	/**
	 * 记录操作日志
	 * 
	 * @author huangxw
	 * @date 2017年06月21日
	 * @throws Throwable
	 */
	@AfterReturning(value = "execution(* com.aoshi.controller..*(..)))", argNames = "object", returning = "object")
	public void doOperaLog(JoinPoint jp, Object object) {
		Log operLog = (operLog(jp));
	   // 设置用户操作信息
	   if (operLog != null) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();

		if (request.getSession() != null
				&& request.getSession().getAttribute(Const.SESSION_USER) != null) {
			User user = (User) request.getSession().getAttribute(
					Const.SESSION_USER);
			AsYpLogs log = new AsYpLogs(Integer.parseInt(user
					.getNewUserId()), operLog.recordModule(),
					operLog.recordDescp(), DateUtil.getTime(),
					IpUtil.getIpAddr(request), user.getNAME());
			asYpLogsMapper.insertSelective(log);
		}
		logger.debug("modelName = " + operLog.recordModule()
				+ " , value = " + operLog.recordDescp());
		}

	}

	private Log operLog(JoinPoint jp) {
		Signature signature = jp.getSignature();
		MethodSignature methodSignature = (MethodSignature) signature;
		Method logMethod = methodSignature.getMethod();
		Log log = logMethod.getAnnotation(Log.class);
		return log;
	}
}
