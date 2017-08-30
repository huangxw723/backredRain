package com.aoshi.service.manage;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsGoodsTypeMapper;
import com.aoshi.dao.AsTypeRelationMapper;
import com.aoshi.domain.AsGoodsType;
import com.aoshi.util.Const;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;

/**
 * 商品类型服务类
 */
@Service
public class GoodsTypeService {

	@Autowired
	private AsGoodsTypeMapper mapper;

	@Autowired
	private AsTypeRelationMapper typeRelationMapper;

	/*
	 * 新增且上传图片
	 */
	public int save(AsGoodsType record, PageData pd) throws Exception {
		Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = Const.GOODSTYPEPATHIMG;
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", Const.FILEPATHIMGDIR + ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setTypeImg(ftpDir + "/" + ftpFile);
		}
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			if (picMap.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
				InputStream is = (ByteArrayInputStream) picMap.get("is");
				String ftpDir = (String) picMap.get("ftpDir");
				String ftpFile = (String) picMap.get("ftpFile");
				boolean flag = ftpConManager.uploadFileByInputStream(is, ftpDir, ftpFile);
				if (!flag) {
					return 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return mapper.insert(record);
	}

	/*
	 * 修改并修改图片
	 */
	public int edit(AsGoodsType record, PageData pd) throws Exception {
		String oldPath = record.getTypeImg();
		Map<String, Object> picMap = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = Const.GOODSTYPEPATHIMG;
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", Const.FILEPATHIMGDIR + ftpDir);
			picMap.put("ftpFile", ftpFile);
			record.setTypeImg(ftpDir + "/" + ftpFile);
		}
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return mapper.updateByPrimaryKeySelective(record);
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
	public AsGoodsType findById(AsGoodsType record) throws Exception {
		return mapper.selectByPrimaryKey(record.getGoodsTypeId());
	}

	/*
	 * 列表(不分页)
	 */
	public List<AsGoodsType> listAll() throws Exception {
		return mapper.selectAll();
	}

	/*
	 * 获取子数据
	 */
	public List<AsGoodsType> findChildren(PageData pd) throws Exception {
		return mapper.selectByParent(pd);
	}

	/**
	 * 删除分类前，判断商品分类是否被使用
	 *
	 * @author tgb 创建时间：2016年12月15日
	 * @version 1.0
	 * @param goodsTypeId
	 * @return
	 */
	public int getTypeRelation(Integer goodsTypeId) {
		return typeRelationMapper.existTypeRelation(goodsTypeId);
	}

}
