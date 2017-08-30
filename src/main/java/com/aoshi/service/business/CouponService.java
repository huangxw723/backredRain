package com.aoshi.service.business;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.*;
import com.aoshi.domain.*;
import com.aoshi.entity.system.User;
import com.aoshi.service.base.AsBaseService;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class CouponService extends AsBaseService {
    @Autowired
    AsCouponMapper asCouponMapper;
    @Autowired
    AsCouponTagRefMapper asCouponTagRefMapper;
    @Autowired
    AsBusinessDistrictMapper asBusinessDistrictMapper;
    @Autowired
    AsTagMapper asTagMapper;
    @Autowired
    AsPrizeTypeMapper asPrizeTypeMapper;

    public List<AsCoupon> queryList(AsCoupon AsCoupon) {
        return asCouponMapper.queryList(AsCoupon);
    }

    public List<AsCoupon> selectByShopId(AsCoupon AsCoupon) {
        return asCouponMapper.queryList(AsCoupon);
    }

    public int save(AsCoupon asCoupon, String tagIds, MultipartFile file) {
        boolean flag = false;
        String ftpFile = UuidUtil.get32UUID() + ".jpg";
        ;
        String ftpDir = Const.COUPONFILEPATHIMG;
        if (!StringUtils.isEmpty(file.getOriginalFilename())) {
            try {
                flag = ftpUpload(file.getBytes(), ftpFile, ftpDir);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (flag) {
            asCoupon.setLogoUrl(ftpDir + "/" + ftpFile);
        }
        asCoupon.setStatus(0);
        asCoupon.setCreateTime(DateUtil.getTime());
        asCoupon.setSn(UUID.randomUUID().toString().replace("-", ""));
        int result = asCouponMapper.insertSelective(asCoupon);
        String[] ids = tagIds.split(",");
        for (int i = 0; i < ids.length; i++) {
            int tagId = Integer.parseInt(ids[i]);

            AsCouponTagRef ref = new AsCouponTagRef();
            ref.setTagId(tagId);
            ref.setCouponId(asCoupon.getCouponId());
            ref.setCreateTime(DateUtil.getTime());
            asCouponTagRefMapper.insertSelective(ref);
        }
        return result;
    }

    private boolean ftpUpload(byte[] bytes, String ftpFile, String ftpDir) {
        String path = Const.FILEPATHIMGDIR + ftpDir;
        //byte[] bytes = Base64.decode(goodsImg);

        FtpConManager ftpConManager = FtpConManager.getInstance();
        try {
            ftpConManager.login(PropertyUtils.getFTP_URL(),
                    PropertyUtils.getFTP_USERNAME(),
                    PropertyUtils.getFTP_PASS());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ftpConManager.uploadFileByInputStream(new ByteArrayInputStream(bytes), path, ftpFile);
    }

    public AsCoupon findById(int couponId) {
        return asCouponMapper.findById(couponId);
    }

    public int update(AsCoupon asCoupon, String tagIds, MultipartFile file) {
        boolean flag = false;
        String ftpFile = UuidUtil.get32UUID() + ".jpg";
        ;
        String ftpDir = Const.COUPONFILEPATHIMG;
        if (!StringUtils.isEmpty(file.getOriginalFilename())) {
            try {
                flag = ftpUpload(file.getBytes(), ftpFile, ftpDir);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        if (flag) {
            asCoupon.setLogoUrl(ftpDir + "/" + ftpFile);
        } else {
            asCoupon.setLogoUrl(null);
        }
        int result = asCouponMapper.updateByPrimaryKeySelective(asCoupon);
        int r = 0;
        if (result > 0) {
            r = asCouponTagRefMapper.deleteByCoupId(asCoupon.getCouponId());
        }
        if (r > 0) {
            String[] ids = tagIds.trim().split(",");
            if (tagIds.trim().length() > 0) {
                for (int i = 0; i < ids.length; i++) {
                    int tagId = Integer.parseInt(ids[i]);

                    AsCouponTagRef ref = new AsCouponTagRef();
                    ref.setTagId(tagId);
                    ref.setCouponId(asCoupon.getCouponId());
                    ref.setCreateTime(DateUtil.getTime());
                    asCouponTagRefMapper.insertSelective(ref);
                }
            }

        }
        return r;
    }

    public List<AsBusinessDistrict> getBusinessDistricts() {
        return asBusinessDistrictMapper.queryList();
    }

    /**
     * 审核
     *
     * @param couponId
     * @return
     */
    public int review(int couponId) {
        AsCoupon asCoupon = new AsCoupon();
        asCoupon.setStatus(1);
        asCoupon.setCouponId(couponId);
        return asCouponMapper.updateByPrimaryKeySelective(asCoupon);
    }

    public int disable(int couponId, int shopId) {
        return asCouponMapper.disableByIdAndShopId(couponId, shopId);
    }

    public List<AsTag> queryTags(int couponId) {
        AsTag asTag = new AsTag();
        asTag.setType(2);
        List<AsTag> tags = asTagMapper.queryList(asTag);
        List<AsCouponTagRef> refs = asCouponTagRefMapper.selectByCouponId(couponId);
        for (AsCouponTagRef ref : refs) {
            for (AsTag tag : tags) {
                if (tag.getTagId().equals(ref.getTagId())) {
                    tag.setChecked(true);
                    continue;
                }
            }

        }

        return tags;
    }

    public int enable(int couponId, int parseInt) {
        return asCouponMapper.enableByIdAndShopId(couponId, parseInt);
    }

    public List<AsPrizeType> queryPrizeTypesLike(AsPrizeType asPrizeType) {
        return asPrizeTypeMapper.queryPrizeTypesLike(asPrizeType);
    }


    /**
     * #####################################优惠券 领取 兑换记录##########################################
     */

    private final static String BASEURL = "business/coupon/";

    @Autowired
    private AsActivityReceivedRecordMapper recordMapper;

    @Autowired
    private AsPrizeMapper asPrizeMapper;

    @Autowired
    private AsActivityReceivedRecordMapper asActivityReceivedRecordmapper;


    /**
     * 优惠券礼品领取记录列表
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object receivedHistory(BaseController c) {
        initialized(c);
        addField("shopId", getCurrentUser().getAs_shop_id());
        addField("activityType", 3);
        pageQueryModule(recordMapper, "listAll", true);
        return renderView(BASEURL + "listReceiveHistory");
    }

    /**
     * 优惠券礼品兑换领取记录列表
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object exchangeHistory(BaseController c) {
        initialized(c);
        addField("shopId", getCurrentUser().getAs_shop_id());
        addField("activityType", 3);
        pageQueryModule(recordMapper, "listAllExchage", true);
        return renderView(BASEURL + "listExchangeHistory");
    }

    /**
     * go兑换页面
     *
     * @param c
     * @return
     * @author chenwenzhu
     * @date 2017年2月18日
     */

    public Object receive(BaseController c) {
        return renderView(BASEURL + "receive");
    }

    /**
     * 进行兑换操作
     *
     * @return
     * @author chenwenzhu
     * @date 2017年2月21日
     */

    public int editReceive(String sn) {
        User user = new User();
        user = getUser();
        if (!getUser().getAs_shop_id().equals("null")) {// 获取商铺id如果不为null则是商场账号 ，反之则是后台管理员账号
            //判断优惠券是否有效
            AsPrize prize = asPrizeMapper.findBySn(sn.trim(),3);
            if (prize == null) {
                return 200;
            }
            String starttime=prize.getStartTime();
            String endtime=prize.getEndTime();
            if(starttime.isEmpty()){
                return  100;
            }else{
                //判断优惠券到开始时间
                long starTtime = DateUtil.parseDate(starttime).getTime();
                if (new Date().getTime() < starTtime) {
                    return 50;
                }
            }
            if(endtime.isEmpty()){
                return  100;
            }else{
                //判断优惠券是否过期
                long endTime = DateUtil.parseDate(endtime).getTime();
                if (new Date().getTime() > endTime) {
                    return 300;
                }
            }
            //判断是否属本店铺的优惠券
            String shopId = getUser().getAs_shop_id();
            if (!shopId.equals(new Integer(prize.getShopId()).toString())) {
                return 400;
            }
            //优惠券是否被使用
            int prizeId = prize.getPrizeId();
            //AsPrize prize = asPrizeMapper.selectByPrimaryKey(prizeId);
            if (prize.getStatus().equals(1)) {
                return 500;
            }
            AsActivityReceivedRecord record = new AsActivityReceivedRecord();
            record.setPrizeId(prizeId);
            record.setType(1);
            AsActivityReceivedRecord receivedRecord = asActivityReceivedRecordmapper.findByAttr(record);
            if (receivedRecord != null) {
                int result = asPrizeMapper.updateUsePrize(prizeId);
                if (result > 0) {
                        /*AsActivity activity = asActivityMapper.selectByStatusAndType(1, 2);
                        Assert.notNull(activity, "活动已结束");*/
                    AsActivityReceivedRecord r = new AsActivityReceivedRecord();
                    r.setUserId(receivedRecord.getUserId());
                    r.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                    r.setPrizeId(prizeId);
                    r.setType(2);
                    r.setStoreId(prize.getStoreId());
                    r.setShopId(prize.getShopId());
                    r.setStaffId(Integer.valueOf(user.getNewUserId()));
                    asActivityReceivedRecordmapper.insertSelective(r);
                }
                //领取成功
                return 700;
            } else {
                //尚未领取
                return 600;
            }
        }
        return 800;
    }


    /**
     * 获取后台用户
     *
     * @return
     */
    public User getCurrentUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        User user = (User) session.getAttribute(Const.SESSION_USER);
        return user;
    }


}
