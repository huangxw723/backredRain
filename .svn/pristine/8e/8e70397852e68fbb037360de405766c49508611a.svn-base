package com.aoshi.service.manage;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsPrizeTypeMapper;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.ASApiException;
import com.aoshi.util.Conditions;

/**
 * 奖品类型模块Service
 * 
 * @author huangxuwen
 * @date 2016年9月01日
 */
@Service("prizeTypeService")
public class PrizeTypeService extends AsBaseService {

	private final static String PAGE_PATH = "manage/prizeType/";
			
	// 奖品类型
		@Autowired
		private AsPrizeTypeMapper asPrizeTypeMapper;
	// 字典表
		@Autowired
		private AsDictParamMapper asDictParamMapper;	
		
	/**
	 * 奖品类型页面
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
		public Object listPage(BaseController c) {

		// 初始化
		initialized(c);
		// 初始化分页信息对象
		queryModule(asPrizeTypeMapper, "listAll", true);
		addViewData("prizeTypes",JSONArray.fromObject(asDictParamMapper.findByKeyCode(DictParam.PARAM_PRIZETYPECODE_ID)));
		return renderView(PAGE_PATH + "prize_list");
		}
		

		/**
	 * 新增奖品类型页面
	 * 
	 * @author huangxuwen
	 * @date 2016年9月2日
	 * @param c
	 * @return mv
	 */
		public Object AddPrizeTypePage(BaseController c) {

		initialized(c);

		addViewData("msg", "save");
        addViewData("prizeTypes",JSONArray.fromObject(asDictParamMapper.findByKeyCode(DictParam.PARAM_PRIZETYPECODE_ID)));
		return renderView(PAGE_PATH + "prize_edit");
		}

	/**
	 * 奖品类型页面保存
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	public Object save(BaseController c) {

		// 初始化
		initialized(c);
		Conditions prize = Conditions.newInstance();
		prize.putData("prizeTypeName",pd.get("prizeTypeName"));
		addField("prizeTypeName",pd.get("prizeTypeName"));
		operaFlag=asPrizeTypeMapper.isPrizeTypeExists(pd)>0;
		ValidatorBreakException.NOT_TRUE(!operaFlag, 1001,
 "奖品类型已经存在！不能保存", 1);
		operaFlag = asPrizeTypeMapper.insertSelective(prize) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		return renderSuccess(1);
	}
	
	/**
	 * 更新奖品类型页面
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return mv
	 */
	public Object editPrizePage(BaseController c) {

		initialized(c);

		Object obj = asPrizeTypeMapper.findById(pd); // 根据ID读取
		addViewData("prizeTypes",JSONArray.fromObject(asDictParamMapper.findByKeyCode(DictParam.PARAM_PRIZETYPECODE_ID)));
		addViewData("msg", "edit");
		addViewData("prizeType", obj);

		return renderView(PAGE_PATH + "prize_edit");
	}
	
	/**
	 * 更新奖品类型
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return
	 * @throws ASApiException
	 */
	public Object editPrize(BaseController c) {
		// 初始化
		initialized(c);
		
		// 更新奖品类型
		addField("prizeTypeName",pd.get("prizeTypeName"));
		operaFlag=asPrizeTypeMapper.isPrizeConfigExists(pd)>0;
		ValidatorBreakException.NOT_TRUE(!operaFlag, 1001,
 "奖品类型已使用！不能更改", 1);
		operaFlag=asPrizeTypeMapper.isPrizeTypeExists(pd)>0;
		ValidatorBreakException.NOT_TRUE(!operaFlag, 1001,
 "奖品类型已经存在！不能保存", 1);
		asPrizeTypeMapper.updateByPrimaryKeySelective(pd);
		return renderSuccess(1);
	}

	/**
	 * 根据id删除奖品类型
	 * 
	 * @author huangxuwen
	 * @date 2016年9月1日
	 * @return
	 * @throws ASApiException
	 */
	public Object deletePrize(BaseController c) {

		initialized(c);
		addField("prizeTypeId",pd.get("prizeTypeId"));
		operaFlag=asPrizeTypeMapper.isPrizeConfigExists(pd)>0;
		ValidatorBreakException.NOT_TRUE(!operaFlag, 1001, "奖品类型使用中!,不能删除！", 0);
		operaFlag = asPrizeTypeMapper.deleteByPrimaryKey(pd)==1;
		ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");
		return renderSuccess(0);
	}

	
}
