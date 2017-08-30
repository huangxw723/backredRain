package com.aoshi.service.manage;

import com.aoshi.common.asenum.CommonStr;
import com.aoshi.common.asenum.DictParam;
import com.aoshi.common.asenum.OperaEnum;
import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsActivityAdMapper;
import com.aoshi.dao.AsActivityMapper;
import com.aoshi.dao.AsDictParamMapper;
import com.aoshi.domain.AsActivity;
import com.aoshi.domain.AsActivityAd;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

/**
 * 全局广告操作 Service
 *
 * @author huangxw
 * @date 2016年9月2日
 */
@Service
public class ActivityAdService extends AsBaseService {

    private final static String PAGE_PATH = "manage/activityAd/";

    @Autowired
    private AsActivityAdMapper asActivityAdMapper;

    @Autowired
    private AsDictParamMapper asDictParamMapper;

    @Autowired
    private AsActivityMapper asActivityMapper;


    /**
     * 广告查询
     *
     * @author haungxw
     * @date 2016年9月2日
     */
    public Object page(BaseController c) {

        initialized(c);
        String adPosType = pd.getStringRequired("adPosType");
        OperaEnum action = OperaEnum.get(pd.getIntRequired("action"));
        switch (action) {

            case ADD:

                addViewData("asActivity", asActivityMapper.getCurrentActivity(null));
                break;

            case EDIT:

                int adId = pd.getIntRequired("adId");
                addField("adId", adId);
                int otype = pd.getInt("otype");
                AsActivityAd asAd = asActivityAdMapper.getActivityAdDataInfo(pd);
               /* if (adPosType.equals("6")) {
                    Long timeDiff = CommonUtils.orderTimeDiff(
                            CommonUtils.getTimeMils(asAd.getAdEndTime()),
                            CommonUtils.getTimeMils(DateUtil.getTime()));
                    if (timeDiff == 0) {
                        addViewData("status", 3);
                    }
                }*/

                addViewData("pd", asAd);
                addViewData("otype", otype);
                addViewData("asActivity", asActivityMapper.getAsActivity(asAd.getRefId()));
                break;

            case QUERY:
                adId = pd.getIntRequired("adId");
                addField("adId", adId);
                asAd = asActivityAdMapper.getActivityAdDataInfo(pd);
                ValidatorBreakException.NOT_NULL(asAd, 1001, "系统繁忙", 1);
                addViewData("pd", asAd);
                addViewData("asActivity", asActivityMapper.getAsActivity(asAd.getRefId()));
                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }
        addViewData("adTypes", JSONArray.fromObject(asDictParamMapper.findByKeyCode(DictParam.PARAM_ACTIVITYADTYPECODE_ID)));
        addViewData("action", action.getId());
        addViewData("adPosType", adPosType);

        //adPosType 1 E街E铺 2云屏红包雨  3积分商城  4弹窗 5悬浮 9(同时查询4和5类型的广告) 6(云屏logo)  7(云屏转盘)
        //adPosType是9时查询4(弹窗)和5(悬浮)类型的广告。adPosType是10时查询2(云屏红包雨)和6(云屏logo)和7(云屏转盘)类型的广告。
        if (adPosType.equals("1") || adPosType.equals("3")) {
            return renderView(PAGE_PATH + "save");
        } else if (adPosType.equals("10") || adPosType.equals("2") || adPosType.equals("6") || adPosType.equals("7")) {
            String adUrlType = pd.getStringRequired("adUrlType");
            addViewData("adUrlType", adUrlType);
            return renderView(PAGE_PATH + "save2");
        } else if (adPosType.equals("9") || adPosType.equals("4") || adPosType.equals("5")) {
            return renderView(PAGE_PATH + "save3");
        }
        return null;

    }

    /**
     * 广告增删改操作
     *
     * @return
     * @author haungxw yangyanchao
     * @date 2016年9月2日
     */
    public Object opera(BaseController c) {

        initialized(c);

        OperaEnum action = OperaEnum.get(pd.getParaForInteger("action"));

        switch (action) {

            case ADD:

                String name = pd.getStringRequired("adName");
                String adPosType = pd.getStringRequired("adPosType");
                int refId = pd.get("refId") == null ? 0 : pd.getParaForPositiveInteger("refId");
                if (adPosType.equals("4")) {
                    int isExist = asActivityAdMapper.getAdPosTypeRefId(4, refId);
                    if (isExist == 1) {
                        ValidatorBreakException.NOT_TRUE(false, "当前红包雨活动已有发布中的弹窗广告！");
                    }
                }
                if (adPosType.equals("5")) {
                    int isExist = asActivityAdMapper.getAdPosTypeRefId(5, refId);
                    if (isExist == 1) {
                        ValidatorBreakException.NOT_TRUE(false, "当前红包雨活动已有发布中的悬浮广告！");
                    }
                }

                //判断大转盘logo广告只能有一条
                if (adPosType.equals("6")) {
                    int isExist = asActivityAdMapper.getAdPosType(6);
                    if (isExist >= 1) {
                        ValidatorBreakException.NOT_TRUE(false, "已经存在大转盘-logo类型的广告！");
                    }
                }
                //判断大转盘首页广告只能有一条
                if (adPosType.equals("7")) {
                    int isExist = asActivityAdMapper.getAdPosType(7);
                    if (isExist >= 1) {
                        ValidatorBreakException.NOT_TRUE(false, "已经存在大转盘-首页类型的广告！");
                    }
                }
                String adUrlType = pd.getStringRequired("adUrlType");
                String adUrl = pd.getStringRequired("adUrl");
                String img = req.getParameter("img");
                String startTime = pd.getParaForString("adStartTime");
                String endTime = pd.getParaForString("adEndTime");
                String adImg = img == null ? "" : img;
                ValidatorBreakException.NOT_TRUE(!(adImg.trim().length() == 0 || "".equals(adImg)), "请上传广告图片");

                String msg = CheckFile(Integer.parseInt(adUrlType), Integer.parseInt(adPosType));
                ValidatorBreakException.NOT_TRUE(StringUtils.isEmpty(msg), msg);

                uploadModule(UploadPathEnum.ACTIVITY, "img");
                adImg = pd.getStringRequired("img");
                String desc = pd.getStringRequired("adDesc");


                // 添加广告配置
                AsActivityAd asactivityad = new AsActivityAd();
                asactivityad.setAdName(name);
                asactivityad.setAdType(1);
                asactivityad.setAdUrlType(Integer.parseInt(adUrlType));
                asactivityad.setAdPosType(Integer.parseInt(adPosType));
                asactivityad.setAdUrl(adUrl);
                asactivityad.setAdStartTime(startTime);
                asactivityad.setAdEndTime(endTime);
                asactivityad.setAdImg(adImg);
                asactivityad.setAdDesc(desc);
                asactivityad.setStatus(1);
                asactivityad.setRefId(refId);
                String code = UUID.randomUUID().toString().replaceAll("-", "");
                asactivityad.setAdSn(code);
                operaFlag = asActivityAdMapper.insertSelective(asactivityad) == 1;
                ValidatorBreakException.NOT_TRUE(operaFlag);

                break;

            case EDIT:

                String ename = pd.getStringRequired("adName");
                int adId = pd.getIntRequired("adId");
                String adPosTypes = pd.getString("adPosType");

                String aurl = pd.getStringRequired("adUrl");
                String aType = pd.getStringRequired("adUrlType");
                String estartTime = pd.getStringRequired("adStartTime");
                String eendTime = pd.getStringRequired("adEndTime");

                msg = CheckFile(Integer.parseInt(aType), Integer.parseInt(adPosTypes));
                ValidatorBreakException.NOT_TRUE(StringUtils.isEmpty(msg), msg);
                uploadModule(UploadPathEnum.ACTIVITY, "adImg");

                String eadImg = pd.getString("adImg");
                String edesc = pd.getStringRequired("adDesc");
                String esn = pd.getStringRequired("adSn");
                refId = pd.get("refId") == null ? 0 : pd.getParaForPositiveInteger("refId");

                // 添加广告配置
                AsActivityAd easactivityad = new AsActivityAd();
                easactivityad.setAdId(adId);
                easactivityad.setAdName(ename);
                easactivityad.setAdUrl(aurl);
                easactivityad.setAdUrlType(Integer.parseInt(aType));
                easactivityad.setAdType(1);
                easactivityad.setAdPosType(Integer.parseInt(adPosTypes));
                easactivityad.setAdStartTime(estartTime);
                easactivityad.setAdEndTime(eendTime);
                easactivityad.setAdImg(eadImg);
                easactivityad.setAdDesc(edesc);
                easactivityad.setAdSn(esn);
                easactivityad.setRefId(refId);
                operaFlag = asActivityAdMapper.updateByPrimaryKeySelective(easactivityad) == 1;

                break;

            default:
                ValidatorBreakException.NOT_TRUE(false);
        }

        addViewData("action", action.getId());
        addViewData("otype", pd.getIntRequired("action"));
        return renderSuccess();

    }


    /**
     * 删除广告
     *
     * @return
     * @author haungxw
     * @date 2016年9月5日
     */
    public Object delete(BaseController c) {

        initialized(c);

        operaFlag = asActivityAdMapper.deleteByPrimaryKey(pd) == 1;
        ValidatorBreakException.NOT_TRUE(operaFlag);

        return renderSuccess();
    }

    /**
     * 更新广告使用状态
     *
     * @return
     * @author haungxw
     * @date 2016年9月5日
     */
    public Object accountStatus_Tx(BaseController c) {

        initialized(c);

        operaFlag = asActivityAdMapper.updateByPrimaryKeySelective(pd) == 1;
        ValidatorBreakException.NOT_TRUE(operaFlag, "数据已过期，请刷新后重试");

        return renderSuccess();
    }

    /**
     * 广告列表
     *
     * @return
     * @author haungxw
     * @date 2016年9月3日
     */
    public Object listAll(BaseController c) {

        initialized(c);
        String adPosType = pd.getStringRequired("adPosType");
        List<?> resultMap = pageQueryModule(asActivityAdMapper, "listAll", true);

        addViewData("adList", resultMap);
        addViewData("adPosType", adPosType);
        //adPosType 1 E街E铺 2云屏红包雨  3积分商城  4弹窗 5悬浮 9(同时查询4和5类型的广告) 6(云屏logo)  7(云屏转盘)
        //adPosType是9时查询4(弹窗)和5(悬浮)类型的广告。adPosType是10时查询2(云屏红包雨)和6(云屏logo)和7(云屏转盘)类型的广告。
        if (adPosType.equals("1") || adPosType.equals("3")) {
            return renderView(PAGE_PATH + "adList");
        } else if (adPosType.equals("10") || adPosType.equals("2") || adPosType.equals("6") || adPosType.equals("7")) {
            String adUrlType = pd.getStringRequired("adUrlType");
            addViewData("adUrlType", adUrlType);
            return renderView(PAGE_PATH + "adList2");
        } else if (adPosType.equals("9") || adPosType.equals("4") || adPosType.equals("5")) {
            addViewData("adPosType", adPosType);
            return renderView(PAGE_PATH + "adList3");
        }
        return null;
    }

    public String CheckFile(Integer adUrlType, Integer adPosType) {
        String msg = "";
        if (StringUtils.isNotBlank(req.getParameter("img"))) {
            String arr[] = String.valueOf(pd.get("img")).split(",");
            byte[] bytes = Base64.decode(arr[1]);
            BufferedImage buffImage;
            try {
                InputStream io = new ByteArrayInputStream(bytes);
                buffImage = javax.imageio.ImageIO.read(io);
                if (adUrlType == 0) {
                    if (adPosType == 4) {
                        if (buffImage.getWidth() > CommonStr.FLIP_IMG_WIDTH || buffImage.getHeight() > CommonStr.FLIP_IMG_HEIGHT
                                && (adUrlType == 0)) {
                            msg = "图片尺寸大小超过限制！请上传" + CommonStr.FLIP_IMG_WIDTH + "px" + "*" + CommonStr.FLIP_IMG_HEIGHT + "px 的图片!";
                        }
                    } else if (adPosType == 5) {
                        if (buffImage.getWidth() > CommonStr.SUSPEND_IMG_WIDTH || buffImage.getHeight() > CommonStr.SUSPEND_IMG_HEIGHT
                                && (adUrlType == 0)) {
                            msg = "图片尺寸大小超过限制！请上传" + CommonStr.SUSPEND_IMG_WIDTH + "px" + "*" + CommonStr.SUSPEND_IMG_HEIGHT + "px 的图片!";
                        }
                    } else {
                        if (buffImage.getWidth() > CommonStr.IMG_WIDTH || buffImage.getHeight() > CommonStr.IMG_HEIGHT
                                && (adUrlType == 0)) {
                            msg = "图片尺寸大小超过限制！请上传" + CommonStr.IMG_WIDTH + "px" + "*" + CommonStr.IMG_HEIGHT + "px 的图片!";
                        }
                    }
                }

                if (adUrlType == 1) {
                    if (adPosType == 2) {
                        if (buffImage.getWidth() > CommonStr.IMG_YP_WIDTH || buffImage.getHeight() > CommonStr.IMG_YP_HEIGHT) {
                            msg = "图片尺寸大小超过限制！请上传" + CommonStr.IMG_YP_WIDTH + "px" + "*" + CommonStr.IMG_YP_HEIGHT + "px 的图片!";
                        }
                    } else if (adPosType == 6) {
                        if (buffImage.getWidth() > CommonStr.IMG_YP_LOGO_WIDTH || buffImage.getHeight() > CommonStr.IMG_YP_LOGO_HEIGHT) {
                            msg = "图片尺寸大小超过限制！请上传" + CommonStr.IMG_YP_LOGO_WIDTH + "px" + "*" + CommonStr.IMG_YP_LOGO_HEIGHT + "px 的图片!";
                        }
                    } else if (adPosType == 7) {
                        if (buffImage.getWidth() > CommonStr.IMG_YP_HOME_WIDTH || buffImage.getHeight() > CommonStr.IMG_YP_HOME_HEIGHT) {
                            msg = "图片尺寸大小超过限制！请上传" + CommonStr.IMG_YP_HOME_WIDTH + "px" + "*" + CommonStr.IMG_YP_HOME_HEIGHT + "px 的图片!";
                        }
                    }

                }
                buffImage = javax.imageio.ImageIO.read(io);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return msg;
    }

    public Object CheckPointActivityCount(Integer type) {

        Integer PointActivityNumber = asActivityAdMapper.getPointActivityCount(type);
        if (6 <= PointActivityNumber) {
            ValidatorBreakException.NOT_TRUE(false, "积分商城广告图不能超过6张");
        }
        return renderSuccess();
    }

    /**
     * E街E铺-活动 获取当前进行中的红包雨活动
     *
     * @return
     * @author yangyanchao
     * @date 2017-03-06
     */
    public List<AsActivity> getCurrentActivity() {
        return asActivityMapper.getCurrentActivity(null);
    }
}
