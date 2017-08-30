package com.aoshi.controller.manage.consultation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsArea;
import com.aoshi.domain.AsCity;
import com.aoshi.domain.AsConsultationSpecialty;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.consultation.consultationInfo.AsSpecialtyService;
import com.aoshi.util.excel.ExcelTools;
import com.github.pagehelper.PageHelper;
/**
 * 特产资讯
 * @author strong
 * @version 1.0
 * 2016年11月30日下午1:42:17
 */
@Controller
@RequestMapping("specialty")
public class SpecialtyController extends BaseController{
	
	@Autowired
	private AsSpecialtyService asSpecialtyService;
	
	private static final String SPECIALTY_PATH = "/consultation/specialty/";
	
	//资讯类型
	private static final String INFO_NAME ="特产";
	
	/**
	 * excel导入
	 */
	@RequestMapping("importExcel")
	public String importDoc(MultipartFile excel,MultipartFile imgs) throws Exception{
		
		asSpecialtyService.importExcel(ExcelTools.readExcelTool(excel));
		return "redirect:cateList";
	}
	
	
	
	/**
	 * 预览
	 */
	@RequestMapping("preview")
	public String preview(ModelMap map,@RequestParam("id") Integer id){
		AsConsultationSpecialty cate =  this.asSpecialtyService.queryById(id);
		map.put("cate", cate);
		return SPECIALTY_PATH+"preview";
	}
	
	
	/**
	 * 显示下拉框选择
	 */
	@RequestMapping("specialtyRelease")
	public String queryspecialty(ModelMap map){
		map.put("provinceList", this.asSpecialtyService.queryPro());
		map.put("info", this.asSpecialtyService.queryType(INFO_NAME));
		return SPECIALTY_PATH+"specialtyRelease";
	}
	
	/**
	 * 查询城市
	 */
	@RequestMapping("city")
	@ResponseBody
	public List<AsCity> queryCity(@RequestParam(value="provinceId",required=false) Integer id,ModelMap map){
		List<AsCity> list = this.asSpecialtyService.queryCity(id);
		map.put("msg", list);
		return list;
	}
	/**
	 * 查询区域
	 */
	@RequestMapping("area")
	@ResponseBody
	public List<AsArea> queryArea(@RequestParam(value="cityId",required=false) Integer id,ModelMap map){
		List<AsArea> list =  this.asSpecialtyService.queryArea(id);
		map.put("msg", list);
		return list;
	}
	
	/**
	 * 发布特产资讯
	 */
	@RequestMapping("specialtySave")	
	public ModelAndView saveSpecialty(AsConsultationSpecialty spots, @RequestParam(value="file",required=true) MultipartFile file){		
		 this.asSpecialtyService.saveSpecialty(spots,file);
		ModelAndView mv = this.getModelAndView();
		 mv.addObject("msg", "success");
		 mv.addObject("result", "添加成功!");
	     mv.setViewName("consultation/result");
	      return mv;
	}
	
	/**
	 * 查询特产资讯
	 */
	@RequestMapping("cateList")	
	public String queryAllCate(ModelMap map,Page page,AsConsultationSpecialty food){
		//分页
		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsConsultationSpecialty> list = this.asSpecialtyService.queryAllCate(food);
		page.setPage(list);
		map.put("provinceList", this.asSpecialtyService.queryPro());
		map.put("city", food.getCityId());
		if(food.getProvinceId()!=null){
			map.put("cityList", this.asSpecialtyService.queryCityList(food.getProvinceId()));
		}
		map.put("food", food);
		map.put("list", list);
		return SPECIALTY_PATH+"list";
	}
	
	/**
	 * 根据id查询特产资讯
	 */
	@RequestMapping("toEdit")
	public String queryCateById(ModelMap map,@RequestParam("id") Integer id){
		queryspecialty(map);	
		AsConsultationSpecialty cate =  this.asSpecialtyService.queryById(id);
		map.put("cate", cate);
		return SPECIALTY_PATH+"edit";
	}
	
	
	/**
	 * 修改特产资讯
	 */
	@RequestMapping("cateEdit")
    public ModelAndView updateFood(AsConsultationSpecialty asConsultationFood ,@RequestParam(value="file",required=false) MultipartFile file){
      asSpecialtyService.update(asConsultationFood,file);
       ModelAndView mv = this.getModelAndView();
		 mv.addObject("msg", "success");
		 mv.addObject("result", "修改成功!");
	     mv.setViewName("consultation/result");
	     return mv;
		
    }

	/**
	 * 根据id删除特产资讯
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Object delete(BaseController c) {
		return asSpecialtyService.delete(this);
	}
	
	/**
	 * 更新状态
	 */
	@RequestMapping("/editStatus")
	@ResponseBody
	public Object editStatus(BaseController c) {
		return asSpecialtyService.editStatus(this);
	}
	
    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll",method=RequestMethod.GET)
    @ResponseBody
    public Object deleteAll(String []ids) {
        return asSpecialtyService.deleteByIds(ids);
    }

    /**
     * 批量下架
     */
    @RequestMapping(value = "/offSaleAll",method=RequestMethod.GET)
    @ResponseBody
    public int offSaleAll(String []ids) {
        return asSpecialtyService.offSaleAll(ids);
    }
	
}
