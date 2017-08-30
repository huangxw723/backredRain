package com.aoshi.util.init_script;

import com.aoshi.common.asenum.UserTypeEnum;
import com.aoshi.dao.*;
import com.aoshi.domain.*;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.Assert;
import org.springframework.web.context.ServletConfigAware;

import javax.servlet.ServletConfig;

/**
 * 数据初始化脚本 (E街E铺3期)
 * @author yangyanchao
 * @date 2017-03-10
 */
@Component
public class DataInitializeVer3 extends AsBaseService implements ServletConfigAware {

    /**
     * 通用Dao
     */
    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private AsShopMapper asShopMapper;

    @Autowired
    private AsUserMapper asUserMapper;

    @Autowired
    private AsShopOwnerInfoMapper asShopOwnerInfoMapper;

    @Autowired
    private AsShopStaffInfoMapper asShopStaffInfoMapper;

    @Autowired
    private AsBankBindMapper asBankBindMapper;

    /**
     * 事务变量
     * 
     * @author yangyanchao
     * @date 2017-03-10
     */
    @Autowired
    private DataSourceTransactionManager txManager;
    private TransactionStatus status;
    private String sysUserId;
    private String account;
    private String roleId;
    private String roleName;
    private String roleRights;
    private int shopId;
    private int shopOwnerUserId;
    private int shopStaffUserId;

    @Override
    public void setServletConfig(ServletConfig servletConfig) {

        // 基本属性定义
        sysUserId = "eb222d278f1507776a357b51e1f6c0ce6b01f849";
        account = "ascmMallManager";
        roleId = "e4c7a3cb806f483696172841d8b167da";
        roleName = "澳视商户管理员";
        roleRights = "16069380442589902755419620923411626025675377120183421272850432";

        try{

            // 开启事务
            createTx();

            // 添加角色
            createRole();

            // 添加店铺
            createShop();

            // 添加帐号
            createUser();

            // 添加后台用户记录
            createSysUser();

            // 添加店铺管理员信息表
            createShopOwner();

            // 添加店铺员工信息表
            createShopStaff();

            // as_shop表,旧数据type字段为null为题,初始化为1
            asShopMapper.updateShopByScriptV3();

            // E街E铺-3期 绑卡信息有变,所有已绑的银行卡作废
            asBankBindMapper.updateByScriptV3();

            txManager.commit(status);
        } catch (Exception e){

            txManager.rollback(status);
        }
    }

    private void createShopStaff() {
        AsShopStaffInfo shopStaffInfoBean = new AsShopStaffInfo();
        shopStaffInfoBean.setUserId(shopStaffUserId);
        shopStaffInfoBean.setShopId(shopId);
        shopStaffInfoBean.setName(roleName);
        shopStaffInfoBean.setCreateTime(CommonUtils.getCurDate());
        shopStaffInfoBean.setShopUserId(shopOwnerUserId);
        operaFlag = asShopStaffInfoMapper.insertSelective(shopStaffInfoBean) == 1;
        Assert.isTrue(operaFlag, "添加店铺员工帐号失败");
    }

    private void createShopOwner() {
        AsShopOwnerInfo shopOwnerInfoBean = new AsShopOwnerInfo();
        shopOwnerInfoBean.setUserId(shopOwnerUserId);
        shopOwnerInfoBean.setShopId(shopId);
        shopOwnerInfoBean.setName(roleName);
        shopOwnerInfoBean.setCreateTime(CommonUtils.getCurDate());
        operaFlag = asShopOwnerInfoMapper.insertSelective(shopOwnerInfoBean) == 1;
        Assert.isTrue(operaFlag, "添加店铺管理员帐号失败");
    }

    private void createSysUser() {
        operaFlag = sysUserMapper.countById(sysUserId) == 0;
        Assert.isTrue(operaFlag, sysUserId +", 数据已存在");
        SysUser sysUserBean = new SysUser();
        sysUserBean.setUserId(sysUserId);
        sysUserBean.setUsername(account);
        sysUserBean.setRoleId(roleId);
        sysUserBean.setRights(roleRights);
        sysUserBean.setStatus("0");
        sysUserBean.setPassword("eb222d278f1507776a357b51e1f6c0ce6b01f849");
        sysUserBean.setAsShopId(shopId);
        sysUserBean.setAsUserId(shopOwnerUserId);
        operaFlag = sysUserMapper.insertSelective(sysUserBean) == 1;
        Assert.isTrue(operaFlag, "添加后台用户失败");
    }

    private void createUser() {
        operaFlag = asUserMapper.countByAccount(account) == 0;
        Assert.notNull(operaFlag, "澳视传媒帐号已存在 shopId "+ shopId);
        AsUser shopOwnerBean = new AsUser();
        shopOwnerBean.setAccount(account);
        shopOwnerBean.setPassword("c4ca4238a0b923820dcc509a6f75849b");
        shopOwnerBean.setSysUserId(sysUserId);
        shopOwnerBean.setType(UserTypeEnum.SELLER.getId());
        shopOwnerBean.setCreateTime(CommonUtils.getCurDate());
        operaFlag = asUserMapper.insertSelective(shopOwnerBean) == 1;
        Assert.isTrue(operaFlag, "添加商户帐号失败");
        shopOwnerUserId = shopOwnerBean.getUserId();

        AsUser shopStaffBean = new AsUser();
        shopStaffBean.setAccount(account);
        shopStaffBean.setPassword("c4ca4238a0b923820dcc509a6f75849b");
        shopStaffBean.setType(UserTypeEnum.STAFF.getId());
        shopStaffBean.setCreateTime(CommonUtils.getCurDate());
        operaFlag = asUserMapper.insertSelective(shopStaffBean) == 1;
        shopStaffUserId = shopStaffBean.getUserId();
    }

    private void createShop() {
        AsShop shopBean = new AsShop();
        shopBean.setName("澳视传媒");
        shopBean.setLogoUrl("ascmMall/shop/de37b0af8f0645dba67bdebf63b8f128.jpg");
        shopBean.setMainPicUrl("ascmMall/shop/mainPicUrl/3bd087289ea244d798f583804045399d.jpg");
        shopBean.setTel("4000900308");
        shopBean.setAddress("广州市萝岗区澳视传媒");
        shopBean.setContactMail("ad@as-cm.com");
        shopBean.setContact("周生");
        shopBean.setType(2);
        operaFlag = asShopMapper.insertSelective(shopBean) == 1;
        shopId = shopBean.getShopId();
    }

    /**
     * 创建角色
     * @author yangyanchao
     * @date 2017-03-10
     */
    private void createRole() {
        operaFlag = sysRoleMapper.isExistById(roleId) == 0;
        Assert.isTrue(operaFlag, "E街E铺3期 数据已存在!");
        SysRole roleBean = new SysRole();
        roleBean.setRoleId(roleId);
        roleBean.setRoleName(roleName);
        roleBean.setRights(roleRights);
        roleBean.setParentId("1");
        operaFlag = sysRoleMapper.insertSelective(roleBean) == 1;
        Assert.isTrue(operaFlag, "创建角色失败");
    }

    /**
     * 启动事务
     * 
     * @author yangyanchao
     * @date 2017-03-10
     */
    private void createTx() {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        status = txManager.getTransaction(def);
    }
}
