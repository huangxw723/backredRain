package com.aoshi.service.business;

import com.aoshi.dao.AsDifferIndustryMapper;
import com.aoshi.domain.AsDifferIndustry;
import com.aoshi.service.base.AsBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DifferIndustryService extends AsBaseService {


    @Autowired
    private AsDifferIndustryMapper asDifferIndustryMapper;

    public List<AsDifferIndustry> getDifferIndustryListByShopId(String shopId) {
        return asDifferIndustryMapper.getDifferIndustryListByShopId(shopId);
    }

    public void deleteByShopIdAndCategoryId(String[] idsCheckeds, int shopId) {
        for (String i : idsCheckeds) {
            asDifferIndustryMapper.deleteByShopIdAndCategoryId(shopId, Integer.valueOf(i));
        }

    }

    public void save(String[] cIds, int shopId) {
        for (String i : cIds) {
            AsDifferIndustry asDifferIndustry = new AsDifferIndustry();
            asDifferIndustry.setShopId(shopId);
            asDifferIndustry.setCategoryId(Integer.valueOf(i));
            asDifferIndustryMapper.insert(asDifferIndustry);
        }
    }

}
