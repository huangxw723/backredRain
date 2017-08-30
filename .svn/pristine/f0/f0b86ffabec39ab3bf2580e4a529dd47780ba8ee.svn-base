package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsShopPic;
import com.aoshi.service.manage.AccountService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.PageData;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 帐号管理
 *
 * @author yangyanchao
 * @date 2016年10月27日
 */
@Controller
@RequestMapping("/account")
public class AccountController extends BaseController {

    private final static String PAGE_PATH = "manage/account/";

    @Autowired
    private AccountService asAccountService;


    /**
     * 跳转到添加商户账号页面（新）
     *@author tgb
     * @return
     */
    @RequestMapping("/saveAccountPage")
    public Object saveAccountPage() {
        return asAccountService.saveAccountPage(this);
    }

    /**
     * 异步检查商家账号是否重名
     * @author tgb
     */
    @RequestMapping("/isExist")
    @ResponseBody
    public Object isExist() {
        return asAccountService.isExist(this);
    }

    /**
     * 异步检查预留手机号码是否已经被使用
     * @author tgb
     */
    @RequestMapping("/isExistPhone")
    @ResponseBody
    public Object isExistPhone() {
        return asAccountService.isExistPhone(this);
    }

    /**
     * 异步检查商户名称是否重名
     * @author tgb
     */
    @RequestMapping("/isMerchantAccountExists")
    @ResponseBody
    public Object isMerchantAccountExists() {
        return asAccountService.isMerchantAccountExists(this);
    }

    /**
     * 保存商户帐号（新）
     * @author tgb
     */
    @RequestMapping("/saveAccountOpera")
    @ResponseBody
    public Object saveAccountOpera() {
        return asAccountService.saveAccountOpera(this);
    }


    /**
     * 查询商户管理列表-运营
     *
     * @return
     * @author tgb
     * @date 2016年10月28日
     */
    @RequestMapping("/getShopAccountList")
    public Object getShopAccountList() {
        return asAccountService.getShopAccountList(this);
    }

    /**
     * 店铺管理列表-业主
     *
     * @return
     * @author tgb
     * @date 2017年06月08日
     */
    @RequestMapping("/getShopAccountOwnerList")
    public Object getShopAccountOwnerList() {
        return asAccountService.getShopAccountOwnerList(this);
    }


    /**
     * 跳转重置密码页面
     *@author tgb
     * @param userId
     * @param account
     * @return
     */
    @RequestMapping("/resetPassword")
    public ModelAndView resetPassword(Integer userId, String account) {
        ModelAndView mv = this.getModelAndView();
        mv.addObject("userId", userId);
        mv.addObject("account", account);
        mv.setViewName("manage/account/resetPwdPage");
        return mv;
    }

    /**
     * 确认重置密码
     *
     * @return
     * @author tgb
     * @date 2017年06月08日
     */
    @RequestMapping("/updatePwd")
    @ResponseBody
    public Object updatePwd() {
        return asAccountService.updatePwd(this);
    }


    /**
     * 商户账号页面跳转控制
     *
     * @return
     * @author huangxw
     * @date 2017年02月21日
     */
    @RequestMapping("/addShopAccountInfoPage")
    public Object page() {
        return asAccountService.page(this);
    }


    /**
     * 去当前登录用户商户管理总页面
     * @author tgb
     */
    @RequestMapping(value = "/goInfoPageTag")
    public ModelAndView goInfoPageTag(Integer type, Integer shopId) {
        ModelAndView mv = this.getModelAndView();
        mv.addObject("type", type);
        mv.addObject("shopId", shopId);
        mv.setViewName("manage/account/goInfoPageTag");
        return mv;
    }

    /**
     * 获取当前登录用户商户个人信息页面-可编辑
     * * @author tgb
     *
     * @return
     * @date 2017年07月12日
     */
    @RequestMapping("/ownerInfoPage")
    public Object ownerInfoPage() {
        return asAccountService.ownerInfoPage(this);
    }

    /**
     * 获取当前登录用户商户信息页面-可编辑
     * * @author tgb
     *
     * @return
     * @date 2017年07月12日
     */
    @RequestMapping("/shopInfoPage")
    public Object shopInfoPage() {
        return asAccountService.shopInfoPage(this);
    }

    /**
     * 后台管理员去商户信息管理总页面
     * @author tgb
     */
    @RequestMapping(value = "/goShopAccountTab")
    public ModelAndView goShopAccountTab(Integer shopId, Integer type) {
        logBefore(logger, "去商户信息管理总页面");
        ModelAndView mv = this.getModelAndView();
        mv.addObject("shopId", shopId);
        mv.addObject("type", type);
        mv.setViewName("manage/account/shopAccountTab");
        return mv;
    }

    /**
     * 当商户账号未填写完资料时弹出提示页面
     * @author tgb
     */
    @RequestMapping(value = "/detail")
    public ModelAndView detail(String account) {
        ModelAndView mv = this.getModelAndView();
        mv.addObject("account", account);
        mv.setViewName("manage/account/detail");
        return mv;
    }

    /**
     * 后台管理员获取商家个人信息页面-只查看
     * * @author tgb
     *
     * @return
     * @date 2017年07月12日
     */
    @RequestMapping("/getShopOwnerInfoPage")
    public Object getShopOwnerInfoPage() {
        return asAccountService.getShopOwnerInfoPage(this);
    }

    /**
     * 后台管理员获取商家信息页面-只查看
     * * @author tgb
     *
     * @return
     * @date 2017年07月12日
     */
    @RequestMapping("/getShopAccountInfoPage")
    public Object getShopAccountInfoPage() {
        return asAccountService.page(this);
    }

    /**
     * 添加商户帐号
     *
     * @return
     * @author huangxw
     * @date 2017年02月21日
     */
    @RequestMapping("/opera")
    @ResponseBody
    public Object opera() {
        return asAccountService.opera(this);
    }

    /**
     * 编辑当前登录商户帐号信息
     *@author tgb
     * @return
     * @date 2017年07月14日
     */
    @RequestMapping("/operaShop")
    public Object operaShop() {
        return asAccountService.operaShop(this);
    }

    /**
     * 编辑当前登录商家个人信息
     *@author tgb
     * @return
     * @date 2017年07月14日
     */
    @RequestMapping("/operaOwner")
    public Object operaOwner() {
        return asAccountService.operaOwner(this);
    }


    /**
     * 添加商家端帐号H5
     *
     * @return
     * @author yangyanchao
     * @date 2016年10月31日
     */
    @RequestMapping("/addShopAccountPage")
    public Object addShopAccountPage() {
        return asAccountService.saveShopAccountPage(this);
    }


    /**
     * 异步检查员工账号是否重名
     */
    @RequestMapping("/isShopAccountExist")
    @ResponseBody
    public Object isShopAccountExist() {
        return asAccountService.isShopAccountExist(this);
    }

    /**
     * 添加帐号
     *
     * @return
     * @author yangyanchao
     * @date 2016年11月2日
     */
    @RequestMapping("/saveShopAccount")
    @ResponseBody
    public Object addShopAccount() {
        return asAccountService.saveShopAccount(this);
    }

    /**
     * 更新帐号禁用状态
     *
     * @return
     * @author yangyanchao
     * @date 2016年11月3日
     */
    @RequestMapping("/updateStatus")
    @ResponseBody
    public Object accountStatus() {
        return asAccountService.accountStatus_Tx(this);
    }

    /**
     * 删除帐号
     *
     * @return
     * @author yangyanchao
     * @date 2016年11月1日
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete() {
        return asAccountService.delete(this);
    }

    /**
     * 获取后台帐号列表
     *
     * @return
     * @author yangyanchao
     * @date 2016年11月2日
     */
    @RequestMapping("/getAdminAccountList")
    public Object getAdminAccountList() {
        return asAccountService.getAdminAccountList(this);
    }

    /**
     * 获取后台运营帐号列表
     *
     * @return
     * @author huangxw
     * @date 2017年04月05日
     */
    @RequestMapping("/getOperaAdminAccountList")
    public Object getOperaAdminAccountList() {
        return asAccountService.getOperaAdminAccountList(this);
    }

    /**
     * 获取普通用户列表
     *
     * @return
     * @author yangyanchao
     * @date 2016年12月26日
     */
    @RequestMapping("/getCommonUserList")
    public Object getCommonUserList() {
        return asAccountService.getCommonUserList(this);
    }

    /**
     * 添加管理员帐号H5
     *
     * @return
     * @author yangyanchao
     * @date 2016年11月2日
     */
    @RequestMapping("/addAdminAccountPage")
    public Object addAdminAccountPage() {
        return asAccountService.addAdminAccountPage(this);
    }

    /**
     * 添加运营管理员帐号H5
     *
     * @return
     * @author huangxw
     * @date 2017年04月05日
     */
    @RequestMapping("/addOperaAdminAccountPage")
    public Object addOperaAdminAccountPage() {
        return asAccountService.addOperaAdminAccountPage(this);
    }

    /**
     * 添加管理员帐号
     *
     * @return
     * @author yangyanchao
     * @date 2016年11月2日
     */
    @RequestMapping("/saveAdminAccount")
    @ResponseBody
    public Object addAdminAccount() {
        return asAccountService.saveAdminAccount(this);
    }

    /**
     * 获取普通用户列表
     *
     * @return
     * @author huangxw
     * @date 2017年3月13日
     */
    @RequestMapping("/getStaffListAll")
    public Object getStaffListAll() {
        return asAccountService.getStaffListAll(this);
    }


    /**
     * 获取后台帐号列表
     *
     * @return
     * @author huangxw
     * @date 2017年05月04日
     */
    @RequestMapping("/getAccountList")
    public Object getAccountList() {
        return asAccountService.getAccountList(this);
    }

    /**
     * 添加管理员帐号
     *
     * @return
     * @author huangxw
     * @date 2017年04月05日
     */
    @RequestMapping("/addAccountPage")
    public Object addAccountPage() {
        return asAccountService.addAccountPage(this);
    }


    /**
     * ##################################################会员管理#######################################################
     */


    /**
     * 去会员账号管理总页面
     */
    @RequestMapping(value = "/goTab")
    public ModelAndView goTab(Integer view, Integer userId) {
        logBefore(logger, "去查看会员账号");
        ModelAndView mv = this.getModelAndView();
        mv.addObject("userId", userId);
        mv.addObject("view", view);
        mv.setViewName("manage/account/accountTab");
        return mv;
    }

    /**
     * 添加会员账号页面
     */
    @RequestMapping("/saveAccountMemberPage")
    public Object saveAccountMemberPage() {
        return asAccountService.saveAccountMemberPage(this);
    }

    /**
     * 异步检查检查会员账号是否已经存在
     *
     * @return
     * @author tgb
     * @date 2017年05月12日
     */
    @RequestMapping("/accountMemberIsExist")
    @ResponseBody
    public Object accountMemberIsExist() {
        return asAccountService.accountMemberIsExist(this);
    }

    /**
     * 添加会员账号操作
     *
     * @return
     * @author tgb
     * @date 2017年05月12日
     */
    @RequestMapping("/saveAccountMember0pera")
    @ResponseBody
    public Object saveAccountMember0pera() {
        return asAccountService.saveAccountMember0pera(this);
    }


    /**
     * 获取会员账号收货地址列表
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/getAccountAddressList")
    public Object getAccountAddressList() {
        return asAccountService.getAccountAddressList(this);
    }

    /**
     * 会员账号收货地址页面跳转控制
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/accountAddressPage")
    public Object accountAddressPage() {
        return asAccountService.accountAddressPage(this);
    }


    /**
     * 会员账号收货地址操作
     *
     * @return
     * @author tgb
     * @date 2017年05月12日
     */
    @RequestMapping("/accountAddressOpera")
    @ResponseBody
    public Object accountAddressOpera() {
        return asAccountService.accountAddressOpera(this);
    }

    /**
     * 设置会员默认收货地址
     *
     * @return
     */
    @RequestMapping("/updateAddress")
    @ResponseBody
    public Object updateAddress() {
        return asAccountService.updateAddress(this);
    }

    /**
     * 获取会员银行卡列表
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/getAccountBankBindList")
    public Object getAccountBankBindList() {
        return asAccountService.getAccountBankBindList(this);
    }

    /**
     * 解绑会员银行卡
     *
     * @return
     */
    @RequestMapping("/unAccountBankBind")
    @ResponseBody
    public Object unAccountBankBind() {
        return asAccountService.unAccountBankBind(this);
    }


    /**
     * 获取会员余额列表
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/getAccountCapitalList")
    public Object getAccountMoneyList() {
        return asAccountService.getAccountCapitalList(this);
    }

    /**
     * 查看处理描述
     *
     * @return
     * @author tgb
     * @date 2017年05月12日
     */
    @RequestMapping("/reason")
    public Object reason() {
        return asAccountService.reason(this);
    }

    /**
     * 判断会员账号是否绑定银行卡
     *
     * @return
     * @author tgb
     * @date 2017年05月12日
     */
    @RequestMapping("/isBankBind")
    @ResponseBody
    public Object isBankBind() {
        return asAccountService.isBankBind(this);
    }


    /**
     * 获取会员
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/getAccountInfoList")
    public Object getAccountInfoList() {
        return asAccountService.getAccountInfoList(this);
    }

    /**
     * 获取会员信息
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/updateShopMemberInfo")
    @ResponseBody
    public Object updateShopMemberInfo() {
        return asAccountService.updateShopMemberInfo(this);
    }

    /**
     * 会员账号提现申请页面跳转控制
     * * @author tgb
     *
     * @return
     * @date 2017年05月15日
     */
    @RequestMapping("/accountDepositPage")
    public Object accountDepositPage() {
        return asAccountService.accountDepositPage(this);
    }

    /**
     * 会员账号提现申请操作跳转控制
     * * @author tgb
     *
     * @return
     * @date 2017年05月15日
     */
    @RequestMapping("/accountDepositOpera")
    @ResponseBody
    public Object accountDepositOpera() {
        return asAccountService.accountDepositOpera(this);
    }

    /**
     * 会员账号我的积分页面控制
     * * @author tgb
     *
     * @return
     * @date 2017年05月15日
     */
    @RequestMapping("/accountIntegrationPage")
    public Object accountIntegrationPage() {
        return asAccountService.accountIntegrationPage(this);
    }

    /**
     * 会员账号我的积分操作跳转控制
     * * @author tgb
     *
     * @return
     * @date 2017年05月15日
     */
    @RequestMapping("/accountIntegrationOpera")
    public Object accountIntegrationOpera() {
        return asAccountService.accountIntegrationOpera(this);
    }

    /**
     * 获取会员账户积分明细列表
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/getPointDetailList")
    public Object getPointDetailList() {
        return asAccountService.getPointDetailList(this);
    }

    /**
     * 获取会员账户积分兑换记录列表
     * * @author tgb
     *
     * @return
     * @date 2017年05月12日
     */
    @RequestMapping("/getExchangeRecordList")
    public Object getExchangeRecordList() {
        return asAccountService.getExchangeRecordList(this);
    }


    /**
     * ########################################商户背景图操作#############################################
     */

    /**
     * 跳转到编辑背景图片列表页面
     *
     * @param map
     * @return
     * @author tgb 创建时间：2017年05月27日
     */
    @RequestMapping("/toEditImage")
    public String toEditImage(int shopId, int view, ModelMap map) {
        List<AsShopPic> shopPics = asAccountService.getShopPicImgs(shopId);
        map.put("shopId", shopId);
        map.put("view", view);
        map.put("shopPics", shopPics);
        return PAGE_PATH + "shopPicImgs";
    }

    /**
     * 跳转到编辑图片页面
     *
     * @param shopId
     * @param map
     * @return
     */
    @RequestMapping(value = "toEditShopPicImgs")
    public String toEditShopPicImgs(int shopId, int shopPicId, ModelMap map) {
        map.put("shopId", shopId);
        map.put("shopPicId", shopPicId);
        return PAGE_PATH + "editShopPicImg";
    }

    /**
     * 编辑背景图
     *
     * @param files
     * @return
     */
    @RequestMapping(value = "editShopPicImgs")
    public String editShopPicImgs(
            @RequestParam(value = "files", required = true) MultipartFile files,
            int shopId, int shopPicId) {
        asAccountService.editShopPicImgs(files, shopId, shopPicId);
        return PAGE_PATH + "result";
    }

    /**
     * 跳转到添加背景图片页
     *
     * @param shopId
     * @param len
     * @return
     * @author tgb
     */
    @RequestMapping("/toAddshopPics")
    public String toAddshopPics(int shopId, int len, ModelMap map) {
        map.put("shopId", shopId);
        map.put("len", len);
        return PAGE_PATH + "addShopPicImgs";
    }

    /**
     * 保存商户背景图片
     *
     * @param files  图片文件数组
     * @param shopId
     * @return
     * @author tgb
     */
    @RequestMapping(value = "saveShopPicImgs")
    public String saveShopPicImgs(
            @RequestParam(value = "files", required = true) MultipartFile[] files,
            int shopId) {
        asAccountService.saveShopPicImgs(files, shopId);
        return PAGE_PATH + "result";
    }

    /**
     * 删除单张商户背景图片
     *
     * @param shopPicId
     * @return
     * @author tgb
     * @version 1.0
     */
    @RequestMapping("/deleteShopPicImg")
    @ResponseBody
    public Object deleteShopPicImg(int shopPicId) {
        return asAccountService.deleteShopPicImg(shopPicId);
    }

    /**
     * 批量删除商户背景图片
     *
     * @return
     * @author tgb
     * @version 1.0
     */
    @RequestMapping("/deleteShopPicImgAlls")
    @ResponseBody
    public Object deleteShopPicImgAlls() {
        logBefore(logger, "deleteShopPicImgAlls");
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String ids = pd.getString("ids");
            if (StringUtils.isNotBlank(ids)) {
                String IdArr[] = ids.split(",");
                int[] ints = StringToInt(IdArr);
                asAccountService.deleteShopPicImgAlls(ints);
                map.put("msg", "ok");
            } else {
                map.put("msg", "no");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 字符数组装int类型
     */
    public int[] StringToInt(String[] arrs) {
        int[] ints = new int[arrs.length];
        for (int i = 0; i < arrs.length; i++) {
            ints[i] = Integer.parseInt(arrs[i]);
        }
        return ints;
    }

    /**
     * 审批进度
     */
    @RequestMapping("/auditProgress")
    public String auditProgress(int type, ModelMap map) {
        String userId = getCurrentUser().getNewUserId();
        Object info = asAccountService.getShopAccountOwnerInfo(Integer.parseInt(userId));
        map.put("type", type);
        map.put("info", info);
        return PAGE_PATH + "audit_progress";
    }

}
