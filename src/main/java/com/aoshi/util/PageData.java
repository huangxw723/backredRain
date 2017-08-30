package com.aoshi.util;

import com.aoshi.resolver.ValidatorBreakException;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@SuppressWarnings("rawtypes")
public class PageData extends HashMap implements Map {

	private static final long serialVersionUID = 1L;

	Map map = null;
	HttpServletRequest request;

	@SuppressWarnings("unchecked")
	public PageData(HttpServletRequest request) {
		this.request = request;
		Map properties = request.getParameterMap();
		Map returnMap = new HashMap();
		Iterator entries = properties.entrySet().iterator();
		Map.Entry entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			value = "";
			entry = (Map.Entry) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i].trim() + "," + value;
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString().trim();
			}
			returnMap.put(name, value);
		}
		map = returnMap;
	}

	public PageData() {
		map = new HashMap();
	}

	/**
	 * 废弃 , 此方法不是获取PageData数据集里面的数据,而是获取Request里面的数据
	 * 
	 * @author yangyanchao
	 * @date 2016年11月15日
	 * @param key
	 *            入参名
	 * @return
	 */
	@Deprecated
	@Override
	public Object get(Object key) {
		Object obj = null;
		if (map.get(key) instanceof Object[]) {
			Object[] arr = (Object[]) map.get(key);
			obj = request == null ? arr
					: (request.getParameter((String) key) == null ? arr
							: arr[0]);
		} else {
			obj = map.get(key);
		}
		return obj;
	}

	@Deprecated
	public String getString(Object key) {
		if (get(key) != null) {
			return String.valueOf(get(key)).trim();
		} else {
			return (String) get(key);
		}
	}

	public int getInt(Object key) {
		if (get(key) != null) {
			return Integer.valueOf(String.valueOf(get(key)));
		} else {
			return 0;
		}
	}

	@Deprecated
	public String getStringRequired(Object key) {

		String value = null;

		try {
			value = get(key).toString();
		} catch (Exception e) {
			ValidatorBreakException.NOT_NULL(value, "非法参数");
		}

		return value;
	}

	@Deprecated
	public int getIntRequired(Object key) {

		int value = 0;
		try {
			value = Integer.parseInt(get(key).toString());
		} catch (Exception e) {
			ValidatorBreakException.NOT_TRUE(value == 0, "非法参数");
		}

		return value;
	}

	@Deprecated
	public Integer getIntegerRequired(Object key) {

		Integer value = null;
		try {
			value = Integer.parseInt(get(key).toString());
		} catch (Exception e) {
			ValidatorBreakException.NOT_TRUE(value == null, "非法参数");
		}

		return value;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object put(Object key, Object value) {
		return map.put(key, value);
	}

	@Override
	public Object remove(Object key) {
		return map.remove(key);
	}

	public void clear() {
		map.clear();
	}

	public boolean containsKey(Object key) {
		return map.containsKey(key);
	}

	public boolean containsValue(Object value) {
		return map.containsValue(value);
	}

	public Set entrySet() {
		return map.entrySet();
	}

	public boolean isEmpty() {
		return map.isEmpty();
	}

	public Set keySet() {
		return map.keySet();
	}

	@SuppressWarnings("unchecked")
	public void putAll(Map t) {
		map.putAll(t);
	}

	public int size() {
		return map.size();
	}

	public Collection values() {
		return map.values();
	}

	/**
	 * 获取 正整数 入参,非法值抛出异常
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param key
	 * @return
	 */
	public int getParaForPositiveInteger(String key) {

		int returnVal = 0;
		try {
			returnVal = Integer.parseInt(request.getParameter(key).toString());
			if (returnVal < 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			ValidatorBreakException.NOT_NULL(null, "非法参数");
		}

		return returnVal;
	}

	/**
	 * 获取 整数 入参,非法值抛出异常
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param key
	 * @return
	 */
	public int getParaForInteger(String key) {

		int returnVal = 0;
		try {
			returnVal = Integer.parseInt(request.getParameter(key).toString());
		} catch (Exception e) {
			ValidatorBreakException.NOT_NULL(null, "非法参数");
		}

		return returnVal;
	}

	/**
	 * 获取 正浮点值 入参,非法值抛出异常
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param key
	 * @return
	 */
	public double getParaForPositiveDouble(String key) {

		double returnVal = 0;
		try {
			returnVal = Double
					.parseDouble(request.getParameter(key).toString());
			if (returnVal < 0) {
				throw new Exception();
			}
		} catch (Exception e) {
			ValidatorBreakException.NOT_NULL(null, "非法参数");
		}

		return returnVal;
	}

	/**
	 * 获取 浮点值 入参,非法值抛出异常
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param key
	 * @return
	 */
	public double getParaForDouble(String key) {

		double returnVal = 0;
		try {
			returnVal = Double
					.parseDouble(request.getParameter(key).toString());
		} catch (Exception e) {
			ValidatorBreakException.NOT_NULL(null, "非法参数");
		}

		return returnVal;
	}

	/**
	 * 获取入参 字符串值,非法值抛出异常
	 * 
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param key
	 * @return
	 */
	public String getParaForString(String key) {

		String returnVal = "";
		try {
			returnVal = request.getParameter(key).toString().trim();
			if (StringUtils.isBlank(returnVal)) {
				throw new Exception();
			}
		} catch (Exception e) {
			ValidatorBreakException.NOT_NULL(null, "非法参数");
		}

		return returnVal;
	}

	/**
	 * 获取入参 字符串值,非法值抛出异常
	 *
	 * @author yangyanchao
	 * @date 2016年9月22日
	 * @param key
	 * @return
	 */
	public String getParaForStringOrNull(String key) {
		String returnVal  = request.getParameter(key);
		return returnVal;
	}

}
