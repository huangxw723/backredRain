package com.aoshi.service.manage.integration.goods;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.codec.Base64;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.dao.AsAttrTypeMapper;
import com.aoshi.dao.AsAttributeMapper;
import com.aoshi.dao.AsGoodsAttrMapper;
import com.aoshi.dao.AsGoodsImgsMapper;
import com.aoshi.dao.AsGoodsMapper;
import com.aoshi.dao.AsGoodsTypeMapper;
import com.aoshi.dao.AsProductMapper;
import com.aoshi.dao.AsTypeRelationMapper;
import com.aoshi.domain.AsGoods;
import com.aoshi.domain.AsGoodsAttr;
import com.aoshi.domain.AsGoodsImgs;
import com.aoshi.domain.AsGoodsType;
import com.aoshi.domain.AsProduct;
import com.aoshi.domain.AsTypeRelation;
import com.aoshi.entity.system.User;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;

@Service
@Transactional
public class GoodsService {
	@Autowired
	AsGoodsMapper<AsGoods> asGoodsMapper;
	@Autowired
	AsGoodsTypeMapper asGoodsTypeMapper;
	@Autowired
	AsGoodsImgsMapper asGoodsImgsMapper;
	@Autowired
	AsTypeRelationMapper asTypeRelationMapper;
	@Autowired
	AsGoodsAttrMapper asGoodsAttrMapper;
	@Autowired
	ProductService productService;
	@Autowired
	AsAttrTypeMapper asAttrTypeMapper;
	@Autowired
	AsAttributeMapper asAttributeMapper;
	@Autowired
	AsProductMapper asProductMapper;

	/**
	 * 获取商品列表
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param params
	 * @return
	 */
	public List<AsGoods> getGoodsList(Map<String, Object> params) {
		return asGoodsMapper.getGoodsList(params);
	}

	/**
	 * 获取商品分类树
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @return
	 */
	public List<AsGoodsType> selectGoodsTypeTree() {
		List<AsGoodsType> goodsTypes = asGoodsTypeMapper.selectByLevel(0);
		return this.getChildren(goodsTypes);
	}

	/**
	 * 获取商品分类树的子节点
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsTypes
	 * @return
	 */
	private List<AsGoodsType> getChildren(List<AsGoodsType> goodsTypes) {
		for (AsGoodsType goodsType : goodsTypes) {
			// 是否打开分类框
			goodsType.setOpen(false);
			// 禁用0级1级分类
			/*
			 * if (!goodsType.getTypeLevel().equals(2)) {
			 * goodsType.setChkDisabled(true);
			 * 
			 * }
			 */
			List<AsGoodsType> asGoodsTypes = asGoodsTypeMapper
					.getChildren(goodsType.getGoodsTypeId());
			if (asGoodsTypes.size() > 0) {
				goodsType.setChildren(asGoodsTypes);
				this.getChildren(asGoodsTypes);
			}

		}
		return goodsTypes;
	}

	/**
	 * 检查商品名字是否重复
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsName
	 * @return
	 */
	public Map<String, Boolean> checkExist(String goodsName) {
		Map<String, Boolean> map = new HashMap<>();
		int data = asGoodsMapper.findByGoodsName(goodsName);
		if (data > 0) {
			map.put("isExist", true);
		}
		return map;
	}

	/**
	 * 检查商品货号是否重复
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsSn
	 * @return
	 */
	public Map<String, Boolean> checkExistSn(String goodsSn) {
		Map<String, Boolean> map = new HashMap<>();
		int data = asGoodsMapper.findByGoodsSn(goodsSn);
		if (data > 0) {
			map.put("isExist", true);
		}
		return map;
	}

	/**
	 * 保存商品
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param asGoods
	 *            商品对象
	 * @param goodsTypeStr
	 *            商品分类id的json格式数组
	 * @param pd
	 * @return
	 */
	public AsGoods save(AsGoods asGoods, String goodsTypeStr, PageData pd) {
		Map<String, Object> picMap = new HashMap<String, Object>();
		// 上传商品主图
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = Const.GOODSFILEPATHIMG;
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", Const.FILEPATHIMGDIR + ftpDir);
			picMap.put("ftpFile", ftpFile);
			asGoods.setGoodsImg(ftpDir + "/" + ftpFile);
			asGoods.setGoodsThumb(ftpDir + "/" + ftpFile);
		}

		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			if (picMap.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(),
						PropertyUtils.getFTP_USERNAME(),
						PropertyUtils.getFTP_PASS());
				InputStream is = (ByteArrayInputStream) picMap.get("is");
				String ftpDir = (String) picMap.get("ftpDir");
				String ftpFile = (String) picMap.get("ftpFile");
				ftpConManager.uploadFileByInputStream(is, ftpDir, ftpFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}

		// 设置商品常规数据
		asGoods.setIsDelete(0);
		asGoods.setIsOnSale(1);
		asGoods.setGoodsType(2);
		asGoods.setSalesCount(0);
		asGoods.setCreateTime(DateUtil.getTime());
		asGoods.setCreateUser(this.getCurrentUser().getNAME());

		int result = asGoodsMapper.insertSelective(asGoods);

		// 上传单张商品图片
		Map<String, Object> picMap1 = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(pd.getString("img1"))) {
			String arr[] = String.valueOf(pd.get("img1")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = Const.GOODSFILEPATHIMG;
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap1.put("is1", new ByteArrayInputStream(bytes));
			picMap1.put("ftpDir1", Const.FILEPATHIMGDIR + ftpDir);
			picMap1.put("ftpFile1", ftpFile);
			AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
			asGoodsImgs.setGoodsId(asGoods.getGoodsId());
			asGoodsImgs.setImgUrl(ftpDir + "/" + ftpFile);
			asGoodsImgsMapper.insertSelective(asGoodsImgs);
		}
		try {
			if (picMap1.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(),
						PropertyUtils.getFTP_USERNAME(),
						PropertyUtils.getFTP_PASS());
				InputStream is = (ByteArrayInputStream) picMap1.get("is1");
				String ftpDir = (String) picMap1.get("ftpDir1");
				String ftpFile = (String) picMap1.get("ftpFile1");
				ftpConManager.uploadFileByInputStream(is, ftpDir, ftpFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		// 添加数据商品分类关联表
		if (result > 0) {
			JSONArray jsonArray = JSONArray.fromObject(goodsTypeStr);
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				Integer goodsTypeId = jsonObject.getInt("goodsTypeId");
				int data = asGoodsTypeMapper.getgoodsTypeLevel(goodsTypeId);
				if (data > 0) {
					AsTypeRelation relation = new AsTypeRelation();
					relation.setGoodsTypeId(goodsTypeId);
					relation.setGoodsId(asGoods.getGoodsId());
					asTypeRelationMapper.insertSelective(relation);
				}
			}
		}
		return asGoods;
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
	 * 查找到需要修改的商品
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 * @return
	 */
	public AsGoods findByGoodsId(int goodsId) {
		return asGoodsMapper.selectByPrimaryKey(goodsId);
	}

	/**
	 * 查找到修改的商品的分类关联集合
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 * @return
	 */
	public List<AsTypeRelation> getRelationsByGoodsId(int goodsId) {
		return asTypeRelationMapper.getRelationsByGoodsId(goodsId);
	}

	/**
	 * 保存被编辑后的商品
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param asGoods
	 * @param goodsType
	 * @param pd
	 * @return
	 */
	public int editGoods(AsGoods asGoods, String goodsType, PageData pd) {
		Map<String, Object> picMap = new HashMap<String, Object>();
		// 上传商品图片
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			String ftpDir = Const.GOODSFILEPATHIMG;
			String ftpFile = UuidUtil.get32UUID() + ".jpg";
			picMap.put("is", new ByteArrayInputStream(bytes));
			picMap.put("ftpDir", Const.FILEPATHIMGDIR + ftpDir);
			picMap.put("ftpFile", ftpFile);
			asGoods.setGoodsImg(ftpDir + "/" + ftpFile);
			asGoods.setGoodsThumb(ftpDir + "/" + ftpFile);
		} else {
			AsGoods oldAsGoods = asGoodsMapper.selectByPrimaryKey(asGoods
					.getGoodsId());
			asGoods.setGoodsImg(oldAsGoods.getGoodsImg());
			asGoods.setGoodsThumb(oldAsGoods.getGoodsThumb());
		}
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			if (picMap.size() > 0) {
				ftpConManager.login(PropertyUtils.getFTP_URL(),
						PropertyUtils.getFTP_USERNAME(),
						PropertyUtils.getFTP_PASS());
				InputStream is = (ByteArrayInputStream) picMap.get("is");
				String ftpDir = (String) picMap.get("ftpDir");
				String ftpFile = (String) picMap.get("ftpFile");
				ftpConManager.uploadFileByInputStream(is, ftpDir, ftpFile);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		asGoods.setUpdateUser(this.getCurrentUser().getNAME());
		asGoods.setUpdateTime(DateUtil.getTime());
		// 保存商品
		int result = asGoodsMapper.updateByPrimaryKeySelective(asGoods);
		if (result > 0) {
			List<AsTypeRelation> relations = asTypeRelationMapper
					.getRelationsByGoodsId(asGoods.getGoodsId());
			if (relations.size() > 0) {
				asTypeRelationMapper.deleteByGoodsId(asGoods.getGoodsId());
			}
			JSONArray jsonArray = JSONArray.fromObject(goodsType);

			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				Integer goodsTypeId = jsonObject.getInt("goodsTypeId");
				int data = asGoodsTypeMapper.getgoodsTypeLevel(goodsTypeId);
				if (data > 0) {
					AsTypeRelation relation = new AsTypeRelation();
					relation.setGoodsTypeId(goodsTypeId);
					relation.setGoodsId(asGoods.getGoodsId());
					asTypeRelationMapper.insertSelective(relation);
				}
			}

		}

		return 1;

	}

	/**
	 * 查看商品的属性值
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 * @return
	 */
	public List<List<AsGoodsAttr>> reviewGoodsAttr(int goodsId) {
		List<AsGoodsAttr> attrs = asGoodsAttrMapper.selectByGoodsId(goodsId);
		MultiValueMap<Integer, AsGoodsAttr> multiValueMap = new LinkedMultiValueMap<>();
		for (AsGoodsAttr attr : attrs) {
			multiValueMap.add(attr.getAttributeId(), attr);
		}

		// 分组
		List<List<AsGoodsAttr>> list = new ArrayList<List<AsGoodsAttr>>();
		for (Map.Entry<Integer, List<AsGoodsAttr>> entry : multiValueMap
				.entrySet()) {
			// String key = entry.getKey();
			List<AsGoodsAttr> values = entry.getValue();
			list.add(values);
		}

		return list;
	}

	/**
	 * 
	 * @param attrStr
	 *            attrStr： [ {attrName:"颜色",attrValue:"红色",attributeId:1},
	 *            {attrName:"颜色",attrValue:"白色",attributeId:1}
	 *            {attrName:"尺寸",attrValue:"中码",attributeId:2} ]
	 * @param goodsId
	 * @return
	 */
	public List<AsProduct> saveGoodsAttr(String attrStr, int goodsId) {
		JSONArray jsonArray = JSONArray.fromObject(attrStr);
		List<AsGoodsAttr> goodsAttrs = new ArrayList<AsGoodsAttr>();

		// 清除旧的商品属性和库存、总库存 属性缩略图片
		asGoodsAttrMapper.deleteByGoodsId(goodsId);
		productService.deleteByGoodsId(goodsId);
		asGoodsMapper.updateGoodsStore(goodsId);
		asGoodsImgsMapper.deleteByGoodsId(goodsId);
		this.updateGoodsWithTimeAndUser(goodsId);// 记录当前操作的用户

		// 保存商品的属性值
		for (int i = 0; i < jsonArray.size(); i++) {
			AsGoodsAttr goodsAttr = new AsGoodsAttr();
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			goodsAttr.setAttributeId(Integer.valueOf(jsonObject.get(
					"attributeId").toString()));
			goodsAttr.setGoodsId(goodsId);
			goodsAttr.setAttrValue(jsonObject.get("attrValue").toString());
			goodsAttr.setAttrName(jsonObject.get("attrName").toString());
			asGoodsAttrMapper.insertSelective(goodsAttr);
			goodsAttrs.add(goodsAttr);
		}
		// 保存商品的属性值是颜色的缩略图图片id
		List<AsGoodsAttr> asGoodsAttrs = asGoodsAttrMapper
				.findByGoodsIdWithAttr(goodsId);
		if (!asGoodsAttrs.isEmpty()) {
			for (AsGoodsAttr asGoodsAttr : asGoodsAttrs) {
				AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
				asGoodsImgs.setGoodsId(goodsId);
				asGoodsImgs.setGoodsAttrId(asGoodsAttr.getGoodsAttrId());
				asGoodsImgsMapper.insertSelective(asGoodsImgs);
			}
		}

		// 分组
		MultiValueMap<String, AsGoodsAttr> multiValueMap = new LinkedMultiValueMap<String, AsGoodsAttr>();
		for (AsGoodsAttr goodsAttr : goodsAttrs) {
			multiValueMap.add(goodsAttr.getAttributeId().toString(), goodsAttr);
		}

		// 重新组装list
		List<List<AsGoodsAttr>> list = new ArrayList<List<AsGoodsAttr>>();
		for (Map.Entry<String, List<AsGoodsAttr>> entry : multiValueMap
				.entrySet()) {
			// String key = entry.getKey();
			List<AsGoodsAttr> values = entry.getValue();
			list.add(values);
		}

		// 合并list
		List<AsProduct> mergeList = new ArrayList<AsProduct>();
		if (list.size() == 1) {// 只有一种属性
			for (AsGoodsAttr goodsAttr : list.get(0)) {
				AsProduct asProduct = new AsProduct();
				asProduct.setGoodsId(goodsAttr.getGoodsId());
				asProduct.setGoodsAttr(goodsAttr.getGoodsAttrId().toString());
				asProduct.setProductStore(0);
				asProduct.setAttrName(goodsAttr.getAttrName() + ":"
						+ goodsAttr.getAttrValue());
				mergeList.add(asProduct);
			}
		} else if (list.size() > 1) {// 2中属性以上，结果为各个属性的数量相乘
										// 如属性1有2中，属性2有3中，结果是2*3=6
			for (int i = 0; i < list.size() - 1; i++) {
				if (i == 0) {// 第一次合并
					mergeList = mergeList(list.get(i), list.get(i + 1));
				} else {// 第二次之后
					mergeList = mergeList2(mergeList, list.get(i + 1));

				}

			}
		}

		// 返回页面的数据
		List<AsProduct> results = new ArrayList<>();
		for (int i = 0; i < mergeList.size(); i++) {
			AsProduct asProduct = mergeList.get(i);
			List<String> goodsAttrNames = new ArrayList<>();
			List<String> goodsAttrValues = new ArrayList<>();
			if (asProduct.getGoodsAttr().indexOf(";") == -1) {
				goodsAttrNames.add(asProduct.getAttrName().split(":")[0]);
				goodsAttrValues.add(asProduct.getAttrName().split(":")[1]);
			} else {
				String[] names = asProduct.getAttrName().split(";");
				for (int j = 0; j < names.length; j++) {
					goodsAttrNames.add(names[j].split(":")[0]);
					goodsAttrValues.add(names[j].split(":")[1]);
				}
			}
			productService.save(asProduct);
			this.updateGoodsWithTimeAndUser(goodsId);// 记录当前操作的用户
			asProduct.setGoodsAttrNames(goodsAttrNames);
			asProduct.setGoodsAttrValues(goodsAttrValues);
			results.add(asProduct);
		}
		return results;
	}

	/**
	 * 首次组装2个集合
	 * 
	 * @param list1
	 * @param list2
	 * @return
	 */
	private List<AsProduct> mergeList(List<AsGoodsAttr> list1,
			List<AsGoodsAttr> list2) {
		List<AsProduct> currentList = new ArrayList<AsProduct>();

		for (int i = 0; i < list1.size(); i++) {
			AsGoodsAttr goodsAttr1 = list1.get(i);
			int goodsAttrId1 = goodsAttr1.getGoodsAttrId();

			for (int j = 0; j < list2.size(); j++) {
				AsGoodsAttr goodsAttr2 = list2.get(j);
				int goodsAttrId2 = goodsAttr2.getGoodsAttrId();

				AsProduct product = new AsProduct();
				product.setGoodsId(goodsAttr2.getGoodsId());
				product.setGoodsAttr(goodsAttrId1 + ";" + goodsAttrId2);
				product.setAttrName(goodsAttr1.getAttrName() + ":"
						+ goodsAttr1.getAttrValue() + ";"
						+ goodsAttr2.getAttrName() + ":"
						+ goodsAttr2.getAttrValue());
				product.setProductStore(0);
				currentList.add(product);
			}
		}
		return currentList;
	}

	/**
	 * 二次组装
	 * 
	 * @param products
	 * @param attrs
	 * @return
	 */
	private List<AsProduct> mergeList2(List<AsProduct> products,
			List<AsGoodsAttr> attrs) {
		List<AsProduct> asProducts = new ArrayList<AsProduct>();
		for (int j = 0; j < products.size(); j++) {
			AsProduct product = products.get(j);
			for (int k = 0; k < attrs.size(); k++) {
				AsGoodsAttr goodsAttr = attrs.get(k);

				AsProduct asProduct = new AsProduct();
				BeanUtils.copyProperties(product, asProduct);
				asProduct.setGoodsAttr(product.getGoodsAttr() + ";"
						+ goodsAttr.getGoodsAttrId());
				asProduct.setAttrName(product.getAttrName() + ";"
						+ goodsAttr.getAttrName() + ":"
						+ goodsAttr.getAttrValue());
				asProducts.add(asProduct);
			}

		}
		return asProducts;
	}


	/**
	 * 修改商品为删除状态
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goods
	 * @return
	 */
	public int updateGoods(int goodsId) {
		AsGoods goods = new AsGoods();
		goods.setGoodsId(goodsId);
		goods.setUpdateTime(DateUtil.getTime());
		goods.setCreateUser(this.getCurrentUser().getNAME());
		goods.setIsDelete(1);
		return asGoodsMapper.updateByPrimaryKeySelective(goods);
	}

	/**
	 * 批量删除商品（修改商品为删除状态）
	 *
	 * @author tgb 创建时间：2016年12月3日
	 * @version 1.0
	 * @param ids
	 *            商品id数组
	 * @return
	 */
	public int deleteGoodsAlls(int[] ids) {
		int data = asGoodsMapper.deleteGoodsAlls(ids);
		if (data > 0) {
			for (int i = 0; i < ids.length; i++) {
				// 记录当前操作的用户
				this.updateGoodsWithTimeAndUser(ids[i]);
			}
		}
		return data;
	}

	/**
	 * 获取商品图片列表
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 *            商品id ，type 1 商品图片，2商品缩列图
	 * @return
	 */
	public List<AsGoodsImgs> getGoodsImgs(int goodsId, int type) {
		if (type == 1) {
			return asGoodsImgsMapper.selectByGoodsId(goodsId);
		} else {
			return asGoodsImgsMapper.selectThumbByGoodsId(goodsId);
		}
	}

	/**
	 * 修改商品图片
	 * @param files
	 * @param goodsId
	 * @param goodsImgsId
     * @return
     */
	public int editGoodsImgs(MultipartFile files, int goodsId,
								 int goodsImgsId) {

		String ftpFile = UuidUtil.get32UUID() + ".jpg";
		String ftpDir = Const.GOODSFILEPATHIMG;
		String url = ftpDir + "/" + ftpFile;
		boolean flag = false;
		try {
			// ftp上传商品图片
			flag = ftpUpload(files.getBytes(), ftpFile, ftpDir);
		} catch (IOException e) {
			e.printStackTrace();
		}
			if (flag) {
				AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
				asGoodsImgs.setGoodsImgsId(goodsImgsId);
				asGoodsImgs.setImgUrl(url);
				asGoodsImgs.setGoodsId(goodsId);
				asGoodsImgsMapper.updateByPrimaryKeySelective(asGoodsImgs);
				this.updateGoodsWithTimeAndUser(goodsId);// 记录当前操作的用户
		}
		return 1;
	}

	/**
	 * 保存商品缩略图
	 * @param files
	 * @param goodsId
	 * @param goodsImgsId
     * @return
     */
	public int saveGoodsAttrImgs(MultipartFile files, int goodsId,
			int goodsImgsId) {

		String ftpFile = UuidUtil.get32UUID() + ".jpg";
		String ftpDir = Const.GOODSFILEPATHIMG;
		String url = ftpDir + "/" + ftpFile;
		boolean flag = false;
		try {
			// ftp上传商品图片
			flag = ftpUpload(files.getBytes(), ftpFile, ftpDir);
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (goodsImgsId == 0) {// 修改的是商品主图片
			if (flag) {
				AsGoods asGoods = new AsGoods();
				asGoods.setGoodsId(goodsId);
				asGoods.setGoodsImg(url);
				asGoods.setGoodsThumb(url);
				asGoodsMapper.updateByPrimaryKeySelective(asGoods);
				this.updateGoodsWithTimeAndUser(goodsId);// 记录当前操作的用户
			}
		} else {// 修改的是缩略图
			AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
			asGoodsImgs.setGoodsImgsId(goodsImgsId);
			asGoodsImgs.setThumbUrl(url);
			asGoodsImgs.setGoodsId(goodsId);
			asGoodsImgsMapper.updateByPrimaryKeySelective(asGoodsImgs);
			this.updateGoodsWithTimeAndUser(goodsId);// 记录当前操作的用户
		}

		return 1;
	}

	/**
	 * 批量保存商品图片
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param files 图片文件数组
	 * @param goodsId 商品id
	 * @return
	 */
	public int saveGoodsImgs(MultipartFile[] files, int goodsId) {
		for (int j = 0; j < files.length; j++) {
			if (!StringUtils.isEmpty(files[j].getOriginalFilename())) {
				try {
					goodsImgUpload(goodsId, files[j].getBytes());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return 1;
	}

	/**
	 * 上传商品图片字节流方法
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 * @param bytes
	 */
	private void goodsImgUpload(int goodsId, byte[] bytes) {
		String ftpFile = UuidUtil.get32UUID() + ".jpg";
		String ftpDir = Const.GOODSFILEPATHIMG;

		// ftp上传商品图片
		boolean flag = ftpUpload(bytes, ftpFile, ftpDir);
		if (flag) {
			AsGoodsImgs asGoodsImgs = new AsGoodsImgs();
			asGoodsImgs.setGoodsId(goodsId);
			asGoodsImgs.setImgUrl(ftpDir + "/" + ftpFile);
			asGoodsImgsMapper.insertSelective(asGoodsImgs);
			this.updateGoodsWithTimeAndUser(goodsId);// 记录当前操作的用户
		}
	}

	/**
	 * 删除商品图片
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsImgsId
	 *            type 1 删除商品图片，2把商品属性有颜色的图片url设置null
	 * @return
	 */
	public Object deleteGoodsImgs(int goodsImgsId, int type) {
		if (type == 1) {
			return asGoodsImgsMapper.deleteByPrimaryKey(goodsImgsId);
		} else {
			return asGoodsImgsMapper.deleteAttrImgsByGoodsImgsId(goodsImgsId);
		}
	}
	/**
	 * 批量删除商品图片
	 *
	 * @author tgb 创建时间：2016年12月4日
	 * @version 1.0
	 * @param ints
	 */
	public int deleteGoodsImgAlls(int[] ids) {
		int data =  asGoodsImgsMapper.deleteGoodsImgAlls(ids);
		return data;
	}

	/**
	 * 查找到需要编辑商品的库存
	 *
	 * @author tgb 创建时间：2016年12月4日
	 * @version 1.0
	 * @param goodsId
	 * @return
	 */
	public List<AsProduct> editGoodsStore(int goodsId) {

		List<AsProduct> mergeList = asProductMapper.selectGoodsProduct(goodsId);
		// 返回页面的数据
		List<AsProduct> results = new ArrayList<>();
		for (int i = 0; i < mergeList.size(); i++) {
			AsProduct asProduct = mergeList.get(i);
			List<String> goodsAttrNames = new ArrayList<>();
			List<String> goodsAttrValues = new ArrayList<>();
			if (asProduct.getGoodsAttr().indexOf(";") == -1) {
				goodsAttrNames.add(asProduct.getAttrName().split(":")[0]);
				goodsAttrValues.add(asProduct.getAttrName().split(":")[1]);
			} else {
				String[] names = asProduct.getAttrName().split(";");
				for (int j = 0; j < names.length; j++) {
					goodsAttrNames.add(names[j].split(":")[0]);
					goodsAttrValues.add(names[j].split(":")[1]);
				}
			}
			asProduct.setGoodsAttrNames(goodsAttrNames);
			asProduct.setGoodsAttrValues(goodsAttrValues);
			results.add(asProduct);
		}
		return results;
	}

	/**
	 * 修改商品信息时，添加修改时间和修改用户
	 *
	 * @author tgb 创建时间：2016年12月7日
	 * @version 1.0
	 * @param goodsId
	 * @return
	 */
	public int updateGoodsWithTimeAndUser(int goodsId) {
		return asGoodsMapper.updateGoodsWithTimeAndUser(DateUtil.getTime(),
				this.getCurrentUser().getNAME(), goodsId);
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

	/**
	 * 获取商品有颜色的属性
	 *
	 * @author tgb 创建时间：2016年12月8日
	 * @version 1.0
	 * @param goodsId
	 * @return
	 */
	public List<AsGoodsAttr> findByGoodsIdWithAttr(int goodsId) {
		return asGoodsAttrMapper.findByGoodsIdWithAttr(goodsId);
	}



}
