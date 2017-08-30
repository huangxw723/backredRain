package com.aoshi.controller.system;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONArray;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.Menu;
import com.aoshi.entity.system.Role;
import com.aoshi.entity.system.User;
import com.aoshi.service.system.MenuService;
import com.aoshi.service.system.RoleService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;
import com.aoshi.util.RightsHelper;
import com.aoshi.util.Tools;

/**
 * 类名称：RoleController 创建人：FH 创建时间：2014年6月30日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/role")
public class RoleController extends BaseController {

	String menuUrl = "role.do"; // 菜单地址(权限用)
	@Resource(name = "menuService")
	private MenuService menuService;
	@Resource(name = "roleService")
	private RoleService roleService;

	/**
	 * 权限(增删改查)
	 */
	@RequestMapping(value = "/qx")
	public ModelAndView qx() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String msg = pd.getString("msg");
			if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				roleService.updateQx(msg, pd);
			}
			mv.setViewName("save_result");
			mv.addObject("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * K权限
	 */
	@RequestMapping(value = "/kfqx")
	public ModelAndView kfqx() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String msg = pd.getString("msg");
			if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				roleService.updateKFQx(msg, pd);
			}
			mv.setViewName("save_result");
			mv.addObject("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * c权限
	 */
	@RequestMapping(value = "/gysqxc")
	public ModelAndView gysqxc() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			String msg = pd.getString("msg");
			if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				roleService.gysqxc(msg, pd);
			}
			mv.setViewName("save_result");
			mv.addObject("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 列表
	 */
	@RequestMapping
	public ModelAndView list(Page page) throws Exception {

	    initialized();

		User user = this.getCurrentUser();
		pd = this.getPageData();

		String roleId = pd.getString("ROLE_ID");
		/*if (roleId == null || "".equals(roleId)) {
			pd.put("ROLE_ID", "1");
		}*/
		List<Role> roleList = roleService.listRoles(); // 列出所有部门
		// List<Role> roleList =
		// roleService.listAllRolesByUser(user.getUSER_ID());// 列出该用户创建的所有部门
		List<Role> roleList_z = new ArrayList<Role>();// 列出此部门的所有下级
		if(roleList.size() > 0){
			if (roleId == null || "".equals(roleId)) {
				pd.put("ROLE_ID", roleList.get(0).getROLE_ID());
			}
			roleList_z = roleService.listAllRolesByPId(pd); // 列出此部门的所有下级
		}
		

		List<PageData> kefuqxlist = roleService.listAllkefu(pd); // 管理权限列表
		pd = roleService.findObjectById(pd); // 取得点击部门
		mv.addObject("pd", pd);
		mv.addObject("kefuqxlist", kefuqxlist);
		mv.addObject("roleList", roleList);
		mv.addObject("roleList_z", roleList);
		mv.setViewName("system/role/role_list");

		return mv;
	}

	/**
	 * 新增页面
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			mv.setViewName("system/role/role_add");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存新增信息
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView add() throws Exception {
		User user = this.getCurrentUser();
		//Role role = roleService.getRoleById(user.getROLE_ID());
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			
			String parent_id = pd.getString("PARENT_ID"); // 父类角色id
			pd.put("ROLE_ID", parent_id);
			if ("0".equals(parent_id)) {
				pd.put("RIGHTS", "");
			} else {
				String rights = roleService.findObjectById(pd).getString("RIGHTS");
				pd.put("RIGHTS", (null == rights) ? "" : rights);
			}
			
			pd.put("QX_ID", "");

			String UUID = this.get32UUID();

			pd.put("GL_ID", UUID);
			pd.put("FX_QX", 0); // 发信权限
			pd.put("FW_QX", 0); // 服务权限
			pd.put("QX1", 0); // 操作权限
			pd.put("QX2", 0); // 产品权限
			pd.put("QX3", 0); // 预留权限
			pd.put("QX4", 0); // 预留权限
			if (Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
				roleService.saveKeFu(pd);
			}// 保存到K权限表

			pd.put("QX_ID", UUID);
			pd.put("ROLE_ID", UUID);
			pd.put("ADD_QX", "0");
			pd.put("DEL_QX", "0");
			pd.put("EDIT_QX", "0");
			pd.put("CHA_QX", "0");
			
			// 用户id
			pd.put("create_by", user.getUSER_ID());
			if (Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
				roleService.add(pd);
			}
			mv.addObject("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			mv.addObject("msg", "failed");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 请求编辑
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit(String ROLE_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			pd.put("ROLE_ID", ROLE_ID);
			pd = roleService.findObjectById(pd);
			mv.setViewName("system/role/role_edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 编辑
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				pd = roleService.edit(pd);
			}
			mv.addObject("msg", "success");
		} catch (Exception e) {
			logger.error(e.toString(), e);
			mv.addObject("msg", "failed");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 分配权限菜单列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @param ROLE_ID
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth")
	public String auth(@RequestParam String ROLE_ID, Model model) throws Exception {
		
		List<Menu> menuList = menuService.listAllMenu();

		Role actRole = roleService.getRoleById(ROLE_ID);
		String roleRights = actRole.getRIGHTS();
		if (Tools.notEmpty(roleRights)) {
			// for (Menu menu : menuList) {
			for (Menu menu : menuList) {
				menu.setHasMenu(RightsHelper.testRights(roleRights,
						menu.getMENU_ID()));
				if (menu.isHasMenu()) {
					List<Menu> subMenuList = menu.getSubMenu();
					for (Menu sub : subMenuList) {
						sub.setHasMenu(RightsHelper.testRights(roleRights,
								sub.getMENU_ID()));
					}
				}
			}
		}

		JSONArray arr = JSONArray.fromObject(menuList);
		String json = arr.toString();
		json = json.replaceAll("MENU_ID", "id").replaceAll("MENU_NAME", "name")
				.replaceAll("subMenu", "nodes")
				.replaceAll("hasMenu", "checked");
		model.addAttribute("zTreeNodes", json);
		model.addAttribute("roleId", ROLE_ID);


		return "authorization";
	}

	/**
	 * 请求角色按钮授权页面
	 */
	@RequestMapping(value = "/button")
	public ModelAndView button(@RequestParam String ROLE_ID, @RequestParam String msg, Model model) throws Exception {
		ModelAndView mv = this.getModelAndView();
		try {
			List<Menu> menuList = menuService.listAllMenu();
			Role role = roleService.getRoleById(ROLE_ID);

			String roleRights = "";
			if ("add_qx".equals(msg)) {
				roleRights = role.getADD_QX();
			} else if ("del_qx".equals(msg)) {
				roleRights = role.getDEL_QX();
			} else if ("edit_qx".equals(msg)) {
				roleRights = role.getEDIT_QX();
			} else if ("cha_qx".equals(msg)) {
				roleRights = role.getCHA_QX();
			}
			
			// 当前用户
			User currentUser = this.getCurrentUser();
			// 当前用户角色
			Role currentRole = roleService.getRoleById(currentUser.getROLE_ID());
			// 判断是否是管理员
			boolean isAdmin = currentRole.getIs_admin() == 1;
			// 当前用户角色权限
			String currentRoleRights = currentRole.getRIGHTS();
			// 只显示当前用户具有的菜单权限
			List<Menu> menus = new ArrayList<Menu>();
			
			for(int i=0;i<menuList.size();i++){
				Menu m = menuList.get(i);
				if (isAdmin) {// 如果是管理员 则显示全部菜单选项
					menus.add(m);
				}else if(RightsHelper.testRights(currentRoleRights,m.getMENU_ID())){
					menus.add(m);// 不是管理员，只显示本身的菜单选项
				}
			}
			
			
			/*if (Tools.notEmpty(roleRights)) {
				for (Menu menu : menuList) {
					menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMENU_ID()));
					if (menu.isHasMenu()) {
						List<Menu> subMenuList = menu.getSubMenu();
						for (Menu sub : subMenuList) {
							sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMENU_ID()));
						}
					}
				}
			}*/
			
			if (Tools.notEmpty(roleRights)) {
				//for (Menu menu : menuList) {
				for (Menu menu : menus) {	
					menu.setHasMenu(RightsHelper.testRights(roleRights, menu.getMENU_ID()));
					if (menu.isHasMenu()) {
						List<Menu> subMenuList = menu.getSubMenu();
						for (Menu sub : subMenuList) {
							sub.setHasMenu(RightsHelper.testRights(roleRights, sub.getMENU_ID()));
						}
					}
				}
			}
			
			//JSONArray arr = JSONArray.fromObject(menuList);
			JSONArray arr = JSONArray.fromObject(menus);
			String json = arr.toString();
			// System.out.println(json);
			json = json.replaceAll("MENU_ID", "id").replaceAll("MENU_NAME", "name").replaceAll("subMenu", "nodes").replaceAll("hasMenu", "checked");
			mv.addObject("zTreeNodes", json);
			mv.addObject("roleId", ROLE_ID);
			mv.addObject("msg", msg);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		mv.setViewName("system/role/role_button");
		return mv;
	}

	/**
	 * 保存角色菜单权限
	 */
	@RequestMapping(value = "/auth/save")
	public void saveAuth(@RequestParam String ROLE_ID, @RequestParam String menuIds, PrintWriter out) throws Exception {
		PageData pd = new PageData();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				if (null != menuIds && !"".equals(menuIds.trim())) {
					BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
					Role role = roleService.getRoleById(ROLE_ID);
					role.setRIGHTS(rights.toString());
					roleService.updateRoleRights(role);
					pd.put("rights", rights.toString());
				} else {
					Role role = new Role();
					role.setRIGHTS("");
					role.setROLE_ID(ROLE_ID);
					roleService.updateRoleRights(role);
					pd.put("rights", "");
				}

				pd.put("roleId", ROLE_ID);

				// 这里是给当前用户的权限同步到子用户组
				// roleService.setAllRights(pd);
			}
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 保存角色按钮权限
	 */
	@RequestMapping(value = "/roleButton/save")
	public void orleButton(@RequestParam String ROLE_ID, @RequestParam String menuIds, @RequestParam String msg, PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
				if (null != menuIds && !"".equals(menuIds.trim())) {
					BigInteger rights = RightsHelper.sumRights(Tools.str2StrArray(menuIds));
					pd.put("value", rights.toString());
				} else {
					pd.put("value", "");
				}
				pd.put("ROLE_ID", ROLE_ID);
				roleService.updateQx(msg, pd);
			}
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object deleteRole(@RequestParam String ROLE_ID) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		String errInfo = "";
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
				pd.put("ROLE_ID", ROLE_ID);
				List<Role> roleList_z = roleService.listAllRolesByPId(pd); // 列出此部门的所有下级
				if (roleList_z.size() > 0) {
					errInfo = "false";
				} else {

					List<PageData> userlist = roleService.listAllUByRid(pd);
					if (userlist.size() > 0) {
						errInfo = "false2";
					} else {
						roleService.deleteRoleById(ROLE_ID);
						roleService.deleteKeFuById(ROLE_ID);
						errInfo = "success";
					}
				}
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */

}
