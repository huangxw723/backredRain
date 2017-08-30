package com.aoshi.controller.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.BaseCategoryService;

/**
 * 基础分类管理模块
 *
 * @author tgb 创建时间：2016年10月20日
 * @version 1.0
 */
@Controller
@RequestMapping("/category")
public class BaseCategoryController extends BaseController {

    @Autowired
    BaseCategoryService categoryService;

    /**
     * 分类列表
     *
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     * 类型  1 行业，2模块，3礼品，4优惠券，5 商场类型
     */
    @RequestMapping("/categoryIndustryList")
    public Object categoryIndustryList() {
        return categoryService.listAll(this, 1);
    }

    @RequestMapping("/categoryModuleList")
    public Object categoryModuleList() {
        return categoryService.listAll(this, 2);
    }

    @RequestMapping("/categoryPrizeList")
    public Object categoryPrizeList() {
        return categoryService.listAll(this, 3);
    }

    @RequestMapping("/categoryCouponList")
    public Object categoryCouponList() {
        return categoryService.listAll(this, 4);
    }

    @RequestMapping("/categoryStoreList")
    public Object categoryStoreList() {
        return categoryService.listAll(this, 5);
    }

    /**
     * 新增去管理总页面
     *
     * @return
     * @author tgb 创建时间：2017年2月20日
     * @version 1.0
     */
    @RequestMapping(value = "/categoryTabList")
    public ModelAndView goList() {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("manage/baseCategory/categoryTabList");
        return mv;
    }

    /**
     * 跳转页面配置
     *
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     */
    @RequestMapping("/page")
    public Object page() {
        return categoryService.page(this);
    }

    /**
     * 跳转操作
     *
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     */
    @RequestMapping("/opera")
    @ResponseBody
    public Object opera() {
        return categoryService.opera(this);
    }
}
