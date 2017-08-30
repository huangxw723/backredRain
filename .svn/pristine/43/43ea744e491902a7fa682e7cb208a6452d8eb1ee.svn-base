package com.aoshi.controller.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.dao.SysUserMapper;
import com.aoshi.domain.AsAdminInfo;
import com.aoshi.domain.AsUser;
import com.aoshi.domain.SysGrRelation;
import com.aoshi.domain.SysGroup;
import com.aoshi.domain.SysRole;
import com.aoshi.domain.SysUrRelation;
import com.aoshi.domain.SysUser;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.Role;
import com.aoshi.service.system.GroupService;
import com.aoshi.service.system.RoleService;
import com.aoshi.service.system.UserService;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/group")
public class GroupController {
	@Autowired
	GroupService groupService;
	@Resource(name = "roleService")
	RoleService roleService;
	@Autowired
	UserService userService;
	private final static String BASE_URL = "system/group/";
	@Autowired
	SysUserMapper sysUserMapper;
	/**
	 * 部门列表
	 * @param map
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/groupList")
	public String groupList(ModelMap map,Page page,
			@RequestParam(value="status",required = false)Integer status,
			@RequestParam(value="keyWord",required = false)String keyWord,
			@RequestParam(value="groupName",required = false)String groupName,
			@RequestParam(value="startTime",required = false)String startTime,
			@RequestParam(value="endTime",required = false)String endTime){
		Map<String,Object> param = new HashMap<>();
		param.put("status", status);
		param.put("keyWord", keyWord);
		param.put("groupName", groupName);
		param.put("startTime", startTime);
		param.put("endTime", endTime);
		//树形部门
		List<SysGroup> groups = groupService.getGroupTree();
		//分页
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<Map<String,Object>> users = groupService.getAdminUser(param);
		
		page.setPage(users);
		map.put("groupList",JSONArray.fromObject(groups));
		map.put("list",users);
		map.put("currentPage", page.getCurrentPage());
		map.put("showCount", page.getShowCount());
		
		map.put("status", status);
		map.put("keyWord", keyWord);
		map.put("groupName", groupName);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		return BASE_URL+"groupList";
	}
	
	/**
	 * 保存部门页面
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/toAddGroup")
	public String toAddGroup(ModelMap map){
		//树形部门
		List<SysGroup> groups = groupService.getGroupTree();
		try {
			List<SysRole> roleList = groupService.listRoles();
			map.put("roleList", JSONArray.fromObject(roleList));
		} catch (Exception e) {
			e.printStackTrace();
		} // 列出所有部门
		map.put("groupList",JSONArray.fromObject(groups));
		
		return BASE_URL+"addGroup";
	}
	
	/**
	 * 保存部门
	 * @param group
	 * @param roleIds
	 * @return
	 */
	@RequestMapping(value = "/saveGroup")
	public String saveGroup(SysGroup group,String roleIds){
		groupService.saveGroup(group,roleIds);
		return BASE_URL+"groupResult";
	}
	
	/**
	 * 编辑部门页面
	 * @param groupId
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/toEditGroup")
	public String toEditGroup(String groupId,ModelMap map){
		SysGroup group = groupService.findGroupById(groupId);
		/*//树形部门
		List<SysGroup> groups = groupService.getGroupTree();*/
		
		//该组拥有的权限
		List<SysGrRelation> relations = groupService.getGrRelationByGroupId(groupId);
		
		
		try {
			List<SysRole> roleList = new ArrayList<>();
			//父级节点拥有的权限
			if(!"0".equals( group.getParentId() )){
				List<SysGrRelation> parentRelations = groupService.getGrRelationByGroupId(group.getParentId());
				List<String> roleIds = new ArrayList<>();
				for(int i=0;i<parentRelations.size();i++){
					roleIds.add(parentRelations.get(i).getRoleId());
				}
				roleList = groupService.seletByRoleIds(roleIds);
			}else{
				roleList = groupService.listRoles();
			}
			
			//List<Role> roleList = roleService.listRoles();
			if(relations.size()>0){
				for(int i=0;i<relations.size();i++){
					SysGrRelation relation = relations.get(i);
					
					for(SysRole role:roleList){
						if(relation.getRoleId().equals(role.getRoleId())){
							role.setChecked(true);
						}
					}
				}
			}
			
			map.put("roleList", roleList);
		} catch (Exception e) {
			e.printStackTrace();
		} // 列出所有部门
		/*map.put("groupList",JSONArray.fromObject(groups));*/
		
		map.put("group",group);
		return BASE_URL+"editGroup";
	}
	
	/**
	 * 更新部门
	 * @param group
	 * @param roleIds
	 * @return
	 */
	@RequestMapping(value = "/updateGroup")
	public String updateGroup(SysGroup group,String roleIds){
		groupService.updateGroup(group,roleIds);
		return BASE_URL+"groupResult";
	}
	
	/**
	 * 新增管理员
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/toAddAdmin")
	public String toAddAdmin(ModelMap map){
		//树形部门
		List<SysGroup> groups = groupService.getGroupTree();
		/*try {
			List<SysRole> roleList = groupService.listRoles();
			map.put("roleList", JSONArray.fromObject(roleList));
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		map.put("groupList",JSONArray.fromObject(groups));
		return BASE_URL+"addAdmin";
	}
	
	/**
	 * 根据部门id查找角色
	 * @param groupId
	 * @return
	 */
	@RequestMapping(value = "/getRoleListByGroupId")
	@ResponseBody
	public List<SysRole> getRoleListByGroupId(String groupId){
		return groupService.getRoleListByGroupId(groupId);
	}
	
	@RequestMapping(value = "/checkAccountExist")
	@ResponseBody
	public boolean checkAccountExist(String account){
		return groupService.checkAccountExist(account);
	}
	
	@RequestMapping(value = "/checkAccount")
	@ResponseBody
	public boolean checkAccount(String userName){
		return groupService.checkAccount(userName);
	}
	
	/**
	 * 新增后台管理
	 * @param adminName
	 * @param adminPhone
	 * @param account
	 * @param password
	 * @param roleIds 
	 * @param groupId
	 * @return
	 */
	@RequestMapping(value = "/saveAdmin")
	public String saveAdmin(AsAdminInfo adminInfo,SysUser sysUser,String roleIds){
		groupService.saveAdmin(adminInfo,sysUser,roleIds);
		return BASE_URL+"groupResult";
	}
	
	/**
	 * 编辑管理员
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/toEditAdmin")
	public String toEditAdmin(int userId,ModelMap map){
		AsUser user = userService.selectByPrimaryKey(userId);
		SysUser sysUser = (SysUser) sysUserMapper.selectByPrimaryKey(user.getSysUserId());
		//该部门拥有的权限
		List<SysRole> roles = groupService.getRoleListByGroupId(sysUser.getGroupId());
		//该用户拥有的权限 
		List<SysUrRelation> relations = groupService.getUrRelationByUserId(sysUser.getUserId());
		for(SysUrRelation ur:relations){
			String roleId = ur.getRoleId();
			for(SysRole role:roles){
				if(roleId.equals(role.getRoleId())){
					role.setChecked(true);
				}
			}
		}
		
		//树形部门
		List<SysGroup> groups = groupService.getGroupTree();
		map.put("groupList",JSONArray.fromObject(groups));
		map.put("roleList", JSONArray.fromObject(roles));
		map.put("userId", sysUser.getUserId());
		map.put("groupId", sysUser.getGroupId());
		return BASE_URL+"editAdmin";
	}
	
	/**
	 * 更新后台管理员
	 * @param sysUser:sysUserId,groupId
	 * @param roleIds
	 * @return
	 */
	@RequestMapping(value = "/updateAdmin")
	public String updateAdmin(SysUser sysUser,String roleIds){
		groupService.updateAdmin(sysUser,roleIds);
		return BASE_URL+"groupResult";
	}
}
