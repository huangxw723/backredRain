package com.aoshi.common.asannotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 操作日志记录注解
 * 
 * @author yangyanchao 
 * @date 2016年10月17日
 * 
 */
@Target({ ElementType.TYPE, ElementType.METHOD })
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log {

	/**
	 * 模块名
	 * 
	 * @author yangyanchao 
 	 * @date 2016年10月17日  
	 * @return
	 */
	public String recordModule() default "";

	/**
	 * 内容说明
	 * 
	 * @author yangyanchao 
	 * @date 2016年10月17日 
	 * @return
	 */
	public String recordDescp() default "";
}
