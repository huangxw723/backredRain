package com.aoshi.service.manage.yp;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsYpTemplateMapper;
import com.aoshi.domain.AsYpTemplate;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.FileUtil;

/**
 * 后台模板管理
 * 
 * @author yangyanchao
 * @date 2016年11月10日
 */
@Service
public class TemplateAdminService extends AsBaseService {

	@Autowired
	private AsYpTemplateMapper asYpTemplateMapper;

	/**
	 * 模板包上传
	 * 
	 * @author yangyanchao
	 * @date 2016年11月10日
	 * @param c
	 * @return
	 */
	public Object uploadTemplatePackage_Tx(BaseController c) {

		initialized(c);

		// 获取项目根路径
		String contextPath = req.getSession().getServletContext()
				.getRealPath("/");

		// 定义资源目录路径
		String resourcePath = "static/template/";
		String dirPath = contextPath + resourcePath;

		// 定义JSP目录路径
		String jspPath = contextPath + "WEB-INF/jsp/manage/yp/template/";

		// 创建模板空间文件夹
		File dir = new File(dirPath);
		if (!dir.exists()) {
			boolean operaFlag = dir.mkdirs();
			ValidatorBreakException.NOT_TRUE(operaFlag);
			logger.debug(String.format("成功创建模板文件夹 [%s]", dir.getAbsolutePath()));
		}

		// 解压缩
		String arr[] = String.valueOf(pd.get("img")).split(",");
		byte[] bytes = Base64.decode(arr[1]);
		Conditions templateInfo = decompress(new ByteArrayInputStream(bytes),
				dirPath, jspPath);

		// 添加模板记录
		AsYpTemplate template = new AsYpTemplate();
		template.setAdminId(getUser().getNewUserId());
		template.setCreateTime(CommonUtils.getCurDate());
		template.setIsHome(0);
		template.setName(templateInfo.getStr("templateName"));
		template.setPath(templateInfo.getStr("jspName"));
		template.setStatus(0);
		template.setPreview(templateInfo.getStr("preview"));
		operaFlag = asYpTemplateMapper.insertSelective(template) == 1;
		/*
		 * if (!operaFlag) { FileUtil.deleteDir(templateInfo.getStr("rootDir"));
		 * FileUtil.deleteDir(jspPath + templateInfo.getStr("jspDir")); }
		 */
		ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();

	}

	/**
	 * 解压缩
	 * 
	 * @author yangyanchao
	 * @date 2016年11月10日
	 * @param is
	 *            文件流
	 * @param decompressPath
	 *            解压路径
	 */
	private Conditions decompress(InputStream is, String commonDestPath,
			String jspDestPath) {

		int BUFFER = 1024 * 4;
		ZipInputStream zis = null;

		String rootDir = null;
		String jspName = "";
		String jspDir = "";
		String templateName = null;
		String preview = "";
		boolean checkFile = false;

		try {

			zis = new ZipInputStream(new BufferedInputStream(is));

			ZipEntry entry;

			int times = 1;
			while ((entry = zis.getNextEntry()) != null) {

				// 文件资源名称
				String entryName = entry.getName();

				// 一般文件
				String newEntryName = commonDestPath + entryName;
				// jsp文件
				String jspEntryName = jspDestPath + entryName;

				// 当上传过程异常时,删除根目录
				if (times == 1) {

					rootDir = newEntryName;
					templateName = entryName.replace("/", "");
					Object templateRecord = asYpTemplateMapper
							.findByName(templateName);
					ValidatorBreakException.NOT_TRUE(templateRecord == null,
							"该模板名已存在");

					jspDir = jspDestPath + File.separator + entryName;

					// 同名模板,删除之前的文件夹
					if (new File(rootDir).exists()) {
						FileUtil.deleteDir(rootDir);
					}
				}

				// 判断当前文件上一级文件夹是否存在
				/*
				 * File parentFile = new File(newEntryName).getParentFile(); if
				 * (!parentFile.exists()) { boolean operaFlag =
				 * parentFile.mkdirs();
				 * ValidatorBreakException.NOT_TRUE(operaFlag, "创建父文件夹失败 # " +
				 * parentFile.getAbsolutePath()); }
				 */

				if (!entry.isDirectory()) {

					FileOutputStream fos = null;
					if (entryName.lastIndexOf(".jsp") >= 0) {

						if (new File(jspEntryName).exists()) {
							FileUtil.deleteDir(jspEntryName);
						}
						jspName = entryName.substring(
								entryName.lastIndexOf("/") + 1,
								entryName.lastIndexOf(".jsp"));

						File jspDirPath = new File(jspDir);
						if (jspDirPath.exists()) {
							FileUtil.deleteDir(jspDirPath.getAbsolutePath());
						}
						boolean operaFlag = jspDirPath.mkdirs();
						ValidatorBreakException.NOT_TRUE(operaFlag,
								"创建模板JSP文件失败");

						fos = new FileOutputStream(jspEntryName);
					} else {

						String fileName = entryName.substring(entryName
								.lastIndexOf("/") + 1);
						if (fileName.equals("preview.png")
								|| fileName.equals("preview.jpg")
								|| fileName.equals("preview.jpeg")) {
							preview = "static/template/" + entryName;
						}
						fos = new FileOutputStream(newEntryName);
					}

					BufferedOutputStream dest = new BufferedOutputStream(fos,
							BUFFER);

					int count;
					byte data[] = new byte[BUFFER];
					while ((count = zis.read(data, 0, BUFFER)) != -1) {
						dest.write(data, 0, count);
					}
					dest.flush();
					dest.close();
				} else {
					boolean operaFlag = new File(newEntryName).mkdirs();
					ValidatorBreakException.NOT_TRUE(operaFlag, "解压文件失败 # "
							+ newEntryName);
				}

				logger.debug("压缩文件成功 # " + newEntryName);
				times++;
				checkFile = true;
			}

			zis.close();
			logger.debug("总处理文件 " + times + " 个");

		} catch (Exception e) {

			e.printStackTrace();
			// FileUtil.deleteDir(rootDir);
			// FileUtil.deleteDir(jspDir);
			ValidatorBreakException.NOT_NULL(null, e.getMessage());
		}

		ValidatorBreakException.NOT_TRUE(checkFile, "文件错误");

		return Conditions.newInstance().putData("rootDir", rootDir)
				.putData("jspName", jspName).putData("jspDir", jspDir)
				.putData("templateName", templateName)
				.putData("preview", preview);
	}
}
