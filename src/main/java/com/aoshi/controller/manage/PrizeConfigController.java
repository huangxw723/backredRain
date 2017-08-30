package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPrizeConfigMapper;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsPrize;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.service.manage.PrizeConfigService;
import com.aoshi.util.ObjectExcelView;
import com.aoshi.util.PageData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 后台全部礼品管理 Controller (包括优惠券)
 *
 * @author tgb
 * @date 2016年11月2日
 */
@Controller
@RequestMapping("/prizeconfig")
public class PrizeConfigController extends BaseController {

    @Autowired
    private PrizeConfigService prizeService;

    @Autowired
    private AsPrizeConfigMapper asPrizeConfigMapper;

    @Autowired
    private AsPrizeMapper asPrizeMapper;

    @Autowired
    private AsYpBaseCategoryMapper asYpBaseCategoryMapper;

    /**
     * 页面跳转中转
     *
     * @author tgb
     * @date 2016年11月2日
     */
    @RequestMapping("/page")
    public Object page() {
        return prizeService.page(this);
    }

    /**
     * 全局礼品操作
     *
     * @return
     * @author tgb
     * @date 2016年11月2日
     */
    @RequestMapping("/opera")
    @ResponseBody
    public Object opera() {
        return prizeService.opera(this);
    }

    /**
     * 摇奖页面跳转中转
     *
     * @author tgb
     * @date 2017年02月23日
     */
    @RequestMapping("/shakePage")
    public Object shakePage() {
        return prizeService.shakePage(this);
    }

    /**
     * 全局摇奖操作
     *
     * @return
     * @author tgb
     * @date 2017年02月23日
     */
    @RequestMapping("/shakeOpera")
    @ResponseBody
    public Object shakeOpera() {
        return prizeService.shakeOpera(this);
    }

    /**
     * 优惠券页面跳转中转
     *
     * @return
     * @author tgb
     * @date 2016年11月2日
     */
    @RequestMapping("/couponsPage")
    public Object couponsPage() {
        return prizeService.couponsPage(this);
    }

    /**
     * 全局优惠券操作
     *
     * @return
     * @author tgb
     * @date 2016年11月2日
     */
    @RequestMapping("/couponsOpera")
    @ResponseBody
    public Object couponsOpera() {
        return prizeService.couponsOpera(this);
    }

    /**
     * 异步加载摇奖概率
     *
     * @return
     * @author tgb 创建时间：2016年10月26日
     */
    @RequestMapping("/shake")
    @ResponseBody
    public Object shake() {
        return prizeService.shake(this);
    }

    /**
     * 异步检查是否重名
     *
     * @return
     * @author tgb 创建时间：2016年11月2日
     */
    @RequestMapping("/isExist")
    @ResponseBody
    public Object isExist() {
        return prizeService.isExist(this);
    }

    /**
     * 转盘礼品列表
     *
     * @return
     * @author tgb
     * @date 2016年11月3日
     */
    @RequestMapping("/listAll")
    public Object listAll() {
        return prizeService.listAll(this);
    }

    /**
     * 转盘礼品历史记录
     *
     * @return
     * @author tgb 创建时间：2016年10月21日
     */
    @RequestMapping("/listHistory")
    public Object listHistory() {
        return prizeService.listHistory(this);
    }

    /**
     * 摇奖礼品列表
     *
     * @return
     * @author tgb
     * @date 2016年11月3日
     */
    @RequestMapping("/shakeListAll")
    public Object shakeListAll() {
        return prizeService.shakeListAll(this);
    }

    /**
     * 摇奖礼品历史记录
     *
     * @return
     * @author tgb 创建时间：2016年10月21日
     */
    @RequestMapping("/shakeListHistory")
    public Object shakeListHistory() {
        return prizeService.shakeListHistory(this);
    }

    /**
     * 优惠券列表历史记录
     *
     * @return
     * @author tgb 创建时间：2016年10月26日
     * @version 1.0
     */
    @RequestMapping("/couponsListHistory")
    public Object couponsListHistory() {
        return prizeService.couponsListHistory(this);
    }

    /**
     * 查询优惠券列表
     *
     * @return
     * @author tgb 创建时间：2016年10月26日
     * @version 1.0
     */
    @RequestMapping("/couponsListAll")
    public Object couponsListAll() {
        return prizeService.couponsListAll(this);
    }

    /**
     * 查看驳回理由
     *
     * @return
     * @author tgb 创建时间：2016年10月25日
     * @version 1.0
     */
    @RequestMapping("/reason")
    public Object reason() {
        return prizeService.reason(this);
    }

    /**
     * 活动统计
     *
     * @return
     * @author tgb 创建时间：2016年11月1日
     * @version 1.0
     */
    @RequestMapping("/info")
    public Object info() {
        return prizeService.info(this);
    }

    /**
     * 修改状态 启用 禁用 删除
     *
     * @author tgb 创建时间：2016年11月1日
     */
    @RequestMapping("/updatePrizeStatus")
    @ResponseBody
    public Object updatePrizeStatus(BaseController c) {
        return prizeService.updatePrizeStatus(this);
    }

    /**
     * 审核列表
     *
     * @return
     * @author chenwenzhu
     * @date 2016年10月25日
     */
    @RequestMapping("/listAudit")
    @ResponseBody
    public Object listAudit(BaseController c) {
        return prizeService.listAudit(this);
    }


    /**
     * 审核处理页面
     *
     * @return
     * @author chenwenzhu
     * @date 2016年10月25日
     */
    @RequestMapping("/auditEdit")
    public Object auditEdit() {
        return prizeService.operpage(this);
    }

    /**
     * 更新审核状态
     *
     * @return
     * @author chenwenzhu
     * @date 2016年10月25日
     */
    @RequestMapping("/prizeStatus")
    public Object prizeStatus() {
        return prizeService.prizeAuditStatus(this);
    }

    /**
     * 审核历史页面
     *
     * @return
     * @author chenwenzhu
     * @date 2016年10月25日
     */
    @RequestMapping("/listAuditHistory")
    public Object listAuditHistory() {
        return prizeService.listAuditHistory(this);
    }

    /**
     * 批量新审核状态
     *
     * @return
     * @author wangjs
     * @date 2017年02月21日
     */
    @RequestMapping("/prizeAllAuditStatus")
    @ResponseBody
    public Object prizeAllAuditStatus(String[] ids) {
        Integer auditStatus = 1;
        return prizeService.prizeAllAuditStatus(ids, auditStatus);
    }


    /**
     * 查看历史详情
     *
     * @return
     * @author wangjs
     * @date 2017年07月21日
     */
    @RequestMapping("/listAuditHistoryByCfgId")
    public Object listAuditHistoryByCfgId(String prizeConfigById) {
        return prizeService.listAuditHistoryByCfgId(this, prizeConfigById);
    }

    /**
     * 导出大转盘礼品管理到Excel
     *
     * @return
     */
    @RequestMapping(value = "/bigWheelExcel")
    public ModelAndView bigWheelExcel() {
        initialized();
        int isJackpot = pd.getInt("isJackpot");
        ModelAndView mv = this.getModelAndView();
        try {
            return exportExcel("listAll", isJackpot == 0 ? "大转盘礼品管理" : "大转盘大奖管理", 1);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 导出大转盘礼品记录到Excel
     *
     * @return
     */
    @RequestMapping(value = "/bigWheelExcelHistory")
    public ModelAndView bigWheelExcelHistory() {
        initialized();
        int isJackpot = pd.getInt("isJackpot");
        ModelAndView mv = this.getModelAndView();
        try {
            return exportExcel("listHistory", isJackpot == 0 ? "大转盘礼品记录" : "大转盘大奖记录", 1);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 导出摇一摇礼品管理到Excel
     *
     * @return
     */
    @RequestMapping(value = "/shakeExcel")
    public ModelAndView shakeExcel() {
        initialized();
        int isJackpot = pd.getInt("isJackpot");
        ModelAndView mv = this.getModelAndView();
        try {
            return exportExcel("shakeListAll", isJackpot == 0 ? "摇一摇礼品管理" : "摇一摇大奖管理", 2);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 导出摇一摇礼品记录到Excel
     *
     * @return
     */
    @RequestMapping(value = "/shakeExcelHistory")
    public ModelAndView shakeExcelHistory() {
        initialized();
        int isJackpot = pd.getInt("isJackpot");
        ModelAndView mv = this.getModelAndView();
        try {
            return exportExcel("shakeListHistory", isJackpot == 0 ? "摇一摇礼品记录" : "摇一摇大奖记录", 2);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 导出优惠券礼品管理到Excel
     *
     * @return
     */
    @RequestMapping(value = "/couponsExcel")
    public ModelAndView couponsExcel() {
        initialized();
        ModelAndView mv = this.getModelAndView();
        try {
            return couponsExportExcel("couponsListAll", "优惠券礼品管理", 3);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 导出优惠券礼品记录到Excel
     *
     * @return
     */
    @RequestMapping(value = "/couponsExcelHistory")
    public ModelAndView couponsExcelHistory() {
        initialized();
        ModelAndView mv = this.getModelAndView();
        try {
            return couponsExportExcel("couponsListHistory", "优惠券礼品记录", 3);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 导出礼品数据到EXCEL
     *
     * @param queryModule 查询方法
     * @param head        标题
     * @param type        礼品类型
     * @return
     * @throws Exception
     */

    public ModelAndView exportExcel(String queryModule, String head, int type) throws Exception {

        initialized();
        ModelAndView mv = this.getModelAndView();
        addField("shopId", getCurrentUser().getAs_shop_id());
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
            dataMap.put("head", head);
            dataMap.put("titles", titles);
            //获取需要导出的数据
            List<?> list = queryModule(asPrizeConfigMapper, queryModule, false);
            // 实际兑换数 类型 1抽奖 2摇奖 3领取 4 自主活动抽奖
            List<AsPrize> exchangeCountList = asPrizeMapper.getExchangeCountList(type);
            List<PageData> varList = new ArrayList<PageData>();
            if (!list.isEmpty() && list.size() > 0) {
                for (Object a : list) {
                    Map ojb = (Map) a;
                    PageData vpd = new PageData();
                    vpd.put("var1", ojb.get("sn".toString())); // 1
                    vpd.put("var2", ojb.get("name".toString())); // 2
                    vpd.put("var3", ojb.get("prizeTypeName".toString())); // 3
                    vpd.put("var4", ojb.get("shopName".toString())); // 4
                    for (AsPrize p : exchangeCountList) {
                        if (p.getPrizeConfigId().equals(ojb.get("prizeConfigId"))) {
                            vpd.put("var5", p.getExchangeCount()); // 5
                        }
                    }
                    vpd.put("var6", ojb.get("surplusCounts".toString())); // 6
                    vpd.put("var7", ojb.get("counts").toString()); // 7
                    vpd.put("var8", ojb.get("startTime").toString()); // 8
                    vpd.put("var9", ojb.get("endTime").toString()); // 9
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


    /**
     * 优惠券导出到excel
     *
     * @param queryModule
     * @param head
     * @param type
     * @return
     * @throws Exception
     */
    public ModelAndView couponsExportExcel(String queryModule, String head, int type) throws Exception {

        initialized();
        ModelAndView mv = this.getModelAndView();
        addField("shopId", getCurrentUser().getAs_shop_id());
        try {
            Map<String, Object> dataMap = new HashMap<String, Object>();
            List<String> titles = new ArrayList<String>();
            titles.add("礼品编号"); // 1
            titles.add("礼品名称"); // 2
            titles.add("礼品类型"); // 3
            titles.add("优惠券标签"); // 4
            titles.add("商户名称"); // 5
            titles.add("实际兑换"); // 6
            titles.add("礼品余数"); // 7
            titles.add("礼品总数"); // 8
            titles.add("开始时间"); // 9
            titles.add("结束时间"); // 10
            dataMap.put("head", head);
            dataMap.put("titles", titles);
            //获取需要导出的数据
            List<?> list = queryModule(asPrizeConfigMapper, queryModule, false);
            // 实际兑换数 类型 1抽奖 2摇奖 3领取 4 自主活动抽奖
            List<AsPrize> exchangeCountList = asPrizeMapper.getExchangeCountList(type);
            //获取优惠券标签
            List<AsYpBaseCategory> tagTypeList = asYpBaseCategoryMapper.getCouponsListAll();
            List<PageData> varList = new ArrayList<PageData>();
            if (!list.isEmpty() && list.size() > 0) {
                for (Object a : list) {
                    Map ojb = (Map) a;
                    PageData vpd = new PageData();
                    vpd.put("var1", ojb.get("sn".toString())); // 1
                    vpd.put("var2", ojb.get("name".toString())); // 2
                    vpd.put("var3", ojb.get("prizeTypeName".toString())); // 3
                    for (AsYpBaseCategory c : tagTypeList) {
                        if (c.getId().equals(ojb.get("prizeCategoryId"))) {
                            vpd.put("var4", c.getName()); // 10
                        }
                    }
                    vpd.put("var5", ojb.get("shopName".toString())); // 4
                    for (AsPrize p : exchangeCountList) {
                        if (p.getPrizeConfigId().equals(ojb.get("prizeConfigId"))) {
                            vpd.put("var6", p.getExchangeCount()); // 5
                        }
                    }
                    vpd.put("var7", ojb.get("surplusCounts".toString())); // 6
                    vpd.put("var8", ojb.get("counts").toString()); // 7
                    vpd.put("var9", ojb.get("startTime").toString()); // 8
                    vpd.put("var10", ojb.get("endTime").toString()); // 9
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
