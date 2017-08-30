package com.aoshi.service.manage;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsFeedbackMapper;
import com.aoshi.domain.AsFeedback;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 意见反馈service
 */
@Service
public class FeedbackService extends AsBaseService {

    private final static String PAGE_PATH = "manage/feedback/";

    @Autowired
    AsFeedbackMapper asFeedbackMapper;

    /**
     * 意见反馈列表
     *
     * @param c
     * @return
     * @author tgb 创建时间：2017年4月11日
     */
    public Object listAll(BaseController c) {
        initialized(c);
        pageQueryModule(asFeedbackMapper, "listAll", true);
        return renderView(PAGE_PATH + "listAll");
    }

    /**
     * 意见反馈页面中转控制
     *
     * @param c
     * @return
     * @author tgb 创建时间：2017年4月11日
     * @version 1.0
     */
    public Object page(BaseController c) {

        initialized(c);

        OperaEnum action = OperaEnum.get(pd.getInt("action"));
        switch (action) {

            case EDIT:
                int feedbackId = pd.getInt("feedbackId");
                Conditions feedback = (Conditions) asFeedbackMapper.findByIdEdit(feedbackId);
                ValidatorBreakException.NOT_NULL(feedback, 1001, "系统繁忙", 1);
                addViewData("pd", feedback);
                break;

            case QUERY:
                feedbackId = pd.getInt("feedbackId");
                feedback = (Conditions) asFeedbackMapper.findById(feedbackId);
                ValidatorBreakException.NOT_NULL(feedback, 1001, "系统繁忙", 1);
                addViewData("pd", feedback);
                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }
        addViewData("action", action.getId());
        return renderView(PAGE_PATH + "save");
    }

    /**
     * 意见反馈操作
     *
     * @param c
     * @return
     * @author tgb
     * @date 2017年4月12日
     */
    public Object opera(BaseController c) {

        initialized(c);
        OperaEnum action = OperaEnum.get(pd.getInt("action"));
        switch (action) {
            case EDIT:
                String remark = pd.getParaForString("remark");
                Integer feedbackId = pd.getInt("feedbackId");
                AsFeedback feedback = asFeedbackMapper.selectByPrimaryKey(feedbackId);
                ValidatorBreakException.NOT_NULL(feedback, "系统繁忙");
                feedback.setStatus(1);
                feedback.setRemark(remark);
                feedback.setUpdateTime(DateUtil.getTime());
                feedback.setSysUserId(Integer.parseInt(getUser().getNewUserId()));
                operaFlag = asFeedbackMapper.updateByPrimaryKey(feedback) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);
                break;
            default:
                ValidatorBreakException.NOT_TRUE(false);
        }

        return renderSuccess();
    }

}
