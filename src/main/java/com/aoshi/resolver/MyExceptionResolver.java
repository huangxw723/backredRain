package com.aoshi.resolver;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.entity.R;
import com.aoshi.util.ASApiException;

/**
 * 自定义系统异常处理
 * 
 * @author yangyanchao
 * @date 2016年7月18日
 */
public class MyExceptionResolver implements HandlerExceptionResolver {

	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {

		ModelAndView mv = new ModelAndView("error");
		if (ex instanceof ASApiException) {

			ASApiException iException = (ASApiException) ex;
			R r = new R(iException.getStatus(), iException.getMessage());
			if (iException.getErrType() == 0) { // 以JSON结构返回信息

				response.setContentType("application/json;charset=utf-8");
				PrintWriter out = null;
				try {
					out = response.getWriter();
					out.print(JSONObject.fromObject(r));
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					if (out != null) {
						out.close();
					}
				}

				mv = null;
			} else { // 以页面形式返回信息

				mv.addObject("result", JSONObject.fromObject(r));
				mv.setViewName("opera_result");
			}
		} else { // 以系统默认形式返回信息
			mv.addObject("exception", ex.toString().replaceAll("\n", "<br/>"));
		}

		ex.printStackTrace();
		return mv;
	}
}
