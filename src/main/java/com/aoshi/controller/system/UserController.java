package com.aoshi.controller.system;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.Role;
import com.aoshi.entity.system.User;
import com.aoshi.service.manage.CapitalService;
import com.aoshi.service.system.MenuService;
import com.aoshi.service.system.RoleService;
import com.aoshi.service.system.UserService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.FileDownload;
import com.aoshi.util.FileUpload;
import com.aoshi.util.GetPinyin;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.ObjectExcelRead;
import com.aoshi.util.ObjectExcelView;
import com.aoshi.util.PageData;
import com.aoshi.util.PathUtil;
import com.aoshi.util.RandomCodeUtil;
import com.aoshi.util.SmsUtils;
import com.aoshi.util.Tools;

/**
 * 类名称：UserController 创建人：FH 创建时间：2014年6月28日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {

	String menuUrl = "user/listUsers.do"; // 菜单地址(权限用)
	@Resource(name = "userService")
	private UserService userService;
	@Resource(name = "roleService")
	private RoleService roleService;
	@Resource(name = "menuService")
	private MenuService menuService;
	@Autowired
	SmsUtils smsUtils;
	@Autowired
	private CapitalService capitalService;
	/**
	 * 保存用户
	 */
	@RequestMapping(value = "/saveU")
	public ModelAndView saveU(PrintWriter out) throws Exception {
		User current = this.getCurrentUser();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String userId = current.getUSER_ID();
		System.err.println("--------userId:"+userId);
		System.out.println("--------userId:"+userId);
		pd.put("create_by", userId);
		pd.put("USER_ID", this.get32UUID()); // ID
		pd.put("RIGHTS", ""); // 权限
		pd.put("LAST_LOGIN", ""); // 最后登录时间
		pd.put("IP", ""); // IP
		pd.put("STATUS", "0"); // 状态
		pd.put("SKIN", "default"); // 默认皮肤

		pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("PASSWORD"), Const.SALT).toString());

		if (null == userService.findByUId(pd)) {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
				userService.saveU(pd);
			} // 判断新增权限
			mv.addObject("msg", "success");
		} else {
			mv.addObject("msg", "failed");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 判断用户名是否存在
	 */
	@RequestMapping(value = "/hasU")
	@ResponseBody
	public Object hasU() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (userService.findByUId(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断邮箱是否存在
	 */
	@RequestMapping(value = "/hasE")
	@ResponseBody
	public Object hasE() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();

			if (userService.findByUE(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 判断编码是否存在
	 */
	@RequestMapping(value = "/hasN")
	@ResponseBody
	public Object hasN() {
		Map<String, String> map = new HashMap<String, String>();
		String errInfo = "success";
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (userService.findByUN(pd) != null) {
				errInfo = "error";
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo); // 返回结果
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/editU")
	public ModelAndView editU() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("PASSWORD") != null && !"".equals(pd.getString("PASSWORD"))) {
			pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("PASSWORD"), Const.SALT).toString());
		}
//		if (Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			userService.editU(pd);
//		}
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 去修改用户页面
	 */
	@RequestMapping(value = "/goEditU")
	public ModelAndView goEditU() throws Exception {
		User user = this.getCurrentUser();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		// 顶部修改个人资料
		String fx = pd.getString("fx");

		// System.out.println(fx);

		if ("head".equals(fx)) {
			mv.addObject("fx", "head");
		} else {
			mv.addObject("fx", "user");
		}

		//List<Role> roleList = roleService.listAllERRoles(); // 列出所有二级角色
		List<Role> roleList = roleService.listAllRolesByUser(user.getUSER_ID()); // 列出所有二级角色
		pd = userService.findByUiId(pd); // 根据ID读取
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "editU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 去新增用户页面
	 */
	@RequestMapping(value = "/goAddU")
	public ModelAndView goAddU() throws Exception {
		User user = this.getCurrentUser();
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<Role> roleList;
		//roleList = roleService.listAllERRoles(); // 列出所有二级角色
		roleList = roleService.listAllRolesByUser(user.getUSER_ID()); // 列出所有二级角色
		mv.setViewName("system/user/user_edit");
		mv.addObject("msg", "saveU");
		mv.addObject("pd", pd);
		mv.addObject("roleList", roleList);
		return mv;
	}

	/**
	 * 显示用户列表(用户组)
	 */
	@RequestMapping(value = "/listUsers")
	public ModelAndView listUsers(Page page) throws Exception {
		User user = this.getCurrentUser();
		Role role = roleService.getRoleById(user.getROLE_ID());
		boolean isAdmin = role.getIs_admin() == 1;
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String USERNAME = pd.getString("USERNAME");

		if (null != USERNAME && !"".equals(USERNAME)) {
			USERNAME = USERNAME.trim();
			pd.put("USERNAME", USERNAME);
		}

		String lastLoginStart = pd.getString("lastLoginStart");
		String lastLoginEnd = pd.getString("lastLoginEnd");

		if (lastLoginStart != null && !"".equals(lastLoginStart)) {
			lastLoginStart = lastLoginStart + " 00:00:00";
			pd.put("lastLoginStart", lastLoginStart);
		}
		if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
			lastLoginEnd = lastLoginEnd + " 00:00:00";
			pd.put("lastLoginEnd", lastLoginEnd);
		}

		
		
		
		List<PageData> userList = new ArrayList<PageData>();
		List<Role> roleList = new ArrayList<Role>();
		if(isAdmin){
			page.setPd(pd);
			roleList = roleService.listAllERRoles(); // 列出所有二级角色
			userList = userService.listPdPageUser(page); // 列出用户列表
		}else{
			pd.put("userId", user.getUSER_ID());
			page.setPd(pd);
			//当前用户创建的角色
			roleList = roleService.getRolesByUser(user.getUSER_ID()); // 列出该用户创建的角色
			//TODO
			userList = userService.listPdPageUser(page); // 列出用户列表
			
		}
		

		mv.setViewName("system/user/user_list");
		mv.addObject("userList", userList);
		mv.addObject("roleList", roleList);
		mv.addObject("pd", pd);
		System.out.println(this.getHC());
		mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 显示用户列表(tab方式)
	 */
	@RequestMapping(value = "/listtabUsers")
	public ModelAndView listtabUsers(Page page) throws Exception {
		User user = this.getCurrentUser();
		
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("create_by", user.getUSER_ID());
		List<PageData> userList = userService.listAllUser(pd); // 列出用户列表
		mv.setViewName("system/user/user_tb_list");
		mv.addObject("userList", userList);
		mv.addObject("pd", pd);
		mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 删除用户
	 */
	@RequestMapping(value = "/deleteU")
	public void deleteU(PrintWriter out) {
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
				userService.deleteU(pd);
			}
			out.write("success");
			out.close();
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/deleteAllU")
	@ResponseBody
	public Object deleteAllU() {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String USER_IDS = pd.getString("USER_IDS");

			if (null != USER_IDS && !"".equals(USER_IDS)) {
				String ArrayUSER_IDS[] = USER_IDS.split(",");
				if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
					userService.deleteAllU(ArrayUSER_IDS);
				}
				pd.put("msg", "ok");
			} else {
				pd.put("msg", "no");
			}

			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	// ===================================================================================================

	/*
	 * 导出用户信息到EXCEL
	 * 
	 * @return
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		User user = this.getCurrentUser();
		Role role = roleService.getRoleById(user.getROLE_ID());
		boolean isAdmin = role.getIs_admin() == 1;
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			if (Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
				// 检索条件===
				String USERNAME = pd.getString("USERNAME");
				if (null != USERNAME && !"".equals(USERNAME)) {
					USERNAME = USERNAME.trim();
					pd.put("USERNAME", USERNAME);
				}
				String lastLoginStart = pd.getString("lastLoginStart");
				String lastLoginEnd = pd.getString("lastLoginEnd");
				if (lastLoginStart != null && !"".equals(lastLoginStart)) {
					lastLoginStart = lastLoginStart + " 00:00:00";
					pd.put("lastLoginStart", lastLoginStart);
				}
				if (lastLoginEnd != null && !"".equals(lastLoginEnd)) {
					lastLoginEnd = lastLoginEnd + " 00:00:00";
					pd.put("lastLoginEnd", lastLoginEnd);
				}
				// 检索条件===

				Map<String, Object> dataMap = new HashMap<String, Object>();
				List<String> titles = new ArrayList<String>();

				titles.add("用户名"); // 1
				titles.add("编号"); // 2
				titles.add("姓名"); // 3
				titles.add("职位"); // 4
				titles.add("手机"); // 5
				titles.add("邮箱"); // 6
				titles.add("最近登录"); // 7
				titles.add("上次登录IP"); // 8

				dataMap.put("titles", titles);
				List<PageData> userList = new ArrayList<PageData>();
				if(isAdmin){
					userList = userService.listAllUser(pd);
				}else{
					pd.put("create_by", user.getUSER_ID());
					userList = userService.listAllUser(pd);
				}
				
				
				
				List<PageData> varList = new ArrayList<PageData>();
				for (int i = 0; i < userList.size(); i++) {
					PageData vpd = new PageData();
					vpd.put("var1", userList.get(i).getString("USERNAME")); // 1
					vpd.put("var2", userList.get(i).getString("NUMBER")); // 2
					vpd.put("var3", userList.get(i).getString("NAME")); // 3
					vpd.put("var4", userList.get(i).getString("ROLE_NAME")); // 4
					vpd.put("var5", userList.get(i).getString("PHONE")); // 5
					vpd.put("var6", userList.get(i).getString("EMAIL")); // 6
					vpd.put("var7", userList.get(i).getString("LAST_LOGIN")); // 7
					vpd.put("var8", userList.get(i).getString("IP")); // 8
					varList.add(vpd);
				}
				dataMap.put("varList", varList);
				ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
				mv = new ModelAndView(erv, dataMap);
			}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 打开上传EXCEL页面
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/user/uploadexcel");
		return mv;
	}

	/**
	 * 下载模版
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {

		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Users.xls", "Users.xls");

	}

	/**
	 * 从EXCEL导入到数据库
	 */
	@RequestMapping(value = "/readExcel")
	public ModelAndView readExcel(@RequestParam(value = "excel", required = false) MultipartFile file) throws Exception {
		User user = this.getCurrentUser();
		Role currentRole = roleService.getRoleById(user.getROLE_ID());
		boolean isAdmin = currentRole.getIs_admin() == 1;
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		}
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
			String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传

			List<PageData> listPd = (List<PageData>) ObjectExcelRead.readExcel(filePath, fileName, 2, 0, 0); // 执行读EXCEL操作,读出的数据导入List
			// 2:从第3行开始；0:从第A列开始；0:第0个sheet

			/* 存入数据库操作====================================== */
			pd.put("RIGHTS", ""); // 权限
			pd.put("LAST_LOGIN", ""); // 最后登录时间
			pd.put("IP", ""); // IP
			pd.put("STATUS", "0"); // 状态
			pd.put("SKIN", "default"); // 默认皮肤
			List<Role> roleList = new ArrayList<Role>();
			if(isAdmin){
				roleList = roleService.listAllERRoles(); // 列出所有二级角色
			}else{
				roleList = roleService.getRolesByUser(user.getUSER_ID());
			}
			

			pd.put("ROLE_ID", roleList.get(0).getROLE_ID()); // 设置角色ID为随便第一个
			/**
			 * var0 :编号 var1 :姓名 var2 :手机 var3 :邮箱 var4 :备注
			 */
			for (int i = 0; i < listPd.size(); i++) {
				pd.put("USER_ID", this.get32UUID()); // ID
				pd.put("NAME", listPd.get(i).getString("var1")); // 姓名

				String USERNAME = GetPinyin.getPingYin(listPd.get(i).getString("var1")); // 根据姓名汉字生成全拼
				pd.put("USERNAME", USERNAME);
				if (userService.findByUId(pd) != null) { // 判断用户名是否重复
					USERNAME = GetPinyin.getPingYin(listPd.get(i).getString("var1")) + Tools.getRandomNum();
					pd.put("USERNAME", USERNAME);
				}
				pd.put("BZ", listPd.get(i).getString("var4")); // 备注
				if (Tools.checkEmail(listPd.get(i).getString("var3"))) { // 邮箱格式不对就跳过
					pd.put("EMAIL", listPd.get(i).getString("var3"));
					if (userService.findByUE(pd) != null) { // 邮箱已存在就跳过
						continue;
					}
				} else {
					continue;
				}

				pd.put("NUMBER", listPd.get(i).getString("var0")); // 编号已存在就跳过
				pd.put("PHONE", listPd.get(i).getString("var2")); // 手机号

				pd.put("PASSWORD", new SimpleHash("SHA-1", "123", Const.SALT).toString()); // 默认密码123
				if (userService.findByUN(pd) != null) {
					continue;
				}
				userService.saveU(pd);
			}
			/* 存入数据库操作====================================== */

			mv.addObject("msg", "success");
		}

		mv.setViewName("save_result");
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */



	@RequestMapping(value = "/phone")
	public Object getAdminPhone() {
		
		return  userService.getAdminPhone(this);
		
	}

	@RequestMapping(value = "/capital/phone")
	public Object getSendAdminPhone() {
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		String  checkFlag = session.getAttribute("checkFlag")==null ? "" : session.getAttribute("checkFlag").toString();
		
		if("0".equals(checkFlag)){
			return capitalService.opearPage(this);
		}else{
			return  userService.getSendAdminPhone(this);
		}
	}


    /**
     * 发送验证码
     *
     * @param phone
     * @return
     * @author wangjs
     * @date 2017年02月20日
     */
    @RequestMapping(value = "/sms")
    @ResponseBody
    public Object getVerifyCode(String phone) {

        Map<String, Object> data = new HashMap<String, Object>();
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();

        String code = RandomCodeUtil.getNumber(6);
        String msg = "【澳视官网】提醒您，您的验证码为" + code
                + "，为保证您的权益，请保管好该验证码。此验证码有效期60秒";
        System.out.println(msg);
        try {
            smsUtils.sendSms2(phone, msg);
            data.put("status", "0");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            data.put("status", "1");
        }
        session.setAttribute("adminPhone", phone);
        session.setAttribute("adminCode", code);
        data.put("phone", phone);
        //data.put("adminCode",code);
        return data;
    }



	
	/**
	 * 验证验证码
	 * @param phone
	 * @param code
	 * @author wangjs
	 * @date 2017年02月20日
	 * @return
	 */

	@RequestMapping(value = "/checkVerifyCode")
	@ResponseBody
	public Object checkVerifyCodeTx(String phone,String code){
		Map<String,Object> data = new HashMap<String,Object>();
				Subject currentUser = SecurityUtils.getSubject();
				Session session = currentUser.getSession();
			
			String adminCode =	session.getAttribute("adminCode")==null ? "" : session.getAttribute("adminCode").toString();
			String adminphone =	session.getAttribute("adminPhone")==null ? "" : session.getAttribute("adminPhone").toString();
			data.put("phone",phone);
			if(code.equals(adminCode)&&adminphone.equals(phone)){
				data.put("status","0");
				session.setAttribute("checkFlag","0");
			}else{
				data.put("status","1");
			}
 				return data;

	}
	
	
	/**
	 * 修改admin手机号
	 * @param phone
	 * @param code
	 * @param adminInfoId
	 * @author wangjs
	 * @date 2017年02月20日
	 * @return
	 */
	@RequestMapping(value = "/updateAdminPhone")
	@ResponseBody
	public Object updateAdminPhoneTx(){
			return userService.updateAdminPhone(this);
	}
	/**
	 * 
	 * @Title  sendUpdateAdminPhone
	 * @author  wangjs   
	 * @version 3.0 
	 * @param adminInfoId
	 * @param phone
	 * @return Object
	 * @Description 修改验证手机页面跳转
	 * @time 2017年2月27日 下午3:09:51
	 */
	@RequestMapping(value = "/sendUpdateAdminPhone")
	public Object sendUpdateAdminPhone(String adminInfoId,String phone) {
		ModelAndView mv = this.getModelAndView();
		mv.addObject("adminInfoId",adminInfoId);
		mv.addObject("phone",phone);
		mv.setViewName("system/admin/updateadminphone");
		return mv;
	}
}
