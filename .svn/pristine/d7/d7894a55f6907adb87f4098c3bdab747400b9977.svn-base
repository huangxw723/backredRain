package com.aoshi.service.manage.consultation.consultationInfo;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationHotelMapper;
import com.aoshi.dao.AsConsultationImgsMapper;
import com.aoshi.dao.AsConsultationTypeMapper;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsConsultationHotel;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Const;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

/**
 * 服务层
 * @author：wendy
 * @date：
 */
@Service
public class AsConsultationHotelService extends AsBaseService {

	private static final Integer typeId = null;
	@Autowired
	private AsConsultationHotelMapper mapper;
	@Autowired
	AsConsultationTypeMapper asConsultationTypeMapper; // 咨询类型表Map
	@Autowired
	AsConsultationImgsMapper asConsultationImgsMapper;

	/**
	 * 列表显示
	 * @param AsConsultationHotel obj
	 */
	public List<AsConsultationHotel> queryList(AsConsultationHotel obj) {
		return mapper.queryList(obj);
	}
	
	/*---------------------------------------增删改查------------------------------------*/
	
	/** 
	 * 保存新增 
	 */
	public AsConsultationHotel saveAdd(AsConsultationHotel obj, String latlng, MultipartFile file,MultipartFile[] files,AsConsultationImgs asImgs) {
		String ftpFile = UuidUtil.get32UUID() + ".jpg";
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
		//上传多张图片
		manyPic(obj,ftpDir,files,asImgs);
		return obj;
	}
	
	/**
	 * 删除
	 * @param Integer id
	 */
	public int deleteByPrimaryKey(Integer id,Integer typeId) {
		asConsultationImgsMapper.deleteByConsultationId(id,typeId);
		mapper.deleteByPrimaryKey(id);
		if(asConsultationImgsMapper.deleteByConsultationId(id,typeId)==1 && mapper.deleteByPrimaryKey(id)==1){
			return 1;
		}
		return 0;
	}
	/**
	 * 批量删除
	 * @param String[] ids
	 */
	public int deleteByIds(String[] ids) {
        if(ids.length>0){
            List<Integer> typeIdList = asConsultationImgsMapper.queryTypeId(ids[0]);
            if(!typeIdList.isEmpty()){
                asConsultationImgsMapper.deleteByIds(ids,typeIdList.get(0));
            }
        }
		mapper.deleteByIds(ids);
		if(asConsultationImgsMapper.deleteByIds(ids,typeId)==1 && mapper.deleteByIds(ids)==1){
			return 1;
		}
		return 0;
	}

	
	
	/** 
	 * 保存编辑
	 */
	public AsConsultationHotel saveEdit(AsConsultationHotel obj, String latlng,MultipartFile file) {
		//上传新的图片
		if (StringUtils.isNotBlank(file.getOriginalFilename())) {
			//
			String ftpFile = UuidUtil.get32UUID() + ".jpg";;
			String ftpDir = Const.CONSULTATIONCITYFILEPATHIMG;
			//上传图片-返回图片路径
			String imgHref;
			try {
				imgHref = ftpUpload(file.getBytes(),ftpFile, ftpDir);
				obj.setCoverImg(imgHref);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//保存图片路径+*.jpg
			
		} 
		// 封装经纬度
		if (!StringUtils.isEmpty(latlng)) {
			String[] arr = latlng.split(",");
			obj.setLng(arr[0].trim());
			obj.setLat(arr[1].trim());
		}
		//更新
		//int result = mapper.updateByPrimaryKeySelective(obj);
		int result = mapper.updateByPrimaryKeySelective(obj);
		
		if (result > 0) {
			// 成功的
		}
		return obj;
	}
	
	
	
	
	/**
	 * 根据ID查询
	 * @param Integer id
	 */
	public AsConsultationHotel selectByPrimaryKey(Integer id) {
		return mapper.selectByPrimaryKey(id);
	}
	
	/*---------------------------------------other------------------------------------*/
	
	/**
	 * 发布
	 * @param AsConsultationHotel obj
	 */
	public int onSale(AsConsultationHotel obj) {
		return mapper.updateByPrimaryKeySelective(obj);
	}
	
	/**
	 * 下架
	 * @param String[] ids
	 */
	public int offSale(AsConsultationHotel obj) {
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
	
	/**
	 * 遍历多张图片
	 * @param AsConsultationHotel obj
	 * @param AsConsultationHotel ftpFile
	 * @param AsConsultationHotel ftpDir
	 * @param MultipartFile[] imgs
	 * @param AsConsultationImgs asImgs
	 */
	private void manyPic(AsConsultationHotel obj,String ftpDir,MultipartFile[] imgs, AsConsultationImgs asImgs) {
		
		for (int i = 0; i < imgs.length; i++) {
			boolean flag = false;
			String path = "";
			if (!StringUtils.isEmpty(imgs[i].getOriginalFilename())) {
				String ftpFile = UuidUtil.get32UUID() + ".jpg";
				System.out.println("------->"+UuidUtil.get32UUID() + ".jpg");
				FtpConManager ftpConManager = FtpConManager.getInstance();
				try {
					path = Const.FILEPATHIMGDIR + ftpDir;
					ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(),PropertyUtils.getFTP_PASS());
					flag=ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(imgs[i].getBytes()), path, ftpFile);
				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					ftpConManager.closeCon();
				}
				if (flag) {
					asImgs.setImgUrl(ftpDir + "/" + ftpFile);
					asImgs.setTypeId(obj.getTypeId());
					asImgs.setConsultationId(obj.getConsultationTrafficId());
					this.mapper.insertImgs(asImgs);
				}
				
			}
		}
		
	}
	
	// 获取商圈信息
	public List<AsBusinessDistrict> selectAll2() {
		return mapper.selectAl2();
	}

	/*---------------------------------------other------------------------------------*/
	
	/**
	 *根据id查询图片
	 * @param id
	 * @return
	 */
	public List<AsConsultationImgs> queryImgs(Integer id,Integer typeId) {
		return this.asConsultationImgsMapper.queryImgsById(id,typeId);
	}
	
	  /**
	    * 查询图片
	  */
     public AsConsultationImgs selectByPrimaryKeyHotel(Integer id) {
		        return mapper.selectByPrimaryKeyImg(id);
	 }
     
     
     /**
      * 增加图片
      */
     public int addImg(AsConsultationImgs asConsultationImgs,BaseController c) {
         initialized(c);
         String foodImg = pd.getStringRequired("img");
         ValidatorBreakException.NOT_TRUE(!(foodImg == null || foodImg
                 .trim().length() == 0 ||"".equals(foodImg)), "请上传菜式图！");
         uploadModule(UploadPathEnum.BRAND, "img");
         String foodImgUrl = pd.getStringRequired("img");
         asConsultationImgs.setImgUrl(foodImgUrl);
         asConsultationImgs.setConsultationId(asConsultationImgs.getConsultationId());
       //asConsultationImgs.setTypeId(asConsultationImgs.setTypeId(typeId);
         return mapper.insertSelectiveImg(asConsultationImgs);
     }
     
     /**
	  * 更新图片  
	  * @param asConsultationStreetFood
	  * @param c
	  * @return
	  */
   public int updateByPrimaryKeySelective(AsConsultationImgs asConsultationImgs,BaseController c){
        initialized(c);
        uploadModule(UploadPathEnum.BRAND, "img");
        String imgUrl = pd.getStringRequired("img");
        if(!StringUtils.isEmpty(imgUrl)){
        	asConsultationImgs.setImgUrl(imgUrl);
        }
        return mapper.updateByPrimaryKeySelectiveImg(asConsultationImgs);
    }

   //删除
   public int deleteByPrimaryKeys(Integer id){
       return mapper.deleteByPrimaryKeyImgs(id);
   }

	public List<AsConsultationType> selectByName(String name) {
		return asConsultationTypeMapper.findByName(name);
	}

	
}
