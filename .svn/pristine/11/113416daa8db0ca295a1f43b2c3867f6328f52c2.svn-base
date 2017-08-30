package com.aoshi.service.manage.consultation.consultationInfo;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.controller.manage.consultation.excel.Converter;
import com.aoshi.dao.AsCateMapper;
import com.aoshi.dao.ExcelMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationCity;
import com.aoshi.domain.AsConsultationFood;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationShop;
import com.aoshi.domain.AsConsultationStreetFood;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import com.aoshi.util.UuidUtil;
/**
 * 美食发布
 * @author strong
 * @version 1.0
 * 2016年11月29日上午10:03:40
 */
@Service
@Transactional
public class AsCateService extends AsBaseService {
	
	@Autowired 
	private AsCateMapper asCateMapper;
	
	@Autowired
	private ExcelMapper excelMapper;
	
	/**
	 * 查询美食
	 * @return
	 */
	public List<AsYpBaseCategory> queryFood(Integer typeId) {
		return this.asCateMapper.queryFood(typeId);
	}
	/**
	 * 查询省份
	 * @return
	 */
	public List<AsProvince> queryPro() {		
		return this.asCateMapper.queryPro();
	}
	/**
	 * 查询城市
	 * @return
	 */
	public List<AsCity> queryCity(Integer id) {
		return this.asCateMapper.queryCity(id);
	}
	
	/**
	 * 查询区域
	 * @return
	 */
	public List<AsArea> queryArea(Integer id) {
		return this.asCateMapper.queryArea(id);
	}
	
	/**
	 * 查询商圈
	 */
	public List<AsBusinessDistrict> queryBusiness(Integer id) {
		return this.asCateMapper.queryBusiness(id);
	}


	/**
	 * 查询类型
	 * @return
	 */
	public AsConsultationType queryType(String name) {
		return this.asCateMapper.queryType(name);
	}
	
	/**
	 * 发布美食
	 * @param food
	 * @return
	 */
	public int saveCate(AsConsultationFood food,String lonlat,MultipartFile file,MultipartFile[] imgs,AsConsultationImgs asImgs) {
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
				food.setCoverImg(filePath+"/"+fileName);				
			}
			//封装经纬度
			if(!StringUtils.isEmpty(lonlat)){
				String[] arr = lonlat.split(",");
				food.setLng(arr[0].trim());
				food.setLat(arr[1].trim());
			}
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			food.setPublicTime(time.format(date));
			food.setVisitCount(0);				
		}
		int result = this.asCateMapper.insertFood(food);		
		//多图片上传
		manyPic(imgs,asImgs,food);
		
		return result;
	}
	
	/**
	 * 遍历多张图片
	 * @param imgs
	 */
	private void manyPic(MultipartFile[] imgs,AsConsultationImgs asImgs,AsConsultationFood food) {
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
					asImgs.setConsultationId(food.getConsultationFoodId());
					this.asCateMapper.insertImgs(asImgs);
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
	 * 查询所有美食信息
	 * @return
	 */
	public List<AsConsultationFood> queryAllCate(AsConsultationFood food) {
		
		return this.asCateMapper.queryAllCate(food);
	}
	
	/**
	 * 根据id查询美食信息
	 * @param id
	 * @return
	 */
	public AsConsultationFood queryCateById(Integer id) {
		 return (AsConsultationFood) this.asCateMapper.selectByPrimaryKey(id);
	}
	
	/**
	 * 更新美食资讯
	 * @param asConsultationFood
	 * @param lonlat
	 */
	
	 public int update(AsConsultationFood asConsultationFood,String latlng,MultipartFile file) {
	        
		 if(!StringUtils.isEmpty(file)&&!StringUtils.isEmpty(file.getOriginalFilename())){
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
					asConsultationFood.setCoverImg(filePath+"/"+fileName);				
				}
	        }
	        if(!StringUtils.isEmpty(latlng)){
	        	String[] arr = latlng.split(",");
	        	asConsultationFood.setLat(arr[0].trim());
	        	asConsultationFood.setLng(arr[1].trim());
	        }
	        
	        return asCateMapper.updateCate(asConsultationFood);
	    }

	  
	    	
	/**
	 * 根据id,和typeId删除美食资讯
	 * @param id
	 * @return
	 */	
	 public int delete(Integer consultationFoodId,Integer typeId){
		 int status = asCateMapper.deleteByPrimaryKey(consultationFoodId);
		 asCateMapper.deleteByPrimaryKeyforImgs(consultationFoodId,typeId);
		 return status;
	 
	 }
	 
	 
	
	/**
	 * 更新状态
	 */
	public Object editStatus(BaseController c) {

		initialized(c);

		operaFlag = asCateMapper.updateByPrimaryKeySelective(pd) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");

		return renderSuccess();
	}
	
	/**
	 *根据id查询图片
	 * @param id
	 * @return
	 */
	public List<AsConsultationImgs> queryImgs(Integer id,Integer typeId) {
		return this.asCateMapper.queryImgsById(id,typeId);
	}
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
    public int deleteByIds(String []ids){
    	Integer typeId = asCateMapper.queryTypeId(ids[0]);
    	List<String> arr = Arrays.asList(ids);
    	Map<String,Object> map = new HashMap<>();
    	map.put("ids", arr);
    	map.put("typeId",typeId);
    	asCateMapper.deleteImgsByIds(map);
        return asCateMapper.deleteCateByIds(ids);
    }
    
    /**
     * 批量下架
     * @param ids
     * @return
     */
    public int offSaleAll(String []ids){
        return asCateMapper.offSaleAll(ids);
    }
    
    /**
	 * 查询图片
	 */
	   public AsConsultationImgs selectByPrimaryKey(Integer id) {
	        return asCateMapper.selectByPrimaryKeyImg(id);
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
       
        	return asCateMapper.updateByPrimaryKeySelectiveImg(asConsultationImgs);
        }
        	return 0;
    }

   public int deleteByPrimaryKey(Integer id){
       return asCateMapper.deleteByPrimaryKeyImg(id);
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
       return asCateMapper.insertSelectiveImg(asConsultationImgs);
   }
   	
   	/**
   	 * 回显查询城市
   	 * @param cityId
   	 * @return
   	 */
	public List<AsCity> queryCityList(Integer provinceId) {
		return this.asCateMapper.queryCityList(provinceId);
	}
	
	/**
	 * 导入excel数据
	 */
	public void importExcel(List<List<Object>> excelResult,List<List<Object>> excelImgs) {
		
		for(List<Object> obj : excelResult){
			AsConsultationFood f = new AsConsultationFood();
			
			AsConsultationType typeId = excelMapper.queryTypeId(obj.get(0).toString());
			f.setTypeId(typeId.getConsultationTypeId());
			
			AsProvince provinceId = excelMapper.queryProvinceId(obj.get(1).toString());
			f.setProvinceId(provinceId.getProvinceId());
			
			AsCity cityId = excelMapper.queryCityId(obj.get(2).toString());
			f.setCityId(cityId.getCityId());
			
			AsArea areaId = excelMapper.queryAreaId(obj.get(3).toString());
			f.setAreaId(areaId.getAreaId());
			
			AsBusinessDistrict busId = excelMapper.queryBusId(obj.get(4).toString(),areaId.getAreaId());
			f.setBusinessDistrictId(busId.getBusinessDistrictId()==null? 0 : busId.getBusinessDistrictId());
			
			AsYpBaseCategory ypId = excelMapper.queryYpId(obj.get(5).toString());
			f.setYpBaseCategoryId(ypId.getId());
			
			f.setName(obj.get(6).toString());
			f.setCoverImg(obj.get(7).toString());
			//f.setStarLevel((int)Float.parseFloat(obj.get(8).toString()));
			f.setVisitCount((int)Float.parseFloat(obj.get(9).toString()));
			f.setStatus((int)Float.parseFloat(obj.get(10).toString()));
			f.setAddress(obj.get(11).toString());
			f.setOpenTime(obj.get(12).toString());
			f.setPhone(obj.get(13).toString());
			f.setLng(obj.get(14).toString());
			f.setLat(obj.get(15).toString());
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			f.setPublicTime(time.format(date));
			//添加基本数据
			asCateMapper.insertFood(f);
			
			
			//for(List<Object> imgs : excelImgs){
			
				for(int i = 0 ; i <excelImgs.size();){
				AsConsultationImgs img = new AsConsultationImgs();
				if(excelImgs.get(i).get(0).toString().equals(obj.get(6).toString())){
					img.setConsultationId(f.getConsultationFoodId());
					img.setTypeId(typeId.getConsultationTypeId());
					img.setImgUrl(excelImgs.get(i).get(1).toString());
					//添加多图片
					asCateMapper.insertImgs(img);
					excelImgs.remove(excelImgs.get(i));
				}else{
					continue;
				}
			}
		}
	}
	
	

	
}
