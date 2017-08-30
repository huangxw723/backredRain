package com.aoshi.service.manage.consultation.consultationInfo;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationConvenienceMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationConvenience;
import com.aoshi.domain.AsConsultationHotel;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.resolver.ValidatorBreakException;
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
public class AsConsultationConvenienceService extends AsBaseService {

	@Autowired
	private  AsConsultationConvenienceMapper mapper;
	
	
	/**
	 * 列表显示
	 * @param AsConsultationConvenience obj
	 */
	public List<AsConsultationConvenience> queryList(AsConsultationConvenience obj) {
		return mapper.queryList(obj);
	}
	
	/*---------------------------------------增删改查------------------------------------*/
	
	/** 
	 * 保存新增 
	 */
	public AsConsultationConvenience saveAdd(AsConsultationConvenience obj, String latlng, MultipartFile file, MultipartFile file2,MultipartFile[] files,AsConsultationImgs asImgs) {
		String ftpFile = UuidUtil.get32UUID() + ".jpg";;
		String ftpDir = Const.CONSULTATIONCITYFILEPATHIMG;
		
		String ftpFile2 = UuidUtil.get32UUID() + ".jpg";;
		String ftpDir2 = Const.CONSULTATIONCITYFILEPATHIMG;
		//上传图片-返回图片路径
		String imgHref = ftpUpload(file,ftpFile, ftpDir);
		obj.setCoverImg(imgHref);
	
		//线路图
		String lineImgs = ftpUpload2(file2,ftpFile2,ftpDir2);
		obj.setLineImg(lineImgs);
		
		
		// 封装经纬度
		if (!StringUtils.isEmpty(latlng)) {
			String[] arr = latlng.split(",");
			obj.setLng(arr[0].trim());
			obj.setLat(arr[1].trim());
		}
		//----------------------------------------------
		int result = mapper.insertSelective(obj);
		if (result > 0) {
			//成功的
		}
		//多图上传
		//manyPic(obj,ftpFile,ftpDir,files,asImgs);
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
	public AsConsultationConvenience saveEdit(AsConsultationConvenience obj, String latlng,MultipartFile file,
			MultipartFile file2) {
		//上传新的图片
		if (StringUtils.isNotBlank(file.getOriginalFilename())) {
			//
			String ftpFile = UuidUtil.get32UUID() + ".jpg";;
			String ftpDir = Const.CONSULTATIONCITYFILEPATHIMG;
			
			
			//上传图片-返回图片路径
			String imgHref;
			
			//单张2
			//String lineImgs;
		
			try {
				imgHref = ftpUpload(file.getBytes(),ftpFile, ftpDir);
				//单张
				//lineImgs = ftpUpload2(file2.getBytes(),ftpFile2, ftpDir2);
				//单张
				if(!"".equals(imgHref)){
					obj.setCoverImg(imgHref);
				}
				
				
			//------------------------------
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		if(StringUtils.isNotBlank(file2.getOriginalFilename())){
			String ftpFile2 = UuidUtil.get32UUID() + ".jpg";;
			String ftpDir2 = Const.CONSULTATIONCITYFILEPATHIMG;
			String lineImgs;
			try {
				lineImgs = ftpUpload(file2.getBytes(),ftpFile2,ftpDir2);
				if(!"".equals(lineImgs)){
					obj.setLineImg(lineImgs);//单张	
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		// 封装经纬度
		if (!StringUtils.isEmpty(latlng)) {
			String[] arr = latlng.split(",");
			obj.setLng(arr[0].trim());
			obj.setLat(arr[1].trim());
		}
		//更新
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
	public AsConsultationConvenience selectByPrimaryKey(Integer id) {
		return mapper.selectById(id);
	}
	
	/*---------------------------------------other------------------------------------*/
	
	/**
	 * 发布
	 * @param AsConsultationConvenience obj
	 */
	public int onSale(AsConsultationConvenience obj) {
		return mapper.updateByPrimaryKeySelective(obj);
	}
	
	/**
	 * 下架
	 * @param String[] ids
	 */
	public int offSale(AsConsultationConvenience obj) {
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
	 * 上传ftp服务
	 * @param MultipartFile file
	 * @param ftpFile--图片地址
	 * @param ftpDir--ftp路径
	 * @return String 图片路径.jpg
	 */
	private String ftpUpload2(MultipartFile file2, String ftpFile2, String ftpDir2) {
		String result="";
		FtpConManager ftpConManager = FtpConManager.getInstance();
		try {
			byte[] bytes=file2.getBytes();
			String path = Const.FILEPATHIMGDIR + ftpDir2;
			ftpConManager.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(),PropertyUtils.getFTP_PASS());
			boolean isTrue=ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile2);
			if(isTrue){
				result=ftpDir2 + "/" + ftpFile2;
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
	private void manyPic(AsConsultationConvenience obj,String ftpFile, String ftpDir,MultipartFile[] imgs, AsConsultationImgs asImgs) {
		
		for (int i = 0; i < imgs.length; i++) {
			boolean flag = false;
			if (!StringUtils.isEmpty(imgs[i].getOriginalFilename())) {
				
				FtpConManager ftpConManager = FtpConManager.getInstance();
				try {
					String path = Const.FILEPATHIMGDIR + ftpDir;
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
					asImgs.setConsultationId(obj.getConsultationConvenienceId());
					this.mapper.insertImgs(asImgs);
				}
				
			}
		}
		
	}
	
  /*---------------------------------------other------------------------------------------------*/
	
	/**
	 *根据id查询图片
	 * @param id
	 * @return
	 */
	public List<AsConsultationImgs> queryImgs(Integer id) {
		return this.mapper.queryImgsById(id);
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
public static void main(String[] args) {
	String str="ascmMall/consultationCity/50a95fc165944705ba90bdf5986d9274.jpg,data:image/jpeg;base64,/9j/4A";
	int index = str.indexOf(",");
	System.out.println(str.substring(index+1,str.length()));
}	


/**
	 * 查询城市
	 * 
	 * @return
	 */
    public List<AsCity> queryCity(Integer id) {
	    return this.mapper.queryCity(id);
    }

    /**
	 * 查询区域
	 * @return
	 */
	public List<AsArea> queryArea(Integer id) {
		return this.mapper.queryArea(id);
	} 

}
