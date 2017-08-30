package com.aoshi.service.manage.locality;

import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.domain.AsStore;
import com.aoshi.util.*;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AsStoreService {

	@Autowired
	private AsStoreMapper mapper;

	@Autowired
	private AsShopMapper asShopMapper;

	public List<AsStore> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 新增
	 */
	public int save(AsStore record, PageData pd) {
		String ftpDir = Const.FILEPATHIMGDIR + Const.STOREFILEPATHIMG;
		List<Map<String, Object>> picMapList = new ArrayList<Map<String, Object>>();
		Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setLogoUrl(Const.STOREFILEPATHIMG + "/" + ftpFile);
			picMapList.add(picMap);
		}
		Map<String, Object> _picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("_img"))) {
			String arr[] = String.valueOf(pd.get("_img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			_picMap.put("is", new ByteArrayInputStream(bytes));
			_picMap.put("ftpDir", ftpDir);
			_picMap.put("ftpFile", ftpFile);
			record.setQrCodeUrl(Const.STOREFILEPATHIMG + "/" + ftpFile);
			picMapList.add(_picMap);
		}
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			if (picMapList.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
				ftpConManager.uploadManyFileByInputStream(picMapList, ftpDir);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return mapper.insert(record);
	}

	/*
	 * 修改
	 */
	public int edit(AsStore record, PageData pd) {
		String ftpDir = Const.FILEPATHIMGDIR + Const.STOREFILEPATHIMG;
		String oldPath = record.getLogoUrl();
		List<Map<String, Object>> picMapList = new ArrayList<Map<String, Object>>();
		Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setLogoUrl(Const.STOREFILEPATHIMG + "/" + ftpFile);
			picMapList.add(picMap);
		}
		String _oldPath = record.getQrCodeUrl();
		Map<String, Object> _picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("_img"))) {
			String arr[] = String.valueOf(pd.get("_img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			_picMap.put("is", new ByteArrayInputStream(bytes));
			_picMap.put("ftpDir", ftpDir);
			_picMap.put("ftpFile", ftpFile);
			record.setQrCodeUrl(Const.STOREFILEPATHIMG + "/" + ftpFile);
			picMapList.add(_picMap);
		}
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			if (picMapList.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
				if (StringUtils.isNotBlank(oldPath)) {
					if (ftpConManager.getFiles(Const.FILEPATHIMGDIR + oldPath).length != 0) {
						boolean flag = ftpConManager.removeFile(Const.FILEPATHIMGDIR + oldPath);
						if (!flag) {
							return 0;
						}
					}
				}
				if (StringUtils.isNotBlank(_oldPath)) {
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
		int result = mapper.updateByPrimaryKeySelective(record) ;
		//更新商场的商户账号信息
		if (result==1){
			Map<String,Object> data = new HashMap<>();
			data.put("storeId",record.getStoreId());
			data.put("businessDistrictId",record.getBusinessDistrictId());
			data.put("name",record.getName());
			data.put("address",record.getAddress());
			data.put("lat",record.getLat());
			data.put("lng",record.getLng());
			result = asShopMapper.updateShopByStoreId(data);
			if(result==1){
				result = asShopMapper.updateShopOwnerInfoByStoreId(data);
			}
		}
		return result ;
	}

	/*
	 * 删除
	 */
	public int delete(int businessDistrictId) {
		return mapper.deleteByPrimaryKey(businessDistrictId);
	}

	/*
	 * 批量删除
	 */
	public int deleteAll(String[] businessDistrictIds) {
		return mapper.deleteByPrimaryKeys(businessDistrictIds);
	}

	/*
	 * 通过id获取数据
	 */
	public AsStore findById(AsStore record) {
		return mapper.selectByPrimaryKey(record.getStoreId());
	}
	
	
	public List<AsStore> queryList() {
		return mapper.queryList();
	}

	/**
	 * 需要的战略合作伙伴
	 * @param pageData
	 * @return
	 */
    public List<AsStore> needToAddCooperation(PageData pageData) {

    	return mapper.selectByNoAddCooperation(pageData);
    }
}
