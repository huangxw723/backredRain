package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.service.manage.BigWheelService;
import com.aoshi.util.Conditions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 大转盘领取兑换记录Controller
 *
 * @author cwz
 * @date 2017年2月22日
 */
@Controller
@RequestMapping("/bigWheel")
public class BigWheelController extends BaseController {

    private final static String PAGE_PATH_BIGWHEEL = "manage/bigwheel/";
    @Autowired
    private BigWheelService bigWheelService;

    @Autowired
    private AsPrizeMapper prizeMapper;

    /**
     * 大转盘领取礼品记录页面
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/receiveHistory")
    public Object receivedHistory() {
        return bigWheelService.receivedHistory(this);
    }

    /**
     * 大转盘 兑换礼品记录页面
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/exchangeHistory")
    public Object exchangeHistory() {
        return bigWheelService.exchangeHistory(this);
    }


    /**
     * 大转盘兑换页面跳转
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/toReceive")
    @ResponseBody
    public Object receive() {
        return bigWheelService.receive(this);
    }

    /**
     * 大转盘兑换操作
     *
     * @return
     */
    @RequestMapping("/editReceive")
    @ResponseBody
    public int editReceive(String sn) {
        return bigWheelService.editReceive(sn);
    }

    /**
     * 大转盘规则设置页面跳转
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/toEditPrize")
    @ResponseBody
    public Object toEditPrize() {
        return bigWheelService.toEditPrize(this);
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
        return PAGE_PATH_BIGWHEEL + "prizeDetail";
    }

}
