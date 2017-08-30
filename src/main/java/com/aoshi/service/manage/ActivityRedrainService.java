package com.aoshi.service.manage;

import com.aoshi.common.asenum.CommonStr;
import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityAdMapper;
import com.aoshi.dao.AsActivityMapper;
import com.aoshi.dao.AsActivityRedrainMapper;
import com.aoshi.dao.AsActivityRedrainWinnerMapper;
import com.aoshi.domain.AsActivity;
import com.aoshi.domain.AsActivityRedrain;
import com.aoshi.domain.AsActivityRedrainWinner;
import com.aoshi.entity.Page;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 红包雨
 * 
 * @author huangxw
 * @date 2017年03月07日
 */
@Service
public class ActivityRedrainService extends AsBaseService {

	private final static String PAGE_PATH = "manage/activityRedRain/";

	@Autowired
	private AsActivityRedrainMapper asActivityRedrainMapper;

	@Autowired
	private AsActivityMapper asActivityMapper;

	@Autowired
	private AsActivityRedrainWinnerMapper asActivityRedrainWinnerMapper;

	@Autowired
	private AsActivityAdMapper asActivityAdMapper;
	/**
	 * 活动列表页面
	 * 
	 * @author huangxw
	 * @date 2017年03月07日
	 * @param c
	 * @return
	 */
	public Object getActivityRedraintList(BaseController c) {

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
				param.put("activityType", 2);*/
				List<?> list = pageQueryModule(asActivityRedrainMapper, "listAll", true);

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

		return renderView(PAGE_PATH + "activityRedRain_list");
	}

	/**
	 * 活动页面中转控制
	 * 
	 * @author huangxw
	 * @date 2017年02月21日
	 * @return c
	 */
	public Object page(BaseController c) {

		initialized(c);

		OperaEnum action = OperaEnum.get(pd.getInt("action") == 0 ? 1 : pd
				.getInt("action"));
		switch(action){
		case ADD:
	    addViewData("activityStatus", 1);
		break;
	case EDIT:
	    Object activityRedrain = new HashMap<>();
	    activityRedrain = asActivityRedrainMapper.selectByPrimaryKey(pd);
	    Object asActivity = asActivityMapper.selectByPrimaryKey(pd);
	    List<?> activityRedrainWinner = asActivityRedrainWinnerMapper.listAll(pd);
		addViewData("activityRedrain", activityRedrain);
		addViewData("asActivity", asActivity);
		addViewData("activityRedrainWinner", activityRedrainWinner);
		addViewData("msg", "opera");
		addViewData("activityStatus", pd.getInt("activityStatus"));
		break;
	case QUERY:
		
	    activityRedrain = asActivityRedrainMapper.selectByPrimaryKey(pd);
	    asActivity = asActivityMapper.selectByPrimaryKey(pd);
	    activityRedrainWinner = asActivityRedrainWinnerMapper.listAll(pd);
	    addViewData("asActivity", asActivity);
		addViewData("activityRedrain", activityRedrain);
		addViewData("activityRedrainWinner", activityRedrainWinner);
		addViewData("msg", "opera");
		break;
		default:
			ValidatorBreakException.NOT_NULL(null);
		}
		addViewData("pd", pd);
		addViewData("action", action.getId());
		return renderView(PAGE_PATH + "save");
	}
	/**
	 *
	 * 活动操作
	 * @author huangxw
	 * @date 2017年02月21日
	 * @return c
	 */
	public Object opera(BaseController c) {
		
		initialized(c);
				
		OperaEnum action = OperaEnum.get(pd.getInt("action"));
		
		switch (action) {
		case ADD:
         String activityName = (String)pd.get("activityName");
         String startTime = pd.getStringRequired("startTime");
         String endTime = pd.getStringRequired("endTime");                    
         String activityDetail = pd.getStringRequired("activityDetail");
         
        //活动是否有重复
 		String lastEndTime = asActivityMapper.isAccountExists(pd);
 		if(lastEndTime!=null){
 		Long timeDiff = CommonUtils.orderTimeDiff(
				CommonUtils.getTimeMils(lastEndTime),
				CommonUtils.getTimeMils(startTime));
 		operaFlag=timeDiff==0?true:false;
 		ValidatorBreakException.NOT_TRUE(operaFlag, "活动时间不能与其他红包雨活动时间重合哦！");
 		}
 		//活动期数获取为活动结束时间期数递增
 		int currentActivityCode = asActivityMapper.getMaxActivityCode()+1;
 		String msg = CheckFile("img",1);////
		 operaFlag =msg==""||"".equals(msg)?true:false;
		 ValidatorBreakException.NOT_TRUE(operaFlag,msg);
		uploadModule(UploadPathEnum.ACTIVITYREDRAIN, "pageUrl");
		String pageUrl = pd.get("pageUrl") == null ? "" : pd
				.get("pageUrl").toString();
		ValidatorBreakException
				.NOT_TRUE(!(pageUrl == null || pageUrl.trim()
						.length() == 0), "请上传背景图片");
		String msge = CheckFile("img0",2);////
		 operaFlag =msge==""||"".equals(msge)?true:false;
		 ValidatorBreakException.NOT_TRUE(operaFlag,msge);
		uploadModule1(UploadPathEnum.ACTIVITYREDIMG, 0);
		String propagandaUrl = pd.getString("img0");
		ValidatorBreakException
				.NOT_TRUE(!(propagandaUrl == null || propagandaUrl.trim()
						.length() == 0), "请上传宣传图片");
		
		AsActivity  asActivity = new AsActivity();
		asActivity.setActivityType(1);
		asActivity.setActivityName(activityName);
		asActivity.setStartTime(startTime);
		asActivity.setEndTime(endTime);
		asActivity.setPropagandaUrl(propagandaUrl);////
		operaFlag=asActivityMapper.insertSelective(asActivity)==1;
		
		AsActivityRedrain  asActivityRedRain = new AsActivityRedrain();
	    asActivityRedRain.setActivityId(asActivity.getActivityId());
		asActivityRedRain.setActivityCode(currentActivityCode);
		asActivityRedRain.setPageUrl(pageUrl);
		asActivityRedRain.setActivityDetail(activityDetail);
		
		operaFlag=asActivityRedrainMapper.insertSelective(asActivityRedRain)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		
	//获奖名单
		String[] userNameArr  = req.getParameter("userNameList").split(",");
		String[] prizeInfoArr  = req.getParameter("prizeInfoList").split(",");
		String[] winTimeArr  = req.getParameter("winTimeList").split(",");
		if(userNameArr.length>0&&prizeInfoArr.length>0&&winTimeArr.length>0){
			int minRecord;
			if(userNameArr.length >= prizeInfoArr.length){
				minRecord = prizeInfoArr.length;
			}else{
				minRecord = userNameArr.length;
			}
			if(minRecord > winTimeArr.length){
				minRecord = winTimeArr.length;
			}
			for (int i = 0; i < minRecord; i++) {
				AsActivityRedrainWinner  asActivityRedrainWinner = new AsActivityRedrainWinner();
				
				asActivityRedrainWinner.setActivityRedrainId(asActivityRedRain.getActivityRedrainId());
				asActivityRedrainWinner.setPrizeInfo(prizeInfoArr[i]);
				asActivityRedrainWinner.setUserName(userNameArr[i]);
				asActivityRedrainWinner.setWinTime(winTimeArr[i]);
				operaFlag=asActivityRedrainWinnerMapper.insertSelective(asActivityRedrainWinner)==1;
				ValidatorBreakException.NOT_TRUE(operaFlag);
			}
			
		}
		//活动期数： 活动结束后对红包雨活动进行期数标注，按照活动结束
		//时间进行活动期数递增，最新结束的活动期数最大； 进行中和未开
		//开始始的活动无期数显示；
		
		break;

		case EDIT:
			Integer activityRedrainId = Integer.parseInt(pd.get("activityRedrainId").toString());
		    activityDetail = pd.getStringRequired("activityDetail");
		    int activityStatus = pd.getInt("activityStatus");
		       		    
	        userNameArr  = req.getParameter("userNameList").split(",");////
			prizeInfoArr  = req.getParameter("prizeInfoList").split(",");
			winTimeArr  = req.getParameter("winTimeList").split(",");
			String [] ids =  req.getParameter("ids").split(",");
			AsActivityRedrain activityRedrain =new AsActivityRedrain();	////
				
	        asActivityRedRain = new AsActivityRedrain();
	        asActivityRedRain=asActivityRedrainMapper.getActivityById(activityRedrainId);
	        msg = CheckFile("img",1);////
			 operaFlag =msg==""||"".equals(msg)?true:false;
			 ValidatorBreakException.NOT_TRUE(operaFlag,msg);
	        uploadModule(UploadPathEnum.ACTIVITYREDRAIN, "pageUrl");
	        pageUrl = pd.get("pageUrl") == null ? asActivityRedRain
					.getPageUrl() : pd.get("pageUrl")
					.toString();
		    if(activityStatus==1||activityStatus==2){
		    	activityName = (String)pd.get("activityName");
		        startTime = pd.getStringRequired("startTime");
		        endTime = pd.getStringRequired("endTime");
		    	AsActivity activity = (AsActivity)asActivityMapper.selectByPrimaryKey(pd);

		    	pd.put("currentstartTime", activity.getStartTime());
		 		 lastEndTime = asActivityMapper.isAccountExists(pd);
		 		if(lastEndTime!=null){
		 		Long timeDiff = CommonUtils.orderTimeDiff(
						CommonUtils.getTimeMils(lastEndTime),
						CommonUtils.getTimeMils(startTime));
		 		operaFlag=timeDiff==0?true:false;
		 		ValidatorBreakException.NOT_TRUE(operaFlag, "活动时间不能与其他红包雨活动时间重合哦！");
		 		}
		 		
		    	activity.setActivityType(1);
		    	activity.setActivityName(activityName);
		    	activity.setStartTime(startTime);
		    	activity.setEndTime(endTime);
		    	//活动是否有重复
		    	 //活动是否有重复
		 		/*lastEndTime = asActivityMapper.isAccountExists(pd);
		 		if(activity.getEndTime().compareTo(startTime)<0){
		 			ValidatorBreakException.NOT_TRUE(false, "活动开始时间不能大于活动结束时间！");
		 		}*/
		 		//活动是否有重复
		    	
		    	String msg1 = CheckFile("img0",2);////
				 operaFlag =msg1==""||"".equals(msg1)?true:false;
				 ValidatorBreakException.NOT_TRUE(operaFlag,msg1);		 
				 uploadModule1(UploadPathEnum.ACTIVITYREDIMG, 0);
				 propagandaUrl = (pd.get("img0") == null||"".equals(pd.getString("img0")))? activity.getPropagandaUrl() : pd.get("img0")
							.toString();
		    	
				activity.setPropagandaUrl(propagandaUrl);	////
				
		    	operaFlag=asActivityMapper.updateByPrimaryKeySelective(activity)==1;
		    	ValidatorBreakException.NOT_TRUE(operaFlag);
				//编辑红包雨活动的时候也要更新该活动的广告管理时间
				Map<String, Object> map = new HashMap<>();
				map.put("activityId", activity.getActivityId());
				map.put("endTime", endTime);
				map.put("startTime", startTime);
				asActivityAdMapper.updateTimeByRefId(map);

		    	activityRedrain =(AsActivityRedrain) asActivityRedrainMapper.selectByPrimaryKey(pd);
		    	activityRedrain.setActivityId(pd.getInt("activityId"));
		    	activityRedrain.setPageUrl(pageUrl);
		    	activityRedrain.setActivityDetail(activityDetail);
				operaFlag=asActivityRedrainMapper.updateByPrimaryKeySelective(activityRedrain)==1;
				ValidatorBreakException.NOT_TRUE(operaFlag);
				
			if(userNameArr.length>0&&prizeInfoArr.length>0&&winTimeArr.length>0){			
				for (int i = 0; i < userNameArr.length; i++) {
					AsActivityRedrainWinner asActivityRedrainWinner = asActivityRedrainWinnerMapper.selectByPrimaryKey(Integer.parseInt(ids[i]));
					asActivityRedrainWinner.setActivityRedrainId(asActivityRedRain.getActivityRedrainId());
					asActivityRedrainWinner.setPrizeInfo(prizeInfoArr[i]);
					asActivityRedrainWinner.setUserName(userNameArr[i]);
					asActivityRedrainWinner.setWinTime(winTimeArr[i]);
					operaFlag=asActivityRedrainWinnerMapper.updateByPrimaryKeySelective(asActivityRedrainWinner)==1;
					ValidatorBreakException.NOT_TRUE(operaFlag);
				}
			}
		    }
		    if(activityStatus==2){
		    	String activityReview = pd.getStringRequired("activityReview");////
		        activityRedrain =(AsActivityRedrain) asActivityRedrainMapper.selectByPrimaryKey(pd);
		        activityRedrain.setActivityId(pd.getInt("activityId"));
		        activityRedrain.setPageUrl(pageUrl);
		        activityRedrain.setActivityDetail(activityDetail);
		        activityRedrain.setActivityReview(activityReview);  ////
				operaFlag=asActivityRedrainMapper.updateByPrimaryKeySelective(activityRedrain)==1;
				ValidatorBreakException.NOT_TRUE(operaFlag);
			
			if(userNameArr.length>0&&prizeInfoArr.length>0&&winTimeArr.length>0&&ids.length>0){			
				for (int i = 0; i < userNameArr.length; i++) {
					AsActivityRedrainWinner asActivityRedrainWinner = asActivityRedrainWinnerMapper.selectByPrimaryKey(Integer.parseInt(ids[i]));					
					asActivityRedrainWinner.setActivityRedrainId(asActivityRedRain.getActivityRedrainId());
					asActivityRedrainWinner.setPrizeInfo(prizeInfoArr[i]);
					asActivityRedrainWinner.setUserName(userNameArr[i]);
					asActivityRedrainWinner.setWinTime(winTimeArr[i]);
					operaFlag=asActivityRedrainWinnerMapper.updateByPrimaryKeySelective(asActivityRedrainWinner)==1;
					ValidatorBreakException.NOT_TRUE(operaFlag);
				}
			}
		    }
		    if(activityStatus==3){//活动已结束
		    	String activityReview = pd.getStringRequired("activityReview");////
		    	activityRedrain =(AsActivityRedrain) asActivityRedrainMapper.selectByPrimaryKey(pd);
		    	activityRedrain.setActivityId(pd.getInt("activityId"));
		    	activityRedrain.setPageUrl(pageUrl);
		    	activityRedrain.setActivityReview(activityReview);
		    	activityRedrain.setActivityDetail(activityDetail);
				operaFlag=asActivityRedrainMapper.updateByPrimaryKeySelective(activityRedrain)==1;
				ValidatorBreakException.NOT_TRUE(operaFlag);			
				if(userNameArr.length>1&&prizeInfoArr.length>1&&winTimeArr.length>1&&ids.length>1){			
					for (int i = 0; i < userNameArr.length; i++) {
						AsActivityRedrainWinner asActivityRedrainWinner = asActivityRedrainWinnerMapper.selectByPrimaryKey(Integer.parseInt(ids[i]));
						
						asActivityRedrainWinner.setActivityRedrainId(asActivityRedRain.getActivityId());
						asActivityRedrainWinner.setPrizeInfo(prizeInfoArr[i]);
						asActivityRedrainWinner.setUserName(userNameArr[i]);
						asActivityRedrainWinner.setWinTime(winTimeArr[i]);
						operaFlag=asActivityRedrainWinnerMapper.updateByPrimaryKeySelective(asActivityRedrainWinner)==1;
						ValidatorBreakException.NOT_TRUE(operaFlag);
					}
				}
		    }	

	
		break;
		case DELETE:
		
		
		break;
		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess();
	}
	
	
	  public String CheckFile(String img, int type){
		  String msg="";
			if (StringUtils.isNotBlank(req.getParameter(img))) {
				String arr[] = String.valueOf(pd.get(img)).split(",");
				byte[] bytes = Base64.decode(arr[1]);
				BufferedImage buffImage;
				try {
				InputStream io = new ByteArrayInputStream(bytes);
				buffImage = javax.imageio.ImageIO.read(io);	
				if(type==1){
					if(buffImage.getWidth()>CommonStr.IMG_ACTIVITYREDRAINBG_WIDTH || buffImage.getHeight()>CommonStr.IMG_ACTIVITYREDRAINBG_HEIGHT){ 
						msg="背景图片尺寸大小超过限制！请上传"+CommonStr.IMG_ACTIVITYREDRAINBG_WIDTH+"px"+"*"+CommonStr.IMG_ACTIVITYREDRAINBG_HEIGHT+"px 的图片!";
					}
				}
				if(type==2){
					if(buffImage.getWidth()>CommonStr.IMG_ACTIVITYREDRAIN_WIDTH || buffImage.getHeight()>CommonStr.IMG_ACTIVITYREDRAIN_HEIGHT){ 
						msg="宣传图片尺寸大小超过限制！请上传"+CommonStr.IMG_ACTIVITYREDRAIN_WIDTH+"px"+"*"+CommonStr.IMG_ACTIVITYREDRAIN_HEIGHT+"px 的图片!";
					}
					
				}
				buffImage = javax.imageio.ImageIO.read(io);
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
			return msg;
	  }
	  
	  
	  /**
		 * 删除活动
		 * 
		 * @author huangxw
		 * @date 2017年04月19日
		 * @param c
		 * @return
		 */
		public Object delete(BaseController c) {

			initialized(c);
			int activityRedrainId = pd.getParaForPositiveInteger("activityRedrainId");
			int activityId = pd.getParaForPositiveInteger("activityId");
			// 判断该帐号是否特殊管理员
			AsActivityRedrain asActivityRedRain=asActivityRedrainMapper.getActivityById(activityRedrainId);
	    	AsActivity activity = (AsActivity)asActivityMapper.selectByPrimaryKey(pd);
			ValidatorBreakException.NOT_NULL(asActivityRedRain);
			ValidatorBreakException.NOT_NULL(activity);
			
		
			operaFlag = asActivityRedrainMapper.deleteByActivityRedrainId(asActivityRedRain) == 1;
			// 删除活动
			operaFlag = asActivityMapper.deleteByActivityId(activity) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag, "数据信息已过期，请刷新后重试");

			return renderSuccess();
		}
}
