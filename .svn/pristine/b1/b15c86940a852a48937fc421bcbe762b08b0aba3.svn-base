package com.aoshi.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 用于对时间差进行判断活动状态
 * @author strong
 * @version 1.0
 * 2017年2月24日下午3:28:43
 */
public class TimeUtil {
	
	
	public static Long getTime(String date){
		String regEx="[^0-9]";   
		Pattern p = Pattern.compile(regEx); 
		Matcher d1 = p.matcher(date); 
		return Long.parseLong(d1.replaceAll("").trim());
	}
}
