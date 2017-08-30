package com.aoshi.service.manage;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import com.aoshi.common.asenum.AccountTypeEnum;
import com.aoshi.common.asenum.CapitalStatusEnum;
import com.aoshi.dao.*;
import com.aoshi.domain.*;
import com.aoshi.entity.R;
import com.aoshi.util.*;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;

import tlt.TranxConfig;
import tlt.TranxServiceImpl;
import tlt.entity.service.ResponseVo;
import tlt.entity.service.SingleTransVo;

/**
 * 提现管理
 * @author yangyanchao
 * @date 2017-02-28
 */
@Service
public class CapitalService extends AsBaseService {

	private final static String PAGE_PATH = "manage/common/";

	@Autowired
	private AsCapitalMapper asCapitalMapper;

	@Autowired
	private AsWalletMapper asWalletMapper;

	@Autowired
    private AsBankBindMapper asBankBindMapper;

	@Autowired
    private AsUserAccountMapper asUserAccountMapper;

	@Autowired
    private AsCapitalActionMapper asCapitalActionMapper;

	/**
	 * 提现申请列表
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @param c
	 * @return
	 */
	public Object listDeposit(BaseController c) {

		initialized(c);
		pageQueryModule(asCapitalMapper, "listAll", true);
		return renderView(PAGE_PATH + "listDeposit");
	}

	/**
	 * 更新提现状态
	 * 
	 * @author yangyanchao
	 * @date 2016年9月8日
	 * @param c
	 * @return
	 */
	public Object depositStatus_Tx(BaseController c) {

		initialized(c);

		// 获取入参
		int capitalId = pd.getInt("capitalId");
		String descp = pd.getString("descp");
        int status = pd.getInt("status");

		AsCapital capital = (AsCapital) asCapitalMapper
				.selectByPrimaryKeyWithLock(capitalId);
		ValidatorBreakException.NOT_NULL(capital);

        int bankBindId = capital.getBankBindId();
        AsBankBind bankBind = asBankBindMapper.selectByPrimaryKey(bankBindId);
        ValidatorBreakException.NOT_NULL(bankBind,"数据异常,请联系客服");

		// 当该笔提现实时状态为已处理,则中断处理
        ValidatorBreakException.NOT_TRUE(!Arrays.asList(
                CapitalStatusEnum.PROCESSING
                ,CapitalStatusEnum.SUCCESS
                ,CapitalStatusEnum.REJECT
                ,CapitalStatusEnum.FAIL)
                .contains(CapitalStatusEnum.get(capital.getStatus()))
                ,1001
                ,"该笔提现正在处理中,请勿重复");

        int userId = capital.getUserId();
        double money = capital.getMoney().doubleValue();
        double serviceCharge = capital.getServiceCharge().doubleValue();

        CapitalStatusEnum toStatusEnum = CapitalStatusEnum.get(status);
        ValidatorBreakException.NOT_NULL(toStatusEnum);

		switch(toStatusEnum) {

            case PROCESSING: //通过

                // 通联支付-提交申请
                String tradeSn = RandomCodeUtil.getPrizeSn();
                int amount = (int)ArithmeticUtil.MULTIPLY(ArithmeticUtil.SUBTRACT(money, serviceCharge), 100);
                SingleTransVo singleTransVo = new SingleTransVo(
                        bankBind.getBankAccount()
                        ,bankBind.getBankCardholder()
                        ,bankBind.getBankCode()
                        ,String.valueOf(amount));
                ResponseVo responseVo = new TranxServiceImpl().singleTranx(TranxConfig.URL, tradeSn,singleTransVo);

                capital.setTradeSn(tradeSn);
                capital.setDescp(descp);
                capital.setUpdateTime(DateUtil.getTime());
                capital.setAdminId(Integer.parseInt(getUser().getNewUserId()));

                if(responseVo.getStatus().equals("0000")){ // 提现成功

                    capital.setStatus(CapitalStatusEnum.SUCCESS.getStatus());

                    // 添加用户帐号资金流水
                    AsUserAccount asUserAccount = new AsUserAccount();
                    asUserAccount.setUserId(capital.getUserId());
                    asUserAccount.setAmount(ArithmeticUtil.newInstance(money));
                    asUserAccount.setAccountType(AccountTypeEnum.POSTAL.getId());
                    asUserAccount.setItemId(capitalId);
                    asUserAccount.setCreateTime(CommonUtils.getCurDate());
                    asUserAccount.setRemark(descp);
                    operaFlag = asUserAccountMapper.insertSelective(asUserAccount) == 1;
                    ValidatorBreakException.NOT_TRUE(operaFlag,"系统繁忙");

                } else if("2000".equals(responseVo.getStatus())
                        || "2001".equals(responseVo.getStatus())
                        || "2003".equals(responseVo.getStatus())
                        || "2005".equals(responseVo.getStatus())
                        || "2007".equals(responseVo.getStatus())
                        || "2008".equals(responseVo.getStatus())){ // 提现处理中

                    capital.setStatus(CapitalStatusEnum.PROCESSING.getStatus());

                } else { // 提现失败

                    capital.setStatus(CapitalStatusEnum.FAIL.getStatus());

                    // 退钱到钱包
                    AsWallet wallet = (AsWallet) asWalletMapper
                            .findByUserIdWithLock(userId);
                    ValidatorBreakException.NOT_NULL(wallet);
                    double oldWalletMoney = wallet.getMoney().doubleValue();
                    double newWalletMoney = ArithmeticUtil.ADD(oldWalletMoney, capital.getMoney().doubleValue());
                    wallet.setMoney(ArithmeticUtil.newInstance(newWalletMoney));
                    wallet.setUpdateTime(CommonUtils.getCurDate());
                    operaFlag = asWalletMapper.updateByPrimaryKeySelective(wallet) == 1;
                    ValidatorBreakException.NOT_TRUE(operaFlag);

                    // 添加 提现日志
                    AsCapitalAction asCapitalAction = new AsCapitalAction();
                    asCapitalAction.setCapitalId(capital.getCapitalId());
                    asCapitalAction.setStatus(CapitalStatusEnum.FAIL.getStatus());
                    asCapitalAction.setErrorCode(responseVo.getStatus());
                    asCapitalAction.setErrorMsg(responseVo.getMsg());
                    asCapitalAction.setCreateTime(CommonUtils.getCurDate());
                    operaFlag = asCapitalActionMapper.insertSelective(asCapitalAction) == 1;
                    ValidatorBreakException.NOT_TRUE(operaFlag);

                    // 更新提现申请状态
                    operaFlag = asCapitalMapper.updateByPrimaryKeySelective(capital) == 1;
                    ValidatorBreakException.NOT_TRUE(operaFlag);

                    return JSONObject.fromObject(new R(0, "[通联提示] : 提现失败," + responseVo.getMsg()));
                }

                // 更新提现申请状态
                operaFlag = asCapitalMapper.updateByPrimaryKeySelective(capital) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);

                break;

            case REJECT: //驳回

                // 退钱到钱包
                AsWallet wallet = (AsWallet) asWalletMapper
                        .findByUserIdWithLock(userId);
                ValidatorBreakException.NOT_NULL(wallet);
                double oldWalletMoney = wallet.getMoney().doubleValue();
                double newWalletMoney = ArithmeticUtil.ADD(oldWalletMoney, capital.getMoney().doubleValue());
                wallet.setMoney(ArithmeticUtil.newInstance(newWalletMoney));
                wallet.setUpdateTime(CommonUtils.getCurDate());
                operaFlag = asWalletMapper.updateByPrimaryKeySelective(wallet) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);

                // 更新申请状态
                capital.setStatus(CapitalStatusEnum.REJECT.getStatus());
                capital.setDescp(descp);
                capital.setUpdateTime(DateUtil.getTime());
                capital.setAdminId(Integer.parseInt(getUser().getNewUserId()));
                operaFlag = asCapitalMapper.updateByPrimaryKeySelective(capital) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);

                break;

            default:

                ValidatorBreakException.NOT_NULL(null);
        }

		return renderSuccess();
	}
	
	/**
	 * 申请处理页面
	 * 
	 * @author huangxuwen
	 * @date 2016年9月20日
	 * @param c
	 * @return mv
	 */
		public Object opearPage(BaseController c) {

		initialized(c);
		Conditions  asCapital =asCapitalMapper.getCapital(pd); // 根据ID读取
		addViewData("msg", "depositStatus");
		addViewData("pd", asCapital);
		return renderView(PAGE_PATH + "save");
		}
}
