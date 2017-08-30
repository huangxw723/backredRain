package com.aoshi.controller.manage;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.dao.AsActivityShakeMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.CalNumRecordMapper;
import com.aoshi.dao.CalNumSetMapper;
import com.aoshi.domain.*;
import com.aoshi.entity.system.User;
import com.aoshi.service.manage.PrizeConfigService;
import com.aoshi.service.manage.PrizeRuleService;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.RandomUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.jfree.data.DataUtilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.*;
import java.io.IOException;

/**
 * @author cwz
 * 
 * 抽奖概率设置
 *
 * @date 17/2/21
 */
@Controller()
@RequestMapping("/prizeRule")
public class PrizeRuleController {

    private static final String BIGWHEELURL="manage/bigwheel/";
    
    private static final String SHAKEURL="manage/shake/";

    private static Log log = LogFactory.getLog(PrizeRuleController.class);

    @Autowired
    PrizeRuleService prizeRuleService;
    @Autowired
    AsStoreMapper asStoreMapper;
    @Autowired
    AsDictParamMapper asDictParamMapper;
    @Autowired
    AsActivityShakeMapper activityShakeMapper;
    @Autowired
    AsShopMapper asShopMapper;
    
    //大转盘规则设置
    
    /** 
     * 跳转大转盘规则设置页面
     * @param map
     * @return
     */
    @RequestMapping("/toEditPrize")
    public String toEditPrize(ModelMap map) {    	
    	//AsDictParam asDictParam= asDictParamMapper.findAllByKeyCode(DictParam.PARAM_USER_PRIZE_COUNT);  //每人每天参与次数  	    	
        Map<String, Object> prizeData = prizeRuleService.findbigWheelByPrizeConfig();    	       
        map.put("prizeData", prizeData);
       //map.put("asDictParam", asDictParam);   	            	                 
        return BIGWHEELURL + "editPrize";
    }

    @RequestMapping("/saveBigWheelPrize")
    public String savesaveBigWheelPrize( String discs,@RequestParam(value = "fileInput" ,required = true) MultipartFile [] fileInput,
    		ModelMap map) throws IOException {
        prizeRuleService.saveBigWheelPrizeData(discs,fileInput);
       // AsDictParam asDictParam= asDictParamMapper.findAllByKeyCode(DictParam.PARAM_USER_PRIZE_COUNT); /每人每天参与次数 
        Map<String, Object> prizeData = prizeRuleService.findbigWheelByPrizeConfig();
        map.put("prizeData", prizeData);
        //map.put("asDictParam", asDictParam);
     
        return BIGWHEELURL + "editPrize";
    }

   
    //摇一摇规则
    /**@author 
     * 跳转摇一摇规则设置页面
     * @param map
     * @return
     */
    @RequestMapping("/goShake.do")
    public String goAddShake(ModelMap map){     	
    	//字典 摇奖次数
    	AsDictParam asDictParam= asDictParamMapper.findAllByKeyCode(DictParam.PARAM_USER_SHAKE_COUNT);
    	//AsStore asStore=new AsStore();
    	//List<AsStore> asStores=asStoreMapper.selectAll();
    		 Map<String, Object> prizeData = prizeRuleService.findShakeByPrizeConfig();  	        
    	        map.put("prizeData", prizeData);
    	        map.put("asDictParam", asDictParam);
    	        //权限控制
    			/*if (StringUtils.isNotBlank(getCurrentUser().getROLE_ID())) {
    				map.put("roleId", getCurrentUser().getROLE_ID().equals("1")?"1":"0");
    			}*/
        return SHAKEURL + "editPrize";
    }
    
    
    /**
     * 更新保存规则页面信息
     * @author 
     * @return
     */   
    @RequestMapping("/saveShakePrize")
    public String saveShakePrize( String shakes,ModelMap map) throws IOException {
        prizeRuleService.savePrizeData(shakes);     
        Map<String, Object> prizeData = prizeRuleService.findShakeByPrizeConfig();
        AsDictParam asDictParam= asDictParamMapper.findAllByKeyCode(DictParam.PARAM_USER_SHAKE_COUNT);
        map.put("prizeData", prizeData);
        map.put("asDictParam", asDictParam);
       // AsStore store = asStoreMapper.selectByPrimaryKey(storeId);
       // map.put("store", store);
        return SHAKEURL + "editPrize";
    }
    
    
    /**
     * 跳转添加奖项页面
     * @author 
     * @return
     */
    @RequestMapping("goAddShake.do")
    public String goAddShake(){
       // map.put("storeId", storeId);
        return SHAKEURL + "addShake";
    }
    
    /**
     * 新增操作
     * @author 
     * @return
     */
    @RequestMapping("/saveShake")
    @ResponseBody
    public int saveShake(String name ){  
        List<AsActivityShake> asActivityShakes = activityShakeMapper.selectAll();
        if(asActivityShakes.size()>9){
             return 0;
        }else{
    	String shopId = getCurrentUser().getAs_shop_id();
    	Integer storeId = null;
    	if (!shopId.equals("null")) {// 获取商铺id如果不为null则是商场账号 ，反之则是后台管理员账号    	
    	AsShop asShop = asShopMapper.findByShopId(shopId); 
    	   storeId =  asShop.getStoreId();
    	}    
    	AsActivityShake asActivityShake = new AsActivityShake();
    	asActivityShake.setName(name);
    	asActivityShake.setStoreId(storeId);
        asActivityShake.setProbability(BigDecimal.ZERO);
        asActivityShake.setCreateTime(DateUtil.getTime());      
        prizeRuleService.saveShake(asActivityShake);
        return 1;
       }      
      
    }
    
    /**
     * 删除操作
     * @author 
     * @return
     */   
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, String> delete(int id) {
        Map<String, String> data = new HashMap<>();
       int i= prizeRuleService.delete(id);
        if(i==1){
        data.put("msg", "操作成功");
        data.put("status", "200");
        return data;
        }else if(i==100) {
        	data.put("msg", "操作失敗，有奖品正在使用该概率");  
        	data.put("status", "300");
            return data;
	    }
        
        data.put("msg", "不予许被执行该操作");   
        return data;
    }


    /**
     * 获取后台用户
     * @author 
     * @return
     */
    public User getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        return user;
    }

}
