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
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsShoppingMapper;
import com.aoshi.dao.ExcelMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationShopping;
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
 * 逛街资讯
 * @author strong
 * @version 1.0
 * 2016年11月30日下午1:49:47
 */
@Service
@Transactional
public class AsShoppingService extends AsBaseService {
	
	@Autowired
	private AsShoppingMapper asShoppingMapper;
	
	@Autowired
	private ExcelMapper excelMapper;
	
	/**
	 * 查询逛街
	 * @return
	 */
	public List<AsYpBaseCategory> queryFood(Integer typeId) {
		return this.asShoppingMapper.queryFood(typeId);
	}
	/**
	 * 查询省份
	 * @return
	 */
	public List<AsProvince> queryPro() {		
		return this.asShoppingMapper.queryPro();
	}

	/**
	 * 查询城市
	 * @return
	 */
	public List<AsCity> queryCity(Integer id) {
		return this.asShoppingMapper.queryCity(id);
	}
	
	/**
	 * 查询区域
	 * @return
	 */
	public List<AsArea> queryArea(Integer id) {
		return this.asShoppingMapper.queryArea(id);
	}
	public AsConsultationType queryType(String name) {
		return this.asShoppingMapper.queryType(name);
	}
	/**
	 * 查询商圈
	 */
	public List<AsBusinessDistrict> queryBusiness(Integer id) {
		return this.asShoppingMapper.queryBusiness(id);
	}

	
	/**
	 * 保存逛街信息
	 * @param shopping
	 * @param bus 
	 * @param metro 
	 * @return
	 */
	public int saveShopping(AsConsultationShopping shopping,String lonlat, MultipartFile file,MultipartFile[] imgs,AsConsultationImgs asImgs, String metro, String bus) {
		
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
				shopping.setCoverImg(filePath+"/"+fileName);				
			}
			//封装经纬度
			if(!StringUtils.isEmpty(lonlat)){
				String[] arr = lonlat.split(",");
				shopping.setLng(arr[0].trim());
				shopping.setLat(arr[1].trim());
			}
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			shopping.setPublicTime(time.format(date));
			shopping.setVisitCount(0);
			if(shopping.getBusinessDistrictId()==null){
				shopping.setBusinessDistrictId(0);
			}
			
			//封装乘车路线
			String metroName = null;
	        if(!StringUtils.isEmpty(metro)){
	        	 metroName = "地铁:"+metro;
	        	 if(!StringUtils.isEmpty(bus)){
	        		 shopping.setRoute(metroName+";"+"公交:"+bus);
	        	 }else{
	        		 shopping.setRoute(metroName);
	        	 }
	        }else{
	        	 if(!StringUtils.isEmpty(bus)){
	        		 shopping.setRoute("公交:"+bus);
	        	 }
	        }
		}
		int result = this.asShoppingMapper.insertFood(shopping);		
		//多图片上传
		manyPic(imgs,asImgs,shopping);
		
		return result;
	}
	
	/**
	 * 遍历多张图片
	 * @param imgs
	 */
	private void manyPic(MultipartFile[] imgs,AsConsultationImgs asImgs,AsConsultationShopping shopping) {
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
					asImgs.setTypeId(shopping.getTypeId());					
					asImgs.setConsultationId(shopping.getConsultationShoppingId());
					this.asShoppingMapper.insertImgs(asImgs);
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
	 * 查询所有逛街信息
	 * @return
	 */
	public List<AsConsultationShopping> queryAllCate(AsConsultationShopping food) {
		
		return this.asShoppingMapper.queryAllCate(food);
	}
	
	/**
	 * 根据id查询逛街信息
	 * @param id
	 * @return
	 */
	public AsConsultationShopping querySpotsById(Integer id) {
		 AsConsultationShopping food= (AsConsultationShopping) this.asShoppingMapper.selectByPrimaryKey(id);
	return food;
	}
	
	/**
	 * 更新逛街资讯
	 * @param AsConsultationShopping
	 * @param bus 
	 * @param metro 
	 * @param lonlat
	 */
	
	 public int update(AsConsultationShopping AsConsultationShopping,String latlng,MultipartFile file, String metro, String bus) {
		
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
					AsConsultationShopping.setCoverImg(filePath+"/"+fileName);				
				}
	        }
	        if(!StringUtils.isEmpty(latlng)){
	        	String[] arr = latlng.split(",");
	        	AsConsultationShopping.setLat(arr[0].trim());
	        	AsConsultationShopping.setLng(arr[1].trim());
	        }
	        
	        String metroName = null;
	        if(!StringUtils.isEmpty(metro)){
	        	 metroName = "地铁:"+metro;
	        	 if(!StringUtils.isEmpty(bus)){
	        		 AsConsultationShopping.setRoute(metroName+";"+"公交:"+bus);
	        	 }else{
	        		 AsConsultationShopping.setRoute(metroName);
	        	 }
	        }else{
	        	 if(!StringUtils.isEmpty(bus)){
	        		 AsConsultationShopping.setRoute("公交:"+bus);
	        	 }
	        }
	        return asShoppingMapper.updateCate(AsConsultationShopping);
	    }

	  
	    	
	/**
	 *  根据id,type删除逛街资讯
	 * @param id
	 * @return
	 */	
	 public int delete(Integer consultationShoppingId,Integer typeId){
		 int status = asShoppingMapper.deleteByPrimaryKey(consultationShoppingId);
		 asShoppingMapper.deleteByPrimaryKeyforImgs(consultationShoppingId,typeId);
		 return status;
	 
	 }
	 
	/**
	 * 更新状态
	 */
	public Object editStatus(BaseController c) {

		initialized(c);

		operaFlag = asShoppingMapper.updateByPrimaryKeySelective(pd) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");

		return renderSuccess();
	}
	
	/**
	 *根据id查询图片
	 * @param id
	 * @return
	 */
	public List<AsConsultationImgs> queryImgs(Integer id,Integer typeId) {
		return this.asShoppingMapper.queryImgsById(id,typeId);
	}
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
    public int deleteByIds(String []ids){
    	Integer typeId = asShoppingMapper.queryTypeId(ids[0]);
    	List<String> arr = Arrays.asList(ids);
    	Map<String,Object> map = new HashMap<>();
    	map.put("ids", arr);
    	map.put("typeId",typeId);
    	asShoppingMapper.deleteImgsByIds(map);
        return asShoppingMapper.deleteCateByIds(ids);
    }
    
    /**
     * 批量下架
     * @param ids
     * @return
     */
    public int offSaleAll(String []ids){
        return asShoppingMapper.offSaleAll(ids);
    }
    
    /**
	 * 查询图片
	 */
	   public AsConsultationImgs selectByPrimaryKey(Integer id) {
	        return asShoppingMapper.selectByPrimaryKeyImg(id);
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
        	return asShoppingMapper.updateByPrimaryKeySelectiveImg(asConsultationImgs);
        }
        	return 0;
    }

   public int deleteByPrimaryKey(Integer id){
       return asShoppingMapper.deleteByPrimaryKeyImg(id);
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
       return asShoppingMapper.insertSelectiveImg(asConsultationImgs);
   }

   /**
  	 * 回显查询城市
  	 * @param cityId
  	 * @return
  	 */
	public List<AsCity> queryCityList(Integer provinceId) {
		return this.asShoppingMapper.queryCityList(provinceId);
	}
	
	/**
	 * 导入excel数据
	 */
	public void importExcel(List<List<Object>> excelResult) {
		
		for(List<Object> obj : excelResult){
			AsConsultationShopping shopping = new AsConsultationShopping();
			
			AsConsultationType typeId = excelMapper.queryTypeId(obj.get(0).toString());
			shopping.setTypeId(typeId.getConsultationTypeId());
			
			AsProvince provinceId = excelMapper.queryProvinceId(obj.get(1).toString());
			shopping.setProvinceId(provinceId.getProvinceId());
			
			AsCity cityId = excelMapper.queryCityId(obj.get(2).toString());
			shopping.setCityId(cityId.getCityId());
			
			AsArea areaId = excelMapper.queryAreaId(obj.get(3).toString());
			shopping.setAreaId(areaId.getAreaId());
			
			AsBusinessDistrict busId = excelMapper.queryBusId(obj.get(4).toString(),areaId.getAreaId());
			shopping.setBusinessDistrictId(busId.getBusinessDistrictId()==null? 0 : busId.getBusinessDistrictId());
			
			AsYpBaseCategory ypId = excelMapper.queryYpId(obj.get(5).toString());
			shopping.setYpBaseCategoryId(ypId.getId());
			
			shopping.setName(obj.get(6).toString());
			shopping.setCoverImg(obj.get(7).toString());
			//shopping.setRecommendLevel((int)Float.parseFloat(obj.get(8).toString()));
			shopping.setRecommendResult(obj.get(9).toString());
			shopping.setVisitCount((int)Float.parseFloat(obj.get(10).toString()));
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			shopping.setPublicTime(time.format(date));
			shopping.setStatus((int)Float.parseFloat(obj.get(11).toString()));
			shopping.setAddress(obj.get(12).toString());
			shopping.setLng(obj.get(13).toString());
			shopping.setLat(obj.get(14).toString());
			shopping.setRoute(obj.get(15).toString());
			shopping.setShoppingDesc(obj.get(16).toString());
			//添加基本数据
			asShoppingMapper.insertFood(shopping);
			
			
		}
	}

}
