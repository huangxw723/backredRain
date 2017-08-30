package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.manage.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 意见反馈controller
 */
@Controller
@RequestMapping("/feedback")
public class FeedbackController extends BaseController {

    @Autowired
    FeedbackService feedbackService;

    /**
     * 意见反馈列表
     *
     * @return
     */
    @RequestMapping("/listAll")
    public Object listAll() {
        return feedbackService.listAll(this);
    }

    /**
     * 意见反馈页面跳转中转
     *
     * @author tgb
     * @date 2017年4月18日
     */
    @RequestMapping("/page")
    public Object page() {
        return feedbackService.page(this);
    }

    /**
     * 意见反馈全局操作
     *
     * @author tgb
     * @date 2017年4月18日
     */
    @RequestMapping("/opera")
    @ResponseBody
    public Object opera() {
        return feedbackService.opera(this);
    }

}
