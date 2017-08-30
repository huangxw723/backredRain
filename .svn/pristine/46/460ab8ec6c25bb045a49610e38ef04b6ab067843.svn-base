package com.aoshi.util.scheduler;

import com.aoshi.common.asenum.AccountTypeEnum;
import com.aoshi.common.asenum.CapitalStatusEnum;
import com.aoshi.dao.AsCapitalActionMapper;
import com.aoshi.dao.AsCapitalMapper;
import com.aoshi.dao.AsUserAccountMapper;
import com.aoshi.dao.AsWalletMapper;
import com.aoshi.domain.AsCapital;
import com.aoshi.domain.AsCapitalAction;
import com.aoshi.domain.AsUserAccount;
import com.aoshi.domain.AsWallet;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.util.ArithmeticUtil;
import com.aoshi.util.CommonUtils;
import com.aoshi.util.Conditions;
import org.apache.log4j.Logger;
import org.quartz.*;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ServletConfigAware;
import tlt.TranxConfig;
import tlt.TranxServiceImpl;
import tlt.entity.service.ResponseVo;

import javax.servlet.ServletConfig;

import java.util.List;
import java.util.Properties;

import static org.quartz.JobBuilder.*;
import static org.quartz.TriggerBuilder.*;
import static org.quartz.SimpleScheduleBuilder.*;

/**
 * 提现申请状态查询定时器
 * @author yangyanchao
 * @date 2017-02-28
 */
@Component
public class CapitalScheduler implements Job , ServletConfigAware {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private AsCapitalMapper asCapitalMapper;

    @Autowired
    private AsUserAccountMapper asUserAccountMapper;

    @Autowired
    private AsWalletMapper asWalletMapper;

    @Autowired
    private AsCapitalActionMapper asCapitalActionMapper;

    @Autowired
    private DataSourceTransactionManager txManager;

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {

        JobDataMap data = context.getJobDetail().getJobDataMap();

        AsUserAccountMapper accountDao = (AsUserAccountMapper) data.get("userAccountDao");
        AsWalletMapper walletDao = (AsWalletMapper) data.get("walletDao");
        AsCapitalActionMapper capitalActionDao = (AsCapitalActionMapper) data.get("capitalActionDao");
        DataSourceTransactionManager tx = (DataSourceTransactionManager) data.get("txManager");

        // 获取通联中间状态的提现申请
        AsCapitalMapper dao = (AsCapitalMapper) data.get("capitalDao");
        List<AsCapital> capitalList = dao.getCapitalByStatusWithScheduler(Conditions.newInstance().putData("status", CapitalStatusEnum.PROCESSING.getStatus()));
        if(capitalList.isEmpty())
            return;

        // 开启事务
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
        TransactionStatus status = tx.getTransaction(def);

        for (AsCapital capital : capitalList){

            // 判断有无流水号
            String tradeSn = capital.getTradeSn();
            ValidatorBreakException.NOT_TRUE(!StringUtils.isEmpty(tradeSn),String.format("异常提现申请,无交易流水号 # [%s]", capital.getCapitalId()));
            System.out.println(String.format("提现申请-定时轮询任务, 流水号[%s]",tradeSn));

            ResponseVo responseVo = new TranxServiceImpl().queryTradeNew(TranxConfig.URL,tradeSn,"","");

            if(responseVo.getStatus().equals("0000")){ // 提现成功

                capital.setUpdateTime(CommonUtils.getCurDate());
                int capitalStatus = CapitalStatusEnum.SUCCESS.getStatus();
                capital.setStatus(capitalStatus);

                // 添加用户帐号资金流水
                AsUserAccount asUserAccount = new AsUserAccount();
                asUserAccount.setUserId(capital.getUserId());
                asUserAccount.setAmount(capital.getMoney());
                asUserAccount.setAccountType(AccountTypeEnum.POSTAL.getId());
                asUserAccount.setItemId(capital.getCapitalId());
                asUserAccount.setCreateTime(CommonUtils.getCurDate());
                asUserAccount.setRemark(capital.getDescp());
                boolean operaFlag = accountDao.insertSelective(asUserAccount) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag,"系统繁忙");

                System.out.println(String.format("提现申请-定时轮询任务, 流水号[%s], 处理成功",tradeSn));

            } else if ("2000".equals(responseVo.getStatus())
                    || "2001".equals(responseVo.getStatus())
                    || "2003".equals(responseVo.getStatus())
                    || "2005".equals(responseVo.getStatus())
                    || "2007".equals(responseVo.getStatus())
                    || "2008".equals(responseVo.getStatus())){ // 提现处理中

                System.out.println(String.format("提现申请-定时轮询任务, 流水号[%s], 处理中",tradeSn));
                continue;

            } else { // 提现失败

                capital.setUpdateTime(CommonUtils.getCurDate());
                capital.setStatus(CapitalStatusEnum.FAIL.getStatus());

                // 返回 提现金额+手续费 到钱包
                AsWallet wallet = (AsWallet) walletDao.findByUserIdWithLock(capital.getUserId());
                ValidatorBreakException.NOT_NULL(wallet);
                double oldWalletMoney = wallet.getMoney().doubleValue();
                double newWalletMoney = ArithmeticUtil.ADD(oldWalletMoney, capital.getMoney().doubleValue());
                wallet.setMoney(ArithmeticUtil.newInstance(newWalletMoney));
                wallet.setUpdateTime(CommonUtils.getCurDate());
                boolean operaFlag = walletDao.updateByPrimaryKeySelective(wallet) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);

                // 添加 提现错误日志流水
                AsCapitalAction asCapitalAction = new AsCapitalAction();
                asCapitalAction.setCapitalId(capital.getCapitalId());
                asCapitalAction.setStatus(CapitalStatusEnum.FAIL.getStatus());
                asCapitalAction.setErrorCode(responseVo.getStatus());
                asCapitalAction.setErrorMsg("[通联提示] : "+responseVo.getMsg());
                asCapitalAction.setCreateTime(CommonUtils.getCurDate());
                operaFlag = capitalActionDao.insertSelective(asCapitalAction) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);

                System.out.println(String.format("提现申请-定时轮询任务, 流水号[%s], 处理失败, 失败原因[%s]", tradeSn, responseVo.getMsg()));
            }

            boolean operaFlag = dao.updateStatusWithScheduler(capital) == 1;
            ValidatorBreakException.NOT_TRUE(operaFlag,String.format("异常提现申请,更新处理状态失败 # [%s]", capital.getCapitalId()));
        }

        tx.commit(status);
    }

    @Override
    public void setServletConfig(ServletConfig servletConfig) {

        try{

            // 读取 定时器配置
            Properties prop = new Properties();
            prop.load(new ClassPathResource("tlt/config.properties").getInputStream());
            if( !Boolean.valueOf(prop.getProperty("scheduler.open")) ){
                return;
            }

            // 建立定时任务
            Scheduler scheduler = new StdSchedulerFactory().getScheduler();
            JobDetail job = newJob(CapitalScheduler.class)
                    .usingJobData(new JobDataMap(Conditions.newInstance()
                            .putData("capitalDao",asCapitalMapper)
                            .putData("userAccountDao",asUserAccountMapper)
                            .putData("walletDao",asWalletMapper)
                            .putData("capitalActionDao",asCapitalActionMapper)
                            .putData("txManager",txManager)
                    ))
                    .build();
            Trigger trigger = newTrigger()
                    .startNow()
                    .withSchedule(simpleSchedule()
                            .withIntervalInSeconds(Integer.parseInt(prop.getProperty("scheduler.interval")))
                            .repeatForever())
                    .build();
            scheduler.start();
            scheduler.scheduleJob(job,trigger);
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
