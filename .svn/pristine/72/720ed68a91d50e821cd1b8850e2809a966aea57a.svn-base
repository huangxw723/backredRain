package com.aoshi.service.manage.consultation.consultationInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.domain.AsDictParam;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.PageData;

/**
 * 优惠券周边距离配置 服务层
 * @author：wendy
 * @date：
 */
@Service
public class AsCouponDistanceService extends AsBaseService {

	//@Autowired
	//AsConsultationCityMapper mapper;
	
	@Autowired
	AsDictParamMapper mapper;

	/**
	 * 列表显示
	 * @param AsDictParam obj
	 */
/*	public List<AsDictParam> selectByName(String obj) {
		//return mapper.selectByPrimaryKey(obj);
		return mapper.selectByName(obj);
	}*/
	
	/*public List<AsConsultationType> selectByName(String name) {
		return mapper.findByName(name);
	}
*/
	
	/*---------------------------------------增删改查------------------------------------*/
	
	/** 
	 * 保存新增 
	 */
	public AsDictParam saveAdd(AsDictParam obj) {
		//保存
		int result = mapper.insertSelective(obj);
		if (result > 0) {
			//成功的
		}
		return obj;
	}

	/** 
	 * 保存编辑
	 */
	@SuppressWarnings("deprecation")
	public AsDictParam saveEdit( AsDictParam obj) {
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
	public AsDictParam selectByPrimaryKey(Integer id) {
		return mapper.selectByPrimaryKey(id);
	}

	/*public List<AsDictParam> queryList(AsDictParam obj) {
		return mapper.;
	}*/
	
	/*public List<AsDictParam> selectByName(String dictValue) {
		return mapper.selectByName(dictValue);
	}*/
	
	/**
	 * 列表显示
	 * @param AsConsultationHotel obj
	 */
	public List<AsDictParam> queryList(AsDictParam obj) {
		return mapper.queryList(obj);
	}
	
	
	
}
