package com.aoshi.service.manage.integration.order;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsShopMapper;
import com.aoshi.domain.AsShop;
import com.aoshi.util.Const;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;

/**
 * 店铺服务类
 */
@Service
public class AsShopService {

	@Autowired
	private AsShopMapper mapper;

	/*
	 * 新增且上传图片
	 */
	public int save(AsShop record, PageData pd) throws Exception {
		List<Map<String, Object>> picMapList = new ArrayList<Map<String, Object>>();
		   Map<String, Object> picMap = new HashMap<String, Object>();
		   Map<String, Object> pic = new HashMap<String, Object>();
		   String ftpDir = Const.FILEPATHIMGDIR + Const.SHOPFILEPATHIMG;
		   String adid = String.valueOf(record.getShopId());
		   int s=0;
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setShopBg(Const.SHOPFILEPATHIMG + "/" + ftpFile);
			picMapList.add(picMap);
		}
		if (StringUtils.isNotBlank(pd.getString("imgt"))) {
			String arr[] = String.valueOf(pd.get("imgt")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFiles = UuidUtil.get32UUID() + ".jpg";
			pic.put("is", new ByteArrayInputStream(bytes));
			pic.put("ftpDir", ftpDir);
			pic.put("ftpFile", ftpFiles);
			record.setShopLogo(Const.SHOPFILEPATHIMG + "/" +ftpFiles);
			picMapList.add(pic);
		}
		    FtpConManager ftpConManager = FtpConManager.getInstance();//ftp实例并上传
		try {
			
			ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
		    ftpConManager.uploadManyFileByInputStream(picMapList, ftpDir);
		    
			
			if(adid!="null"&&!adid.equals(null)&&!adid.equals("")){
				s=mapper.updateByPrimaryKey(record);
			}else{
		        s=mapper.insert(record);
		    }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return s;
	}
	
	/*
	 * 修改并修改图片
	 */
	public int edit(AsShop record, PageData pd) throws Exception {
		String ftpDir = Const.FILEPATHIMGDIR + Const.SHOPFILEPATHIMG;
		String oldPath = record.getShopLogo();
		List<Map<String, Object>> picMapList = new ArrayList<Map<String, Object>>();
		Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setShopBg(Const.SHOPFILEPATHIMG + "/" + ftpFile);
			picMapList.add(picMap);
		}
		String _oldPath = record.getShopBg();
		Map<String, Object> _picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("imgt"))) {
			String arr[] = String.valueOf(pd.get("imgt")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			_picMap.put("is", new ByteArrayInputStream(bytes));
			_picMap.put("ftpDir", ftpDir);
			_picMap.put("ftpFile", ftpFile);
			record.setShopLogo(Const.SHOPFILEPATHIMG + "/" + ftpFile);
			picMapList.add(_picMap);
		}
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			if (picMapList.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
				if (StringUtils.isNotBlank(oldPath)) {
					if (ftpConManager.getFiles(Const.FILEPATHIMGDIR + oldPath).length != 0&&StringUtils.isNotBlank(pd.getString("imgt"))) {
						boolean flag = ftpConManager.removeFile(Const.FILEPATHIMGDIR + oldPath);
						if (!flag) {
							return 0;
						}
					}
				}
				if (StringUtils.isNotBlank(_oldPath)&&StringUtils.isNotBlank(pd.getString("img"))) {
					if (ftpConManager.getFiles(Const.FILEPATHIMGDIR + _oldPath).length != 0) {
						boolean flag = ftpConManager.removeFile(Const.FILEPATHIMGDIR + _oldPath);
						if (!flag) {
							return 0;
						}
					}
				}
				ftpConManager.uploadManyFileByInputStream(picMapList, ftpDir);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return mapper.updateByPrimaryKey(record);
	}
	/*
	 * 修改并修改图片
	 */
	public int edits(AsShop record, PageData pd) throws Exception {
			String oldPath = record.getShopBg();
			Map<String, Object> picMap = new HashMap<String, Object>();
			String adid = String.valueOf(record.getShopId());
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = Const.GOODSTYPEPATHIMG;
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", Const.FILEPATHIMGDIR + ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setShopBg(ftpDir + "/" + ftpFile);
		}
			FtpConManager ftpConManager = FtpConManager.getInstance();
		if (picMap.size() > 0) {
			ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
			if (StringUtils.isNotBlank(oldPath)) {
			if (ftpConManager.getFiles(Const.FILEPATHIMGDIR + oldPath).length != 0) {
			boolean flag = ftpConManager.removeFile(Const.FILEPATHIMGDIR + oldPath);
			if (!flag) {
				return 0;
			}
			}
			}
			InputStream is = (ByteArrayInputStream) picMap.get("is");
			String ftpDir = (String) picMap.get("ftpDir");
			String ftpFile = (String) picMap.get("ftpFile");
			boolean flag = ftpConManager.uploadFileByInputStream(is, ftpDir, ftpFile);
			if (!flag) {
				return 0;
			}
		}
		if(adid!="null"&&!adid.equals(null)&&!adid.equals("")){
			return mapper.updateByPrimaryKey(record);
		}
		return mapper.insert(record);
	}

	/*
	 * 删除
	 */
	public int delete(int goodsTypeId) throws Exception {
		return mapper.deleteByPrimaryKey(goodsTypeId);
	}

	/*
	 * 通过id获取数据
	 */
	public Object findById(AsShop record) throws Exception {
		return mapper.selectByPrimaryKey(record.getShopId());
	}

}
