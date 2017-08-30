package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.service.manage.ShakeService;
import com.aoshi.util.Conditions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 摇一摇 Controller
 *
 * @author cwz
 * @date 2017年2月22日
 */
@Controller
@RequestMapping("/shake")
public class ShakeController extends BaseController {

    private final static String PAGE_PATH_SHAKE = "manage/shake/";

    @Autowired
    private ShakeService shakeService;

    @Autowired
    private AsPrizeMapper prizeMapper;

    /**
     * 摇一摇领取礼品记录页面
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月22日
     */
    @RequestMapping("/receiveHistory")
    public Object receivedHistory() {
        return shakeService.receivedHistory(this);
    }

    /**
     * 摇一摇兑换页面跳转
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/toReceive")
    @ResponseBody
    public Object receive() {
        return shakeService.receive(this);
    }

    /**
     * 摇一摇 兑换礼品记录页面
     *
     * @return
     * @author tgb
     * 创建时间：2017年3月6日
     * @version 1.0
     */
    @RequestMapping("/exchangeHistory")
    public Object shakeExchangeHistory() {
        return shakeService.exchangeHistory(this);
    }

    /**
     * 摇一摇兑换操作
     *
     * @param sn
     * @return
     */
    @RequestMapping("/editReceive")
    @ResponseBody
    public int editReceive(String sn) {
        return shakeService.editReceive(sn);
    }

    /**
     * 摇一摇规则设置页面跳转
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */
    @RequestMapping("/toEditPrize")
    @ResponseBody
    public Object toEditPrize() {
        return shakeService.toEditPrize(this);
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
        return PAGE_PATH_SHAKE + "prizeDetail";
    }
}
