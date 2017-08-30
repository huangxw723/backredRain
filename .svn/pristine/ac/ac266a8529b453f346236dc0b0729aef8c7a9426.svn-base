package com.aoshi.controller.manage.consultation.shop;

import com.aoshi.common.asenum.UploadPathEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsConsultationShop;
import com.aoshi.domain.AsConsultationStreetFood;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.entity.Page;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.manage.consultation.StreetFood.ConsultationStreetFoodService;
import com.aoshi.service.manage.consultation.brand.BrandCategoryService;
import com.aoshi.service.manage.consultation.shop.ConsultationShopService;
import com.aoshi.service.manage.locality.AsAreaService;
import com.aoshi.service.manage.locality.AsBusinessDistrictService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.aoshi.util.*;
import com.github.pagehelper.PageHelper;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/11/28.
 */
@Controller
@RequestMapping("consultation/shop")
public class ConsultationShopController extends BaseController{
    private static final String BASEURL="consultation/shop/";
    private static final String BASEURL2="consultation/streetFood/";
    @Autowired
    private ConsultationShopService consultationShopService;
    @Autowired
    private AsBusinessDistrictService asBusinessDistrictService;
    @Autowired
    private BrandCategoryService brandCategoryService;
    @Autowired
    private AsProvinceService asProvinceService;
    @Autowired
    private AsCityService asCityService;
    @Autowired
    private AsAreaService asAreaService;
    @Autowired
    private ConsultationStreetFoodService consultationStreetFoodService;

    /**
     * 美食街列表
     * @param map
     * @return
     */
    @RequestMapping("shopList")
    public String shopList(ModelMap map, Page page,
                          @RequestParam(value="keyWord",required=false)String keyWord,AsConsultationShop asConsultationShop){
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        PageHelper.startPage(pageNum, pageSize);
        if(!StringUtils.isEmpty(keyWord)){
            asConsultationShop.setShopName(keyWord);
        }
        List<AsConsultationShop> list = consultationShopService.queryList(asConsultationShop);
        page.setPage(list);
        PageData pd = this.getPageData();
        map.put("ypBaseCategoryList",brandCategoryService.getDishesListShow());//品类
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("keyWord", keyWord);
        map.put("pd", pd);
        map.put("list", list);
        return BASEURL+"shopList";
    }


    /**
     * 下架
     */
    @RequestMapping(value = "/offSale")
    @ResponseBody
    public int offSale(Integer id) {
        AsConsultationShop asConsultationShop =consultationShopService.selectByPrimaryKey(id);
        asConsultationShop.setStatus(3);
        return consultationShopService.offSale(asConsultationShop);
    }

    /**
     * 批量下架
     */
    @RequestMapping(value = "/offSaleAll")
    @ResponseBody
    public int offSaleAll(String []ids) {
        return consultationShopService.offSaleAll(ids);
    }

    /**
     * 发布
     */
    @RequestMapping(value = "/onSale")
    @ResponseBody
    public int onSale(Integer id) {
        AsConsultationShop asConsultationShop =consultationShopService.selectByPrimaryKey(id);
        asConsultationShop.setStatus(2);
        asConsultationShop.setCreateTime(DateUtil.getTime());
        return consultationShopService.onSale(asConsultationShop);
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/deleteFoodById")
    @ResponseBody
    public int deleteFoodById(Integer brandId) {
        return consultationShopService.deleteByPrimaryKey(brandId);
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll(String []ids) {
        return consultationShopService.deleteByIds(ids);
    }


    /**
     * 去增页面
     * @param map
     * @return
     */
    @RequestMapping(value="toAdd")
    public String toAdd(ModelMap map){
        List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getDishesListShow();
        List<AsYpBaseCategory> shopYpBaseCategoryList = brandCategoryService.getshopCategoriesShow();
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("ypBaseCategoryList", ypBaseCategoryList);
        map.put("shopYpBaseCategoryList", shopYpBaseCategoryList);
        return BASEURL+"addShop";
    }

    /**
     * 新增
     * @param asConsultationShop
     * @return
     */
    @RequestMapping("addFood")
    @ResponseBody
    public Map<String, Object> addFood(AsConsultationShop asConsultationShop,String []shopFoodNameAll,String[] imgNewAdurls,String type){
        ValidatorBreakException.NOT_TRUE(!(imgNewAdurls == null || imgNewAdurls.length==0 ||"".equals(imgNewAdurls)), "请点击“选择文件”，上传菜式图！");
        ValidatorBreakException.NOT_TRUE(!(shopFoodNameAll == null || shopFoodNameAll.length==0 ||"".equals(shopFoodNameAll)), "请填写菜名！");
        for(int i=0;i<shopFoodNameAll.length;i++){
            ValidatorBreakException.NOT_TRUE(!(shopFoodNameAll[i] == null  ||"".equals(shopFoodNameAll[i])), "请填写菜名");
        }
        List<String> stringList = new ArrayList<String>();
        String url="";
        for(int i=0;i<imgNewAdurls.length;i=i+2){
            url =imgNewAdurls[i]+","+imgNewAdurls[i+1];
            stringList.add(url);
        }
        asConsultationShop.setShopTypeYpBaseCategoryId(0);// TODO: 字段弃用
        int result = consultationShopService.save(asConsultationShop,this,shopFoodNameAll,stringList,type);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 编辑页面
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toEdit")
    public String toEdit(Integer id,ModelMap map,String action){
        AsConsultationShop asConsultationShop = consultationShopService.selectByPrimaryKey(id);
        List<AsConsultationStreetFood> asConsultationStreetFoodList = consultationStreetFoodService.findByShopId(id);
        List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getDishesListShow();
        List<AsYpBaseCategory> shopYpBaseCategoryList = brandCategoryService.getshopCategoriesShow();
        map.put("shopYpBaseCategoryList", shopYpBaseCategoryList);
        map.put("ypBaseCategoryList", ypBaseCategoryList);
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("asConsultationShop", asConsultationShop);
        map.put("asConsultationStreetFoodList", asConsultationStreetFoodList);
        map.put("action", action);
        map.put("latlng",asConsultationShop.getLat()+","+asConsultationShop.getLng());//经纬度
        return BASEURL+"editShop";
    }

    /**
     * 编辑菜式页面
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toEditMeal")
    public String toEditMeal(Integer id,ModelMap map){
        List<AsConsultationStreetFood> asConsultationStreetFoodList = consultationStreetFoodService.findByShopId(id);
        map.put("list", asConsultationStreetFoodList);
        map.put("consultationShopId", id);
        return BASEURL2+"mealList";
    }

    /**
     * 更新
     * @param asConsultationShop
     * @return
     */
    @RequestMapping("updateFood")
    @ResponseBody
    public Map updateFood(AsConsultationShop asConsultationShop ,String[]hasUrl,String [] hastitle){
       int result = consultationShopService.update(this,asConsultationShop,hastitle,hasUrl);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 预览页面
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("toPreview")
    public String toPreview(Integer id,ModelMap map,String action){
        AsConsultationShop asConsultationShop = consultationShopService.selectByPrimaryKey(id);
        AsYpBaseCategory asYpBaseCategory =brandCategoryService.selectByPrimaryKey(asConsultationShop.getShopTypeYpBaseCategoryId());
        List<AsConsultationStreetFood> asConsultationStreetFoodList = consultationStreetFoodService.findByShopId(id);
        List<AsYpBaseCategory> ypBaseCategoryList = brandCategoryService.getfoodCategoriesShow();
        map.put("ypBaseCategoryList", ypBaseCategoryList);
        map.put("provinceList", asProvinceService.list(null));//省
        map.put("cityList", JSONArray.fromObject(asCityService.list(null)));//市
        map.put("areaList", JSONArray.fromObject(asAreaService.list(null)));//区域
        map.put("districtList", JSONArray.fromObject(asBusinessDistrictService.list(null)));//商圈
        map.put("asConsultationShop", asConsultationShop);
        map.put("asConsultationStreetFoodList", asConsultationStreetFoodList);
        map.put("action", action);
        map.put("latlng",asConsultationShop.getLat()+","+asConsultationShop.getLng());//经纬度
        if(asYpBaseCategory!=null){
            map.put("shopTypeName", asYpBaseCategory.getName());
        }
        return BASEURL+"preview";
    }

    /**
     * 转换图片
     */
    @RequestMapping(value = "/convertImg")
    public void convertImg(
            @RequestParam(value = "upload", required = false) MultipartFile file,
            HttpServletResponse response) {
        logBefore(logger, "上传图片");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            String fileName = file.getOriginalFilename();
            String callback = pd.getString("CKEditorFuncNum");
            String imgUrl = "";
            String message = "";
            if (org.apache.commons.lang.StringUtils.endsWithIgnoreCase(fileName, ".jpg")
                    || org.apache.commons.lang.StringUtils.endsWithIgnoreCase(fileName, ".jpeg")
                    || org.apache.commons.lang.StringUtils.endsWithIgnoreCase(fileName, ".png")) {
                byte[] bytes = file.getBytes();
                BufferedImage img = ImageIO
                        .read(new ByteArrayInputStream(bytes));
                if (img.getHeight() > 1024 || img.getWidth() > 1024) {
                    message = "图片尺寸超过限制（1024 × 1024）";
                } else if (file.getSize() > 1024 * 1024 * 2) {
                    message = "图片大小超过限制（2MB）";
                } else {
                    int width = img.getWidth();
                    int height = img.getHeight();
                    BufferedImage image = new BufferedImage(width, height,
                            BufferedImage.TYPE_INT_RGB);
                    Graphics g = image.createGraphics();
                    g.drawImage(img, 0, 0, width, height, null);
                    g.dispose();
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    ImageIO.write(image,
                            fileName.substring(fileName.indexOf(".") + 1), baos);
                    byte[] afterBytes = baos.toByteArray();
                    String ftpDir = UploadPathEnum.USERS.getPath();
                    String ftpFile = this.get32UUID() + ".jpg";
                    FtpConManager ftpConManager = FtpConManager.getInstance();
                    ftpConManager.login(PropertyUtils.getFTP_URL(),
                            PropertyUtils.getFTP_USERNAME(),
                            PropertyUtils.getFTP_PASS());
					/*
					 * ftpConManager.uploadFileByInputStream( new
					 * ByteArrayInputStream(afterBytes), Const.FILEPATHIMGDIR +
					 * ftpDir, ftpFile);
					 */
                    ftpConManager.uploadFileByInputStream(
                            file.getInputStream(),
                            Const.FILEPATHIMGDIR + ftpDir, ftpFile);
                    imgUrl = PropertyUtils.getHTTP_URL() + ftpDir + "/"
                            + ftpFile;
                }
            } else {
                message = "文件格式不正确（必须为.jpg|.jpeg|.png文件）";
            }
            out.println("<script type='text/javascript'>");
            out.println("window.parent.CKEDITOR.tools.callFunction(" + callback
                    + ",'" + imgUrl + "','" + message + "')");
            out.println("</script>");
            out.flush();
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            if (out != null) {
                out.close();
            }
        }
    }
}
