package com.aoshi.service.manage.navigation;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationNavigationMapper;
import com.aoshi.domain.AsConsultationNavigation;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by xjl on 2017/1/18.
 */
@Service
@Transactional
public class NavigationStoreService extends AsBaseService {

    @Autowired
    AsConsultationNavigationMapper mapper;

    public int save(AsConsultationNavigation asConsultationNavigation, BaseController c) {
        initialized(c);
        String brandLogo = pd.getStringRequired("img");
        ValidatorBreakException.NOT_TRUE(!(brandLogo == null || brandLogo
                .trim().length() == 0 ||"".equals(brandLogo)), "请上传logo图片");
        uploadModule(UploadPathEnum.BRAND, "img");
        String LogoUrl = pd.getStringRequired("img");
        asConsultationNavigation.setLogo(LogoUrl);
        return mapper.insertSelective(asConsultationNavigation);
    }

    public int updateByPrimaryKeySelective(AsConsultationNavigation asConsultationNavigation,BaseController c,String latlng){
        initialized(c);
        uploadModule(UploadPathEnum.BRAND, "img");
        String logo = pd.getStringRequired("img");
        if(!StringUtils.isEmpty(logo)){
            asConsultationNavigation.setLogo(logo);
        }
        AsConsultationNavigation nasConsultationShop =mapper.selectByPrimaryKey(asConsultationNavigation.getAsConsultationNavigationId());
        if(!StringUtils.isEmpty(latlng)){
            String [] lat=latlng.split(",");
            asConsultationNavigation.setLat(lat[1]);
            asConsultationNavigation.setLng(lat[0]);
            if(nasConsultationShop.getAddress().equals(asConsultationNavigation.getAddress()) && !(nasConsultationShop.getLat().equals(lat[1]))){// 地址不变，经纬度变
                ValidatorBreakException.NOT_TRUE(nasConsultationShop.getLat().equals(lat[1]), "地址改变，请重新获取经纬度！");
            }
            if(!(nasConsultationShop.getAddress().equals(asConsultationNavigation.getAddress())) && nasConsultationShop.getLat().equals(lat[1])){//地址变，经纬度不变
                ValidatorBreakException.NOT_TRUE(nasConsultationShop.getAddress().equals(asConsultationNavigation.getAddress()), "地址改变，请重新获取经纬度！");
            }
        }
        return mapper.updateByPrimaryKeySelective(asConsultationNavigation);
    }
}
