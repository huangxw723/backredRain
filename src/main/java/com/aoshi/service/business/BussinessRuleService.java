package com.aoshi.service.business;


import com.aoshi.dao.AsActivityDiscMapper;
import com.aoshi.dao.AsActivityShakeMapper;
import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsActivityDisc;
import com.aoshi.domain.AsActivityShake;
import com.aoshi.domain.AsStore;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.util.*;
import com.google.gson.JsonParser;
import net.sf.json.JSONArray;
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
 * BussinessRuleService
 *
 * @author zf
 * @date 10/24/16
 */
@Service
public class BussinessRuleService {

    @Autowired
    AsActivityShakeMapper activityShakeMapper;

    @Autowired
    AsYpBaseCategoryMapper categoryMapper;

    @Autowired
    AsActivityDiscMapper activityDiscMapper;

    @Autowired
    private AsStoreMapper storeMapper;

    public Map<String,Object> findByPrizeConfig(Integer storeId) {
        Map<String, Object> data = new HashMap<String, Object>();
//        List<AsActivityShake> asActivityShakes =  activityShakeMapper.selectAll();
        // 摇奖记录 默认3 条
        List<AsActivityShake> asActivityShakes = activityShakeMapper.selectByStoreId(storeId);

        if (asActivityShakes.size() <  3){
            for (int i = 0; i < 3 - asActivityShakes.size(); i++){
                AsActivityShake asActivityShake = new AsActivityShake();
                asActivityShake.setStoreId(storeId);
                asActivityShake.setProbability(BigDecimal.ZERO);
                asActivityShake.setCreateTime(DateUtil.getTime());
                activityShakeMapper.insert(asActivityShake);
            }
        }
        asActivityShakes = activityShakeMapper.selectByStoreId(storeId);
        List<AsActivityDisc> discs = activityDiscMapper.selectByStoreId(storeId);

            if (discs.size() < 6) {
            for (int i = 0; i < 6 - discs.size() ; i++){
                AsActivityDisc asActivityDisc = new AsActivityDisc();
                asActivityDisc.setCreateTime(DateUtil.getTime());
                asActivityDisc.setStoreId(storeId);
                asActivityDisc.setProbability(BigDecimal.ZERO);
                asActivityDisc.setCategoryId(0);
                activityDiscMapper.insert(asActivityDisc);
            }
        }
        discs = activityDiscMapper.selectByStoreId(storeId);

        data.put("shake", asActivityShakes);
        List<AsYpBaseCategory> category = categoryMapper.selectAllPrize();
        for (int i =0;i < category.size(); i++) {
            if ("现金红包".equals(category.get(i).getName()))
                category.remove(category.get(i));
        }
        data.put("categories", category);

        // 转盘记录 默认6 条
        data.put("disc", discs);
        return data;
    }


    public void savePrizeData(String discss, String shakess, Integer storeId, boolean isCooperation, MultipartFile[] files) throws IOException {
        AsActivityDisc[] discs = new ObjectMapper().readValue(discss,AsActivityDisc[].class);
        AsActivityShake[] shakes = new ObjectMapper().readValue(shakess,AsActivityShake[].class);
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
//
            d.setStoreId(storeId);
//            if (d.getActivityDiscId() == null) {
//                activityDiscMapper.insert(d);
//            }else{
                activityDiscMapper.updateByPrimaryKeySelective(d);
//            }
        }

        for (AsActivityShake s : shakes) {
            s.setStoreId(storeId);
//            if (s.getActivityShakeId() == null) {
//                activityShakeMapper.insert(s);
//            }else{
                activityShakeMapper.updateByPrimaryKeySelective(s);
//            }
        }
        AsStore asStore = storeMapper.selectByPrimaryKey(storeId);
        if (isCooperation){
            asStore.setIsCooperation(1);
        }else{
            asStore.setIsCooperation(0);
        }
        storeMapper.updateByPrimaryKeySelective(asStore);
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

    /**
     * 删除
     * @param id
     */
    public void delete(int id) {
        activityShakeMapper.deleteByPrimaryKey(id);
    }

    /**
     *
     * @param asActivityShake
     */
    public void saveShake(AsActivityShake asActivityShake) {
        activityShakeMapper.insert(asActivityShake);
    }
}
