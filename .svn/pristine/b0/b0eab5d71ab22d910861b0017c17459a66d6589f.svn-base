package com.aoshi.service.manage;


import com.aoshi.common.asenum.DictParam;
import com.aoshi.dao.AsActivityDiscMapper;
import com.aoshi.dao.AsActivityShakeMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsPrizeConfigMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsActivityDisc;
import com.aoshi.domain.AsActivityShake;
import com.aoshi.domain.AsDictParam;
import com.aoshi.domain.AsPrizeConfig;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsStore;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.system.User;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.*;
import com.google.gson.JsonParser;

import net.sf.json.JSONArray;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 *
 * @author 
 * @date 17/2/21
 */
@Service
public class PrizeRuleService extends AsBaseService {

    @Autowired
    AsActivityShakeMapper activityShakeMapper;

    @Autowired
    AsYpBaseCategoryMapper categoryMapper;

    @Autowired
    AsActivityDiscMapper activityDiscMapper;

    @Autowired
    private AsStoreMapper storeMapper;
    
    @Autowired
    private AsDictParamMapper asDictParamMapper;
    
    @Autowired
    private AsShopMapper asShopMapper;
    
    @Autowired
    private AsPrizeConfigMapper prizeConfigMapper;
    
    //大转盘规则
    public Map<String,Object> findbigWheelByPrizeConfig() {
        Map<String, Object> data = new HashMap<String, Object>();
        // 无转盘记录 默认6 条
        List<AsActivityDisc> discs = activityDiscMapper.selectAll();
        if(discs.isEmpty()){
        	for(int i=1;i<6;i++){
        		AsActivityDisc activityDisc =new AsActivityDisc();
        		activityDisc.setCategoryType(i);
        		//activityDisc.setProbability(BigDecimal.ZERO);
        		activityDisc.setCreateTime(DateUtil.getTime());
        		activityDiscMapper.insertSelective(activityDisc);
        	}
        	
        	 List<AsActivityDisc> discsList = activityDiscMapper.selectAll();
        	 data.put("disc", discsList);
             return data;
        }
        data.put("disc", discs);
        return data;
    }
    
    public void saveBigWheelPrizeData(String discss,MultipartFile[] files) throws IOException {
        AsActivityDisc[] discs = new ObjectMapper().readValue(discss,AsActivityDisc[].class); 
       // AsDictParam asDictParam= asDictParamMapper.findAllByKeyCode(DictParam.PARAM_USER_PRIZE_COUNT);   
        //文件上传
        for (int i = 0;i < files.length; i++){
            String ftpFile = UuidUtil.get32UUID() + ".jpg";
            String ftpDir = Const.COUPONFILEPATHIMG;
            boolean flag = false;
            if(!StringUtils.isEmpty(files[i].getOriginalFilename())){
                try {
                    flag = ftpUpload(files[i].getBytes(), ftpFile,ftpDir);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(flag){
                discs[i].setIcon(ftpDir+"/"+ftpFile);
            }
        }       
        for (AsActivityDisc d: discs) {                                                                                                                                                                                                                            
        		 //asDictParam.setDictValue(d.getCount());   
        		//asDictParamMapper.updateByPrimaryKeySelective(asDictParam);    
        	if(d.getIcon()!=null){
        		 activityDiscMapper.updateByPrimaryKeySelective(d);  
        	}
                     	           
        }
        
    }
    
    private boolean ftpUpload(byte[] bytes,String ftpFile,String ftpDir){
        String path = Const.FILEPATHIMGDIR + ftpDir;
        //byte[] bytes = Base64.decode(goodsImg);

        FtpConManager ftpConManager = FtpConManager.getInstance();
        try {
            ftpConManager.login(PropertyUtils.getFTP_URL(),
                    PropertyUtils.getFTP_USERNAME(),
                    PropertyUtils.getFTP_PASS());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile);
    }


    //摇一摇规则
    
    public Map<String,Object> findShakeByPrizeConfig() {
        Map<String, Object> data = new HashMap<String, Object>();
        //List<AsActivityShake> asActivityShakes =  activityShakeMapper.selectAll();
        // 摇奖记录 默认3 条
        List<AsActivityShake> asActivityShakes = activityShakeMapper.selectAll();
        if (asActivityShakes.size() <  3){
        	String shopId = getCurrentUser().getAs_shop_id();
         	Integer storeId = null;
         	if (!shopId.equals("null")) {// 获取商铺id如果不为null则是商场账号 ，反之则是后台管理员账号    	
         	   AsShop asShop = asShopMapper.findByShopId(shopId); 
         	   storeId =  asShop.getStoreId();
         	}
            for (int i = 0; i < 3 - asActivityShakes.size(); i++){
                AsActivityShake asActivityShake = new AsActivityShake();
                asActivityShake.setStoreId(storeId);
                asActivityShake.setProbability(BigDecimal.ZERO);
                asActivityShake.setCreateTime(DateUtil.getTime());
                activityShakeMapper.insert(asActivityShake);
            }
            List<AsActivityShake> shake = activityShakeMapper.selectAll();
            data.put("shake", shake);
            return data;
        }
       
       
       // asActivityShakes = activityShakeMapper.selectByStoreId(storeId);
        data.put("shake", asActivityShakes);
        return data;
    }

    public void savePrizeData( String shakess) throws IOException {       
        AsActivityShake[] shakes = new ObjectMapper().readValue(shakess,AsActivityShake[].class);  
        AsDictParam asDictParam= asDictParamMapper.findAllByKeyCode(DictParam.PARAM_USER_SHAKE_COUNT);         
        for (AsActivityShake s : shakes) {            
        	asDictParam.setDictValue(s.getCount()); 
            asDictParamMapper.updateByPrimaryKeySelective(asDictParam);
            activityShakeMapper.updateByPrimaryKeySelective(s);
           
        }
        /*AsStore asStore = storeMapper.selectByPrimaryKey(storeId);
        if (isCooperation){
            asStore.setIsCooperation(1);
        }else{
            asStore.setIsCooperation(0);
        }
        storeMapper.updateByPrimaryKeySelective(asStore);*/
    }
   
    /**
     * 删除
     * @param id
     */
    public int delete(int id) {
    	List<AsActivityShake> asActivityShakes = activityShakeMapper.selectAll();    	
    	if(asActivityShakes.size()>3){
    		int result=prizeConfigMapper.fingByShakeId(id);
        	if(result == 0){
        		activityShakeMapper.deleteByPrimaryKey(id);
        		return 1;
        	}else {
				return 100;
			}       
    	}
    	
    	return 0;
    }

    /**
     *
     * @param asActivityShake
     */
    public void saveShake(AsActivityShake asActivityShake) {
        activityShakeMapper.insert(asActivityShake);
    }
    
    /**
     * 获取后台用户           *
     * @author 
     * @return user
    */
    public User getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        return user;
    }
}
