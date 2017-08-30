package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aoshi.common.asenum.BeaconTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsBeaconUidMapper;
import com.aoshi.domain.AsBeacon;
import com.aoshi.domain.AsBeaconLink;
import com.aoshi.domain.AsBeaconRelation;
import com.aoshi.domain.AsBeaconUid;
import com.aoshi.entity.Page;
import com.aoshi.service.base.AsBaseService;

@Service
public class BeaconUUIDService extends AsBaseService {
	
	private static final String BEACONURL="beacon/";
    @Autowired AsBeaconUidMapper beaconUidMapper;
    
	/**
	 * benconUUID列表
	 * @param c
	 * @return
	 */
	public Object getbeaconUUIDList(BaseController c){
		initialized(c);
	    pageQueryModule(beaconUidMapper, "listAll", true);
		return renderView(BEACONURL+"beaconUUIDList");
	}
	/**
	 * 编辑页面
	 * @return
	 */
	public Object toBeaconUUID(){
		return renderView(BEACONURL+"addBeaconUUID");
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
    public int deleteByBeaconId(Integer id) {	       
    	int result = beaconUidMapper.deleteByPrimaryKey(id);	
		 if(result >0){
		    return 1;
		 }
	     return 0;
	}

	/**
	 * 批量删除
	 * @param ids
	 * 
	 */
    public int deleteByBeaconIds(String[] ids) {	     
	    int result = beaconUidMapper.deleteByIds(ids);
	    if(result >0){
	    	return 1;
	    }
	     return 0;
	}
    
}
