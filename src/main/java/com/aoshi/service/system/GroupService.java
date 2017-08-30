package com.aoshi.service.system;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.aoshi.common.asenum.UserTypeEnum;
import com.aoshi.dao.AsAdminInfoMapper;
import com.aoshi.dao.AsUserMapper;
import com.aoshi.dao.AsWalletMapper;
import com.aoshi.dao.SysGrRelationMapper;
import com.aoshi.dao.SysGroupMapper;
import com.aoshi.dao.SysRoleMapper;
import com.aoshi.dao.SysUrRelationMapper;
import com.aoshi.dao.SysUserMapper;
import com.aoshi.domain.AsAdminInfo;
import com.aoshi.domain.AsUser;
import com.aoshi.domain.AsWallet;
import com.aoshi.domain.SysGrRelation;
import com.aoshi.domain.SysGroup;
import com.aoshi.domain.SysRole;
import com.aoshi.domain.SysUrRelation;
import com.aoshi.domain.SysUser;
import com.aoshi.entity.system.Role;
import com.aoshi.entity.system.User;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;

import net.sf.json.JSONObject;

@Service
public class GroupService {
	@Autowired
	SysGroupMapper sysGroupMapper;
	@Autowired
	AsUserMapper asUserMapper;
	@Autowired
	SysGrRelationMapper sysGrRelationMapper;
	@Autowired
	SysRoleMapper sysRoleMapper;
	@Autowired
	SysUserMapper sysUserMapper;
	@Autowired
	AsAdminInfoMapper asAdminInfoMapper;
	@Autowired
	AsWalletMapper asWalletMapper;
	@Autowired
	SysUrRelationMapper sysUrRelationMapper;
	
	public List<SysGroup> getGroupTree() {
		List<SysGroup> groups = sysGroupMapper.selectByParentId("0");
		
		return groups;
	}

	public List<Map<String, Object>> getAdminUser(Map<String,Object> map) {
		String groupName = map.get("groupName") ==null?"":map.get("groupName").toString();
		
		if(!StringUtils.isEmpty(groupName)){
			List<SysGroup> list = new ArrayList<>();
			List<String> ids = new ArrayList<>();
			SysGroup sysGroup = new SysGroup();
			sysGroup.setGroupName(groupName);
			list = sysGroupMapper.selectByAttr(sysGroup);
			
			if(list.size() == 0){
				return new ArrayList<>();
			}
			
			for(SysGroup group:list){
				ids.add(group.getGroupId());
			}
			List<SysUser> users = sysUserMapper.selectByGroupIds(ids);
			if(users.size() == 0){
				return new ArrayList<>();
			}else{
				map.put("users", users);
			}
		}
		
		return asUserMapper.getAdminUser(map);
	}

	public int saveGroup(SysGroup group, String roleIds) {
		String groupId = UUID.randomUUID().toString().replaceAll("-", "");
		group.setGroupId(groupId);
		sysGroupMapper.insertSelective(group);
		if(roleIds.indexOf(";") == -1){
			SysGrRelation grRelation = new SysGrRelation();
			grRelation.setGmId(UUID.randomUUID().toString().replaceAll("-", ""));
			grRelation.setGroupId(group.getGroupId());
			grRelation.setRoleId(roleIds);
			sysGrRelationMapper.insert(grRelation);
		}else{
			String[] array = roleIds.split(";");
			for(int i=0;i<array.length;i++){
				SysGrRelation grRelation = new SysGrRelation();
				grRelation.setGmId(UUID.randomUUID().toString().replaceAll("-", ""));
				grRelation.setGroupId(group.getGroupId());
				grRelation.setRoleId(array[i]);
				sysGrRelationMapper.insert(grRelation);
			}
		}
		return 1;
	}

	public SysGroup findGroupById(String groupId) {
		return sysGroupMapper.selectByPrimaryKey(groupId);
	}

	public int updateGroup(SysGroup group, String roleIds) {
		sysGroupMapper.updateByPrimaryKey(group);
		
		sysGrRelationMapper.deleteByGroupId(group.getGroupId());
		
		if(roleIds.indexOf(";") == -1){
			SysGrRelation grRelation = new SysGrRelation();
			grRelation.setGmId(UUID.randomUUID().toString().replaceAll("-", ""));
			grRelation.setGroupId(group.getGroupId());
			grRelation.setRoleId(roleIds);
			sysGrRelationMapper.insert(grRelation);
		}else{
			String[] array = roleIds.split(";");
			for(int i=0;i<array.length;i++){
				SysGrRelation grRelation = new SysGrRelation();
				grRelation.setGmId(UUID.randomUUID().toString().replaceAll("-", ""));
				grRelation.setGroupId(group.getGroupId());
				grRelation.setRoleId(array[i]);
				sysGrRelationMapper.insert(grRelation);
			}
		}
		
		return 1;
	}

	public List<SysGrRelation> getGrRelationByGroupId(String groupId) {
		return sysGrRelationMapper.getGrRelationByGroupId(groupId);
	}

	public List<SysRole> getRoleListByGroupId(String groupId) {
		List<SysGrRelation> relations = sysGrRelationMapper.getGrRelationByGroupId(groupId);
		
		List<String> roleIds = new ArrayList<>();
		for(int i=0;i<relations.size();i++){
			roleIds.add(relations.get(i).getRoleId());
		}
		if(roleIds.size() == 0){
			return new ArrayList<>();
		}
		return sysRoleMapper.seletByRoleIds(roleIds);
	}
	
	public List<SysRole> seletByRoleIds(List<String> roleIds){
		return sysRoleMapper.seletByRoleIds(roleIds);
	}
	
	public List<SysRole> listRoles() {
		return sysRoleMapper.listRoles();
	}
	
	/**
	 * 新增后台管理
	 * @param adminName
	 * @param adminPhone
	 * @param username
	 * @param password
	 * @param roleIds
	 * @return
	 */
	public int saveAdmin(AsAdminInfo info, SysUser sysUser, String roleIds) {
		//判断账号是否存在
		boolean exist = this.checkAccountExist(sysUser.getUsername());
		if(exist){
			return 0;
		}
		
		// 添加后台用户信息
		String sysUserId = UUID.randomUUID().toString().replaceAll("-", "");
		
		SysUser sys = new SysUser();
		sys.setUserId(sysUserId);
		sys.setUsername(sysUser.getUsername());
		sys.setName(sysUser.getUsername());
		sys.setPassword(CommonUtils.encryptPwd(sysUser.getPassword(), 2));
		sys.setGroupId(sysUser.getGroupId());
		sys.setStatus("0");
		sys.setSkin("skin-2");
		sys.setCreateBy(getCurrentUser().getUSER_ID());
		sysUserMapper.insertSelective(sys);
		
		//添加账号
		AsUser user = new AsUser();
		user.setAccount(sysUser.getUsername());
	    user.setCreateTime(DateUtil.getTime());
	    user.setPassword(CommonUtils.encryptPwd(sysUser.getPassword(), 2));
	    user.setStatus(0);
	    user.setSysUserId(sysUserId);
	    user.setType(4);
	    asUserMapper.insertSelective(user);
	    
	    // 添加后台管理员信息表
	    AsAdminInfo adminInfo = new AsAdminInfo();
        adminInfo.setAdminName(info.getAdminName());
        adminInfo.setAdminPhone(info.getAdminPhone());
        adminInfo.setCreateTime(DateUtil.getTime());
        //adminInfo.setRoleId("");
        adminInfo.setStatus(0);
        adminInfo.setUserId(user.getUserId());
        asAdminInfoMapper.insertSelective(adminInfo);
        
        // 添加钱包记录
        AsWallet wallet = new AsWallet();
        wallet.setUserId(user.getUserId());
        wallet.setCreateTime(DateUtil.getTime());
        asWalletMapper.insertSelective(wallet);
        
        //用户权限
        if(roleIds.indexOf(";") == -1){
        	SysUrRelation relation = new SysUrRelation();
        	relation.setUmId(UUID.randomUUID().toString().replaceAll("-", ""));
        	relation.setRoleId(roleIds);
        	relation.setUserId(sysUserId);
        	sysUrRelationMapper.insertSelective(relation);
        }else{
        	String[] array = roleIds.split(";");
        	for(int i=0;i<array.length;i++){
        		SysUrRelation relation = new SysUrRelation();
        		relation.setUmId(UUID.randomUUID().toString().replaceAll("-", ""));
        		relation.setRoleId(array[i]);
        		relation.setUserId(sysUserId);
        		sysUrRelationMapper.insertSelective(relation);
        	}
        }
        
		return 1;
	}

	public boolean checkAccountExist(String account) {
		AsUser asUser = asUserMapper.checkAccountExist(account);
		return asUser != null;
	}
	
	
	private User getCurrentUser(){
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		return user;
	}
	
	/**
	 * 更新后台管理员
	 * @param sysUser:sysUserId,groupId
	 * @param roleIds
	 * @return
	 */
	public int updateAdmin(SysUser param, String roleIds) {
		SysUser sysUser = new SysUser();
		sysUser.setUserId(param.getUserId());
		sysUser.setGroupId(param.getGroupId());
		sysUserMapper.updateByPrimaryKeySelective(param);
		//重新添加用户权限
		sysUrRelationMapper.deleteByUserId(param.getUserId());
		//用户权限
        if(roleIds.indexOf(";") == -1){
        	SysUrRelation relation = new SysUrRelation();
        	relation.setUmId(UUID.randomUUID().toString().replaceAll("-", ""));
        	relation.setRoleId(roleIds);
        	relation.setUserId(param.getUserId());
        	sysUrRelationMapper.insertSelective(relation);
        }else{
        	String[] array = roleIds.split(";");
        	for(int i=0;i<array.length;i++){
        		SysUrRelation relation = new SysUrRelation();
        		relation.setUmId(UUID.randomUUID().toString().replaceAll("-", ""));
        		relation.setRoleId(array[i]);
        		relation.setUserId(param.getUserId());
        		sysUrRelationMapper.insertSelective(relation);
        	}
        }
		return 1;
	}

	public List<SysUrRelation> getUrRelationByUserId(String userId) {
		return sysUrRelationMapper.selectByUserId(userId);
	}

	public boolean checkAccount(String userName) {
		return asUserMapper.checkAccountExist(userName) != null;
	}
	
}
