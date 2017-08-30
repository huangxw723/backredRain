package com.aoshi.util;

import java.math.BigInteger;
import java.util.List;

/**
 * @author Administrator 权限计算帮助类
 */
public class RightsHelper {
	/**
	 * 利用BigInteger对权限进行2的权的和计算
	 * 
	 * @param rights
	 *            int型权限编码数组
	 * @return 2的权的和
	 */
	public static BigInteger sumRights(int[] rights) {
		BigInteger num = new BigInteger("0");
		for (int i = 0; i < rights.length; i++) {
			num = num.setBit(rights[i]);
		}
		return num;
	}

	/**
	 * 利用BigInteger对权限进行2的权的和计算
	 * 
	 * @param rights
	 *            String型权限编码数组
	 * @return 2的权的和
	 */
	public static BigInteger sumRights(String[] rights) {
		BigInteger num = new BigInteger("0");
		for (int i = 0; i < rights.length; i++) {
			num = num.setBit(Integer.parseInt(rights[i]));
		}
		return num;
	}

	/**
	 * 测试是否具有指定编码的权限
	 * 
	 * @param sum
	 * @param targetRights
	 * @return
	 */
	public static boolean testRights(BigInteger sum, int targetRights) {
		return sum.testBit(targetRights);
	}

	/**
	 * 测试是否具有指定编码的权限
	 * 
	 * @param sum
	 * @param targetRights
	 * @return
	 */
	public static boolean testRights(String sum, int targetRights) {
		if (Tools.isEmpty(sum))
			return false;
		return testRights(new BigInteger(sum), targetRights);
	}

	/**
	 * 测试是否具有指定编码的权限
	 * 
	 * @param sum
	 * @param targetRights
	 * @return
	 */
	public static boolean testRights(String sum, String targetRights) {
		if (Tools.isEmpty(sum))
			return false;
		return testRights(new BigInteger(sum), targetRights);
	}
	
	/**
	 * 用户拥有多个权限的菜单判断
	 * @author luhuajiang
	 * @param sums
	 * @param targetRights
	 * @return
	 */
	public static boolean testMultiRights(List<String> sums,String targetRights){
		if(sums.size() == 0){
			return false;
		}
		
		boolean result = false;
		for(int i=0;i<sums.size();i++){
			String sum = sums.get(i);
			result = testRights(new BigInteger(sum), targetRights) || result;
		}
		return result;
	}

	/**
	 * 测试是否具有指定编码的权限
	 * 
	 * @param sum
	 * @param targetRights
	 * @return
	 */
	public static boolean testRights(BigInteger sum, String targetRights) {
		return testRights(sum, Integer.parseInt(targetRights));
	}
}
