package com.aoshi.controller.upload;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.core.io.ClassPathResource;

import com.aoshi.common.asenum.ImgTypeEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.UuidUtil;

public class FileUploadServlet extends HttpServlet {

	private static final int UPLOAD_SUCCSSS = 0; // "上传文件成功！",
	private static final int UPLOAD_FAILURE = 1; // "上传文件失败！"),
	private static final int UPLOAD_TYPE_ERROR = 2; // "上传文件类型错误！"),
	private static final int UPLOAD_OVERSIZE = 3; // "上传文件过大！"),
	private static final int UPLOAD_ZEROSIZE = 4; // "上传文件为空！"),
	private static final int UPLOAD_NOTFOUND = 5; // "上传文件路径错误！")

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		String imgName = null;
		String param = request.getParameter("param");
		List list = new ArrayList<>();
	

		// 上传操作
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");
		try {
		List items = upload.parseRequest(request);
		if (null != items) {
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
		if (item.isFormField()) {
				continue;
		} else {
			InputStream imgsInputStream = item.getInputStream();
			ImgTypeEnum action = ImgTypeEnum.fromTypeName(param);
			switch (action) {
			case USERS:
				break;
			case SHOP:
				break;
			case ACTIVITY:
				break;
			case BRAND:
				break;
			case SHOPQRCODEURL:
				break;
			case SHOPMAINPICURL:
				imgName = uploadModule(UploadPathEnum.SHOP,imgsInputStream);
				break;
			case ACTIVITYMEETING:
				break;
			case ACTIVITYREDRAIN:
				break;
			case ACTIVITYREDIMG:
				break;
			case EVENTIMG:
				break;
			case SHOP_IDENTITY_FRONT:
				break;
				
			case SHOP_IDENTITY_BACK:
				break;
			default:
				break;
			}
			list.add(imgName);
		}
		}
		JSONArray result = JSONArray.fromObject(list);
		PrintWriter out1 = null;
		out1 = response.getWriter();
		out1.write(result.toString());
		}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected String uploadModule(UploadPathEnum uploadPathEnum,
			InputStream imgsInputStream) {
		String ftpDir = uploadPathEnum.getRootPath() + uploadPathEnum.getPath();
		String imgName = UuidUtil.get32UUID() + ".jpg";
		FtpConManager ftpConManager = FtpConManager.getInstance();
	 try {

		Properties props = new Properties();
		props.load(new ClassPathResource("dbconfig.properties")
				.getInputStream());
		ftpConManager.login(props.getProperty("FTP_URL"),
				props.getProperty("FTP_USERNAME"),
				props.getProperty("FTP_PASS"));

		InputStream is = imgsInputStream;
		boolean flag = ftpConManager.uploadFileByInputStream(is, ftpDir,
				imgName);
		if (flag) {
			return imgName;
		}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return imgName;
	}

	/**
	 * new文件名= 时间 + 全球唯一编号
	 * 
	 * @param fileName
	 *            old文件名
	 * @return new文件名
	 */
	private String generateFileName(String fileName) {
		String uuid = UUID.randomUUID().toString();
		int position = fileName.lastIndexOf(".");
		String extension = fileName.substring(position);
		return uuid + extension;
	}
	
}