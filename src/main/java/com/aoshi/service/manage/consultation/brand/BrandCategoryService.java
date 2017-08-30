package com.aoshi.service.manage.consultation.brand;

import com.aoshi.common.asenum.ConsultationCategoryTypeEnum;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by xjl on 2016/11/28.
 */
@Service
public class BrandCategoryService extends AsBaseService {
    @Autowired
    AsYpBaseCategoryMapper asYpBaseCategoryMapper;

    public List<AsYpBaseCategory> getfoodCategories(){
        return asYpBaseCategoryMapper.getfoodCategories();
    }

    public List<AsYpBaseCategory> getfoodCategoriesShow(){
        return asYpBaseCategoryMapper.getfoodCategoriesShow();
    }

    public List<AsYpBaseCategory> getCategoriesShow(){
        return asYpBaseCategoryMapper.getCategoriesShow();
    }

    public List<AsYpBaseCategory> getshopCategoriesShow(){
        return asYpBaseCategoryMapper.getshopCategoriesShow();
    }

    public List<AsYpBaseCategory> getshoppingCategories(){
        return asYpBaseCategoryMapper.getshoppingCategories();
    }

    public List<AsYpBaseCategory> getmarketCategories(){
        return asYpBaseCategoryMapper.getmarketCategories();
    }
    public List<AsYpBaseCategory> getshopCategories(){
        return asYpBaseCategoryMapper.getshopCategories();
    }

    public List<AsYpBaseCategory> getdishesList(){
        return asYpBaseCategoryMapper.getDishesList();
    }

    public List<AsYpBaseCategory> getHotelList(){
        return asYpBaseCategoryMapper.getHotelList();
    }

    public List<AsYpBaseCategory> getHotelListShow(){
        return asYpBaseCategoryMapper.getHotelListShow();
    }

    public List<AsYpBaseCategory> getDishesListShow(){
        return asYpBaseCategoryMapper.getDishesListShow();
    }

    public int save(AsYpBaseCategory asYpBaseCategory,String type){
        if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.DELICIOUS_FOOD_TYPE.getId()))){
            //新增美食品类
            asYpBaseCategory.setType(ConsultationCategoryTypeEnum.DELICIOUS_FOOD_TYPE.getId());
        }else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.SHOPPING_CLASSIFICATION_TYPE.getId()))){
            //新增逛街分类
            asYpBaseCategory.setType(ConsultationCategoryTypeEnum.SHOPPING_CLASSIFICATION_TYPE.getId());
        }else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.Marketing_CLASSIFICATION_TYPE.getId()))){
            //新增商场分类
            asYpBaseCategory.setType(ConsultationCategoryTypeEnum.Marketing_CLASSIFICATION_TYPE.getId());
        }else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.SHOP_CLASSIFICATION_TYPE.getId()))){
            //新增店铺分类
            asYpBaseCategory.setType(ConsultationCategoryTypeEnum.SHOP_CLASSIFICATION_TYPE.getId());
        }else if(null!=type && !type.isEmpty() && type.equals(String.valueOf(ConsultationCategoryTypeEnum.DISHES_TYPE.getId()))){
            //新增菜式分类
            asYpBaseCategory.setType(ConsultationCategoryTypeEnum.DISHES_TYPE.getId());
        }else {
            //新增酒店品牌名称分类
            asYpBaseCategory.setType(ConsultationCategoryTypeEnum.HOTEL_TYPE.getId());
        }
        asYpBaseCategory.setCreateTime(DateUtil.getTime());
        return asYpBaseCategoryMapper.insertSelective(asYpBaseCategory);
    }

    public int deleteByPrimaryKey(Integer id){
        return asYpBaseCategoryMapper.deleteByPrimaryKey(id);
    }

    public AsYpBaseCategory selectByPrimaryKey(Integer id){
        return asYpBaseCategoryMapper.selectByPrimaryKey(id);
    }

    public AsYpBaseCategory selectById(Integer id){
        return asYpBaseCategoryMapper.selectById(id);
    }

    public int updateByPrimaryKeySelective(AsYpBaseCategory asYpBaseCategory){
        asYpBaseCategory.setCreateTime(DateUtil.getTime());
        return asYpBaseCategoryMapper.updateByPrimaryKeySelective(asYpBaseCategory);
    }
}
