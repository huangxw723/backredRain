package com.aoshi.service.manage.ownActivity;

import com.aoshi.common.asenum.DictParam;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.dao.AsOwnActivityDiscMapper;
import com.aoshi.dao.AsOwnGiftMapper;
import com.aoshi.dao.AsPrizeMapper;
import com.aoshi.domain.AsPrizeConfig;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.system.User;
import com.aoshi.util.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 商家自主礼品serivce
 *
 * @author strong
 * @version 1.0
 *          2017年2月18日下午1:32:40
 */
@Service
@Transactional
public class OwnGiftService {

    @Autowired
    private AsOwnGiftMapper asOwnGiftMapper;

    @Autowired
    private AsOwnActivityDiscMapper asOwnActivityDiscMapper;

    @Autowired
    private AsDictParamMapper asDictParamMapper;

    @Autowired
    private AsPrizeMapper asPrizeMapper;


    /**
     * 查询所有
     *
     * @param isShop
     * @param keyWord
     * @param isShop
     * @return
     */
    public List<AsPrizeConfig> queryAll(String categoryId, String keyWord, int isShop) {
        return asOwnGiftMapper.queryAll(categoryId, keyWord, isShop);
    }

    /**
     * 显示礼品选择
     *
     * @param keyWord
     * @return
     */
    public List<AsPrizeConfig> queryToGift(String keyWord, Integer shopId) {
        return asOwnGiftMapper.queryToGift(keyWord, shopId);
    }


    /**
     * 获取商家ID
     */
    public Integer getShopId() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        String adminRoleId = asDictParamMapper.findByKeyCode(DictParam.PARAM_ADMIN_ROLE_ID);
        String operationRoleId = asDictParamMapper.findByKeyCode(DictParam.PARAM_OPERATION_MANAGER_ROLE_ID);
        if (user.getROLE_ID().equals(adminRoleId) || user.getROLE_ID().equals(operationRoleId)) {
            return 0;
        }
        return Integer.parseInt(user.getAs_shop_id());
    }


    /**
     * 查询礼品类型
     *
     * @param type
     * @return
     */
    public List<AsYpBaseCategory> queryType(Integer type) {
        return asOwnGiftMapper.queryType(type);
    }


    /**
     * 添加礼品
     *
     * @param asPrizeConfig
     * @param img
     */
    public void save(AsPrizeConfig asPrizeConfig, MultipartFile img) {
        Boolean flag = false;
        //定义名字
        String fileName = UuidUtil.get32UUID() + ".jpg";
        //定义路径
        String filePath = Const.ACTIVITYFILEPATHIMG;
        if (!StringUtils.isEmpty(img.getOriginalFilename())) {
            try {
                //创建图片上传
                flag = ftpUpload(img.getBytes(), fileName, filePath);

            } catch (IOException e) {
                e.printStackTrace();
            }
            if (flag) {
                //封装图片路径
                asPrizeConfig.setLogoUrl(filePath + "/" + fileName);
            }

            asPrizeConfig.setCreateTime(DateUtil.getTime());
            asPrizeConfig.setAuditTime(DateUtil.getTime());


            //礼品编号
            String sys = System.currentTimeMillis() + "";
            String num = sys.substring(sys.length() - 5, sys.length());

            String math = "";
            for (int i = 0; i < 5; i++) {
                math += (int) (Math.random() * 10);
            }

            asPrizeConfig.setSn(num + math);
            asPrizeConfig.setSurplusCounts(asPrizeConfig.getCounts());
        }
        asOwnGiftMapper.save(asPrizeConfig);
    }

    //实现图片上传方法
    private Boolean ftpUpload(byte[] bs, String fileName, String filePath) {
        //定义ftp路径
        String ftpPath = Const.FILEPATHIMGDIR + filePath;
        //获取ftp对象
        FtpConManager fcm = FtpConManager.getInstance();
        //定义ftp连接属性
        try {
            fcm.login(PropertyUtils.getFTP_URL(), PropertyUtils.getFTP_USERNAME(), PropertyUtils.getFTP_PASS());
        } catch (Exception e) {
            e.printStackTrace();
        }
        //进行Ftp图片上传
        return fcm.uploadFileByInputStream(new ByteArrayInputStream(bs), ftpPath, fileName);
    }

    /**
     * 去修改页面
     *
     * @param id
     * @param id
     * @return
     */
    public AsPrizeConfig toEdit(Integer id) {
        return asOwnGiftMapper.toEdit(id);
    }

    /**
     * 修改
     *
     * @param asPrizeConfig
     * @param file
     */
    public int edit(AsPrizeConfig asPrizeConfig, String categoryName, MultipartFile file) {

        //计算剩余数量 和总数量
        AsPrizeConfig config = asOwnGiftMapper.toEdit(asPrizeConfig.getPrizeConfigId());
        Integer tempCounts = config.getCounts() - config.getSurplusCounts();

        asPrizeConfig.setCounts(tempCounts + asPrizeConfig.getSurplusCounts());

        if (categoryName.equals("礼品券")) {
            asPrizeConfig.setPrice(new BigDecimal("0"));
        }

        Boolean flag = false;
        //定义名字
        String fileName = UuidUtil.get32UUID() + ".jpg";
        //定义路径
        String filePath = Const.ACTIVITYFILEPATHIMG;

        if (!StringUtils.isEmpty(file.getOriginalFilename())) {
            try {
                //创建图片上传
                flag = ftpUpload(file.getBytes(), fileName, filePath);

            } catch (IOException e) {
                e.printStackTrace();
            }
            if (flag) {
                //封装图片路径
                asPrizeConfig.setLogoUrl(filePath + "/" + fileName);
            }
        }
        int result = asOwnGiftMapper.edit(asPrizeConfig);
        if (result > 0) {
            //更新物品表的时间
            Map<String, Object> map = new HashMap<>();
            map.put("prizeConfigId", asPrizeConfig.getPrizeConfigId());
            map.put("inactiveTime", asPrizeConfig.getInactiveTime());
            map.put("activeTime", asPrizeConfig.getActiveTime());
            map.put("endTime", asPrizeConfig.getEndTime());
            map.put("startTime", asPrizeConfig.getStartTime());
            asPrizeMapper.updateTimeByConfigId(map);
        }
        return result;
    }

    /**
     * 删除
     *
     * @param prizeConfigId
     * @return
     */
    public int delete(Integer prizeConfigId) {
        asOwnActivityDiscMapper.deleteByPrimaryKey(prizeConfigId);
        return asOwnGiftMapper.delete(prizeConfigId);
    }

    /**
     * 查询商家的名字
     *
     * @param shopId
     * @return
     */
    public String queryShopName(Integer shopId) {
        return asOwnGiftMapper.queryShopName(shopId);
    }


}
