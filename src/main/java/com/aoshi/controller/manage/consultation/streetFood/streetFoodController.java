package com.aoshi.controller.manage.consultation.streetFood;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsConsultationStreetFood;
import com.aoshi.service.manage.consultation.StreetFood.ConsultationStreetFoodService;
import com.aoshi.service.manage.consultation.shop.ConsultationShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("consultation/streetFood")
public class streetFoodController extends BaseController{
    private static final String BASEURL="consultation/streetFood/";
    @Autowired
    private ConsultationShopService foodService;
    @Autowired
    private ConsultationStreetFoodService consultationStreetFoodService;


    /**
     * 编辑菜式页面
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("list")
    public String list(Integer id,ModelMap map){
        List<AsConsultationStreetFood> asConsultationStreetFoodList = consultationStreetFoodService.findByShopId(id);
        map.put("list", asConsultationStreetFoodList);
        return BASEURL+"mealList";
    }


    /**
     * 编辑页面
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toEdit")
    public String toEdit(Integer id,ModelMap map){
        AsConsultationStreetFood asConsultationStreetFood = consultationStreetFoodService.selectByPrimaryKey(id);
        map.put("asConsultationStreetFood", asConsultationStreetFood);
        return BASEURL+"editMeal";
    }

    /**
     * 更新
     * @param asConsultationStreetFood
     * @return
     */
    @RequestMapping("update")
    @ResponseBody
    public Map update(AsConsultationStreetFood asConsultationStreetFood){
        int result = consultationStreetFoodService.updateByPrimaryKeySelective(asConsultationStreetFood,this);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/del")
    @ResponseBody
    public int del(ModelMap map,Integer id) {
        return consultationStreetFoodService.deleteByPrimaryKey(id);
    }

    /**
     * 去增页面
     * @param map
     * @return
     */
    @RequestMapping(value="toAdd")
    public String toAdd(ModelMap map,String id){
        map.put("asConsultationShopId",id);
        return BASEURL+"addMeal";
    }

    /**
     * 新增
     * @param asConsultationStreetFood
     * @return
     */
    @RequestMapping("save")
    @ResponseBody
    public Map<String, Object> save(AsConsultationStreetFood asConsultationStreetFood,Integer shopId){
        int result = consultationStreetFoodService.save(asConsultationStreetFood,this,shopId);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }
}
