package com.aoshi.controller.manage;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsAttrType;
import com.aoshi.domain.AsAttribute;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.AsAttrTypeService;
import com.aoshi.service.manage.AsAttributeService;
import com.aoshi.util.AppUtil;
import com.aoshi.util.Const;
import com.aoshi.util.Jurisdiction;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AttributeController
 * <p>
 * 商品属性类型表管理 (add、del、edit、cha)
 *
 * @author hxw
 * @date 16/6/28
 */
@Controller
@RequestMapping(value = "/attrType")
public class AttrTypeController extends BaseController {

    String menuUrl = "attrType/TypeList.do"; // 菜单地址(权限用)

    @Autowired
    private AsAttrTypeService attrTypeService;

    @Autowired
    private AsAttributeService attributeService;


    /**
     * 商品属性和类型总页面
     */
    @RequestMapping(value = "/TypeList")
    public ModelAndView TypeList() {
        logBefore(logger, "去查看地点页面");
        ModelAndView mv = this.getModelAndView();
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return mv;
        } // 校验权限
        mv.setViewName("manage/attrType/TypeList");
        return mv;
    }


    /**
     * 商品类型列表页面
     */
    @RequestMapping(value = "/attrTypeList")
    public ModelAndView attrTypeList(Page page, String keyword) {
        logBefore(logger, "列表attrTypeList");
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("manage/attrType/attrTypeList");
        PageData pd = this.getPageData();
        try {
            page.setPd(pd);
            PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
            List<AsAttrType> AsAttrType = attrTypeService.list(pd);
            PageInfo<AsAttrType> pageInfo = new PageInfo<AsAttrType>(AsAttrType);
            page.setEntityOrField(true);
            page.setTotalResult((int) pageInfo.getTotal());
            mv.addObject("AsAttrTypeList", AsAttrType);
            mv.addObject("pd", pd);
            mv.addObject("keyword", keyword);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 商品属性列表页面
     */
    @RequestMapping(value = "/attrButeList")
    public ModelAndView buteList(Page page, String keyword) {
        logBefore(logger, "列表attributekList");
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("manage/attrType/attriButeList");
        PageData pd = this.getPageData();
        try {
            page.setPd(pd);
            PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
            List<AsAttribute> AsAttribute = attributeService.list(pd);
            PageInfo<AsAttribute> pageInfo = new PageInfo<AsAttribute>(AsAttribute);
            page.setEntityOrField(true);
            page.setTotalResult((int) pageInfo.getTotal());
            mv.addObject("attrTypeList", attrTypeService.list(null));
            mv.addObject("attributeList", AsAttribute);
            mv.addObject("pd", pd);
            mv.addObject("keyword", keyword);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }


    /**
     * 新增商品类型页面
     */
    @RequestMapping(value = "/goAddAttrType")
    public ModelAndView goAddGoodsActivity(AsAttrType attrType) {
        logBefore(logger, "去修改goAddAttrType页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        pd.put("id", "goAddAttrType");
        try {
            mv.setViewName("manage/attrType/attrTypeEdit");
            mv.addObject("msg", "saveAttrType");
            mv.addObject("id", "goAddAttrType");
            mv.addObject("attrType", attrType);
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 修改商品类型页面
     */
    @RequestMapping(value = "/goEditAttrType")
    public ModelAndView goEditAttrType(AsAttrType attrType) {
        logBefore(logger, "去修改goEditAttrType页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        try {

            attrType = attrTypeService.findById(attrType); // 根据ID读取
            mv.addObject("attrType", attrType);
            pd.put("id", "editAttrType");
            mv.addObject("pd", pd);
            mv.setViewName("manage/attrType/attrTypeEdit");
            mv.addObject("msg", "saveAttrType");
            mv.addObject("attrType", attrType);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }


    /**
     * 保存商品类型
     */
    @RequestMapping(value = "/saveAttrType")
    public ModelAndView saveAttrType(AsAttrType attr) {
        logBefore(logger, "新增saveAttribute");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        }
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        try {

            attrTypeService.save(attr);

        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.addObject("id", pd.get("id"));
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 新增属性页面
     */
    @RequestMapping(value = "/goAddAttrButeType")
    public ModelAndView goAddAttrButeType(AsAttribute attribute) {
        logBefore(logger, "去修改goAddAttrType页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        pd.put("id", "AttrButeType");
        try {
            List<AsAttrType> attrTypeList = attrTypeService.list(null);
            mv.setViewName("manage/attrType/attributeEdit");
            mv.addObject("msg", "saveAttrButeType");
            mv.addObject("attributeList", "attributeList");
            mv.addObject("attrTypeList", attrTypeList);
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }


    /**
     * 修改属性页面
     */
    @RequestMapping(value = "/goEditAttrButeType")
    public ModelAndView goEditAttrButeType(AsAttribute attribute) {
        logBefore(logger, "去修改AttButeType页面");
        ModelAndView mv = this.getModelAndView();
        try {

            List<AsAttrType> attrTypeList = attrTypeService.list(null);
            attribute = attributeService.findById(attribute); // 根据ID读取
            mv.setViewName("manage/attrType/attributeEdit");
            mv.addObject("msg", "eidtAttButeType");
            mv.addObject("attribute", attribute);
            mv.addObject("attrTypeList", attrTypeList);

        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存商品属性
     */
    @RequestMapping(value = "/eidtAttButeType")
    public ModelAndView eidtAttButeType(AsAttribute attribute) {
        logBefore(logger, "新增saveAttribute");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        }
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        try {
            attribute.setAttrTypeId(pd.getInt("attrTypeId"));
            attributeService.edit(attribute);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.addObject("id", pd.get("id"));
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 保存商品属性
     */
    @RequestMapping(value = "/saveAttrButeType")
    public ModelAndView saveAttrButeType(AsAttribute attribute) {
        logBefore(logger, "新增saveAttribute");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        }
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        try {
            attribute.setAttrTypeId(pd.getInt("attrTypeId"));
            attributeService.save(attribute);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mv.addObject("id", pd.get("id"));
        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 商品属性删除
     */
    @RequestMapping(value = "/deleteAttribut")
    public void deleteAttribut(PrintWriter out) {
        logBefore(logger, "删除attribut");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        }
        PageData pd = this.getPageData();
        try {
            attributeService.delete(pd.getInt("attributeId"));
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 商品属性批量删除
     */
    @RequestMapping(value = "/deleteAllAttrbute")
    @ResponseBody
    public Object deleteAllAttrbute() {
        logBefore(logger, "批量删除deleteAll");
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
                String ids = pd.getString("ids");
                if (StringUtils.isNotBlank(ids)) {
                    String IdArr[] = ids.split(",");
                    int[] ints = StringToInt(IdArr);
                    attributeService.deleteAll(ints);
                    map.put("msg", "ok");
                } else {
                    map.put("msg", "no");
                }
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 商品属性列表
     */
    @RequestMapping(value = "/attributeList")
    public ModelAndView attributeList(Page page) {
        logBefore(logger, "列表attributekList");
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("manage/attrType/attriButeList");
        PageData pd = this.getPageData();
        try {
            page.setPd(pd);
            PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
            AsAttribute AsAttribute = attributeService.findAsAttribute(pd);
            mv.addObject("attribute", AsAttribute);
            mv.addObject("pd", pd);
            mv.addObject("attrTypeList", attrTypeService.list(null));
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }


    /**
     * 删除商品类型
     */
    @RequestMapping(value = "/deleteAttrType")
    public void deleteAttrType(PrintWriter out) {
        logBefore(logger, "删除deleteAttrType");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return;
        }
        PageData pd = this.getPageData();
        try {
            attrTypeService.delete(pd.getInt("attrTypeId"));
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 批量商品类型删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll() {
        logBefore(logger, "批量删除deleteAll");
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
                String ids = pd.getString("ids");
                if (StringUtils.isNotBlank(ids)) {
                    String IdArr[] = ids.split(",");
                    int[] ints = StringToInt(IdArr);
                    attrTypeService.deleteAll(ints);
                    map.put("msg", "ok");
                } else {
                    map.put("msg", "no");
                }
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /* ===============================权限================================== */
    @SuppressWarnings("unchecked")
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }

	/* ===============================权限================================== */

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
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
}
