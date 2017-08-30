package com.aoshi.service.base;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.codec.Base64;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsBaseMapper;
import com.aoshi.domain.AsUser;
import com.aoshi.entity.R;
import com.aoshi.entity.system.User;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import org.springframework.core.io.ClassPathResource;

/**
 * BaseService
 * 
 * @author yangyanchao
 * @date 2016年6月27日
 */
public class AsBaseService {

	protected Logger logger = Logger.getLogger(this.getClass());

	protected BaseController c;
	protected PageData pd;
	protected HttpServletRequest req;

	// 数据库操作标识
	protected boolean operaFlag;

	/**
	 * 用户初始化 Controller 和 PageData
	 * 
	 * @author yangyanchao
	 * @date 2016年6月27日
	 * @param c
	 */
	public void initialized(BaseController c) {
		this.c = c;
		c.initialized();
		pd = c.pd;
		req = c.getRequest();
	}

	/**
	 * 获取32位 UUID
	 * 
	 * @author yangyanchao
	 * @date 2016年9月1日
	 * @return
	 */
	public String get32UUID() {
		return c.get32UUID();
	}

	/**
	 * 获取当前登录用户
	 * 
	 * @author yangyanchao
	 * @date 2016年7月8日
	 * @return
	 */
	protected User getUser() {
		return c.getCurrentUser();
	}

	/**
	 * 给PageData容器添加元素
	 * 
	 * @author yangyanchao
	 * @date 2016年7月14日
	 * @param k
	 * @param v
	 * @return
	 */
	public BaseController addField(String k, Object v) {
		return c.addField(k, v);
	}

	/**
	 * 删除PageData容器指定元素
	 * 
	 * @author yangyanchao
	 * @date 2016年7月14日
	 * @param k
	 * @return
	 */
	public BaseController removeField(String k) {
		return c.removeField(k);
	}

	/**
	 * 获取PageData指定值
	 * 
	 * @author yangyanchao
	 * @date 2016年7月20日
	 * @param k
	 *            键
	 * @return
	 */
	public Object getField(String k) {
		return c.getField(k);
	}

    /**
     * 多字段
     *
     * @author yangyanchao
     * @date 2017-03-02
     * @param uploadPathEnum 路径
     * @param colNames 数据库对应字段名
     */
	protected void uploadModule(UploadPathEnum uploadPathEnum,
			String... colNames) {

		for (String colName : colNames) {
			Map<String, Object> picMap = new HashMap<String, Object>();
			if (StringUtils.isNotBlank(req.getParameter("img"))) {
				String arr[] = String.valueOf(pd.get("img")).split(",");
				byte[] bytes = Base64.decode(arr[1]);
				String ftpDir = uploadPathEnum.getRootPath()
						+ uploadPathEnum.getPath();
				String ftpFile = c.get32UUID() + ".jpg";
				picMap.put("is", new ByteArrayInputStream(bytes));
				picMap.put("ftpDir", ftpDir);
				picMap.put("ftpFile", ftpFile);
				pd.put(colName,
						uploadPathEnum.getPath() + "/"
						+ picMap.get("ftpFile"));
			}

			if (picMap.size() > 0) {
				FtpConManager ftpConManager = FtpConManager.getInstance();
				try {

                    Properties props = new Properties();
                    props.load(new ClassPathResource("dbconfig.properties").getInputStream());
					ftpConManager.login(props.getProperty("FTP_URL"),
                            props.getProperty("FTP_USERNAME"),
                            props.getProperty("FTP_PASS"));

					InputStream is = (ByteArrayInputStream) picMap.get("is");
					String ftpDir = (String) picMap.get("ftpDir");
					String ftpFile = (String) picMap.get("ftpFile");
					boolean flag = ftpConManager.uploadFileByInputStream(is,
							ftpDir, ftpFile);
					if (!flag) {
						logger.debug("upload failed");
					}

					String uploadLogStr = "图片上传 : 字段[%s] 与 [%s] 已绑定 ";
					logger.debug(String.format(
							uploadLogStr,
							colName,
							picMap.get("ftpDir") + "/"
									+ picMap.get("ftpFile")));

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					ftpConManager.closeCon();
				}
			}
		}
	}
	
	/**
	 * 上传图片模块
	 * 
	 * @author huangxw
	 * @date 2016年9月2日
	 * @param v
	 *            对应的图片数组下标
	 * @param uploadPathEnum
	 *            对应类型路径
	 */
	protected void uploadModule1(UploadPathEnum uploadPathEnum, int v) {


			
			String colNam="img";
			Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString(colNam + v))) {
			String arr[] = String.valueOf(pd.getString(colNam + v)).split(",");
				byte[] bytes = Base64.decode(arr[1]);
				String ftpDir = uploadPathEnum.getRootPath()
						+ uploadPathEnum.getPath();
				String ftpFile = c.get32UUID() + ".jpg";
				picMap.put("is", new ByteArrayInputStream(bytes));
				picMap.put("ftpDir", ftpDir);
				picMap.put("ftpFile", ftpFile);
			pd.put(colNam + v,
						uploadPathEnum.getPath() + "/"
						+ picMap.get("ftpFile"));
			}

			if (picMap.size() > 0) {
				FtpConManager ftpConManager = FtpConManager.getInstance();
				try {

                    Properties props = new Properties();
                    props.load(new ClassPathResource("dbconfig.properties").getInputStream());
                    ftpConManager.login(props.getProperty("FTP_URL"),
                            props.getProperty("FTP_USERNAME"),
                            props.getProperty("FTP_PASS"));

					InputStream is = (ByteArrayInputStream) picMap.get("is");
					String ftpDir = (String) picMap.get("ftpDir");
					String ftpFile = (String) picMap.get("ftpFile");
					boolean flag = ftpConManager.uploadFileByInputStream(is,
							ftpDir, ftpFile);
				String uploadLogStr = "图片上传 : 字段[%s] 与 [%s] 已绑定 ";
					if (!flag) {
						logger.debug("upload failed");
					}

					logger.debug(String.format(
							uploadLogStr,
							colNam+v,
							picMap.get("ftpDir") + "/"
									+ picMap.get("ftpFile")));
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					ftpConManager.closeCon();
				}
		}

	}
	
	/**
	 * 通用图片上传,非指定表字段
	 * 
	 * @author yangyanchao
	 * @date 2016年7月18日
	 * @param uploadPathEnum
	 *            FTP上传分类路径
	 * @return
	 */
	protected String uploadModule(UploadPathEnum uploadPathEnum) {

		Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(req.getParameter("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = uploadPathEnum.getRootPath()
					+ uploadPathEnum.getPath();
			String ftpFile = c.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", ftpDir);
			picMap.put("ftpFile", ftpFile);
			picMap.put("ftpPath",
					uploadPathEnum.getPath() + "/"
					+ picMap.get("ftpFile"));
		}

		if (picMap.size() > 0) {
			FtpConManager ftpConManager = FtpConManager.getInstance();
			try {

                Properties props = new Properties();
                props.load(new ClassPathResource("dbconfig.properties").getInputStream());
                ftpConManager.login(props.getProperty("FTP_URL"),
                        props.getProperty("FTP_USERNAME"),
                        props.getProperty("FTP_PASS"));

				ftpConManager.login(PropertyUtils.getFTP_URL(),
						PropertyUtils.getFTP_USERNAME(),
						PropertyUtils.getFTP_PASS());

				InputStream is = (ByteArrayInputStream) picMap.get("is");
				String ftpDir = (String) picMap.get("ftpDir");
				String ftpFile = (String) picMap.get("ftpFile");
				boolean flag = ftpConManager.uploadFileByInputStream(is,
						ftpDir, ftpFile);
				if (!flag) {
					logger.debug("upload failed");
				}

				String uploadLogStr = "图片上传 : [%s] ";
				logger.debug(String.format(uploadLogStr, picMap.get("ftpPath")));

				return picMap.get("ftpPath").toString();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				ftpConManager.closeCon();
			}
		}

		return "";
	}

	/**
	 * 基础通用查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月27日
	 * @param dao
	 *            模块DAO
	 */
	protected void pageQueryModule(AsBaseMapper dao) {
		this.pageQueryModule(dao, "select_all", true);
	}

	/**
	 * 分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年7月22日
	 * @param dao
	 * @param methodName
	 * @param isBindPageInfo
	 *            是否绑定到ModelAndView
	 * @return
	 */
	protected List<Object> pageQueryModule(AsBaseMapper dao, String methodName,
			boolean isBindPageInfo) {
		return c.pageQueryModule(dao, methodName, isBindPageInfo);
	}

	/**
	 * 分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年7月22日
	 * @param dao
	 * @param methodName
	 * @param isBindPageInfo
	 *            是否绑定到ModelAndView
	 * @param conditions
	 *            自定义Where条件
	 * @return
	 */
	protected List<Object> pageQueryModule(AsBaseMapper dao, String methodName,
			boolean isBindPageInfo, Map<Object, Object> conditions) {
		return c.pageQueryModule(dao, methodName, isBindPageInfo, conditions);
	}

	/**
	 * 非分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月28日
	 * @param dao
	 *            模块DAO
	 */
	protected List<Object> queryModule(AsBaseMapper dao) {
		return this.queryModule(dao, "select_all", true);
	}

	/**
	 * 通用非分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月29日
	 * @param dao
	 * @param methodName
	 *            方法名
	 * @param isBindPageInfo
	 *            是否把信息绑定到ModelAndView
	 */
	protected List<Object> queryModule(AsBaseMapper dao, String methodName,
			boolean isBindPageInfo) {
		return c.queryModule(dao, methodName, isBindPageInfo);
	}

	/**
	 * 通用非分页查询
	 * 
	 * @author yangyanchao
	 * @date 2016年6月29日
	 * @param dao
	 * @param methodName
	 *            方法名
	 * @param isBindPageInfo
	 *            是否把信息绑定到ModelAndView
	 * @param conditions
	 *            自定义Where条件
	 */
	protected List<Object> queryModule(AsBaseMapper dao, String methodName,
			boolean isBindPageInfo, Map<Object, Object> conditions) {
		return c.queryModule(dao, methodName, isBindPageInfo, conditions);
	}

	/**
	 * 重置分页信息
	 * 
	 * @author yangyanchao
	 * @date 2016年10月24日
	 * @param list
	 */
	protected void resetPageInfo(List<Object> list, int counts) {
		c.resetPageInfo(list, counts);
	}

	/**
	 * 添加视图数据
	 * 
	 * @author yangyanchao
	 * @date 2016年7月22日
	 * @param key
	 *            键
	 * @param value
	 *            值
	 * @return
	 */
	public BaseController addViewData(String key, Object value) {
		return c.addViewData(key, value);
	}
	
	/**
	 * 判断是否是最高管理员用户
	 * 
	 * @author huangxw
	 * @date 2017年04月19日
	 * @return
	 */
	protected boolean isAdmin() {
		return c.isAdmin();
	}
	
	/**
	 * 判断是否是管理员用户
	 * 
	 * @author huangxw
	 * @date 2017年04月19日
	 * @return
	 */
	protected boolean isRoomAdmin() {
		return c.isRoomAdmin();
	}

	protected Object renderView(String viewName) {
		return c.renderView(viewName);
	}

	public Object renderSuccess() {
		return renderSuccess(0);
	}

	public Object renderSuccess(R iR) {
		return renderSuccess(0, iR);
	}

	public Object renderSuccess(int msgType) {
		return c.renderSuccess(msgType);
	}

	public Object renderSuccess(int msgType, R iR) {
		return c.renderSuccess(msgType, iR);
	}

	public String getUserName(AsUser asUser) {

		String name = asUser.getAccount();
		if (StringUtils.isNotBlank(name)) {
			return name;
		}
		return name;
	}
}