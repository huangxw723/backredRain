package com.aoshi.service.manage.consultation.consultationInfo;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsSpecialtyMapper;
import com.aoshi.dao.ExcelMapper;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsBusinessDistrict;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationImgs;
import com.aoshi.domain.AsConsultationShopping;
import com.aoshi.domain.AsConsultationSpecialty;
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
 * 特产资讯
 * @author strong
 * @version 1.0
 * 2016年11月30日下午1:49:47
 */
@Service
@Transactional
public class AsSpecialtyService extends AsBaseService {
	
	@Autowired
	private AsSpecialtyMapper asSpecialtyMapper;
	
	@Autowired
	private ExcelMapper excelMapper;
	
	/**
	 * 查询省份
	 * @return
	 */
	public List<AsProvince> queryPro() {		
		return this.asSpecialtyMapper.queryPro();
	}

	/**
	 * 查询城市
	 * @return
	 */
	public List<AsCity> queryCity(Integer id) {
		return this.asSpecialtyMapper.queryCity(id);
	}
	
	/**
	 * 查询区域
	 * @return
	 */
	public List<AsArea> queryArea(Integer id) {
		return this.asSpecialtyMapper.queryArea(id);
	}
	
	/**
	 * 资讯类型
	 * @param name
	 * @return
	 */
	public AsConsultationType queryType(String name) {
		return this.asSpecialtyMapper.queryType(name);
	}
	
	/**
	 * 保存特产信息
	 * @param shopping
	 * @return
	 */
	public int saveSpecialty(AsConsultationSpecialty shopping,MultipartFile file ) {
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
			
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			shopping.setPublicTime(time.format(date));
			shopping.setVisitCount(0);				
		}
		 return this.asSpecialtyMapper.insertFood(shopping);		
	
		
	
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
	 * 查询所有特产信息
	 * @return
	 */
	public List<AsConsultationSpecialty> queryAllCate(AsConsultationSpecialty food) {
		
		return this.asSpecialtyMapper.queryAllCate(food);
	}
	
	/**
	 * 根据id查询特产信息
	 * @param id
	 * @return
	 */
	public AsConsultationSpecialty queryById(Integer id) {
		return  (AsConsultationSpecialty) this.asSpecialtyMapper.selectByPrimaryKey(id);
	
	}
	
	/**
	 * 更新特产资讯
	 * @param AsConsultationSpecialty
	 * @param lonlat
	 */
	
	 public int update(AsConsultationSpecialty AsConsultationSpecialty,MultipartFile file) {

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
					AsConsultationSpecialty.setCoverImg(filePath+"/"+fileName);				
				}
	        }
        
	        return asSpecialtyMapper.updateCate(AsConsultationSpecialty);
	    }

	  
	    	
	/**
	 * 根据id删除特产资讯
	 * @param id
	 * @return
	 */	
	public Object delete(BaseController c) {

		initialized(c);

		operaFlag = asSpecialtyMapper.deleteByPrimaryKey(pd) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
	
	/**
	 * 更新状态
	 */
	public Object editStatus(BaseController c) {

		initialized(c);

		operaFlag = asSpecialtyMapper.updateByPrimaryKeySelective(pd) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");

		return renderSuccess();
	}
	

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
    public int deleteByIds(String []ids){
        return asSpecialtyMapper.deleteCateByIds(ids);
    }
    
    /**
     * 批量下架
     * @param ids
     * @return
     */
    public int offSaleAll(String []ids){
        return asSpecialtyMapper.offSaleAll(ids);
    }
    
    /**
 	 * 回显查询城市
 	 * @param cityId
 	 * @return
 	 */
	public List<AsCity> queryCityList(Integer provinceId) {
		return this.asSpecialtyMapper.queryCityList(provinceId);
	}
	
	/**
	 * 导入excel数据
	 */
	public void importExcel(List<List<Object>> excelResult) {
		
		for(List<Object> obj : excelResult){
			AsConsultationSpecialty specialty = new AsConsultationSpecialty();
			
			AsConsultationType typeId = excelMapper.queryTypeId(obj.get(0).toString());
			specialty.setTypeId(typeId.getConsultationTypeId());
			
			AsProvince provinceId = excelMapper.queryProvinceId(obj.get(1).toString());
			specialty.setProvinceId(provinceId.getProvinceId());
			
			AsCity cityId = excelMapper.queryCityId(obj.get(2).toString());
			specialty.setCityId(cityId.getCityId());
			
			AsArea areaId = excelMapper.queryAreaId(obj.get(3).toString());
			specialty.setAreaId(areaId.getAreaId());
			
			
			specialty.setName(obj.get(4).toString());
			specialty.setCoverImg(obj.get(5).toString());
			specialty.setVisitCount((int)Float.parseFloat(obj.get(6).toString()));
			Date date = new Date();
			SimpleDateFormat  time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			specialty.setPublicTime(time.format(date));
			specialty.setStatus((int)Float.parseFloat(obj.get(7).toString()));
			specialty.setConsultationDesc(obj.get(8).toString());
			//添加基本数据
			asSpecialtyMapper.insertFood(specialty);
			
			
		}
	}


}
