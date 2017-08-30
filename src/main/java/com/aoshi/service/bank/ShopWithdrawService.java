package com.aoshi.service.bank;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.domain.AsDictParam;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;

@Service
public class ShopWithdrawService extends AsBaseService {

	// 数据库操作标识
	protected boolean operaFlag;
	@Autowired
	private AsDictParamMapper asDictParamMapper;
	/**
	 * 
	 * @Title  getSetWithdraw
	 * @author  wangjs   
	 * @version 3.0 
	 * @param c
	 * @return Object
	 * @Description 获取提现设置信息
	 * @time 2017年2月25日 上午11:16:39
	 */
	public Object getSetWithdraw(BaseController c) {
		initialized(c);
		Map<String, String> withdrawMap = new HashMap<String, String>();
		
		//提现金额下限
		AsDictParam asdDictParam1 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_CAPITAL_MONEY_MIN);
		//提现金额上限
		AsDictParam asdDictParam2 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_CAPITAL_MONEY_MAX);
		//是否需要手续费 0-不需要,1-需要
		AsDictParam asdDictParam3 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_CAPITAL_NEED_SERVICE_CHARGE);
		//提现手续费(元)
		AsDictParam asdDictParam4 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_CAPITAL_SET_SERVICE_CHARGE);
		//每天提现最大次数
		AsDictParam asdDictParam5 = asDictParamMapper.findAllByKeyCode(DictParam.PARAM_CAPITAL_TIMES_DAY);

		withdrawMap.put("capMinWithdrawValue", asdDictParam1.getDictValue());
		withdrawMap.put("capMinWithdrawId", asdDictParam1.getDictParamId().toString());

		withdrawMap.put("capMaxWithdrawValue", asdDictParam2.getDictValue());
		withdrawMap.put("capMaxWithdrawId", asdDictParam2.getDictParamId().toString());
		
		withdrawMap.put("capNeedSerWithdrawValue", asdDictParam3.getDictValue());
		withdrawMap.put("capNeedSerWithdrawId", asdDictParam3.getDictParamId().toString());

		withdrawMap.put("capMoneySerWithdrawValue", asdDictParam4.getDictValue());
		withdrawMap.put("capMoneySerWithdrawId", asdDictParam4.getDictParamId().toString());

		withdrawMap.put("capNumWithdrawValue", asdDictParam5.getDictValue());
		withdrawMap.put("capNumWithdrawId", asdDictParam5.getDictParamId().toString());
	
		addViewData("withdrawMap", withdrawMap);
		return renderView("bank/bankDetail/setWithdraw");
	}

	/**
	 * 	
	 * @Title  updateWithdrawTx
	 * @author  wangjs   
	 * @version 3.0 
	 * @param withdrawId
	 * @param withdrawValue
	 * @return Object
	 * @Description 修改提现设置
	 * @time 2017年2月25日 上午11:17:09
	 */
	public Object updateWithdrawTx(String withdrawId,String withdrawValue) {
		//initialized(c);
		//数字格式化
		DecimalFormat decimalFormat=new DecimalFormat("0.00");
		
		String [] withdrawIds = withdrawId.split(",");
		String [] withdrawValues = withdrawValue.split(",");
		
		AsDictParam asDictParam1 = new AsDictParam();
		AsDictParam asDictParam2 = new AsDictParam();
		AsDictParam asDictParam3 = new AsDictParam();
		AsDictParam asDictParam4 = new AsDictParam();
		AsDictParam asDictParam5 = new AsDictParam();

		String capMinWithdrawId = withdrawIds[0];
		String capMinWithdrawValue = withdrawValues[0];
		BigDecimal newMinWithdrawValue = new BigDecimal(capMinWithdrawValue);
		String minWithdrawValue=decimalFormat.format(newMinWithdrawValue);
		asDictParam1.setDictParamId(Integer.valueOf(capMinWithdrawId));
		asDictParam1.setDictValue(minWithdrawValue);

		String capMaxWithdrawId = withdrawIds[1];
		String capMaxWithdrawValue = withdrawValues[1];
		BigDecimal newManWithdrawValue = new BigDecimal(capMaxWithdrawValue);
		String maxWithdrawValue=decimalFormat.format(newManWithdrawValue);
		asDictParam2.setDictParamId(Integer.valueOf(capMaxWithdrawId));
		asDictParam2.setDictValue(maxWithdrawValue);

		String capNeedSerWithdrawId =withdrawIds[2];
		String capNeedSerWithdrawValue =  withdrawValues[2];
		asDictParam3.setDictParamId(Integer.valueOf(capNeedSerWithdrawId));
		asDictParam3.setDictValue(capNeedSerWithdrawValue);

		String capMoneySerWithdrawId = withdrawIds[3];
		String capMoneySerWithdrawValue = withdrawValues[3];
		BigDecimal newMoneySerWithdrawValue = new BigDecimal(capMoneySerWithdrawValue);
		String moneySerWithdrawValue=decimalFormat.format(newMoneySerWithdrawValue);
		asDictParam4.setDictParamId(Integer.valueOf(capMoneySerWithdrawId));
		asDictParam4.setDictValue(moneySerWithdrawValue);

		String capNumWithdrawId = withdrawIds[4];
		String capNumWithdrawValue =  withdrawValues[4];
		asDictParam5.setDictParamId(Integer.valueOf(capNumWithdrawId));
		asDictParam5.setDictValue(capNumWithdrawValue);
		//提现金额下限
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam1) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		//提现金额上限
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam2) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		//是否需要手续费 0-不需要,1-需要
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam3) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		//提现手续费(元)
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam4) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);
		//每天提现最大次数
		operaFlag = asDictParamMapper.updateByPrimaryKeySelective(asDictParam5) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
}
