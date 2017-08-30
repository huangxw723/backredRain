package com.aoshi.controller.bank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aoshi.controller.base.BaseController;
import com.aoshi.service.bank.BankService;

/**
 * 
* @ClassName: BankController
* @Description: 银行卡
* @author wangjs
* @date 2017年2月23日 下午2:40:21
*
 */
@Controller
@RequestMapping("/bank")
public class BankController extends BaseController{
	@Autowired
	BankService bankService;
	
	/**
	 * 
	 * @Title  getBankById
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 获取银行卡列表
	 * @time 2017年2月23日 下午2:41:57
	 */
	@RequestMapping("/bankList")
	public Object getBankById() {
		
		return bankService.getAllBankTx(this);
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
	@RequestMapping("/bankAdd")
	@ResponseBody
	public Object addBank() {
		//bankService.addBankTx(this);
		//return bankService.getAllBankTx(this);S
		return bankService.addBankTx(this);
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
	@RequestMapping("/bankEdit")
	@ResponseBody
	public Object editBank() {
		/*bankService.editBankTx(this);
		return bankService.bankInfoByPramTx(this);*/
		return bankService.editBankTx(this);
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
	@RequestMapping("/updateBankStatus")
	@ResponseBody
	public Object updateBankStatus() {
		
		return bankService.updateBankStatusTx(this);
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
	@RequestMapping("/bankInfoByPram")
	public Object bankInfoByPram() {
		
		return bankService.bankInfoByPramTx(this);
	}
	
	/**
	 * 
	 * @Title  bankAddVieww
	 * @author  wangjs   
	 * @version 1.0 
	 * @return Object
	 * @Description 修改·银行卡信息页面跳转
	 * @time 2017年2月23日 下午2:44:10
	 */
	@RequestMapping("/bankAddVieww")
	public Object bankAddVieww() {
		
		return renderView("bank/bankDetail/bankAdd");
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
	 * @time 2017年2月23日 下午8:32:27
	 */
	@RequestMapping("/checkBankByCodeOrName")
	@ResponseBody
	public Object checkBankByCodeOrName(String bankCode,String bankName) {
		
		return bankService.checkBankByCodeOrName(bankCode,bankName);
	}
	
	
	
}
