package com.aoshi.controller.manage;

import com.aoshi.domain.AsActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.ActivityAdService;

import java.util.List;

/**
 * 广告管理 Controller
 *
 * @author haungxw
 * @date 2016年9月2日
 */
@Controller
@RequestMapping("/activityAd")
public class ActivityAdController extends BaseController {

    @Autowired
    private ActivityAdService activityAdService;

    /**
     * 跳转到添加页面
     *
     * @author haungxw
     * @date 2016年9月2日
     */
    @RequestMapping("/page")
    public Object page() {
        return activityAdService.page(this);
    }


    /**
     * 广告增删改操作
     *
     * @return
     * @author haungxw
     * @date 2016年9月2日
     */
    @RequestMapping("/opera")
    @ResponseBody
    public Object opera() {
        return activityAdService.opera(this);
    }

    /**
     * 查询广告列表
     *
     * @return
     * @author haungxw
     * @date 2016年9月3日
     */
    @RequestMapping("/listAll")
    public Object listAll() {
        return activityAdService.listAll(this);
    }

    /**
     * 删除广告
     *
     * @return
     * @author haungxw
     * @date 2016年9月5日
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(BaseController c) {
        return activityAdService.delete(this);
    }

    /**
     * 更新广告使用状态
     *
     * @return
     * @author haungxw
     * @date 2016年9月5日
     */
    @RequestMapping("/accountStatus")
    @ResponseBody
    public Object accountStatus(BaseController c) {
        return activityAdService.accountStatus_Tx(this);
    }

    /**
     * 校验积分广告数量
     *
     * @return
     * @author sjs
     * @date 2017年1月3日
     */
    @RequestMapping("/CheckPointActivityCount")
    @ResponseBody
    public Object CheckPointActivityCount(BaseController c) {
        Integer type = 3;
        return activityAdService.CheckPointActivityCount(type);
    }

    /**
     * E街E铺-活动 获取当前进行中的红包雨活动
     *
     * @return
     * @author yangyanchao
     * @date 2017-03-06
     */
    @RequestMapping("/getCurrentActivity")
    @ResponseBody
    public List<AsActivity> getCurrentActivity() {
        return activityAdService.getCurrentActivity();
    }

}
