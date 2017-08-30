package com.aoshi.controller.manage;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsBeaconUidMapper;
import com.aoshi.domain.AsBeacon;
import com.aoshi.domain.AsBeaconUid;
import com.aoshi.entity.Page;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.manage.BeaconUUIDService;
import com.aoshi.util.DateUtil;

@Controller
@RequestMapping("/beacon")
public class BeaconUUIDController extends BaseController {

	/**
	 * beacon UUID 管理
	 * @author chenwz
	 * 2017、3 、24
	 */
	private static final String BEACONURL="beacon/";
	@Autowired BeaconUUIDService  beaconUUIDService;
	@Autowired AsBeaconUidMapper  beaconUidMapper;
	
	/**
	 * beaconUUID列表
	 * @return
	 */
	@RequestMapping(value ="/beaconUUIDList")
	public Object beaconUUIDList(){
		return beaconUUIDService.getbeaconUUIDList(this);
	}
	
	/**
	 * 跳转新增页面
	 * @return
	 */
	@RequestMapping(value ="/toAddBeaconUUID")
	public Object toAddBeaconUUID(){
		return beaconUUIDService.toBeaconUUID();
	}
	
	/**
	 * 新增操作
	 * @param asBeaconUid
	 * @return
	 */
	@RequestMapping(value = "/addBeaconUUID")
    @ResponseBody
    public Object addBeacon(AsBeaconUid asBeaconUid) {
        
        asBeaconUid.setCreateTime(DateUtil.getTime());
        int result = beaconUidMapper.insertSelective(asBeaconUid); 
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }
	
	/**
     * 编辑页面
     * @param beaconId
     * @param map
     * @return
     */
    @RequestMapping(value ="toEdit")
    public String toEdit(Integer beaconUidId,ModelMap map){
        AsBeaconUid asBeaconUid = beaconUidMapper.selectByPrimaryKey(beaconUidId);
        map.put("asBeaconUid", asBeaconUid);
        return BEACONURL+"editBeaconUUID";
    }
    
    /**
     * 更新
     * @param asBeacon
     * @return
     */
    @RequestMapping(value ="update")
    @ResponseBody
    public Map update(AsBeaconUid asBeaconUid){
        int result = beaconUidMapper.updateByPrimaryKeySelective(asBeaconUid);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delById")
    @ResponseBody
    public int delById(Integer id) {
        return beaconUUIDService.deleteByBeaconId(id);
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll(String []ids) {
        return beaconUUIDService.deleteByBeaconIds(ids);
    }
}
