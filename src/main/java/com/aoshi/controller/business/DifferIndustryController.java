package com.aoshi.controller.business;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsDifferIndustry;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.User;
import com.aoshi.service.business.DifferIndustryService;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商家异业推荐模块
 *
 * @author tgb
 * @date 2017年02月21日
 */
@Controller
@RequestMapping("/differIndustry")
public class DifferIndustryController extends BaseController {

    @Autowired
    private DifferIndustryService differIndustryService;

    @Autowired
    private AsYpBaseCategoryMapper asYpBaseCategoryMapper;

    /**
     * 获取商家异业推荐列表
     *
     * @return
     * @author tgb 创建时间：2017年2月21日
     * @version 1.0
     */
    @RequestMapping(value = "/getDifferIndustryList")
    public ModelAndView getDifferIndustryList(Page page) {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("business/coupon/differIndustryList");
        PageData pd = this.getPageData();
        try {
            User user = this.getCurrentUser();
            String shopId = user.getAs_shop_id();
            if (!shopId.equals("null")) {
                // 通过shopId获取所有异业
                List<AsDifferIndustry> diList = differIndustryService
                        .getDifferIndustryListByShopId(shopId);
                // 获取所有行业
                page.setPd(pd);
                PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
                List<AsYpBaseCategory> categoryList = asYpBaseCategoryMapper
                        .queryCategoryList(1);
                // 设置所有行业默认为选中
                if (!categoryList.isEmpty() && categoryList.size() > 0) {
                    for (AsYpBaseCategory c : categoryList) {
                        c.setCheck(false);
                    }
                }
                // 两个循环对比 如果异业中的行业categoryId和行业id 一样 就设置true，未选中
                if (!diList.isEmpty() && diList.size() > 0) {
                    for (AsDifferIndustry di : diList) {
                        for (AsYpBaseCategory c : categoryList) {
                            if (!c.getCheck()) {
                                if (di.getCategoryId().equals(c.getId())) {
                                    c.setCheck(true);
                                }
                            }
                        }
                    }
                }

                PageInfo<AsYpBaseCategory> pageInfo = new PageInfo<AsYpBaseCategory>(
                        categoryList);
                page.setEntityOrField(true);
                page.setTotalResult((int) pageInfo.getTotal());

                mv.addObject("categoryList", categoryList);
                mv.addObject("shopId", shopId);
                mv.addObject("pd", pd);
            }

        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存
     *
     * @param shopId
     * @param ids
     * @return
     */
    @RequestMapping(value = "/saveDifferIndustryIds")
    @ResponseBody
    public Map<String, Object> saveDifferIndustryIds(String ids, String idsChecked, int shopId) {
        Map<String, Object> map = new HashMap<>();
        try {
            // 保存前先删除当前页的值 ，覆盖保存
            if (StringUtils.isNotBlank(idsChecked)) {
                String idsCheckeds[] = idsChecked.split(",");
                differIndustryService.deleteByShopIdAndCategoryId(idsCheckeds, shopId);
            }
            //批量保存
            if (StringUtils.isNotBlank(ids)) {
                String cIds[] = ids.split(",");
                differIndustryService.save(cIds, shopId);
            }
            map.put("msg", "ok");
        }catch (Exception e){
            logger.error(e.toString(), e);
            map.put("msg", "no");
        }
        return map;
    }

}
