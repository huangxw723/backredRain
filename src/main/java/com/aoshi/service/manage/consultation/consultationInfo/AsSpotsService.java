package com.aoshi.service.manage.consultation.consultationInfo;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsSpotsMapper;
import com.aoshi.dao.ExcelMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationFood;
import com.aoshi.domain.AsConsultationSpots;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationShopping;
import com.aoshi.domain.AsConsultationSpots;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Const;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;

/**
 * 景点发布业务层
 * @author strong
 * @version 1.0
 * 2016年11月30日下午1:49:47
 */
@Service
@Transactional
public class AsSpotsService extends AsBaseService{
	
	@Autowired
	private AsSpotsMapper asSpotsMapper;
	
	@Autowired
	private ExcelMapper excelMapper;
	
	/**
	 * 查询景点
	 * @return
	 */
	public List<AsYpBaseCategory> queryFood() {
		return this.asSpotsMapper.queryFood();
	}
	/**
	 * 查询省份
	 * @return
	 */
	public List<AsProvince> queryPro() {		
		return this.asSpotsMapper.queryPro();
	}

	/**
	 * 查询城市
	 * @return
	 */
	public List<AsCity> queryCity(Integer id) {
		return this.asSpotsMapper.queryCity(id);
	}
	
	/**
	 * 查询区域
	 * @return
	 */
	public List<AsArea> queryArea(Integer id) {
		return this.asSpotsMapper.queryArea(id);
	}

	public AsConsultationType queryType(String name) {
		return this.asSpotsMapper.queryType(name);
	}
	
	/**
	 * 发布景点
	 * @param spots
	 * @param bus 
	 * @param metro 
	 * @return
	 */
	public int saveSpots(AsConsultationSpots spots,String lonlat,MultipartFile file,MultipartFile[] imgs,AsConsultationImgs asImgs, String metro, String bus) {
		
		
		Boolean flag=false;
		//定义名字
		String fileName = UuidUtil.get32UUID()+".jpg"; 
		//定义路径
		String filePath = Const.COUPONFILEPATHIMG;
		if(!StringUtils.isEmpty(file.getOriginalFilename())){
			try {
				//创建图片上传
				flag = ftpUpload(file.getBytes(),fileName,filePath);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(flag){
				//封装图片路径
				spots.setCoverImg(filePath+"/"+fileName);				
			}
			//封装经纬度
			if(!StringUtils.isEmpty(lonlat)){
				String[] arr = lonlat.split(",");
				spots.setLng(arr[0].trim());
				spots.setLat(arr[1].trim());
			}
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			spots.setPublicTime(time.format(date));
			//封装乘车路线
			String metroName = null;
	        if(!StringUtils.isEmpty(metro)){
	        	 metroName = "地铁:"+metro;
	        	 if(!StringUtils.isEmpty(bus)){
	        		 spots.setLine(metroName+";"+"公交:"+bus);
	        	 }else{
	        		 spots.setLine(metroName);
	        	 }
	        }else{
	        	 if(!StringUtils.isEmpty(bus)){
	        		 spots.setLine("公交:"+bus);
	        	 }
	        }
			spots.setVisitCount(0);
			spots.setYpBaseCategoryId(0);
			spots.setStarLevel("0");
		}
		int result = this.asSpotsMapper.insertFood(spots);		
		//多图片上传
		manyPic(imgs,asImgs,spots);
		
		return result;
	}
	
	/**
	 * 遍历多张图片
	 * @param imgs
	 */
	private void manyPic(MultipartFile[] imgs,AsConsultationImgs asImgs,AsConsultationSpots food) {
		
		for (int i = 0; i < imgs.length; i++) {
			boolean flag = false;
			String fileName = UuidUtil.get32UUID() + ".jpg";
			String filePath = Const.COUPONFILEPATHIMG;
			if(!StringUtils.isEmpty(imgs[i].getOriginalFilename())){
				try {
					flag = ftpUpload(imgs[i].getBytes(), fileName, filePath);					
				} catch (IOException e) {
					e.printStackTrace();
				}
				if(flag){
					asImgs.setImgUrl(filePath+"/"+fileName);
					asImgs.setTypeId(food.getTypeId());					
					asImgs.setConsultationId(food.getConsultationSpotsId());
					this.asSpotsMapper.insertImgs(asImgs);
				}
			}
		
		}
		
		
	}

	//实现图片上传方法
	private Boolean ftpUpload(byte[] bs, String fileName, String filePath) {
		//定义ftp路径
		String ftpPath = Const.FILEPATHIMGDIR+filePath;
		//获取ftp对象
		FtpConManager fcm = FtpConManager.getInstance();
		//定义ftp连接属性
		try {			
			fcm.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(),PropertyUtils.getFTP_PASS());
		} catch (Exception e) {
			e.printStackTrace();
		}	
		//进行Ftp图片上传
		return fcm.uploadFileByInputStream(new ByteArrayInputStream(bs), ftpPath, fileName);
	}
	
	/**
	 * 查询所有景点信息
	 * @return
	 */
	public List<AsConsultationSpots> queryAllCate(AsConsultationSpots food) {
		
		return this.asSpotsMapper.queryAllCate(food);
	}
	
	/**
	 * 根据id查询景点信息
	 * @param id
	 * @return
	 */
	public AsConsultationSpots querySpotsById(Integer id) {
		 AsConsultationSpots food= (AsConsultationSpots) this.asSpotsMapper.selectByPrimaryKey(id);
	return food;
	}
	
	/**
	 * 更新景点资讯
	 * @param AsConsultationSpots
	 * @param bus 
	 * @param metro 
	 * @param lonlat
	 */
	
	 public int update(AsConsultationSpots AsConsultationSpots,String latlng,MultipartFile file, String metro, String bus) {
		 if(!StringUtils.isEmpty(file) && !StringUtils.isEmpty(file.getOriginalFilename())){
	        	Boolean flag=false;
	    		//定义名字
	    		String fileName = UuidUtil.get32UUID()+".jpg"; 
	    		//定义路径
	    		String filePath = Const.COUPONFILEPATHIMG;
	        	try {
					//创建图片上传
					flag = ftpUpload(file.getBytes(),fileName,filePath);
					
				} catch (IOException e) {
					e.printStackTrace();
				}
				if(flag){
					//封装图片路径
					AsConsultationSpots.setCoverImg(filePath+"/"+fileName);				
				}
	        }
		 	
		 
	        if(!StringUtils.isEmpty(latlng)){
	        	String[] arr = latlng.split(",");
	        	AsConsultationSpots.setLat(arr[0].trim());
	        	AsConsultationSpots.setLng(arr[1].trim());
	        }
	        String metroName = null;
	        if(!StringUtils.isEmpty(metro)){
	        	 metroName = "地铁:"+metro;
	        	 if(!StringUtils.isEmpty(bus)){
	        		 AsConsultationSpots.setLine(metroName+";"+"公交:"+bus);
	        	 }else{
	        		 AsConsultationSpots.setLine(metroName);
	        	 }
	        }else{
	        	 if(!StringUtils.isEmpty(bus)){
	        		 AsConsultationSpots.setLine("公交:"+bus);
	        	 }
	        }
	        
	        return asSpotsMapper.updateCate(AsConsultationSpots);
	    }

	  
	    	
		/**
		 * 根据id,和typeId删除美食资讯
		 * @param id
		 * @return
		 */	
		 public int delete(Integer consultationSpotsId,Integer typeId){
			 int status = asSpotsMapper.deleteByPrimaryKey(consultationSpotsId);
			 asSpotsMapper.deleteByPrimaryKeyforImgs(consultationSpotsId,typeId);
			 return status;
		 
		 }
	
	/**
	 * 更新状态
	 */
	public Object editStatus(BaseController c) {

		initialized(c);

		operaFlag = asSpotsMapper.updateByPrimaryKeySelective(pd) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");

		return renderSuccess();
	}
	
	/**
	 *根据id查询图片
	 * @param id
	 * @return
	 */
	public List<AsConsultationImgs> queryImgs(Integer id,Integer typeId) {
		return this.asSpotsMapper.queryImgsById(id,typeId);
	}
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
    public int deleteByIds(String []ids){
    	Integer typeId = asSpotsMapper.queryTypeId(ids[0]);
    	List<String> arr = Arrays.asList(ids);
    	Map<String,Object> map = new HashMap<>();
    	map.put("ids", arr);
    	map.put("typeId",typeId);
    	asSpotsMapper.deleteImgsByIds(map);
        return asSpotsMapper.deleteCateByIds(ids);
    }
    /**
     * 批量下架
     * @param ids
     * @return
     */
    public int offSaleAll(String []ids){
        return asSpotsMapper.offSaleAll(ids);
    }
    
    /**
	 * 查询图片
	 */
	   public AsConsultationImgs selectByPrimaryKey(Integer id) {
	        return asSpotsMapper.selectByPrimaryKeyImg(id);
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
        	return asSpotsMapper.updateByPrimaryKeySelectiveImg(asConsultationImgs);
        }
        	return 0;
    }

   public int deleteByPrimaryKey(Integer id){
       return asSpotsMapper.deleteByPrimaryKeyImg(id);
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
       asConsultationImgs.setTypeId(asConsultationImgs.getTypeId());
       return asSpotsMapper.insertSelectiveImg(asConsultationImgs);
   }
   
   /**
 	 * 回显查询城市
 	 * @param cityId
 	 * @return
 	 */
	public List<AsCity> queryCityList(Integer provinceId) {
		return this.asSpotsMapper.queryCityList(provinceId);
	}

	/**
	 * 导入excel数据
	 */
	public void importExcel(List<List<Object>> excelResult) {
		
		for(List<Object> obj : excelResult){
			AsConsultationSpots spots = new AsConsultationSpots();
			
			AsConsultationType typeId = excelMapper.queryTypeId(obj.get(0).toString());
			spots.setTypeId(typeId.getConsultationTypeId());
			
			AsProvince provinceId = excelMapper.queryProvinceId(obj.get(1).toString());
			spots.setProvinceId(provinceId.getProvinceId());
			
			AsCity cityId = excelMapper.queryCityId(obj.get(2).toString());
			spots.setCityId(cityId.getCityId());
			
			AsArea areaId = excelMapper.queryAreaId(obj.get(3).toString());
			spots.setAreaId(areaId.getAreaId());
			
			AsYpBaseCategory ypId = excelMapper.queryYpId(obj.get(4).toString());
			spots.setYpBaseCategoryId(ypId.getId());
			
			spots.setName(obj.get(5).toString());
			spots.setCoverImg(obj.get(6).toString());
			spots.setVisitCount((int)Float.parseFloat(obj.get(7).toString()));
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			spots.setPublicTime(time.format(date));
			//spots.setStarLevel((int)Float.parseFloat(obj.get(8).toString()));
			spots.setStatus((int)Float.parseFloat(obj.get(9).toString()));
			spots.setAddress(obj.get(10).toString());
			spots.setOpenTime(obj.get(11).toString());
			spots.setLng(obj.get(12).toString());
			spots.setLat(obj.get(13).toString());
			spots.setLine(obj.get(14).toString());
			spots.setConsultationDesc(obj.get(15).toString());
			spots.setPhone(obj.get(16).toString());
			//添加基本数据
			asSpotsMapper.insertFood(spots);
			
			
		}
	}
	
}
