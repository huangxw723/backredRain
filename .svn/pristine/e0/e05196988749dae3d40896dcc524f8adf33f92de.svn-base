package com.aoshi.service.manage;

import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.*;
import com.aoshi.domain.*;
import com.aoshi.entity.Page;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * 全局操作 Service
 * 
 * @author tgb
 * @date 2017年03月06日
 */
@Service
public class ActivityMeetingService extends AsBaseService {

	private final static String PAGE_PATH = "manage/activityMeeting/";

	@Autowired
	private AsActivityMapper activityMapper;

	@Autowired
	private AsActivityMeetingMapper activityMeetingMapper;

	@Autowired
	private AsProvinceMapper provinceMapper;

	@Autowired
	private AsCityMapper asCityMapper;

	@Autowired
	private AsAreaMapper asAreaMapper;

	/**
	 * 页面中转控制
	 *
	 * @author tgb 创建时间：2017年03月05日
	 * @version 1.0
	 * @param c
	 * @return
	 */
	public Object page(BaseController c) {

		initialized(c);

		OperaEnum action = OperaEnum.get(pd.getInt("action"));
		int activityStatus = pd.getInt("activityStatus");
		switch (action) {

		case ADD:
			break;

		case EDIT:

			int activityId = pd.getInt("activityId");
			AsActivity activity = activityMapper.selectByPrimaryKey(activityId);
			ValidatorBreakException.NOT_NULL(activity, 1001, "系统繁忙", 1);

			AsActivityMeeting activityMeeting = activityMeetingMapper
					.selectByActivityId(activityId);
			ValidatorBreakException.NOT_NULL(activityMeeting, 1001, "系统繁忙", 1);

			addViewData("pd", activity);
			addViewData("am", activityMeeting);
			break;

		default:
			ValidatorBreakException.NOT_TRUE(false);
		}
		// 获取地址集合
		Page page = c.getPage();

		page.setCurrentPage(1);
		page.setShowCount(100);
		page.setPd(pd);

		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());

		List<AsProvince> provinceList = provinceMapper.selectByAttr(pd);
		List<AsCity> cityList = asCityMapper.selectByAttr(null);
		JSONArray cityListJson = JSONArray.fromObject(cityList);
		List<AsArea> areaList = asAreaMapper.selectByAttr(null);
		JSONArray areaListJson = JSONArray.fromObject(areaList);

		addViewData("provinceList", provinceList);
		addViewData("cityList", cityListJson);
		addViewData("areaList", areaListJson);

		addViewData("action", action.getId());
		addViewData("activityStatus", activityStatus);
		return renderView(PAGE_PATH + "save");
	}

	/**
	 * 操作
	 * 
	 * @author tgb
	 * @date 2017年03月06日
	 * @param c
	 * @return
	 */
	public Object opera(BaseController c) {

		initialized(c);

		OperaEnum action = OperaEnum.get(pd.getInt("action"));
		int activityStatus = pd.getInt("activityStatus");
		switch (action) {
		case ADD:
			// 获取activity入参值
			String activityName = pd.getString("activityName");
			String startTime = pd.getString("startTime");
			String endTime = pd.getString("endTime");
			uploadModule(UploadPathEnum.ACTIVITYMEETING, "propagandaUrl");
			String propagandaUrl = pd.get("propagandaUrl") == null ? "" : pd
					.get("propagandaUrl").toString();
			ValidatorBreakException
					.NOT_TRUE(!(propagandaUrl == null || propagandaUrl.trim()
							.length() == 0), "请上传宣传图片");

			long timeDiff = CommonUtils.orderTimeDiff(
					CommonUtils.getTimeMils(endTime),
					System.currentTimeMillis());
			ValidatorBreakException.NOT_TRUE(timeDiff != 0, "结束日期必须大于等于当天时间");
			long timeDiff2 = CommonUtils.orderTimeDiff(
					CommonUtils.getTimeMils(endTime),
					CommonUtils.getTimeMils(startTime));
			ValidatorBreakException.NOT_TRUE(timeDiff2 != 0, "结束日期必须大于开始日期");
			// 添加配置 插入数据 AsActivity
			AsActivity activity = new AsActivity();
			activity.setActivityName(activityName);
			activity.setActivityType(2);
			activity.setPropagandaUrl(propagandaUrl);
			activity.setStartTime(startTime);
			activity.setEndTime(endTime);

			operaFlag = activityMapper.insertSelective(activity) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			Integer provinceId = pd.getInt("provinceId");
			Integer cityId = pd.getInt("cityId");
			Integer areaId = pd.getInt("areaId");

			String address = pd.getString("address");
			String activityDetail = pd.getString("activityDetail");
			// 插入数据 AsActivityMeeting 数据
			AsActivityMeeting activityMeeting = new AsActivityMeeting();
			activityMeeting.setActivityId(activity.getActivityId());
			activityMeeting.setProvinceId(provinceId);
			activityMeeting.setCityId(cityId);
			activityMeeting.setAreaId(areaId);
			activityMeeting.setAddress(address);
			activityMeeting.setActivityDetail(activityDetail);

			operaFlag = activityMeetingMapper.insertSelective(activityMeeting) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);

			break;

		case EDIT:
			activity = new AsActivity();
			int activityId = pd.getInt("activityId");
			activityDetail = pd.getString("activityDetail");
			activityStatus = pd.getInt("activityStatus");
			String activityReview = pd.getString("activityReview");
			activity = activityMapper.selectByPrimaryKey(activityId);
			ValidatorBreakException.NOT_NULL(activity, "系统繁忙");

			// 修改配置 activityStatus 1.未开始，2.进行中，3.已结束（3的时候只能编辑活动详情和活动回顾）

				// 获取activity入参值
				activityName = pd.getString("activityName");
				startTime = pd.getString("startTime");
				endTime = pd.getString("endTime");
				uploadModule(UploadPathEnum.ACTIVITYMEETING, "propagandaUrl");
				propagandaUrl = pd.get("propagandaUrl") == null ? activity
						.getPropagandaUrl() : pd.get("propagandaUrl")
						.toString();
				if (activityStatus !=3) {
					timeDiff = CommonUtils.orderTimeDiff(
							CommonUtils.getTimeMils(endTime),
							System.currentTimeMillis());
					ValidatorBreakException.NOT_TRUE(timeDiff != 0,
							"结束日期必须大于等于当天时间");
					timeDiff2 = CommonUtils.orderTimeDiff(
							CommonUtils.getTimeMils(endTime),
							CommonUtils.getTimeMils(startTime));
					ValidatorBreakException
							.NOT_TRUE(timeDiff2 != 0, "结束日期必须大于开始日期");
				}

				// 修改配置 更新 activity
				activity.setActivityName(activityName);
				activity.setActivityType(2);
				activity.setPropagandaUrl(propagandaUrl);
				activity.setStartTime(startTime);
				activity.setEndTime(endTime);

				operaFlag = activityMapper.updateByPrimaryKey(activity) == 1;
				ValidatorBreakException.NOT_TRUE(operaFlag);
				// 获取activityMeeting入参值
				provinceId = pd.getInt("provinceId");
				cityId = pd.getInt("cityId");
				areaId = pd.getInt("areaId");
				address = pd.getString("address");
				// 修改配置 更新 activityMeeting
				activityMeeting = activityMeetingMapper
						.selectByActivityId(activityId);
				activityMeeting.setActivityId(activityId);
				activityMeeting.setProvinceId(provinceId);
				activityMeeting.setCityId(cityId);
				activityMeeting.setAreaId(areaId);
				activityMeeting.setAddress(address);
				activityMeeting.setActivityDetail(activityDetail);
				activityMeeting.setActivityReview(activityReview);
				operaFlag = activityMeetingMapper
						.updateByPrimaryKeyWithBLOBs(activityMeeting) == 1;
				ValidatorBreakException.NOT_TRUE(operaFlag);

			break;
		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess();
	}

	/**
	 * 明星见面会列表
	 * 
	 * @author tgb
	 * @date 2017年03月06日
	 * @param c
	 * @return
	 */
	public Object listAll(BaseController c) {

		initialized(c);
		/*// 获取入参
		String endTime = pd.getString("endTime");
		String startTime = pd.getString("startTime");
		String keyWord = pd.getString("keyWord");

		// 组装参数
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("endTime", endTime);
		param.put("startTime", startTime);
		param.put("keyWord", keyWord);

		List<AsActivity> list = activityMapper.activityMeetingListAll(param);
		// 开始时间小于当前时间为未开始，当前时间大于等于开始时间并且小于等于结束时间为进行中，结束时间小于当前时间为已结束
		// 1.未开始，2.进行中，3.已结束
		if (!list.isEmpty() && list.size() > 0) {
			for (AsActivity a : list) {
				if (a.getStartTime().compareTo(DateUtil.getTime()) > 0) {
					a.setActivityStatus(1);
				} else if (a.getStartTime().compareTo(DateUtil.getTime()) <= 0
						&& a.getEndTime().compareTo(DateUtil.getTime()) >= 0) {
					a.setActivityStatus(2);
				} else if (a.getEndTime().compareTo(DateUtil.getTime()) < 0) {
					a.setActivityStatus(3);
				}
			}
		}*/
		
		List<?> list = pageQueryModule(activityMapper, "meetingListAll", true);

		//List<?> list = asActivityRedrainMapper.listAll(param);
		// 开始时间小于当前时间为未开始，当前时间大于等于开始时间并且小于等于结束时间为进行中，结束时间小于当前时间为已结束
		// 1.未开始，2.进行中，3.已结束
		if (!list.isEmpty() && list.size() > 0) {
			for (Object a : list) {
				Map ojb = (Map)a;
				String  startTimeval = ojb.get("startTime").toString();
				String  endTimeval = ojb.get("endTime").toString();
				if (startTimeval.compareTo(DateUtil.getTime()) > 0) {
					ojb.put("activityStatus", 1);
				} else if (startTimeval.compareTo(DateUtil.getTime()) <= 0
						&& endTimeval.compareTo(DateUtil.getTime()) >= 0) {
					ojb.put("activityStatus", 2);
				} else if (endTimeval.compareTo(DateUtil.getTime()) < 0) {
					ojb.put("activityStatus", 3);;
				}
			}
		}
		Page page = c.getPage();

		int currentPage = pd.getIntRequired("pageNum");
		if (currentPage == 0) {
			currentPage = pd.getIntRequired("currentPage");
		}
		if (currentPage == 0) {
			currentPage = 1;
		}

		int showCount = pd.getIntRequired("pageSize");
		if (showCount == 0) {
			showCount = pd.getIntRequired("showCount");
		}
		if (showCount == 0) {
			showCount = 10;
		}

		page.setCurrentPage(currentPage);
		page.setShowCount(showCount);
		page.setPd(pd);

		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());

		PageInfo<Conditions> pageInfo = new PageInfo<Conditions>((List<Conditions>) list);
		page.setEntityOrField(true);
		page.setTotalResult((int) pageInfo.getTotal());
		addViewData("pageInfo", pageInfo);
		addViewData("page", page);
		addViewData("currentPage", currentPage);
		addViewData("showCount", showCount);
		addViewData("list", list);

		return renderView(PAGE_PATH + "listAll");
	}

	/**
	 * 异步检查是否重名
	 *
	 * @author tgb 创建时间：2017年3月6日
	 * @version 1.0
	 * @param c
	 * @return
	 */
	public Object isExist(BaseController c) {
		initialized(c);
		String activityName = pd.getString("activityName");
		Integer data = activityMapper.findByName(activityName, 2);
		if (data > 0) {
			return true;
		}
		return false;
	}
	
	/**
	 * 删除明星见面会
	 *@author tgb
	 *创建时间：2017年4月19日 
	 *@version 1.0
	 * @param c
	 * @return
	 */
	public Object deleteActivityMeeting(BaseController c) {

		initialized(c);

		int activityId = pd.getInt("activityId");
		operaFlag = activityMapper.deleteByPrimaryKey(activityId) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		operaFlag = activityMeetingMapper.deleteByActivityId(activityId) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		return renderSuccess();
	}
	

}
