package com.aoshi.service.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityDataMapper;
import com.aoshi.dao.AsActivityDiscMapper;
import com.aoshi.dao.AsActivityMapper;
import com.aoshi.dao.AsActivityReceivedRecordMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsPrizeConfigMapper;
import com.aoshi.dao.AsPrizeTypeMapper;
import com.aoshi.service.base.AsBaseService;

/**
 * 活动设置模块Service
 * 
 * @author huangxuwen
 * @date 2016年9月01日
 */
@Service("activityService")
public class ActivityService extends AsBaseService {

	private final static String PAGE_PATH = "manage/activity/";

	@Autowired
	private AsActivityMapper activityMapper;

	@Autowired
	private AsActivityDiscMapper activityDiscMapper;

	@Autowired
	private AsPrizeTypeMapper asPrizeTypeMapper;

	@Autowired
	private AsActivityDataMapper activityDataMapper;

	@Autowired
	private AsPrizeConfigMapper asPrizeConfigMapper;

	@Autowired
	private AsDictParamMapper asDictParamMapper;

	@Autowired
	private AsActivityReceivedRecordMapper asActivityReceivedRecordMapper;

	/**
	 * 活动设置页面
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	public Object listPage(BaseController c) {

		//		// 初始化
		//		initialized(c);
		//		addField("type", pd.get("type"));
		//		List<Conditions> aListing =activityDiscMapper.fiandAlls(pd);
		//		Conditions ac=null;
		//		AsActivity activity=null;
		//		if(aListing.size()>0){
		//		Conditions acId = (Conditions) aListing.get(0);
		//		addField("activityId", String.valueOf(acId.get("activityId")));
		//		AsActivityData acData = activityDataMapper.getActivityDataInfo(pd);
		//		activity = activityMapper.activityById(pd);
		//		addViewData("acList", acData);
		//		}
		//		// 奖品类型list
		//	    List<Conditions> prizeTypes =  asPrizeTypeMapper.listAll(null);
		//	    addViewData("intervals",JSONArray.fromObject(asDictParamMapper.findByKeyCode(DictParam.PARAM_INTERVALTIMETYPECODE_ID)));
		//	    addViewData("prizeTypes", prizeTypes);
		//	    addViewData("aListing", aListing);
		//	    addViewData("activity", activity);
		//		addViewData("msg", "save");
		//		return renderView(PAGE_PATH + "activity_edit");
		return "";
	}

	/**
	 * 活动设置页面保存
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	public Object save(BaseController c) {
		//
		//		// 初始化
		//		initialized(c);
		//		// 保存活动
		//		String code = UUID.randomUUID().toString().replaceAll("-", "");
		//		addField("sn", code);
		//		addField("activityName", pd.get("activityName"));
		//		addField("times", pd.get("times"));
		//		addField("status", "1");
		//		addField("startTime",  pd.get("startTime")+" "+DateUtil.getHms());
		//		addField("endTime",  pd.get("endTime")+" 23:59:59");
		//		operaFlag = activityMapper.insertSelective(pd) == 1;
		//		ValidatorBreakException.NOT_TRUE(operaFlag);
		//		// 1活动转盘信新增 ==>上传转盘图片模块
		//		String[] img  =new String[6];
		//	    img[0]=String.valueOf(pd.get("img0"));
		//	    img[1]=String.valueOf(pd.get("img1"));
		//	    img[2]=String.valueOf(pd.get("img2"));
		//	    img[3]=String.valueOf(pd.get("img3"));
		//	    img[4]=String.valueOf(pd.get("img4"));
		//	    img[5]=String.valueOf(pd.get("img5"));
		//
		//	    String typeId []  = pd.getString("prizeTypeId").split(",");
		//	    String names []  = pd.getString("prizeTypeName").split(",");
		//		// 批量保存转盘信息
		//        for (int i = 0; i < typeId.length; i++) {
		//		// 上传照片
		//		uploadModule1(UploadPathEnum.ACTIVITY, i);
		//		// 添加转盘设置信息
		//		AsActivityDisc asActivityDisc = new AsActivityDisc();
		//			// asActivityDisc.setName(names[names.length-1-i]);
		//		asActivityDisc.setIcon(pd.getString("img" + i));
		//		asActivityDisc.setCreateTime(CommonUtils.getCurDate());
		//			// asActivityDisc.setStatus(0);
		//			// asActivityDisc.setActivityId(pd.getInt("activityId"));
		//			// asActivityDisc.setPrizeTypeId(Integer.parseInt(typeId[typeId.length-1-i]));
		//		operaFlag = activityDiscMapper.insertSelective(asActivityDisc) == 1;
		//		ValidatorBreakException.NOT_TRUE(operaFlag);
		//		}
		//        addField("type", pd.get("type"));
		//		AsActivity activity = activityMapper.activityById(pd);
		//		// int prizeCount = asPrizeConfigMapper.prizeCountfindById(pd);//
		//		// 根据活动id查询奖品总数
		//		// int shopCount = asPrizeConfigMapper.countShopfindById(pd);//
		//		// 根据活动id查询商家总数
		//		// 增加活动记录表信息记录活动总数 剩下数
		//		AsActivityData adata = new AsActivityData();
		//		adata.setActivityId(activity.getActivityId());
		//		adata.setName(activity.getActivityName());
		//		adata.setSn(activity.getSn());
		//		// adata.setShopCounts(shopCount);
		//		// adata.setPrizeCounts(prizeCount);
		//		// adata.setPrizeSurplusCounts(prizeCount);
		//		adata.setType(String.valueOf(activity.getType())=="1"||"1".equals(String.valueOf(activity.getType()))?"抽奖":"摇奖");
		//		adata.setCreateTime(activity.getStartTime());
		//		activityDataMapper.insertSelective(adata);
		//		AsActivityData AsActivityData = activityDataMapper.getActivityDataInfo(pd);
		//		addViewData("acList", AsActivityData);
		//		addViewData("activity", activity);
		//		addField("type", pd.get("type"));
		//		List<Conditions> aListing =activityDiscMapper.fiandAlls(pd);
		//		addViewData("aListing", aListing); // 刷新活动信息页面 返回活动信息详情
		//		return renderView(PAGE_PATH + "activity_edit");
		return "";
	}

	public Object updateActivity(BaseController ce) {
		//		initialized(ce);
		//		AsActivity ac = activityMapper.activityById(pd);
		//		if (ac != null)
		//			ac.setStatus(2);
		//		operaFlag = activityMapper.updateByPrimaryKeySelective(ac) > 0;
		//		ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess(0);
	}

	/**
	 * 活动历史数据
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @param c
	 * @return
	 */
	public Object listHistory(BaseController c) {

		initialized(c);

		pageQueryModule(activityDataMapper, "listHistory", true);

		return renderView(PAGE_PATH + "listHistory");

	}

	/**
	 * 活动礼品领取记录
	 * 
	 * @author yangyanchao
	 * @date 2016年9月6日
	 * @param c
	 * @return
	 */
	public Object receivedHistory(BaseController c) {

		initialized(c);

		pageQueryModule(asActivityReceivedRecordMapper, "receivedHistory", true);

		return renderView(PAGE_PATH + "receivedHistory");
	}

}
