package com.aoshi.service.manage.consultation.shop;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsConsultationFoodMapper;
import com.aoshi.dao.AsConsultationShopMapper;
import com.aoshi.dao.AsConsultationStreetFoodMapper;
import com.aoshi.domain.AsConsultationShop;
import com.aoshi.domain.AsConsultationStreetFood;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.DateUtil;
import com.aoshi.util.FtpConManager;
import com.aoshi.util.PropertyUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.codec.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/11/28.
 */

@Service
@Transactional
public class ConsultationShopService extends AsBaseService {
    @Autowired
    AsConsultationShopMapper asConsultationShopMapper;
    @Autowired
    AsConsultationFoodMapper asConsultationFoodMapper;
    @Autowired
    AsConsultationStreetFoodMapper asConsultationStreetFoodMapper;

    public List<AsConsultationShop> queryList(AsConsultationShop asConsultationShop){
        return asConsultationShopMapper.queryList(asConsultationShop);
    }

    public int offSale(AsConsultationShop asConsultationShop){
        return asConsultationShopMapper.updateByPrimaryKeySelective(asConsultationShop);
    }

    public int onSale(AsConsultationShop asConsultationShop){
        return asConsultationShopMapper.updateByPrimaryKeySelective(asConsultationShop);
    }

    public AsConsultationShop selectByPrimaryKey(Integer id){
        return asConsultationShopMapper.selectById(id);
    }

    public int deleteByPrimaryKey(Integer brandId){
        asConsultationStreetFoodMapper.deleteByConsultationShopId(brandId);
        asConsultationShopMapper.deleteByPrimaryKey(brandId);
        if(asConsultationShopMapper.deleteByPrimaryKey(brandId)==1 && asConsultationStreetFoodMapper.deleteByConsultationShopId(brandId)==1){
            return 1;
        }
        return 0;

    }

    public int deleteByIds(String []ids){
        asConsultationStreetFoodMapper.deleteByIds(ids);
        asConsultationShopMapper.deleteByIds(ids);
        if(asConsultationShopMapper.deleteByIds(ids)==1 && asConsultationStreetFoodMapper.deleteByIds(ids)==1){
            return 1;
        }
        return 0;
    }

    public int offSaleAll(String []ids){
        return asConsultationShopMapper.offSaleAll(ids);
    }

    public int save(AsConsultationShop asConsultationShop,BaseController c,String []shopFoodNameAll,List<String> stringList,String type) {
        initialized(c);
        String coverImg = pd.getStringRequired("img");

        ValidatorBreakException.NOT_TRUE(!(coverImg == null || coverImg
                .trim().length() == 0 ||"".equals(coverImg)), "请上传封面图片");
        String bannerImg = pd.getStringRequired("img2");
        ValidatorBreakException.NOT_TRUE(!(bannerImg == null || bannerImg
                .trim().length() == 0 ||"".equals(bannerImg)), "请上传banner图片");
        uploadModule(UploadPathEnum.BRAND, "img");
        uploadModule2(UploadPathEnum.BRAND, "img2");
        for(int i=0;i<stringList.size();i++){
            newUploadModule(UploadPathEnum.BRAND, stringList);
        }
        String coverImgUrl = pd.getStringRequired("img");
        String bannerImgUrl = pd.getStringRequired("img2");
        asConsultationShop.setCoverImg(coverImgUrl);
        asConsultationShop.setBannerImg(bannerImgUrl);
        asConsultationShop.setCreateTime(DateUtil.getTime());
        asConsultationShop.setMotifyTime(DateUtil.getTime());
        asConsultationShop.setVisitCount(0);
        if("1".equals(type)){
            asConsultationShop.setStatus(1);
        }else if("2".equals(type)){
            asConsultationShop.setStatus(2);
        }

        int flag=asConsultationShopMapper.insertSelective(asConsultationShop);
            for(int j=0;j<shopFoodNameAll.length;j++){
                AsConsultationStreetFood asConsultationStreetFood = new AsConsultationStreetFood();
                asConsultationStreetFood.setFoodImg(pd.getStringRequired(stringList.get(j)));
                asConsultationStreetFood.setFoodName(shopFoodNameAll[j]);
                asConsultationStreetFood.setFoodContent("");
                asConsultationStreetFood.setConsultationShopId(asConsultationShop.getConsultationShopId());
                asConsultationStreetFoodMapper.insertSelective(asConsultationStreetFood);
            }
        return flag;
    }

    public int update(BaseController c,AsConsultationShop asConsultationShop,String [] hastitle,String[]hasUrl) {
        AsConsultationShop nasConsultationShop =asConsultationShopMapper.selectByPrimaryKey(asConsultationShop.getConsultationShopId());
        if(hasUrl.length==2){//不变
            asConsultationShop.setCoverImg(hastitle[0]);
            asConsultationShop.setBannerImg(hastitle[1]);
        }else if(hasUrl.length==4){
            initialized(c);
            String coverImg = pd.getStringRequired("img");
            ValidatorBreakException.NOT_TRUE(!(coverImg == null || coverImg
                    .trim().length() == 0 ||"".equals(coverImg)), "请上传封面图片");
            String bannerImg = pd.getStringRequired("img2");
            ValidatorBreakException.NOT_TRUE(!(bannerImg == null || bannerImg
                    .trim().length() == 0 ||"".equals(bannerImg)), "请上传banner图片");
            uploadModule(UploadPathEnum.BRAND, "img");
            uploadModule2(UploadPathEnum.BRAND, "img2");
            String coverImgUrl = pd.getStringRequired("img");
            String bannerImgUrl = pd.getStringRequired("img2");
            asConsultationShop.setCoverImg(coverImgUrl);
            asConsultationShop.setBannerImg(bannerImgUrl);
        }else if(hasUrl.length==3){
            if(hasUrl[2].contains("ascmMall")){
                //下不变
                initialized(c);
                String coverImg = pd.getStringRequired("img");
                ValidatorBreakException.NOT_TRUE(!(coverImg == null || coverImg
                        .trim().length() == 0 ||"".equals(coverImg)), "请上传封面图片");
                uploadModule(UploadPathEnum.BRAND, "img");
                String coverImgUrl = pd.getStringRequired("img");
                asConsultationShop.setCoverImg(coverImgUrl);
                asConsultationShop.setBannerImg(hastitle[1]);
            }else {
                initialized(c);
                String bannerImg = pd.getStringRequired("img2");
                ValidatorBreakException.NOT_TRUE(!(bannerImg == null || bannerImg
                        .trim().length() == 0 ||"".equals(bannerImg)), "请上传banner图片");
                uploadModule2(UploadPathEnum.BRAND, "img2");
                String bannerImgUrl = pd.getStringRequired("img2");
                asConsultationShop.setCoverImg(hastitle[0]);
                asConsultationShop.setBannerImg(bannerImgUrl);
            }
        }
        asConsultationShop.setMotifyTime(DateUtil.getTime());
        return  asConsultationShopMapper.updateByPrimaryKeySelective(asConsultationShop);
    }

    private void uploadModule2(UploadPathEnum uploadPathEnum,
                                String... colNames) {

        for (String colName : colNames) {
            Map<String, Object> picMap = new HashMap<String, Object>();
            if (StringUtils.isNotBlank(req.getParameter("img2"))) {
                String arr[] = String.valueOf(pd.get("img2")).split(",");
                byte[] bytes = Base64.decode(arr[1]);
                String ftpDir = uploadPathEnum.getRootPath()
                        + uploadPathEnum.getPath();
                String ftpFile = c.get32UUID() + ".jpg";
                picMap.put("is", new ByteArrayInputStream(bytes));
                picMap.put("ftpDir", ftpDir);
                picMap.put("ftpFile", ftpFile);
                pd.put(colName,
                        uploadPathEnum.getPath() + "/"
                                + picMap.get("ftpFile"));
            }

            if (picMap.size() > 0) {
                FtpConManager ftpConManager = FtpConManager.getInstance();
                try {
                    ftpConManager.login(PropertyUtils.getFTP_URL(),
                            PropertyUtils.getFTP_USERNAME(),
                            PropertyUtils.getFTP_PASS());

                    InputStream is = (ByteArrayInputStream) picMap.get("is");
                    String ftpDir = (String) picMap.get("ftpDir");
                    String ftpFile = (String) picMap.get("ftpFile");
                    boolean flag = ftpConManager.uploadFileByInputStream(is,
                            ftpDir, ftpFile);
                    if (!flag) {
                        logger.debug("upload failed");
                    }

                    String uploadLogStr = "图片上传 : 字段[%s] 与 [%s] 已绑定 ";
                    logger.debug(String.format(
                            uploadLogStr,
                            colName,
                            picMap.get("ftpDir") + "/"
                                    + picMap.get("ftpFile")));

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    ftpConManager.closeCon();
                }
            }
        }
    }

    private void newUploadModule(UploadPathEnum uploadPathEnum,
                                List<String> list) {

        for (int i=0;i<list.size();i++) {
            Map<String, Object> picMap = new HashMap<String, Object>();
            if (StringUtils.isNotBlank(list.get(i))) {
                String arr[] = String.valueOf(list.get(i)).split(",");
                byte[] bytes = Base64.decode(arr[1]);
                String ftpDir = uploadPathEnum.getRootPath()
                        + uploadPathEnum.getPath();
                String ftpFile = c.get32UUID() + ".jpg";
                picMap.put("is", new ByteArrayInputStream(bytes));
                picMap.put("ftpDir", ftpDir);
                picMap.put("ftpFile", ftpFile);
                pd.put(list.get(i),
                        uploadPathEnum.getPath() + "/"
                                + picMap.get("ftpFile"));
            }

            if (picMap.size() > 0) {
                FtpConManager ftpConManager = FtpConManager.getInstance();
                try {
                    ftpConManager.login(PropertyUtils.getFTP_URL(),
                            PropertyUtils.getFTP_USERNAME(),
                            PropertyUtils.getFTP_PASS());

                    InputStream is = (ByteArrayInputStream) picMap.get("is");
                    String ftpDir = (String) picMap.get("ftpDir");
                    String ftpFile = (String) picMap.get("ftpFile");
                    boolean flag = ftpConManager.uploadFileByInputStream(is,
                            ftpDir, ftpFile);
                    if (!flag) {
                        logger.debug("upload failed");
                    }

                    String uploadLogStr = "图片上传 : 字段[%s] 与 [%s] 已绑定 ";
                    logger.debug(String.format(
                            uploadLogStr,
                            list.get(i),
                            picMap.get("ftpDir") + "/"
                                    + picMap.get("ftpFile")));

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    ftpConManager.closeCon();
                }
            }
        }
    }
}
