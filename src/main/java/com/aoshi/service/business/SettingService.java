package com.aoshi.service.business;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.dao.SysUserMapper;
import com.aoshi.domain.SysUser;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;

/**
 * 商家端公用模块 Service
 * 
 * @author yangyanchao
 * @date 2016年9月8日
 */
@Service
public class SettingService extends AsBaseService {
	
	private final static String PAGE_PATH = "business/common/";

	@Autowired
	private SysUserMapper sysUserMapper;

	@Autowired
	private AsUserMapper asUserMapper;

	/**
	 * 修改密码
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @param c
	 * @return
	 */
	public Object updatePwd(BaseController c) {
		
		initialized(c);

		String sysUserId = getUser().getUSER_ID();

		SysUser sysUser = (SysUser) sysUserMapper.selectByPrimaryKey(sysUserId);
		ValidatorBreakException.NOT_NULL(sysUser, "系统繁忙");

		Conditions user = (Conditions) asUserMapper.findBySysUserId(sysUserId);
		ValidatorBreakException.NOT_NULL(user, "系统繁忙");

		String oldPassword = pd.getString("oldPassword");
		String password = pd.getString("password");

		String SHA1OldPassword = CommonUtils.encryptPwd(oldPassword, 2);
		String SHA1Password = CommonUtils.encryptPwd(password, 2);
		String MD5Password = CommonUtils.encryptPwd(password);

		// 验证原密码
		ValidatorBreakException.NOT_TRUE(
				sysUser.getPassword().equals(SHA1OldPassword), "原密码不正确");

		// 修改后台用户表密码
		sysUser.setPassword(SHA1Password);
		operaFlag = sysUserMapper.updateByPrimaryKeySelective(sysUser) == 1;

		// 修改账号表密码
		user.putData("password", MD5Password).keep("userId", "password");
		operaFlag = asUserMapper.updateByPrimaryKeySelective(user) == 1;

		return renderSuccess();
	}
	
	
	
	/**
	 * 修改密码
	 * 
	 * @author wangjs
	 * @date 2017年02月20日
	 * @return
	 */
	public Object updatePass(BaseController c ,String oldPassword,String password) {
		
		initialized(c);

		String sysUserId = getUser().getUSER_ID();

		SysUser sysUser = (SysUser) sysUserMapper.selectByPrimaryKey(sysUserId);
		Map<String,Object> data = new HashMap<String,Object>();
		if(null==sysUser){
			data.put("status","1");
		}
		
		//ValidatorBreakException.NOT_NULL(sysUser, "系统繁忙");

		Conditions user = (Conditions) asUserMapper.findBySysUserId(sysUserId);
		if(null==user){
			data.put("status",1);
		}
	//	ValidatorBreakException.NOT_NULL(user, "系统繁忙");

//		String oldPassword = pd.getString("oldPassword");
//		String password = pd.getString("password");

		String SHA1OldPassword = CommonUtils.encryptPwd(oldPassword, 2);
		String SHA1Password = CommonUtils.encryptPwd(password, 2);
		String MD5Password = CommonUtils.encryptPwd(password);

		// 验证原密码
		if(!sysUser.getPassword().equals(SHA1OldPassword)){
			data.put("status",2);
			return data;
		}
		
		ValidatorBreakException.NOT_TRUE(
				sysUser.getPassword().equals(SHA1OldPassword), "原密码不正确");

		// 修改后台用户表密码
		sysUser.setPassword(SHA1Password);
		operaFlag = sysUserMapper.updateByPrimaryKeySelective(sysUser) == 1;

		// 修改账号表密码
		user.putData("password", MD5Password).keep("userId", "password");
		operaFlag = asUserMapper.updateByPrimaryKeySelective(user) == 1;

		if(operaFlag){
			data.put("status","0");
		}else{
			data.put("status","3");
		}
		return data;
	}
	
	
	
	
}
