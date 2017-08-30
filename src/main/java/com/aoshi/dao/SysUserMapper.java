package com.aoshi.dao;

import com.aoshi.domain.SysUser;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SysUserMapper extends AsBaseMapper {

	Object findByAccountAndPwd(Object conditions);

	//根据shoId删除所有账号信息
	int deleteData(Object conditions);

    /**
     * 根据ID统计数目
     *
     * @author yangyanchao
     * @date 2017-03-10
     * @param condition ID
     * @return
     */
    @Select("select count(*) from sys_user where user_id = #{userId}")
	int countById(@Param("userId") Object condition);
    
	/**
	 * 通过手机号码获取后台用户 找回密码
	 * @param phone
	 * @return
     */
	@Select("SELECT s.* FROM sys_user s JOIN as_user u ON s.USER_ID = u.sys_user_id where s.PHONE = #{phone}")
	SysUser findByPhone(@Param("phone")String phone);

	@Select("select * from sys_user where user_id = #{userId}")
	SysUser getSysUser(@Param("userId") String userId);

	@Select("select count(*) from sys_user where PHONE = #{phone}")
	int phoneMemberIsExist(@Param("phone")String phone);

	/**
	 * 检查后台用户是否重复
	 * @param conditions
	 * @return
     */
	int userNameIsExist(Object conditions);

	List<SysUser> selectByGroupIds(List<String> ids);
}