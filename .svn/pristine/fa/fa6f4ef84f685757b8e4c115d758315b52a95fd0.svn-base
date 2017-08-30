package com.aoshi.controller.manage.integration;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsAttrType;
import com.aoshi.domain.AsGoods;
import com.aoshi.domain.AsGoodsAttr;
import com.aoshi.domain.AsGoodsImgs;
import com.aoshi.domain.AsGoodsType;
import com.aoshi.domain.AsProduct;
import com.aoshi.domain.AsTypeRelation;
import com.aoshi.domain.AsUnit;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.AsAttributeService;
import com.aoshi.service.manage.UnitService;
import com.aoshi.service.manage.integration.goods.GoodsService;
import com.aoshi.service.manage.integration.goods.ProductService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;

/**
 * 积分商城商品管理模块
 *
 * @author tgb 创建时间：2016年12月7日
 * @version 1.0
 */
@Controller
@RequestMapping(value = "goods/")
public class GoodsController extends BaseController {
    private static final String BASE_URL = "manage/integration/";
    @Autowired
    GoodsService goodsService;
    @Autowired
    ProductService productService;
    @Autowired
    AsAttributeService attrTypeService;
    @Autowired
    UnitService unitService;

    /**
     * 商品列表
     *
     * @param map
     * @param page
     * @param keyword     关键字
     * @param sSalesPrice 开始积分
     * @param eSalesPrice 结束积分
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "getGoodsList")
    public String getGoodsList(
            ModelMap map,
            Page page,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "sSalesPrice", required = false) String sSalesPrice,
            @RequestParam(value = "eSalesPrice", required = false) String eSalesPrice) {
        PageHelper.startPage(page.getCurrentPage(), page.getShowCount());

        // 组装参数
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", keyword);
        params.put("sSalesPrice", sSalesPrice);
        params.put("eSalesPrice", eSalesPrice);

        List<AsGoods> list = goodsService.getGoodsList(params);
        page.setPage(list);
        map.put("page", page);
        map.put("keyword", keyword);
        map.put("sSalesPrice", sSalesPrice);
        map.put("eSalesPrice", eSalesPrice);
        map.put("list", list);

        return BASE_URL + "goodsList";
    }

    /**
     * 跳转到添加商品页面
     *
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月7日
     * @version 1.0
     */
    @RequestMapping(value = "toAdd")
    public String toAdd(ModelMap map) {
        List<AsGoodsType> goodsTypes = goodsService.selectGoodsTypeTree();
        List<AsUnit> units = unitService.findAll();
        // this.getList(map,null);
        map.put("goodsTypes", JSONArray.fromObject(goodsTypes));
        map.put("units", units);
        return BASE_URL + "addGoods";
    }

    /**
     * 判断商品名称是否重复
     *
     * @param goodsName
     * @return
     */
    @RequestMapping(value = "checkExist")
    @ResponseBody
    public Map<String, Boolean> checkExist(String goodsName) {
        return goodsService.checkExist(goodsName);
    }

    /**
     * 判断商品货号sn是否重复
     *
     * @return
     */
    @RequestMapping(value = "checkExistSn")
    @ResponseBody
    public Map<String, Boolean> checkExistSn(String goodsSn) {
        return goodsService.checkExistSn(goodsSn);
    }

    /**
     * 保存商品
     *
     * @param asGoods      带参数的商品对象
     * @param goodsTypeStr 商品分类id的json格式的字符串
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月7日
     * @version 1.0
     */
    @RequestMapping(value = "addGoods")
    public String addGoods(AsGoods asGoods, String goodsTypeStr, ModelMap map) {
        PageData pd = this.getPageData();
        AsGoods goods = goodsService.save(asGoods, goodsTypeStr, pd);

        List<AsAttrType> attrTypes = attrTypeService.selectAll();
        map.put("attrTypes", attrTypes);
        map.put("goodsId", goods.getGoodsId());
        return BASE_URL + "goodsAttr";
    }

    /**
     * 查找到需要修改的商品
     *
     * @param map
     * @param goodsId
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "toEditGoods")
    public String toEditGoods(ModelMap map, int goodsId) {
        AsGoods goods = goodsService.findByGoodsId(goodsId);
        List<AsTypeRelation> typeRelations = goodsService
                .getRelationsByGoodsId(goodsId);
        List<AsGoodsType> goodsTypes = goodsService.selectGoodsTypeTree();
        List<AsUnit> units = unitService.findAll();

        for (AsTypeRelation relation : typeRelations) {
            for (AsGoodsType goodsType : goodsTypes) {
                if (relation.getGoodsTypeId()
                        .equals(goodsType.getGoodsTypeId())) {
                    goodsType.setChecked(true);
                }
                if (goodsType.getChildren() != null
                        && goodsType.getChildren().size() > 0) {
                    setChildren(goodsType.getChildren(), relation);
                }
            }
        }
        map.put("goodsTypes", JSONArray.fromObject(goodsTypes));
        map.put("goods", goods);
        map.put("units", units);
        return BASE_URL + "editGoods";
    }

    /**
     * 组装商品分类树的子节点
     *
     * @param goodsTypes
     * @param typeRelation
     * @author tgb 创建时间：2016年12月7日
     * @version 1.0
     */
    private void setChildren(List<AsGoodsType> goodsTypes,
                             AsTypeRelation typeRelation) {
        for (AsGoodsType goodsType : goodsTypes) {
            if (goodsType.getGoodsTypeId()
                    .equals(typeRelation.getGoodsTypeId())) {
                goodsType.setChecked(true);
            }

            if (goodsType.getChildren() != null
                    && goodsType.getChildren().size() > 0) {
                setChildren(goodsType.getChildren(), typeRelation);
            }
        }
    }

    /**
     * 保存被编辑的商品
     *
     * @param asGoods                        商品带参对象
     * @param goodsTypeStr商品分类id的json格式数组字符串
     * @return
     * @author tgb 创建时间：2016年12月7日
     * @version 1.0
     */
    @RequestMapping(value = "editGoods", method = RequestMethod.POST)
    public String editGoods(AsGoods asGoods, String goodsTypeStr) {
        PageData pd = this.getPageData();
        goodsService.editGoods(asGoods, goodsTypeStr, pd);
        return BASE_URL + "result";
    }

    /**
     * 跳转编辑商品主图(缩略图) 或 属性有颜色的图片
     *
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月9日
     * @version 1.0
     */
    @RequestMapping(value = "toEditAttrImage", method = RequestMethod.GET)
    public String toEditAttrImage(int goodsId, ModelMap map) {
        List<AsGoodsImgs> goodsImgs = goodsService.getGoodsImgs(goodsId, 2);
        AsGoods asGoods = goodsService.findByGoodsId(goodsId);
        map.put("goodsThumb", asGoods.getGoodsThumb());
        map.put("goodsId", goodsId);
        map.put("goodsImgs", goodsImgs);
        return BASE_URL + "goodsThumbImgs";
    }

    /**
     * 删除图片 把 编辑商品主图(缩略图) 或 属性有颜色的图片url 设置null
     *
     * @param goodsImgsId
     * @return
     * @author tgb 创建时间：2016年12月9日
     * @version 1.0
     */
    @RequestMapping(value = "deleteAttrImgsByGoodsImgsId")
    @ResponseBody
    public Object deleteAttrImgsByGoodsImgsId(int goodsImgsId) {
        return goodsService.deleteGoodsImgs(goodsImgsId, 2);
    }

    /**
     * 跳转到编辑缩略图页面
     *
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月9日
     * @version 1.0
     */
    @RequestMapping(value = "toAddGoodsAttrImgs")
    public String toAddGoodsAttrImgs(int goodsId, int goodsImgsId, ModelMap map) {
        map.put("goodsId", goodsId);
        map.put("goodsImgsId", goodsImgsId);
        return BASE_URL + "addGoodsAttrImgs";
    }

    /**
     * 保存缩略图
     *
     * @param files
     * @param goodsId
     * @return
     * @author tgb 创建时间：2016年12月9日
     * @version 1.0
     */
    @RequestMapping(value = "saveGoodsAttrImgs")
    public String saveGoodsAttrImgs(
            @RequestParam(value = "files", required = true) MultipartFile files,
            int goodsId, int goodsImgsId) {
        goodsService.saveGoodsAttrImgs(files, goodsId, goodsImgsId);
        return BASE_URL + "result";
    }

    /**
     * 跳转到编辑商品图片列表页面
     *
     * @param goodsId 商品id
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月7日
     * @version 1.0
     */
    @RequestMapping(value = "toEditImage", method = RequestMethod.GET)
    public String toEditImage(int goodsId, ModelMap map) {
        List<AsGoodsImgs> goodsImgs = goodsService.getGoodsImgs(goodsId, 1);
        map.put("goodsId", goodsId);
        map.put("goodsImgs", goodsImgs);
        return BASE_URL + "goodsImgs";
    }

    /**
     * 跳转到添加商品图片页
     *
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "toAddGoodsImgs")
    public String toAddGoodsImgs(int goodsId, int len, ModelMap map) {
        map.put("goodsId", goodsId);
        map.put("len", len);
        return BASE_URL + "addGoodsImgs";
    }

    /**
     * 跳转到编辑商品图片页面
     *
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "toEditGoodsImgs")
    public String toEditGoodsImgs(int goodsId, int goodsImgsId, ModelMap map) {
        map.put("goodsId", goodsId);
        map.put("goodsImgsId", goodsImgsId);
        return BASE_URL + "editGoodsImg";
    }

    /**
     * 编辑商品图
     *
     * @param files
     * @param goodsId
     * @return
     * @author tgb 创建时间：2016年12月9日
     * @version 1.0
     */
    @RequestMapping(value = "editGoodsImgs")
    public String editGoodsImgs(
            @RequestParam(value = "files", required = true) MultipartFile files,
            int goodsId, int goodsImgsId) {
        goodsService.editGoodsImgs(files, goodsId, goodsImgsId);
        return BASE_URL + "result";
    }

    /**
     * 保存商品图片
     *
     * @param files   图片文件数组
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "saveGoodsImgs")
    public String saveGoodsImgs(
            @RequestParam(value = "files", required = true) MultipartFile[] files,
            int goodsId, ModelMap map) {
        goodsService.saveGoodsImgs(files, goodsId);
        return BASE_URL + "result";
    }

    /**
     * 删除单张商品图片
     *
     * @param goodsImgsId
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "deleteImgsByGoodsImgsId")
    @ResponseBody
    public Object deleteImgsByGoodsImgsId(int goodsImgsId) {
        return goodsService.deleteGoodsImgs(goodsImgsId, 1);
    }

    /**
     * 批量删除商品图片
     *
     * @return
     * @author tgb 创建时间：2016年12月3日
     * @version 1.0
     */
    @RequestMapping(value = "/deleteGoodsImgAlls")
    @ResponseBody
    public Object deleteGoodsImgAlls() {
        logBefore(logger, "批量删除deleteGoodsImgAlls");
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String ids = pd.getString("ids");
            if (StringUtils.isNotBlank(ids)) {
                String IdArr[] = ids.split(",");
                int[] ints = StringToInt(IdArr);
                goodsService.deleteGoodsImgAlls(ints);
                map.put("msg", "ok");
            } else {
                map.put("msg", "no");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 删除商品
     *
     * @param goodsId
     * @return
     */
    @RequestMapping(value = "deleteGoods")
    @ResponseBody
    public Object deleteGoods(int goodsId) {
        return goodsService.updateGoods(goodsId);
    }


    /**
     * 批量删除商品
     *
     * @return
     * @author tgb 创建时间：2016年12月3日
     * @version 1.0
     */
    @RequestMapping(value = "/deleteGoodsAlls")
    @ResponseBody
    public Object deleteGoodsAlls() {
        logBefore(logger, "批量删除deleteGoodsAlls");
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String ids = pd.getString("ids");
            if (StringUtils.isNotBlank(ids)) {
                String IdArr[] = ids.split(",");
                int[] ints = StringToInt(IdArr);
                goodsService.deleteGoodsAlls(ints);
                map.put("msg", "ok");
            } else {
                map.put("msg", "no");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 字符数组装int类型
     */
    public int[] StringToInt(String[] arrs) {
        int[] ints = new int[arrs.length];
        for (int i = 0; i < arrs.length; i++) {
            ints[i] = Integer.parseInt(arrs[i]);
        }
        return ints;
    }

    @RequestMapping(value = "getAttribute")
    @ResponseBody
    public Object getAttribute(int attrTypeId) {
        return attrTypeService.getAttributeByAttrTypeId(attrTypeId);
    }

    /**
     * 查看商品的属性值页面
     *
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月7日
     * @version 1.0
     */
    @RequestMapping(value = "reviewGoodsAttr")
    public String reviewGoodsAttr(int goodsId, ModelMap map) {
        List<List<AsGoodsAttr>> attrs = goodsService.reviewGoodsAttr(goodsId);
        map.put("attrs", attrs);
        return BASE_URL + "reviewGoodsAttr";
    }

    /**
     * 编辑商品属性，跳转到页面
     *
     * @param goodsId
     * @param map
     * @return
     */
    @RequestMapping(value = "editGoodsAttr")
    public String editGoodsAttr(int goodsId, ModelMap map) {
        List<AsAttrType> attrTypes = attrTypeService.selectAll();

        map.put("goodsId", goodsId);
        map.put("attrTypes", attrTypes);
        return BASE_URL + "goodsAttr";
    }

    /**
     * 保存商品属性
     *
     * @param attrStr ： [ {attrName:"颜色",attrValue:"红色",attributeId:1},
     *                {attrName:"颜色",attrValue:"白色",attributeId:1}
     *                {attrName:"尺寸",attrValue:"中码",attributeId:2} ]
     * @param goodsId
     * @param map
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "saveAttr")
    public String saveAttr(String attrStr, int goodsId, ModelMap map)
            throws UnsupportedEncodingException {
        // attrStr = new String(attrStr.getBytes("ISO-8859-1"), "UTF-8");
        List<AsProduct> products = goodsService.saveGoodsAttr(attrStr, goodsId);
        List<AsGoodsAttr> goodsAttrs = goodsService.findByGoodsIdWithAttr(goodsId);
        map.put("goodsAttrs", goodsAttrs);
        map.put("products", products);
        map.put("goodsId", goodsId);
        return BASE_URL + "attrEdit";
    }

    /**
     * 保存商品库存
     *
     * @param storeStr
     * @param goodsId
     * @return
     * @author tgb 创建时间：2016年12月5日
     * @version 1.0
     */
    @RequestMapping(value = "saveStore")
    public String saveStore(String storeStr, String attrIds, int goodsId) {
        productService.saveStore(storeStr, attrIds, goodsId);
        return BASE_URL + "result";
    }

    /**
     * 查找到需要编辑商品的库存
     *
     * @param goodsId
     * @param map
     * @return
     * @author tgb 创建时间：2016年12月4日
     * @version 1.0
     */
    @RequestMapping(value = "editGoodsStore")
    public String editGoodsStore(int goodsId, ModelMap map) {
        List<AsProduct> products = goodsService.editGoodsStore(goodsId);
        map.put("products", products);
        map.put("goodsId", goodsId);
        return BASE_URL + "goodsStoreEdit";
    }

}
