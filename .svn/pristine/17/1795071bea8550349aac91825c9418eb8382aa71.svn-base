package com.aoshi.service.business;

import com.aoshi.common.asenum.ActivityTypeEnum;
import com.aoshi.common.asenum.BaseCategoryTypeEnum;
import com.aoshi.common.asenum.DictParam;
import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.controller.manage.consultation.streetFood.streetFoodController;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsEventMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.domain.AsActivity;
import com.aoshi.domain.AsActivityMeeting;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsEvent;
import com.aoshi.domain.AsPrize;
import com.aoshi.domain.AsPrizeConfig;
import com.aoshi.domain.AsPrizeJackpot;
import com.aoshi.domain.AsProvince;
import com.aoshi.domain.AsShop;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.service.manage.ActivityService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Transactional
public class BussinessActivityService extends AsBaseService {

    private final static String PAGE_PATH = "business/activity/";

    @Autowired
    private AsEventMapper asEventMapper;
    
    @Autowired
    private AsDictParamMapper asDictParamMapper;
    
    @Autowired
    private AsShopMapper asShopMapper;

    /**
     * 商户活动列表    
     * @return
     * @author chenwz
     * @date 2017年5月25日
     */
    public Object listAll(BaseController c) {

        initialized(c);
        addField("shopId", getUser().getAs_shop_id());
        pageQueryModule(asEventMapper, "listAll", true);      
        addViewData("shopId", getUser().getAs_shop_id());       
        return renderView(PAGE_PATH + "listAll");
    }
    
    /**
     * 商户活动页面跳转中转 
     * @author chenwz
     * @date 2017年5月25日
     */
    public Object topage(BaseController c) {

        initialized(c);
        OperaEnum action = OperaEnum.get(pd.getInt("action"));
        switch (action) {

            case ADD:          		 			
                break;

            case EDIT:
                int asEventId = pd.getInt("asEventId");           
                AsEvent asEvent =  asEventMapper.selectByPrimaryKey(asEventId);
                ValidatorBreakException.NOT_NULL(asEvent, 1001, "系统繁忙", 1);
                addViewData("pd", asEvent);             
                break;

            case QUERY:
            	asEventId = pd.getInt("asEventId");
            	AsEvent asEvent1 =  asEventMapper.selectByPrimaryKey(asEventId);
                ValidatorBreakException.NOT_NULL(asEvent1, 1001, "系统繁忙", 1);
                addViewData("pd", asEvent1);              
                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }
      
        //判断是否是后台运营管理员
        if (isAdminRole()) {
            List<Conditions> shopAll = asShopMapper.findByShopAll();
            addViewData("shopAll", shopAll);
           
        } else {
            String shopId = getUser().getAs_shop_id();
            AsShop asShop = asShopMapper.findByShopId(shopId);
            addViewData("asShop", asShop);           
        }
    
        addViewData("action", action.getId());
        return renderView(PAGE_PATH + "save");
    }

    /**
	 * 全局操作
	 * @author chenwz
	 * @date 2017年5月25日
	 * @return
	 */
    public Object opera(BaseController c) {
		initialized(c);
		OperaEnum action = OperaEnum.get(pd.getInt("action"));  	
		switch (action) {
		case ADD:
			String eventName = pd.getString("eventName");
			String eventTitle = pd.getString("eventTitle");
			Integer shopId = pd.getInt("shopId");
            Integer storeId = pd.getInt("storeId");
			String startTime = pd.getString("startTime");
			String endTime = pd.getString("endTime");
			String eventDetail = pd.getString("eventDetail");
			uploadModule(UploadPathEnum.EVENTIMG, "eventLogo");
			String eventLogo = pd.get("eventLogo") == null ? "" : pd
					.get("eventLogo").toString();
			ValidatorBreakException
					.NOT_TRUE(!(eventLogo == null || eventLogo.trim()
							.length() == 0), "请上传活动logo");

			long timeDiff = CommonUtils.orderTimeDiff(
					CommonUtils.getTimeMils(endTime),
					System.currentTimeMillis());
			ValidatorBreakException.NOT_TRUE(timeDiff != 0, "结束日期必须大于等于当天时间");
			long timeDiff2 = CommonUtils.orderTimeDiff(
					CommonUtils.getTimeMils(endTime),
					CommonUtils.getTimeMils(startTime));
			ValidatorBreakException.NOT_TRUE(timeDiff2 != 0, "结束日期必须大于开始日期");		
			AsEvent event=new AsEvent();
			event.setEventName(eventName);
			event.setEventTitle(eventTitle);
			event.setShopId(shopId);
			event.setStoreId(storeId);
			event.setEventLogo(eventLogo);
			event.setEventDetail(eventDetail);
			event.setStartTime(startTime);
			event.setEndTime(endTime);
			event.setCreateTime(DateUtil.getTime());
			event.setStatus(0);
            event.setAuditStatus(0);
			operaFlag = asEventMapper.insertSelective(event) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);  	
			break;

		case EDIT:	
			 event= new AsEvent();
			 int asEventId = pd.getInt("asEventId");
			 event = asEventMapper.selectByPrimaryKey(asEventId);
			 ValidatorBreakException.NOT_NULL(event, "系统繁忙");
			 eventName = pd.getString("eventName");
			 eventTitle = pd.getString("eventTitle");
			 if(event.getStatus() == 0){
				 shopId = pd.getInt("shopId");
	             storeId = pd.getInt("storeId");
	             event.setShopId(shopId);
				 event.setStoreId(storeId);
			 }			
			 startTime = pd.getString("startTime");
			 endTime = pd.getString("endTime");			 
			 uploadModule(UploadPathEnum.EVENTIMG, "eventLogo");
			 eventLogo = pd.get("eventLogo") == null ? event.getEventLogo() : pd.get("eventLogo")
						.toString();
			 eventDetail = pd.getString("eventDetail");
			 event.setEventName(eventName);
		     event.setEventTitle(eventTitle);		  
			 event.setEventLogo(eventLogo);
			 event.setStartTime(startTime);		
			 event.setEndTime(endTime);
			 event.setEventDetail(eventDetail);
			 operaFlag = asEventMapper.updateByPrimaryKeySelective(event) == 1;
			 ValidatorBreakException.NOT_TRUE(operaFlag);
			break;
		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess();
	}
    
    /**
     * 更新礼品状态  
     * @param c
     * @return
     * @author chenwz
     * 创建时间：2017年5月25日
     * 
     */
    public Object updateEventStatus(BaseController c) {

        initialized(c);
        int asEventId = pd.getInt("asEventId");
        int status = pd.getInt("status");
        operaFlag = asEventMapper.updateEventStatus(asEventId, status) == 1;
        ValidatorBreakException.NOT_TRUE(operaFlag);
        return renderSuccess();
    }
    
    /**
	 * 删除商户活动
	 * @author chenwwz
	 * 创建时间：2017年5月25日 
	 * @return
	 */
	public Object deleteEvent(BaseController c) {

		initialized(c);
		int asEventId = pd.getInt("asEventId");
		operaFlag = asEventMapper.deleteByPrimaryKey(asEventId) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		return renderSuccess();
	}
	
	 /**
     * 查看驳回理由
     * @param c
     * @return
     * @author chenwz 
     * 创建时间：2017年5月26日
     */
    public Object reason(BaseController c) {

        initialized(c);
        int asEventId = pd.getInt("asEventId");
        AsEvent asevent= asEventMapper.selectByPrimaryKey(asEventId);
        ValidatorBreakException.NOT_NULL(asevent, 1001, "系统繁忙", 1);
        addViewData("asEvent", asevent);
        return renderView(PAGE_PATH + "reason");
    }
    
    /**
  	 * 异步检查是否重名
  	 * @author chenwz
  	 * 创建时间：2017年5月26日	
  	 * @return
  	 */
    public Object isExist(BaseController c) {
		initialized(c);
		String eventName = pd.getString("eventName");
		Integer data = asEventMapper.findByName(eventName);
		if (data > 0) {
			return true;
		}
		return false;
	}

    /**
     * 判断是否是管理员和运营管理组权限
     *
     * @return
     */
    public boolean isAdminRole() {
        String roleId = getUser().getROLE_ID();
        if (StringUtils.isNotBlank(roleId)) {
            String adminRoleId = asDictParamMapper.findByKeyCode(DictParam.PARAM_ADMIN_ROLE_ID);
            String operationRoleId = asDictParamMapper.findByKeyCode(DictParam.PARAM_OPERATION_MANAGER_ROLE_ID);
            if (roleId.equals(adminRoleId) || roleId.equals(operationRoleId)) {
                return true;
            }
        }
        return false;
    }

    /**
     * #############################################商户活动审核管理###################################################
     */

    /**
     * 商户活动审核列表
     *
     * @param c
     * @return
     * @author tgb
     * @date 2017年05月25日
     */
    public Object listAudit(BaseController c) {
        initialized(c);
        pageQueryModule(asEventMapper, "listAudit", true);
        return renderView(PAGE_PATH + "listAudit");
    }

    /**
     * 审核处理页面
     *
     * @param c
     * @return
     * @author tgb
     * @date 2017年05月21日
     */
    public Object page(BaseController c) {
        initialized(c);
        int asEventId = pd.getInt("asEventId");
        Conditions event = asEventMapper.auditHistoryById(asEventId);
        addViewData("event", event);
        return renderView(PAGE_PATH + "auditEdit");
    }

    /**
     * 更新审核状态
     *
     * @param c
     * @return
     * @author tgb
     * @date 2017年05月21日
     */
    public Object updateStatus(BaseController c) {
        initialized(c);
        int asEventId = pd.getInt("asEventId");
        int auditStatus = pd.getInt("auditStatus");
        String reason = pd.getString("reason");
        AsEvent event = asEventMapper.selectByPrimaryKey(asEventId);
        ValidatorBreakException.NOT_NULL(event);
        if (auditStatus == 1) {
            event.setAuditStatus(auditStatus);
            event.setAuditTime(DateUtil.getTime());
            event.setStatus(1);
            event.setReason(reason);
            operaFlag = asEventMapper.updateByPrimaryKeySelective(event) == 1;
            ValidatorBreakException.NOT_TRUE(operaFlag);
        } else if (auditStatus == 2) {
            event.setAuditStatus(auditStatus);
            event.setAuditTime(DateUtil.getTime());
            event.setReason(reason);
            operaFlag = asEventMapper.updateByPrimaryKeySelective(event) == 1;
            ValidatorBreakException.NOT_TRUE(operaFlag);
        }
        return renderSuccess(1);
    }

    /**
     * 批量新审核状态
     *
     * @return
     * @author tgb
     * @date 2017年05月21日
     */
    public Object allAuditStatus(String[] ids, Integer auditStatus) {
        Map<String, Object> data = new HashMap<String, Object>();
        String errIds = "";
        if (ids.length > 0) {
            for (int i = 0; i < ids.length; i++) {
                Integer asEventId = Integer.valueOf(ids[i]);
                AsEvent event = asEventMapper.selectByPrimaryKey(asEventId);
                ValidatorBreakException.NOT_NULL(event);
                if (auditStatus == 1) {
                    event.setAuditStatus(auditStatus);
                    event.setAuditTime(DateUtil.getTime());
                    event.setStatus(1);
                    event.setReason("审核通过");
                    operaFlag = asEventMapper.updateByPrimaryKeySelective(event) == 1;
                    if (!operaFlag) {
                        errIds = event.toString() + ",";
                    }
                } else if (auditStatus == 2) {
                    event.setAuditStatus(auditStatus);
                    event.setAuditTime(DateUtil.getTime());
                    event.setReason("审核不通过");
                    operaFlag = asEventMapper.updateByPrimaryKeySelective(event) == 1;
                    ValidatorBreakException.NOT_TRUE(operaFlag);
                    if (!operaFlag) {
                        errIds = event.toString() + ",";
                    }
                }
            }
            data.put("status", "0");
            data.put("errIds", errIds);
        } else {
            data.put("status", "1");
        }
        return data;
    }

    /**
     * 审核历史列表
     *
     * @param c
     * @return
     * @author tgb
     * @date 2017年05月21日
     */
    public Object listAuditHistory(BaseController c) {
        initialized(c);
        pageQueryModule(asEventMapper, "listAuditHistory", true);
        return renderView(PAGE_PATH + "listAuditHistory");
    }

    /**
     * 查看历史详情页面
     *
     * @return
     * @author tgb
     * @date 2017年05月21日
     */
    public Object auditHistoryById(BaseController c) {
        initialized(c);
        int asEventId = pd.getInt("asEventId");
        Conditions event = asEventMapper.auditHistoryById(asEventId);
        addViewData("event", event);
        return renderView(PAGE_PATH + "auditHistoryInfo");
    }

}
