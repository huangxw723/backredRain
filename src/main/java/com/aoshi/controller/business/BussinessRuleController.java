package com.aoshi.controller.business;

import com.aoshi.dao.AsStoreMapper;
import com.aoshi.dao.CalNumRecordMapper;
import com.aoshi.dao.CalNumSetMapper;
import com.aoshi.domain.*;
import com.aoshi.entity.system.User;
import com.aoshi.service.business.BussinessRuleService;
import com.aoshi.util.Const;
import com.aoshi.util.PageData;
import net.sf.json.JSONArray;
import org.apache.commons.lang.math.RandomUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.*;
import java.io.IOException;

/**
 * BussinessRuleController
 * 抽奖概率设置
 * @author zf
 * @date 10/24/16
 */
@Controller()
@RequestMapping("/prize")
public class BussinessRuleController {

    private static final String BASEURL="business/coupon/";

    private static Log log = LogFactory.getLog(BussinessRuleController.class);

    @Autowired
    BussinessRuleService bussinessRuleService;
    @Autowired
    AsStoreMapper asStoreMapper;
    /**@author luhuajiang
     * 编辑标签页面
     * @param map
     * @return
     */
    @RequestMapping("/toEditPrize")
    public String toEditPrize(ModelMap map, Integer storeId) {
        Map<String, Object> prizeData = bussinessRuleService.findByPrizeConfig(storeId);
        AsStore store = asStoreMapper.selectByPrimaryKey(storeId);
        map.put("prizeData", prizeData);
        map.put("storeId", storeId);
        map.put("store", store);
        return BASEURL + "editPrize";
    }

    @RequestMapping("/save")
    public String save(String discs, String shakes, Integer storeId, boolean isCooperation
            ,@RequestParam(value = "fileInput" ,required = true) MultipartFile [] fileInput
            , ModelMap map) throws IOException {
        bussinessRuleService.savePrizeData(discs, shakes,storeId,isCooperation,fileInput);

        Map<String, Object> prizeData = bussinessRuleService.findByPrizeConfig(storeId);
        map.put("prizeData", prizeData);
        map.put("storeId", storeId);
        AsStore store = asStoreMapper.selectByPrimaryKey(storeId);
        map.put("store", store);
        return BASEURL + "editPrize";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map<String, String> delete(int id) {
        bussinessRuleService.delete(id);
        Map<String, String> data = new HashMap<>();
        data.put("msg", "操作成功");
        data.put("status", "200");
        return data;
    }

    @RequestMapping("goAddShake.do")
    public String goAddShake(ModelMap map, Integer storeId){
        map.put("storeId", storeId);
        return BASEURL + "addShake";
    }

    @RequestMapping("/saveShake")
    public String saveShake(ModelMap map, String name, Integer storeId){
        AsActivityShake asActivityShake = new AsActivityShake();
        asActivityShake.setName(name);
        asActivityShake.setProbability(BigDecimal.ZERO);
        asActivityShake.setStoreId(storeId);
        bussinessRuleService.saveShake(asActivityShake);
        return BASEURL + "result";
    }

    /**
     * 获取后台用户
     *
     * @author luhuajiang
     * @return
     */
    public User getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        return user;
    }

}
