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

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 全局礼品操作 Service
 * 
 * @author tgb
 * @date 2016年11月2日
 */
@Service
public class ShakeService extends AsBaseService {

	private final static String PAGE_PATH_SHAKE = "manage/shake/";	
	

	@Autowired
	private AsActivityReceivedRecordMapper recordMapper;

	@Autowired
	private AsPrizeMapper prizeMapper;

			
	
	/**
	 * 摇一摇 礼品领取记录列表
	 * 
	 * @author chenwenzhu
	 * @date 2017年2月18日
	 * @param c
	 * @return
	 */
	
	public Object receivedHistory(BaseController c){
		initialized(c);
		addField("shopId",getCurrentUser().getAs_shop_id());
		addField("activityType",2);
    	pageQueryModule(recordMapper, "listAll", true);       
		return renderView(PAGE_PATH_SHAKE+"listReceiveHistory");
	}
	
	/**
	 * 摇一摇、礼品兑换领取记录列表
	 * 
	 * @author chenwenzhu
	 * @date 2017年2月18日
	 * @param c
	 * @return
	 */	
	public Object exchangeHistory(BaseController c){
		
		initialized(c);
		addField("shopId",getCurrentUser().getAs_shop_id());
		addField("activityType",2);
    	pageQueryModule(recordMapper, "listAllExchage", true);
		return renderView(PAGE_PATH_SHAKE+"listExchangeHistory");
	}
	
	
	/**
	 * 兑换页面跳转
	 * @author chenwenzhu
	 * @date 2017年2月18日
	 * @param c
	 * @return
	 */	
    public Object receive(BaseController c){
		
		initialized(c);
		return renderView(PAGE_PATH_SHAKE+"receive");
	}
    
    /**
	 * 进行兑换操作
	 * @author chenwenzhu
	 * @date 2017年2月21日
	 * @param sn
	 * @return
	 */
    public int editReceive(String sn){
			
    	  User user = new User();
	      user=getUser();
    	  if (!getUser().getAs_shop_id().equals("null")) {// 获取商铺id如果不为null则是商场账号 ，反之则是后台管理员账号    	
  		    //判断优惠券是否有效
  			 AsPrize prize = prizeMapper.findBySn(sn.trim(),2);
  			 if(prize==null){
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
              String shopId= getUser().getAs_shop_id();   			
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
  			AsActivityReceivedRecord receivedRecord = recordMapper.findByAttr(record);
  			if (receivedRecord != null) {
  				int result = prizeMapper.updateUsePrize(prizeId);
  				if (result > 0) {
  					/*AsActivity activity = asActivityMapper.selectByStatusAndType(1, 2);
  					Assert.notNull(activity, "活动已结束");*/
  					AsActivityReceivedRecord r = new AsActivityReceivedRecord();
  					r.setUserId(receivedRecord.getUserId());
  					r.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
  					r.setPrizeId(prizeId);
  					r.setType(2);
  					r.setStoreId(prize.getStoreId());
  					r.setShopId(prize.getShopId());  
  					r.setStaffId(Integer.valueOf(user.getNewUserId()));
  					recordMapper.insertSelective(r);
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
	 * 摇一摇规则设置页面跳转
	 * @author chenwenzhu
	 * @date 2017年2月18日
	 * @param c
	 * @return
	 */
    public Object toEditPrize(BaseController c){
		
		initialized(c);
		return renderView(PAGE_PATH_SHAKE+"editPrize");
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
