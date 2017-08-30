package com.aoshi.service.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityReceivedRecordMapper;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.domain.AsActivityReceivedRecord;
import com.aoshi.domain.AsPrize;
import com.aoshi.entity.system.User;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Const;
import com.aoshi.util.DateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 大转盘 领取兑换记录
 *
 * @author cwz
 * @date 2017年2月22日
 */
@Service
public class BigWheelService extends AsBaseService {


    private final static String PAGE_PATH_BIGWHEEL = "manage/bigwheel/";

    @Autowired
    private AsActivityReceivedRecordMapper recordMapper;

    @Autowired
    private AsPrizeMapper asPrizeMapper;

    @Autowired
    private AsActivityReceivedRecordMapper asActivityReceivedRecordmapper;


    /**
     * 大转盘 礼品领取记录列表
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object receivedHistory(BaseController c) {
        initialized(c);
        addField("shopId", getCurrentUser().getAs_shop_id());
        addField("activityType", 1);
        pageQueryModule(recordMapper, "listAll", true);
        return renderView(PAGE_PATH_BIGWHEEL + "listReceiveHistory");
    }

    /**
     * 大转盘 礼品兑换领取记录列表
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object exchangeHistory(BaseController c) {

        initialized(c);
        addField("shopId", getCurrentUser().getAs_shop_id());
        addField("activityType", 1);
        pageQueryModule(recordMapper, "listAllExchage", true);
        return renderView(PAGE_PATH_BIGWHEEL + "listExchangeHistory");
    }

    /**
     * go兑换页面
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object receive(BaseController c) {
        initialized(c);
        return renderView(PAGE_PATH_BIGWHEEL + "receive");
    }

    /**
     * 进行兑换操作
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月21日
     */

    public int editReceive(String sn) {
        User user = new User();
        user = getUser();
        if (!getUser().getAs_shop_id().equals("null")) {// 获取商铺id如果不为null则是商场账号 ，反之则是后台管理员账号
            //判断优惠券是否有效
            AsPrize prize = asPrizeMapper.findBySn(sn.trim(),1);
            if (prize == null) {
                return 200;
            }
            String starttime=prize.getStartTime();
            String endtime=prize.getEndTime();
            if(starttime.isEmpty()){
                return  100;
            }else{
                //判断优惠券到开始时间
                long starTtime = DateUtil.parseDate(starttime).getTime();
                if (new Date().getTime() < starTtime) {
                    return 50;
                }
            }
            if(endtime.isEmpty()){
             	return  100;
            }else{
           	//判断优惠券是否过期
      			long endTime = DateUtil.parseDate(endtime).getTime();
      			if (new Date().getTime() > endTime) {   				
      				return 300;
      			}
            }  	        
            //判断是否属本店铺的优惠券
            String shopId = getUser().getAs_shop_id();
            if (!shopId.equals(new Integer(prize.getShopId()).toString())) {
                return 400;
            }
            //优惠券是否被使用
            int prizeId = prize.getPrizeId();
            //AsPrize prize = asPrizeMapper.selectByPrimaryKey(prizeId);
            if (prize.getStatus().equals(1)) {
                return 500;
            }
            AsActivityReceivedRecord record = new AsActivityReceivedRecord();
            record.setPrizeId(prizeId);
            record.setType(1);
            AsActivityReceivedRecord receivedRecord = asActivityReceivedRecordmapper.findByAttr(record);
            if (receivedRecord != null) {
                int result = asPrizeMapper.updateUsePrize(prizeId);
                if (result > 0) {
                        /*AsActivity activity = asActivityMapper.selectByStatusAndType(1, 2);
    					Assert.notNull(activity, "活动已结束");*/
                    AsActivityReceivedRecord r = new AsActivityReceivedRecord();
                    r.setUserId(receivedRecord.getUserId());
                    r.setCreateTime(DateUtil.getTime());
                    r.setPrizeId(prizeId);
                    r.setType(2);
                    r.setStoreId(prize.getStoreId());
                    r.setShopId(prize.getShopId());
                    r.setStaffId(Integer.valueOf(user.getNewUserId()));
                    asActivityReceivedRecordmapper.insertSelective(r);
                }
                //领取成功
                return 700;
            } else {
                //尚未领取
                return 600;
            }
        }
        return 800;
    }

    /**
     * 大转盘规则设置
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object toEditPrize(BaseController c) {

        initialized(c);
        return renderView(PAGE_PATH_BIGWHEEL + "editPrize");
    }

    /**
     * 获取后台用户
     *
     * @return
     */
    public User getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        return user;
    }

}
