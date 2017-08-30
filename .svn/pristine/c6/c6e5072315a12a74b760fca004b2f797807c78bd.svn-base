package com.aoshi.resolver;

import com.aoshi.util.ASApiException;

/**
 * 校验器,满足则中断运行,并抛出系统异常
 * 
 * @author yangyanchao
 * @date 2016年7月21日
 */
public class ValidatorBreakException {

	public static final void NOT_NULL(Object object) {
		NOT_NULL(object, 1001, "系统繁忙", 0);
	}

	public static final void NOT_NULL(Object object, String errMsg) {
		NOT_NULL(object, 1001, errMsg, 0);
	}

	public static final void NOT_NULL(Object object, int status, String errMsg) {
		NOT_NULL(object, status, errMsg, 0);
	}

	/**
	 * 判断对象是否为NULL
	 * 
	 * @author yangyanchao
	 * @date 2016年7月21日
	 * @param object
	 *            判断目标
	 * @param status
	 *            错误码
	 * @param errMsg
	 *            错误信息
	 * @param throwExceptionType
	 *            错误抛出类型 0.抛出JSON 1.抛出错误页面
	 */
	public static final void NOT_NULL(Object object, int status, String errMsg,
			int throwExceptionType) {
		if (object == null) {
			throw new ASApiException(status, errMsg, throwExceptionType);
		}
	}

	public static final void NOT_TRUE(boolean operaFlag) {
		NOT_TRUE(operaFlag, 1001, "系统繁忙", 0);
	}

	public static final void NOT_TRUE(boolean operaFlag, String errMsg) {
		NOT_TRUE(operaFlag, 1001, errMsg, 0);
	}

	public static final void NOT_TRUE(boolean operaFlag, int status,
			String errMsg) {
		NOT_TRUE(operaFlag, status, errMsg, 0);
	}

	/**
	 * 判断值是否false
	 * 
	 * @author yangyanchao
	 * @date 2016年7月21日
	 * @param object
	 *            判断目标
	 * @param status
	 *            错误码
	 * @param errMsg
	 *            错误信息
	 * @param throwExceptionType
	 *            错误抛出类型 0.抛出JSON 1.抛出错误页面
	 */
	public static final void NOT_TRUE(boolean operaFlag, int status,
			String errMsg, int throwExceptionType) {
		if (!operaFlag) {
			throw new ASApiException(status, errMsg, throwExceptionType);
		}
	}
}
