package com.aoshi.util;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;



/**
 * TokenManager
 * 
 * @author zf
 * @date 16/6/20
 */
@Component
public class TokenManager {
	public static Map<String, Map<String, Object>> token = new HashMap<>();

	private static Map<String, String> tokenMap = new ConcurrentHashMap<>();

	public String createToken(String username) {
		String token = UUID.randomUUID().toString();
		tokenMap.put(token, username);
		return token;
	}

	public boolean checkToken(String token) {
		return !StringUtils.isEmpty(token) && tokenMap.containsKey(token);
	}

	public synchronized String createToken() {
		return UUID.randomUUID().toString().replace("-", "");
	}

	public static Map<String, Map<String, Object>> getToken() {
		return token;
	}

	public synchronized static void setToken(String token, Map<String, Object> map) {

		TokenManager.token.put(token, map);
	}


}
