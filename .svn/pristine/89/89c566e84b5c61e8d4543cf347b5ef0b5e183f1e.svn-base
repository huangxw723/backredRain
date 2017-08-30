package com.aoshi.service.manage.consultation.consultationInfo;

import java.io.ByteArrayInputStream;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.dao.AsConsultationInfoMapper;
import com.aoshi.dao.AsConsultationTypeMapper;
import com.aoshi.domain.AsConsultationInfo;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Const;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PageData;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;

/**
 * 服务层
 * @author：wendy
 * @date：
 */
@Service
public class AsConsultationInfoService extends AsBaseService {

	@Autowired
	AsConsultationInfoMapper mapper;
	
	@Autowired
	AsConsultationTypeMapper asConsultationTypeMapper; //咨询类型表Map
	/**
	 * 列表显示
	 * @param AsConsultationInfo obj
	 */
	public List<AsConsultationInfo> queryList(AsConsultationInfo obj) {
		return mapper.queryList(obj);
	}
	
	/*---------------------------------------增删改查------------------------------------*/
	
	/** 
	 * 保存新增 
	 */
	public AsConsultationInfo saveAdd(AsConsultationInfo obj, String latlng, MultipartFile file) {
		String ftpFile = UuidUtil.get32UUID() + ".jpg";;
		String ftpDir = Const.CONSULTATIONCITYFILEPATHIMG;
		//上传图片-返回图片路径
		String imgHref = ftpUpload(file,ftpFile, ftpDir);
		
		//保存图片路径+*.jpg
		obj.setCoverImg(imgHref);
		
		// 封装经纬度
		if (!StringUtils.isEmpty(latlng)) {
			String[] arr = latlng.split(",");
			obj.setLng(arr[0].trim());
			obj.setLat(arr[1].trim());
		}
		
		//保存
		int result = mapper.insertSelective(obj);
		if (result > 0) {
			//成功的
		}
		return obj;
	}
	
	/**
	 * 删除
	 * @param Integer id
	 */
	public int deleteByPrimaryKey(Integer id) {
		return mapper.deleteByPrimaryKey(id);
	}
	/**
	 * 批量删除
	 * @param String[] ids
	 */
	public int deleteByIds(String[] ids) {
		return mapper.deleteByIds(ids);
	}

	/** 
	 * 保存编辑
	 */
	@SuppressWarnings("deprecation")
	public AsConsultationInfo saveEdit(PageData pd, AsConsultationInfo obj, String latlng,String oldIamge) {
		//上传新的图片
		if (StringUtils.isNotBlank(pd.getString("img"))) {
			//获取图片字节流=MultipartFile file
			String arr[] = String.valueOf(pd.get("img")).split(",");
			byte[] bytes = Base64.decode(arr[1]);
			//
			String ftpFile = UuidUtil.get32UUID() + ".jpg";;
			String ftpDir = Const.CONSULTATIONCITYFILEPATHIMG;
			//上传图片-返回图片路径
			String imgHref = ftpUpload(bytes,ftpFile, ftpDir);
			
			//保存图片路径+*.jpg
			obj.setCoverImg(imgHref);
		} else {
			//原来的
			obj.setCoverImg(oldIamge);
		}
		// 封装经纬度
		if (!StringUtils.isEmpty(latlng)) {
			String[] arr = latlng.split(",");
			obj.setLng(arr[0].trim());
			obj.setLat(arr[1].trim());
		}
		//更新
		int result = mapper.updateByPrimaryKey(obj);
		if (result > 0) {
			// 成功的
		}
		return obj;
	}
	
	/**
	 * 根据ID查询
	 * @param Integer id
	 */
	public AsConsultationInfo selectByPrimaryKey(Integer id) {
		return mapper.selectById(id);
	}
	
	public List<AsConsultationType> selectByLevel(int parentId) {
		return asConsultationTypeMapper.selectByLevel(parentId);
	}
	
	/**
	 * 根据城市百科名称查询出对应consultation_type_id
	 * @param name
	 * @return
	 */
	public List<AsConsultationType> selectByName(String name) {
		return asConsultationTypeMapper.selectByName(name);
	}
	/*---------------------------------------other------------------------------------*/
	
	/**
	 * 发布
	 * @param AsConsultationInfo obj
	 */
	public int onSale(AsConsultationInfo obj) {
		return mapper.updateByPrimaryKeySelective(obj);
	}
	
	/**
	 * 下架
	 * @param String[] ids
	 */
	public int offSale(AsConsultationInfo obj) {
		return mapper.updateByPrimaryKeySelective(obj);
	}
	
	/**
	 * 批量下架
	 * @param String[] ids
	 */
	public int offSaleAll(String[] ids) {
		return mapper.offSaleAll(ids);
	}
	
	/**
	 * 上传ftp服务
	 * @param byte[] bytes
	 * @param ftpFile--图片地址
	 * @param ftpDir--ftp路径
	 * @return String 图片路径.jpg
	 */
	private String ftpUpload(byte[] bytes, String ftpFile, String ftpDir) {
		String result="";
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			String path = Const.FILEPATHIMGDIR + ftpDir;
			ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(),PropertyUtils.getFTP_PASS());
			boolean isTrue=ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile);
			if(isTrue){
				result=ftpDir + "/" + ftpFile;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return result;
	}
	
	/**
	 * 上传ftp服务
	 * @param MultipartFile file
	 * @param ftpFile--图片地址
	 * @param ftpDir--ftp路径
	 * @return String 图片路径.jpg
	 */
	private String ftpUpload(MultipartFile file, String ftpFile, String ftpDir) {
		String result="";
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			byte[] bytes=file.getBytes();
			String path = Const.FILEPATHIMGDIR + ftpDir;
			ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(),PropertyUtils.getFTP_PASS());
			boolean isTrue=ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile);
			if(isTrue){
				result=ftpDir + "/" + ftpFile;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ftpConManager.closeCon();
		}
		return result;
	}
	


}
