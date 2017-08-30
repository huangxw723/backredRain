package com.aoshi.service.manage.integration.goods;

import java.io.ByteArrayInputStream;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsGoodsImgsMapper;
import com.aoshi.dao.AsGoodsMapper;
import com.aoshi.dao.AsProductMapper;
import com.aoshi.domain.AsGoods;
import com.aoshi.domain.AsGoodsImgs;
import com.aoshi.domain.AsProduct;
import com.aoshi.entity.system.User;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;
@Service
public class ProductService {
	@Autowired
	AsProductMapper asProductMapper;
	@Autowired
	AsGoodsMapper asGoodsMapper;
	@Autowired
	AsGoodsImgsMapper asGoodsImgsMapper;

	public int deleteByGoodsId(int goodsId) {
		return asProductMapper.deleteByGoodsId(goodsId);
	}
	
	public int save(AsProduct asProduct) {
		return asProductMapper.insertSelective(asProduct);
	}

	/**
	 * 保存商品属性库存
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param storeStr
	 * @param attrIds
	 * @param goodsId
	 * @param files
	 */
	public void saveStore(String storeStr, String attrIds, int goodsId) {
		JSONArray jsonArray = JSONArray.fromObject(storeStr);
		int goodsStore = 0;
		for(int i=0;i<jsonArray.size();i++){
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			int store = jsonObject.getInt("productStore");
			store = store>0?store:0;
			AsProduct asProduct = new AsProduct();
			if(!"".equals(jsonObject.getString("productId"))){
				asProduct.setProductId(jsonObject.getInt("productId"));
				asProduct.setProductStore(jsonObject.getInt("productStore"));
				asProductMapper.updateByPrimaryKeySelective(asProduct);
			}
			goodsStore = goodsStore+store;
		}
		AsGoods goods = new AsGoods();
		goods.setGoodsId(goodsId);
		goods.setGoodsStore(goodsStore);
		goods.setUpdateTime(DateUtil.getTime());
		goods.setUpdateUser(this.getCurrentUser().getNAME());
		asGoodsMapper.updateByPrimaryKeySelective(goods);
		
		// 保存商品属性有颜色的图片
		if (attrIds != null && !attrIds.equals("null")) {
			JSONArray jsonAttrIds = JSONArray.fromObject(attrIds);
			if (jsonAttrIds.getJSONObject(0) != null
				&& !jsonAttrIds.getJSONObject(0).equals("null")) {
				asGoodsImgsMapper.deleteByGoodsId(goodsId);// 删除之前缩略图
				for (int i = 0; i < jsonAttrIds.size(); i++) {
				JSONObject jsonAttrObject = jsonAttrIds.getJSONObject(i);
				int attrId = jsonAttrObject.getInt("ids");
				if (!"".equals(jsonAttrObject.getString("ids"))) {
						AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
						asGoodsImgs.setGoodsAttrId(attrId);
						asGoodsImgs.setGoodsId(goodsId);
						asGoodsImgsMapper.insertSelective(asGoodsImgs);
						/*
						 * try { if (files.length > 0 && !files[i].isEmpty()) {
						 * goodsAttrImgUpload(goodsId, files[i].getBytes(),
						 * attrId); } else { AsGoodsImgs asGoodsImgs = new
						 * AsGoodsImgs(); asGoodsImgs.setGoodsAttrId(attrId);
						 * asGoodsImgs.setGoodsId(goodsId);
						 * asGoodsImgsMapper.insertSelective(asGoodsImgs); } }
						 * catch (IOException e) { e.printStackTrace(); }
						 */
				}

			}
		}
		}
	}
	
	public List<AsProduct> selectGoodsProduct(int goodsId){
		return asProductMapper.selectGoodsProduct(goodsId);
	}

	/**
	 * 上传商品属性有颜色的缩略图片方法
	 *
	 * @author tgb 创建时间：2016年12月15日
	 * @version 1.0
	 * @param goodsId
	 * @param bytes
	 * @param attrId
	 */
	private void goodsAttrImgUpload(int goodsId, byte[] bytes, int attrId) {
		String ftpFile = UuidUtil.get32UUID() + ".jpg";
		String ftpDir = Const.GOODSFILEPATHIMG;
		// ftp上传商品图片
		boolean flag = ftpUpload(bytes, ftpFile, ftpDir);
		if (flag) {
			AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
			asGoodsImgs.setGoodsAttrId(attrId);
			asGoodsImgs.setGoodsId(goodsId);
			asGoodsImgs.setThumbUrl(bytes.length==0?null:ftpDir + "/" + ftpFile);
			asGoodsImgsMapper.insertSelective(asGoodsImgs);
		}
	}

	/**
	 * 上传ftp
	 * 
	 * @param bytes
	 *            --文件
	 * @param ftpFile
	 *            --图片地址
	 * @param ftpDir
	 *            --ftp路径
	 * @return
	 */
	private boolean ftpUpload(byte[] bytes, String ftpFile, String ftpDir) {
		String path = Const.FILEPATHIMGDIR + ftpDir;
		// byte[] bytes = Base64.decode(goodsImg);

		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			ftpConManager.login(PropertyUtils.getFTP_URL(),
					PropertyUtils.getFTP_USERNAME(),
					PropertyUtils.getFTP_PASS());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(
				bytes), path, ftpFile);
	}

	/**
	 * 获取后台当前用户
	 * 
	 * @author luhuajiang
	 * @return
	 */
	public User getCurrentUser() {
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		return user;
	}
}
