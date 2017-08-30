package com.aoshi.service.manage;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsRobotConsultMapper;
import com.aoshi.domain.AsRobotConsult;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 小宝咨询service
 */
@Service
public class RobotConsultService extends AsBaseService {

    private final static String PAGE_PATH = "manage/robotConsult/";

    @Autowired
    AsRobotConsultMapper asRobotConsultMapper;

    /**
     * 小宝咨询列表
     *
     * @param c
     * @return
     * @author tgb 创建时间：2017年5月5日
     */
    public Object listAll(BaseController c) {
        initialized(c);
        pageQueryModule(asRobotConsultMapper, "listAll", true);
        return renderView(PAGE_PATH + "listAll");
    }

    /**
     * 小宝咨询页面中转控制
     *
     * @param c
     * @return
     * @author tgb 创建时间：2017年5月5日
     * @version 1.0
     */
    public Object page(BaseController c) {

        initialized(c);

        OperaEnum action = OperaEnum.get(pd.getInt("action"));
        switch (action) {
            case QUERY:
                int robotConsultId = pd.getInt("robotConsultId");
                AsRobotConsult asRobotConsult = asRobotConsultMapper.selectByPrimaryKey(robotConsultId);
                ValidatorBreakException.NOT_NULL(asRobotConsult, 1001, "系统繁忙", 1);
                addViewData("pd", asRobotConsult);
                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }
        addViewData("action", action.getId());
        return renderView(PAGE_PATH + "save");
    }

}
