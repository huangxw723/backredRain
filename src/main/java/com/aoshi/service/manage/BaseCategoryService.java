package com.aoshi.service.manage;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.*;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 基础分类管理Service
 *
 * @author tgb 创建时间：2016年10月26日
 * @version 1.0
 */
@Service
public class BaseCategoryService extends AsBaseService {

    private static final String BASEURL = "manage/baseCategory/";

    @Autowired
    AsYpBaseCategoryMapper asYpBaseCategoryMapper;

    @Autowired
    AsPrizeConfigMapper asPrizeConfigMapper;

    @Autowired
    AsPrizeMapper asPrizeMapper;

    @Autowired
    AsPrizeCategoryMapper asPrizeCategoryMapper;

    @Autowired
    AsShopMapper asShopMapper;

    @Autowired
    AsYpTypeStatisticsMapper asYpTypeStatisticsMapper;

    /**
     * 所有分类列表
     *
     * @param c type 1 行业，2模块，3礼品，4优惠券，5 商场类型
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     */
    public Object listAll(BaseController c, Integer type) {

        initialized(c);
        addField("type", type);
        List<Object> categoryList = pageQueryModule(asYpBaseCategoryMapper,
                "queryListAll", true);
        ValidatorBreakException.NOT_NULL(categoryList);
        addViewData("pd", pd);
        addViewData("type", type);
        if (type == 1) {
            addViewData("msg", "categoryIndustryList");
        } else if (type == 2) {
            addViewData("msg", "categoryModuleList");
        } else if (type == 3) {
            addViewData("msg", "categoryPrizeList");
        } else if (type == 4) {
            addViewData("msg", "categoryCouponList");
        } else if (type == 5) {
            addViewData("msg", "categoryStoreList");
        }

        return renderView(BASEURL + "categoryList");
    }

    /**
     * 页面跳转到添加 和修改
     *
     * @param c
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     */
    public Object page(BaseController c) {

        initialized(c);

        OperaEnum action = OperaEnum.get(pd.getInt("action"));
        switch (action) {

            case ADD:

                break;

            case EDIT:
                int categoryId = pd.getInt("categoryId");
                Conditions categorys = (Conditions) asYpBaseCategoryMapper
                        .findById(categoryId);
                ValidatorBreakException.NOT_NULL(categorys);
                addViewData("pd", categorys);
                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }
        String type = pd.getStringRequired("type");
        addViewData("type", type);
        addViewData("action", action.getId());
        return renderView(BASEURL + "categoryEditAndSave");
    }

    /**
     * 操作 确定添加 修改 删除
     *
     * @param c
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     */
    public Object opera(BaseController c) {

        initialized(c);

        OperaEnum action = OperaEnum.get(pd.getInt("action"));
        switch (action) {
            case ADD:

                int type = pd.getInt("type");
                String name = pd.getString("name");

                operaFlag = findByName(name, type);
                ValidatorBreakException.NOT_TRUE(operaFlag, "分类名称已经存在！");

                AsYpBaseCategory category = new AsYpBaseCategory();
                category.setCreateTime(DateUtil.getTime());
                category.setStatus(0);
                category.setName(name);
                category.setType(type);
                operaFlag = asYpBaseCategoryMapper.insertCategory(category) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag, "添加分类失败！");

                break;

            case EDIT:

                type = pd.getInt("type");
                name = pd.getString("name");
                int categoryId = pd.getInt("categoryId");

                operaFlag = findByName(name, type);
                ValidatorBreakException.NOT_TRUE(operaFlag, "分类名称已经存在");

                category = new AsYpBaseCategory();
                category.setType(type);
                category.setName(name);
                category.setId(categoryId);
                operaFlag = asYpBaseCategoryMapper.updateCategory(category) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag, "修改分类失败！");

                break;
            case DELETE:

                categoryId = pd.getInt("categoryId");

                // 判断是否有关联的礼品
                operaFlag = asPrizeConfigMapper.findByCategoryId(categoryId) == 0;
                ValidatorBreakException.NOT_TRUE(operaFlag, "有关联的礼品,不能删除该分类！");

                // 判断是否有关联的物品
                operaFlag = asPrizeMapper.findByCategoryId(categoryId) == 0;
                ValidatorBreakException.NOT_TRUE(operaFlag, "有关联的物品,不能删除该分类！");

                // 判断是否有关联的优惠券
                operaFlag = asPrizeCategoryMapper.findByCategoryId(categoryId) == 0;
                ValidatorBreakException.NOT_TRUE(operaFlag, "有关联的优惠券,不能删除该分类！");

                // 判断是否有关联的商户行业或者商场类型
                operaFlag = asShopMapper.findByCategoryId(categoryId) == 0;
                ValidatorBreakException.NOT_TRUE(operaFlag, "有关联的商户或商场,不能删除该分类！");

                // 判断是否有关联的服务内容
                //operaFlag = asYpTypeStatisticsMapper.findByCategoryId(categoryId) == 0;
                //ValidatorBreakException.NOT_TRUE(operaFlag, "有关联的服务内容,不能删除该分类！");

                operaFlag = asYpBaseCategoryMapper.updateCategoryStatus(categoryId) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag, "删除失败！");

                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }

        return renderSuccess();
    }

    /**
     * 验证是否重名
     *
     * @param name 检查的名字
     * @param type 活动的类型
     * @return
     * @author tgb 创建时间：2016年11月5日
     * @version 1.0
     */
    public boolean findByName(String name, Integer type) {
        return asYpBaseCategoryMapper.findByName(name, type) == 1 ? false
                : true;
    }


}
