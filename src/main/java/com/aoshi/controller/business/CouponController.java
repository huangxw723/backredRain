package com.aoshi.controller.business;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.domain.AsCoupon;
import com.aoshi.domain.AsPrizeType;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsTag;
import com.aoshi.entity.Page;
import com.aoshi.entity.system.User;
import com.aoshi.service.business.CouponService;
import com.aoshi.service.business.ShopService;
import com.aoshi.service.business.TagService;
import com.aoshi.service.manage.locality.AsStoreService;
import com.aoshi.util.Conditions;
import com.aoshi.util.Const;
import com.github.pagehelper.PageHelper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/coupon")
public class CouponController extends BaseController {
    private static final String BASEURL = "business/coupon/";

    @Autowired
    private TagService tagService;
    @Autowired
    CouponService couponService;
    @Autowired
    AsStoreService storeService;
    @Autowired
    ShopService shopService;

    @Autowired
    private AsPrizeMapper prizeMapper;

    /**@author luhuajiang
     * 设置分页
     * @param page
     * @param list
     */
    /*@SuppressWarnings({ "rawtypes", "unchecked" })
	private void setPage(Page page,List list){
		
		PageInfo<Object> pageInfo = new PageInfo<Object>(list);
		page.setTotalResult((int)pageInfo.getTotal());
		page.setEntityOrField(true);
	}*/

    /**
     * @param map
     * @return
     * @author luhuajiang
     * 标签列表
     */
    @RequestMapping("tagList")
    public String tagList(ModelMap map, Page page,
                          @RequestParam(value = "keyword", required = false) String keyword) {
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();

        PageHelper.startPage(pageNum, pageSize);

        AsTag tag = new AsTag();
        if (!StringUtils.isEmpty(keyword)) {
            tag.setName(keyword);
        }
        List<AsTag> list = tagService.queryList(tag);
        page.setPage(list);
        map.put("list", list);
        map.put("keyword", keyword);
        return BASEURL + "tagList";
    }

    /**
     * @param map
     * @return
     * @author luhuajiang
     * 去增页面
     */
    @RequestMapping(value = "toAddTag")
    public String toAddTage(ModelMap map) {
        return BASEURL + "addTag";
    }

    /**
     * @param map
     * @param tag
     * @return
     * @author luhuajiang
     * 新增标签
     */
    @RequestMapping("addTag")
    public String addTag(ModelMap map, AsTag tag) {
        int result = tagService.save(tag);
        map.put("result", result);
        return BASEURL + "result";
    }

    /**
     * @param map
     * @param tagId
     * @return
     * @author luhuajiang
     * 删除标签
     */
    @RequestMapping("deleteTag")
    @ResponseBody
    public int deleteTag(ModelMap map, int tagId) {
        return tagService.delete(tagId);
    }

    /**
     * @param tagId
     * @param map
     * @return
     * @author luhuajiang
     * 编辑标签页面
     */
    @RequestMapping("toEditTag")
    public String toEditTag(Integer tagId, ModelMap map) {
        AsTag tag = tagService.findByTagId(tagId);
        map.put("tag", tag);
        return BASEURL + "editTag";
    }

    /**
     * @param map
     * @param tag
     * @return
     * @author luhuajiang
     * 更新标签
     */
    @RequestMapping("editTag")
    public String editTag(ModelMap map, AsTag tag) {
        int result = tagService.update(tag);
        map.put("result", result);
        return BASEURL + "result";
    }

    /**
     * 判断标签是否存在
     *
     * @param name
     * @return
     */
    @RequestMapping(value = "isExist")
    @ResponseBody
    public boolean isExist(String name, int type) {
        return tagService.isExist(name, type);
    }

    /**
     * @param map
     * @param page
     * @return
     * @author luhuajiang
     * 优惠券列表
     */
    @RequestMapping("couponList")
    public String couponList(ModelMap map, Page page,
                             @RequestParam(value = "keyword", required = false) String keyword) {
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();

        PageHelper.startPage(pageNum, pageSize);

        AsCoupon coupon = new AsCoupon();
        if (!StringUtils.isEmpty(keyword)) {
            coupon.setName(keyword);
        }
        List<AsCoupon> list = couponService.queryList(coupon);
        page.setPage(list);
        map.put("list", list);
        map.put("keyword", keyword);

        return BASEURL + "couponList";
    }

    /**
     * @param map
     * @param page
     * @return
     * @author luhuajiang
     * 我的优惠券列表
     */
    @RequestMapping("myCoupons")
    public String myCoupons(ModelMap map, Page page,
                            @RequestParam(value = "keyword", required = false) String keyword) {
        int shopId = Integer.parseInt(this.getCurrentUser().getShopId());
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();

        PageHelper.startPage(pageNum, pageSize);

        AsCoupon coupon = new AsCoupon();
        if (!StringUtils.isEmpty(keyword)) {
            coupon.setName(keyword);
        }
        coupon.setShopId(shopId);
        //coupon.setStatus(1);
        List<AsCoupon> list = couponService.queryList(coupon);

        page.setPage(list);
        map.put("list", list);
        map.put("keyword", keyword);

        return BASEURL + "myCoupons";
    }

    /**
     * @param map
     * @return
     * @author luhuajiang
     * 新增优惠券页面
     */
    @RequestMapping(value = "toAddCoupon")
    public String toAddCoupon(ModelMap map) {
        int shopId = Integer.parseInt(this.getCurrentUser().getShopId());
        AsTag tag = new AsTag();
        tag.setType(2);
        List<AsTag> tags = tagService.queryList(tag);

        //查找出有‘券字样’的优惠券
        AsPrizeType prizeType = new AsPrizeType();
        prizeType.setShopId(shopId);
        prizeType.setPrizeTypeName("券");

        List<AsPrizeType> prizeTypes = couponService.queryPrizeTypesLike(prizeType);
        map.put("prizeTypes", prizeTypes);
        map.put("tags", tags);
        return BASEURL + "addCoupon";
    }

    /**
     * @param map
     * @param couponId
     * @return
     * @author luhuajiang
     * 编辑优惠券页面
     */
    @RequestMapping(value = "toEditCoupon")
    public String toEditCoupon(ModelMap map, int couponId) {

        List<AsTag> tags = couponService.queryTags(couponId);
        AsCoupon asCoupon = couponService.findById(couponId);

        //查找出有‘券字样’的优惠券
        AsPrizeType prizeType = new AsPrizeType();
        prizeType.setPrizeTypeName("券");

        List<AsPrizeType> prizeTypes = couponService.queryPrizeTypesLike(prizeType);
        map.put("prizeTypes", prizeTypes);

        map.put("tags", tags);
        map.put("coupon", asCoupon);
        return BASEURL + "editCoupon";
    }

    /**
     * 优惠券详情
     *
     * @param map
     * @param couponId
     * @return
     */
    @RequestMapping(value = "couponDetail")
    public String couponDetail(ModelMap map, int couponId) {
        List<AsTag> tags = couponService.queryTags(couponId);
        AsCoupon asCoupon = couponService.findById(couponId);
        map.put("tags", tags);
        map.put("coupon", asCoupon);

        return BASEURL + "couponDetail";
    }

    /**
     * 新增优惠券
     *
     * @param tagIds
     * @param map
     * @return
     */
    @RequestMapping(value = "addCoupon")
    public String addCoupon(AsCoupon asCoupon, String tagIds,
                            @RequestParam(value = "file", required = true) MultipartFile file,
                            ModelMap map) {
        String shopId = this.getCurrentUser().getShopId();
        AsShop shop = shopService.findByShopId(shopId);

        asCoupon.setShopId(Integer.parseInt(shopId));
        asCoupon.setStoreId(shop.getStoreId());
        asCoupon.setBusinessDistrictId(shop.getBusinessDistrictId());
        int result = couponService.save(asCoupon, tagIds, file);
        map.put("result", result);
        return BASEURL + "result";
    }

    /**
     * 编辑优惠券
     *
     * @param asCoupon
     * @param tagIds
     * @param map
     * @return
     */
    @RequestMapping(value = "editCoupon")
    public String editCoupon(AsCoupon asCoupon, String tagIds,
                             @RequestParam(value = "file", required = true) MultipartFile file,
                             ModelMap map) {
        int result = couponService.update(asCoupon, tagIds, file);
        map.put("result", result);
        return BASEURL + "result";
    }

    /**
     * 审核
     *
     * @param couponId
     * @return
     */
    @RequestMapping(value = "review")
    @ResponseBody
    public int review(int couponId) {
        return couponService.review(couponId);
    }


    /**
     * 禁用优惠券
     *
     * @param couponId
     * @return
     */
    @RequestMapping(value = "disable")
    @ResponseBody
    public int disable(int couponId) {
        User user = this.getCurrentUser();
        return couponService.disable(couponId, Integer.parseInt(user.getShopId()));
    }


    /**
     * 启用优惠券
     *
     * @param couponId
     * @return
     */
    @RequestMapping(value = "enable")
    @ResponseBody
    public int enable(int couponId) {
        User user = this.getCurrentUser();
        return couponService.enable(couponId, Integer.parseInt(user.getShopId()));
    }


    /**
     * 优惠券领取礼品记录页面
     *
     * @return
     * @author tgb
     * 创建时间：2017年3月6日
     * @version 1.0
     */
    @RequestMapping("/couponsReceiveHistory")
    public Object couponsReceiveHistory() {
        return couponService.receivedHistory(this);
    }

    /**
     * 优惠券兑换礼品记录页面
     *
     * @return
     * @author tgb
     * 创建时间：2017年3月6日
     * @version 1.0
     */
    @RequestMapping("/couponsExchangeHistory")
    public Object couponsExchangeHistory() {
        return couponService.exchangeHistory(this);
    }

    /**
     * 优惠券兑换页面跳转
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/toReceive")
    @ResponseBody
    public Object receive() {
        return couponService.receive(this);
    }

    /**
     * 优惠券兑换操作
     *
     * @return
     */
    @RequestMapping("/editReceive")
    @ResponseBody
    public int editReceive(String sn) {
        return couponService.editReceive(sn);
    }


    /**
     * 礼品详情页面跳转
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/toPrizeDetail")
    public String toPrizeDetail(ModelMap map, Integer id) {
        Conditions asPrize = (Conditions) prizeMapper.getPrizeDetailById(id);
        map.put("p", asPrize);
        return BASEURL + "prizeDetail";
    }


    /**
     * 获取后台用户
     *
     * @return
     * @author luhuajiang
     */
    public User getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        return user;
    }
}
