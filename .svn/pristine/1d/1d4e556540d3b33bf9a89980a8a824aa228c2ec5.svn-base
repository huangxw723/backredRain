package com.aoshi.service.bank;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsBankMapper;
import com.aoshi.domain.AsBank;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;

/**
 * 
* @ClassName: BankController
* @Description: 银行卡
* @author wangjs
* @date 2017年2月23日 下午2:40:21
*
 */
@Service
public class BankService extends AsBaseService{
	
	private final static String PAGE_PATH = "bank/bankDetail/";
	// 数据库操作标识
	protected boolean operaFlag;
	
	@Autowired
	AsBankMapper asBankMapper;
	 
	/**
	 * 
	 * @Title  getBankById
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 获取银行卡列表
	 * @time 2017年2月23日 下午2:41:57
	 */
	public Object  getAllBankTx(BaseController c){
		
		initialized(c);
		
		pageQueryModule(asBankMapper,"selectAllBank", true);
		
		return renderView(PAGE_PATH+"bankList");
	}
	
	/**
	 * 	
	 * @Title  addBank
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 添加银行卡
	 * @time 2017年2月23日 下午2:42:28
	 */
	
	public Object  addBankTx(BaseController c){
		
		initialized(c);
		String bankCode = pd.getStringRequired("bankCode");
		String bankName = pd.getStringRequired("bankName");
		Integer status = 0;
		
		AsBank asBank = new AsBank();
		asBank.setBankCode(bankCode);
		asBank.setBankName(bankName);
		asBank.setStatus(status);
		asBank.setCreateTime(DateUtil.getTime());
		
		operaFlag =	asBankMapper.insertSelective(asBank)==1;
		 ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
	/**
	 * 
	 * @Title  editBank
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 修改银行卡
	 * @time 2017年2月23日 下午2:42:50
	 */
	public Object  editBankTx(BaseController c){
		
		initialized(c);
		Integer bankId = Integer.parseInt(pd.getStringRequired("bankId"));
		String bankCode = pd.getStringRequired("bankCode");
		String bankName = pd.getStringRequired("bankName");
		Integer status = Integer.parseInt(pd.getStringRequired("status"));
		
		AsBank asBank = new AsBank();
		asBank.setBankId(bankId);
		asBank.setBankCode(bankCode);
		asBank.setBankName(bankName);
		asBank.setStatus(status);
		asBank.setCreateTime(DateUtil.getTime());
		
		operaFlag =	asBankMapper.updateByPrimaryKeySelective(asBank)==1;
		 ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
	/**
	 * 
	 * @Title  updateBankStatus
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 启用/停用银行卡
	 * @time 2017年2月23日 下午2:43:11
	 */

	public Object  updateBankStatusTx(BaseController c){
		
		initialized(c);
		Integer bankId = Integer.parseInt(pd.getStringRequired("bankId"));
		Integer status = Integer.parseInt(pd.getStringRequired("status"));
		AsBank asBank = new AsBank();
		asBank.setBankId(bankId);
		asBank.setStatus(status);
		asBank.setCreateTime(DateUtil.getTime());
		
		operaFlag =	asBankMapper.updateByPrimaryKeySelective(asBank)==1;
		 ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
	/**
	 * 
	 * @Title  bankInfoByPram
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 条件查询银行卡
	 * @time 2017年2月23日 下午2:43:46
	 */
	public Object  bankInfoByPramTx(BaseController c){
		
		initialized(c);
		if(!"1".equals(pd.getStringRequired("flag"))){
			Integer bankId = Integer.parseInt(pd.getStringRequired("bankId"));
				AsBank asBank = new AsBank();
				asBank.setBankId(bankId);
				List<Conditions> cd =	asBankMapper.bankInfoByPram(asBank);
				addViewData("bankCd",cd.get(0));
				return renderView(PAGE_PATH+"bankEdit");
		}else{
			AsBank asBank = new AsBank();
			String bankIds =pd.getStringRequired("bankId");
			if(null!=bankIds&&!"".equals(bankIds)){
				Integer bankId = Integer.parseInt(pd.getStringRequired("bankId"));
				//asBank.setBankId(bankId);
				addField("bankId",bankId);
			}
			
			String bankCode= pd.getStringRequired("bankCode");
			String bankName = pd.getStringRequired("bankName");
//			asBank.setBankName(bankName);
//			asBank.setBankCode(bankCode);
			addField("bankCode",bankCode);
			addField("bankName",bankName);

			
			
			pageQueryModule(asBankMapper,"bankInfoByPram", true);

			/*List<Conditions> cd =	asBankMapper.bankInfoByPram(asBank);
			addViewData("list",cd);*/
			return renderView(PAGE_PATH+"bankList");
		}
	
	}
	
	
	/**
	 * 
	 * @Title  checkBankByCodeOrName
	 * @author  wangjs   
	 * @version 1.0 
	 * @param bankCode
	 * @param bankName
	 * @return Object
	 * @Description 校验银行代码、银行名称是否重复
	 * @time 2017年2月23日 下午8:31:06
	 */
	
		public Object  checkBankByCodeOrName(String bankCode,String bankName){
				
			Map<String,Object> data = new HashMap<String,Object>();
				if(null!=bankCode&&!"".equals(bankCode)){
					Conditions conditionByBankCode = asBankMapper.selectByCodeOrName(bankCode,null);
					if(null!=conditionByBankCode){
						data.put("statusCode","1");
					}else{
						data.put("statusCode","0");
					}
				}if(null!=bankName&&!"".equals(bankName)){
					Conditions conditionsByBankName = asBankMapper.selectByCodeOrName(null,bankName);

					if(null!=conditionsByBankName){
						data.put("statusName","1");
					}else {
						data.put("statusName","0");
					}
				}	
					return data;
			}
}
