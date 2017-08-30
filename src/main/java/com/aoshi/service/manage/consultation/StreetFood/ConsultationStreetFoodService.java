package com.aoshi.service.manage.consultation.StreetFood;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationStreetFoodMapper;
import com.aoshi.domain.AsConsultationStreetFood;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Administrator on 2016/12/1.
 */
@Service
public class ConsultationStreetFoodService extends AsBaseService{
    @Autowired
    AsConsultationStreetFoodMapper asConsultationStreetFoodMapper;

    public List<AsConsultationStreetFood> findByShopId(Integer id) {
        return asConsultationStreetFoodMapper.findByShopId(id);
    }

    public int deleteByPrimaryKey(Integer id){
        return asConsultationStreetFoodMapper.deleteByPrimaryKey(id);
    }

    public List<AsConsultationStreetFood> selectInId(String[] FoodId) {
        return asConsultationStreetFoodMapper.selectInId(FoodId);
    }

    public AsConsultationStreetFood selectByPrimaryKey(Integer id) {
        return asConsultationStreetFoodMapper.selectByPrimaryKey(id);
    }

    public int save(AsConsultationStreetFood asConsultationStreetFood,BaseController c,Integer consultationShopId) {
        initialized(c);
        String foodImg = pd.getStringRequired("img");
        ValidatorBreakException.NOT_TRUE(!(foodImg == null || foodImg
                .trim().length() == 0 ||"".equals(foodImg)), "请上传菜式图！");
        uploadModule(UploadPathEnum.BRAND, "img");
        String foodImgUrl = pd.getStringRequired("img");
        asConsultationStreetFood.setFoodImg(foodImgUrl);
        asConsultationStreetFood.setConsultationShopId(consultationShopId);
        return asConsultationStreetFoodMapper.insertSelective(asConsultationStreetFood);
    }

    public int updateByPrimaryKeySelective(AsConsultationStreetFood asConsultationStreetFood,BaseController c){
        initialized(c);
        uploadModule(UploadPathEnum.BRAND, "img");
        String foodImg = pd.getStringRequired("img");
        if(!StringUtils.isEmpty(foodImg)){
            asConsultationStreetFood.setFoodImg(foodImg);
        }
        return asConsultationStreetFoodMapper.updateByPrimaryKeySelective(asConsultationStreetFood);
    }

}
