package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aoshi.common.asenum.ApiParam;
import com.aoshi.common.asenum.DictParam;
import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsShippingMapper;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;

import net.sf.json.JSONArray;

/**
 * 配送商管理模块 Service
 * 
 * @author yangyanchao
 * @date 2016年7月8日
 */
@Service
public class AsShippingService extends AsBaseService {

	// 页面H5相对路径
	private final static String PAGE_PATH = "manage/shipping/";

	@Autowired
	private AsShippingMapper asshippingmapper;

	@Autowired
	private AsDictParamMapper asDictParamMapperDao;

	/**
	 * 配送商列表
	 * 
	 * @author yangyanchao
	 * @date 2016年7月8日
	 * @param c
	 * @return
	 */
	public Object shippingList(BaseController c) {

		initialized(c);
		List<?> resultMap = pageQueryModule(asshippingmapper, "listAll", true);
		addViewData("keyWords",pd.getString("keyWords"));
		addViewData("shippingList",resultMap);
		return renderView(PAGE_PATH + "shippingList");
	}

	/**
	 * 配置管理 添加/修改页面
	 * 
	 * @author yangyanchao
	 * @date 2016年7月7日
	 * @param c
	 * @return
	 */
	public Object goShippingCfgPage(BaseController c) {

		initialized(c);

		int doAction = pd.getInt(ApiParam.DO_ACTION);
		if (doAction == 2) {
			Object obj = asshippingmapper.selectByPrimaryKey(pd
					.getInt("shippingId"));
			ValidatorBreakException.NOT_NULL(obj);
			addViewData("pd", obj);
		}

		addViewData(ApiParam.DO_ACTION, req.getParameter(ApiParam.DO_ACTION));

		return renderView(PAGE_PATH + "shippingEdit");
	}

	/**
	 * 添加/修改 配送记录
	 * 
	 * @author yangyanchao
	 * @date 2016年7月7日
	 * @return
	 */
	public Object operaShipping(BaseController c) {

		initialized(c);

		OperaEnum operaEnum = OperaEnum.get(pd.getInt(ApiParam.DO_ACTION));

		switch (operaEnum) {

		case ADD:

			operaFlag = asshippingmapper.insertSelective(pd) == 1;
			ValidatorBreakException.NOT_TRUE(operaFlag);
			break;

		case EDIT:

			asshippingmapper.updateByPrimaryKeySelective(pd);

			break;

		case DELETE:

			List<?> ids = CommonUtils.valToCollection(getField(
					ApiParam.BATCH_OPERA_IDS).toString());
			addField(ApiParam.BATCH_OPERA_IDS, ids);

			operaFlag = asshippingmapper.deleteByPrimaryKeys(pd) == ids
					.size();
			ValidatorBreakException.NOT_TRUE(operaFlag);

			break;

		default:
			ValidatorBreakException.NOT_TRUE(false);
		}

		return renderSuccess(1);
	}

	/**
	 * 添加/编辑 配送模板H5
	 * 
	 * @author yangyanchao
	 * @date 2016年7月8日
	 * @return
	 */
	@RequestMapping("/goShippingTplPage")
	public Object goShippingTplPage(BaseController c) {

		initialized(c);

		String param = asDictParamMapperDao
				.findByKeyCode(DictParam.PARAM_SHIPPING_EXPRESS_SCOPE);
		JSONArray jsonArr = JSONArray.fromObject(param);
		addViewData("paramExpressScope", jsonArr);

		return renderView(PAGE_PATH + "shippingTpl");
	}

}
