package com.aoshi.service.manage;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsAdvertiserMapper;
import com.aoshi.domain.AsAdvertiser;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 广告客户service
 */
@Service
public class AsAdvertiserService extends AsBaseService {

    private final static String PAGE_PATH = "manage/advertiser/";

    @Autowired
    AsAdvertiserMapper asAdvertiserMapper;

    /**
     * 广告客户列表
     *
     * @param c
     * @return
     * @author tgb 创建时间：2017年4月11日
     */
    public Object listAll(BaseController c) {
        initialized(c);
        pageQueryModule(asAdvertiserMapper, "listAll", true);
        return renderView(PAGE_PATH + "listAll");
    }

    /**
     * 广告客户页面中转控制
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
            case QUERY:
                int advertiserId = pd.getInt("advertiserId");
                AsAdvertiser asAdvertiser = asAdvertiserMapper.selectByPrimaryKey(advertiserId);
                ValidatorBreakException.NOT_NULL(asAdvertiser, 1001, "系统繁忙", 1);
                addViewData("pd", asAdvertiser);
                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }
        addViewData("action", action.getId());
        return renderView(PAGE_PATH + "save");
    }

}
