package com.aoshi.controller.manage.ownActivity;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.domain.*;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.ownActivity.OwnActivityService;
import com.aoshi.service.manage.ownActivity.OwnGiftService;
import com.aoshi.util.*;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商家礼品列表
 *
 * @author strong
 * @version 1.0
 *          2017年2月18日下午1:09:40
 */

@Controller
@RequestMapping("ownGift")
public class OwnGiftController extends BaseController {

    @Autowired
    private OwnGiftService ownGiftService;

    @Autowired
    private OwnActivityService ownActivityService;

    @Autowired
    private AsPrizeMapper asPrizeMapper;

    @Autowired
    private AsShopMapper asShopMapper;

    private static final String OWN_GIFT_PATH = "/manage/ownGift/";

    //礼品类型
    private static final Integer TYPE = 3;

    /**
     * 查询商家礼品列表
     */
    @RequestMapping("listAll")
    public String listAll(ModelMap map, Page page, String categoryId, String keyWord) {
        //登陆身份 0 系统管理员，1 商家账号
        int isShop = ownActivityService.query();
        PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
        List<AsPrizeConfig> list = ownGiftService.queryAll(categoryId, keyWord, isShop);
        page.setPage(list);
        //判断礼品是否已经过期
        if (!list.isEmpty() && list.size() > 0) {
            //当前时间
            Long day = TimeUtil.getTime(DateUtil.getTime());
            for (int i = 0; i < list.size(); i++) {
                //结束时间
                Long endTime = TimeUtil.getTime(list.get(i).getEndTime());
                if (day > endTime) {
                    list.get(i).setStatus(4);
                }
            }
        }

        //礼品类型
        down(map);
        // 实际兑换数 类型 1抽奖 2摇奖 3领取 4 自主活动抽奖
        List<AsPrize> exchangeCountList = asPrizeMapper.getExchangeCountList(4);
        map.put("exchangeCountList", exchangeCountList);

        map.put("isShop", isShop == 0 ? 0 : 1);
        map.put("list", list);
        map.put("keyWord", keyWord);
        map.put("categoryId", categoryId);
        map.put("currentPage", page.getCurrentPage());
        map.put("showCount", page.getShowCount());
        return OWN_GIFT_PATH + "listAll";
    }

    /**
     * 查询下拉选择
     */
    @RequestMapping("down")
    public String down(ModelMap map) {
        List<AsYpBaseCategory> type = ownGiftService.queryType(TYPE);
        ArrayList<AsYpBaseCategory> types = new ArrayList<>();
        if (!StringUtils.isEmpty(type)) {
            for (AsYpBaseCategory t : type) {
                if (t.getName().equals("折扣券") || t.getName().equals("代金券") || t.getName().equals("礼品券")) {
                    types.add(t);
                }
            }
        }
        map.put("type", types);
        int isShop = ownActivityService.query();
        if (isShop != 0) {// 获取商铺isShop如果不为0则是商场账号 ，反之则是后台管理员账号
            AsShop asShop = asShopMapper.findByShopId("" + isShop);
            map.put("asShop", asShop);
        } else {
            List<Conditions> shopAll = asShopMapper.findByShopAll();
            map.put("shopAll", shopAll);
        }
        return OWN_GIFT_PATH + "save";
    }

    /**
     * 添加
     */
    @RequestMapping("save")
    public ModelAndView save(AsPrizeConfig asPrizeConfig, MultipartFile file) {
        ownGiftService.save(asPrizeConfig, file);
        ModelAndView mv = this.getModelAndView();
        mv.addObject("msg", "success");
        mv.addObject("result", "添加成功!");
        mv.setViewName("manage/ownGift/result");
        return mv;
    }

    /**
     * 根据Id查询
     */
    @RequestMapping("toEdit")
    public String toEdit(ModelMap map, Integer prizeConfigId, Integer action) {
        down(map);
        AsPrizeConfig asPrizeConfig = ownGiftService.toEdit(prizeConfigId);
        List<AsOwnActivity> asOwnActivity = ownActivityService.queryStatus(prizeConfigId);
        //判断礼品时间
        if (!StringUtils.isEmpty(asOwnActivity)) {
            Long day = TimeUtil.getTime(DateUtil.getTime());
            for (int i = 0; i < asOwnActivity.size(); i++) {
                Long statrTime = TimeUtil.getTime(asOwnActivity.get(i).getStartTime());
                Long endTime = TimeUtil.getTime(asOwnActivity.get(i).getEndTime());
                if (day >= statrTime & day < endTime) {
                    map.put("status", 1);
                    break;
                }
            }

        }

        int isShop = ownActivityService.query();
        if (isShop != 0) {// 获取商铺isShop如果不为0则是商场账号 ，反之则是后台管理员账号
            AsShop asShop = asShopMapper.findByShopId("" + isShop);
            map.put("asShop", asShop);
        } else {
            List<Conditions> shopAll = asShopMapper.findByShopAll();
            map.put("shopAll", shopAll);
        }


        map.put("asPrizeConfig", asPrizeConfig);
        map.put("action", action);
        return OWN_GIFT_PATH + "edit";
    }

    /**
     * 修改
     */
    @RequestMapping("edit")
    public ModelAndView edit(AsPrizeConfig asPrizeConfig, String categoryName, @RequestParam(value = "file", required = false) MultipartFile file) {
        ownGiftService.edit(asPrizeConfig, categoryName, file);
        ModelAndView mv = this.getModelAndView();
        mv.addObject("msg", "success");
        mv.addObject("result", "修改成功!");
        mv.setViewName("manage/ownGift/result");
        return mv;
    }


    /**
     * 删除
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, Object> delete(Integer prizeConfigId) {
        int status = ownGiftService.delete(prizeConfigId);
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("status", status);
        data.put("msg", "删除成功!");
        return data;
    }

    /**
     * 自主活动礼品管理导出的excel
     *
     * @param categoryId
     * @param keyWord
     * @return
     * @throws Exception
     */
    @RequestMapping("ownGiftListAll")
    public ModelAndView exportExcel(String categoryId, String keyWord) throws Exception {

        ModelAndView mv = this.getModelAndView();
        try {
            Map<String, Object> dataMap = new HashMap<String, Object>();
            List<String> titles = new ArrayList<String>();
            titles.add("礼品编号"); // 1
            titles.add("礼品名称"); // 2
            titles.add("礼品类型"); // 3
            titles.add("商户名称"); // 4
            titles.add("实际兑换"); // 5
            titles.add("礼品余数"); // 6
            titles.add("礼品总数"); // 7
            titles.add("开始时间"); // 8
            titles.add("结束时间"); // 9
            dataMap.put("head", "自主活动礼品管理");
            dataMap.put("titles", titles);
            //获取需要导出的数据
            int isShop = ownActivityService.query();
            List<AsPrizeConfig> list = ownGiftService.queryAll(categoryId, keyWord, isShop);
            // 实际兑换数 类型 1抽奖 2摇奖 3领取 4 自主活动抽奖
            List<AsPrize> exchangeCountList = asPrizeMapper.getExchangeCountList(4);
            List<PageData> varList = new ArrayList<PageData>();
            if (!list.isEmpty() && list.size() > 0) {
                for (AsPrizeConfig a : list) {
                    PageData vpd = new PageData();
                    vpd.put("var1", a.getSn()); // 1
                    vpd.put("var2", a.getName()); // 2
                    vpd.put("var3", a.getAsYpBaseCategory().getName()); // 3
                    vpd.put("var4", a.getShopName()); // 4
                    for (AsPrize p : exchangeCountList) {
                        if (p.getPrizeConfigId().equals(a.getPrizeConfigId())) {
                            vpd.put("var5", p.getExchangeCount()); // 5
                        }
                    }
                    vpd.put("var6", a.getSurplusCounts()); // 6
                    vpd.put("var7", a.getCounts()); // 7
                    vpd.put("var8", a.getStartTime()); // 8
                    vpd.put("var9", a.getEndTime()); // 9
                    varList.add(vpd);
                }
            }
            dataMap.put("varList", varList);
            ObjectExcelView erv = new ObjectExcelView(); // 执行excel操作
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

}
