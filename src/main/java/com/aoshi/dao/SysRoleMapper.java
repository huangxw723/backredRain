package com.aoshi.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.aoshi.domain.SysRole;

public interface SysRoleMapper extends AsBaseMapper {

    /**
     * 判断ID权限角色是否存在
     * 
     * @author yangyanchao
     * @date 2017-03-10
     * @param conditions 角色ID
     * @return
     */
    int isExistById(Object conditions);
    
    List<SysRole> getRoleAll();

	List<SysRole> seletByRoleIds(List<String> roleIds);
	
	@Select(value="select * from sys_role")
	List<SysRole> listRoles();
	
}