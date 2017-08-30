package com.aoshi.util;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.security.SecureRandom;

public class SecurityUtil {
	public static final String KEY = "dkcIRJ524sdkei24";

	public static void main(String[] args){
		String content = "13799462738";
		String encode = encodeAES(content);
		String decode = decodeAES(encode);
		System.out.println(encode);
		System.out.println(decode);

	}
	
	// 用jdk实现 加密
	public static String encodeAES(String content){
		try {
			// 生成KEY
			KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
			//防止Linux操作系统key值改变
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" ); 
	        secureRandom.setSeed(KEY.getBytes());
			keyGenerator.init(128, secureRandom);
			// 产生密钥
			SecretKey secretKey = keyGenerator.generateKey();
			// 获取密钥
			byte[] keyBytes = secretKey.getEncoded();
			
			// KEY转换
			Key key = new SecretKeySpec(keyBytes, "AES");
			
			
			// 加密
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, key);
			byte[] result = cipher.doFinal(content.getBytes());
			
			return Base64.encodeBase64String(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 用jdk实现 解密
	public static String decodeAES(String content){
		try {
			// 生成KEY
			KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");			
			//防止Linux操作系统key值改变
			SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" ); 
	        secureRandom.setSeed(KEY.getBytes());
			keyGenerator.init(128, secureRandom);
			// 产生密钥
			SecretKey secretKey = keyGenerator.generateKey();
			// 获取密钥
			byte[] keyBytes = secretKey.getEncoded();
			
			// KEY转换
			Key key = new SecretKeySpec(keyBytes, "AES");
			
			// 解密
			Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, key);
			byte[] result = Base64.decodeBase64(content);
			result = cipher.doFinal(result);
			
			return new String(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
