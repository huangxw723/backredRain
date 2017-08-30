package com.aoshi.controller.manage.consultation.type;

import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.*;
import com.aoshi.entity.Page;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.manage.consultation.brand.BrandCategoryService;
import com.aoshi.service.manage.consultation.brand.BrandService;
import com.aoshi.service.manage.consultation.consultationInfo.AsConsultationInfoService;
import com.aoshi.service.manage.consultation.type.AsConsultationTypeService;
import com.aoshi.service.manage.locality.AsCityService;
import com.aoshi.service.manage.locality.AsProvinceService;
import com.github.pagehelper.PageHelper;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("consultation/type")
public class AsConsultationTypeController extends BaseController {
	private static final String BASEURL="consultation/type/";
	@Autowired
	private AsProvinceService asProvinceService;
	@Autowired
	private AsCityService asCityService;
	@Autowired
	private AsConsultationInfoService asConsultationInfoService;
	@Autowired
	private AsConsultationTypeService asConsultationTypeService;

	/**
	 * 列表
	 * @param map
	 * @return
	 */
	@RequestMapping(value="typeList")
	public String typeList(ModelMap map,String keyWord,Page page){
		AsConsultationType asConsultationType = new AsConsultationType();

		if(keyWord !=null && !keyWord.trim().equals("")){
			asConsultationType.setTypeName(keyWord);
		}
//		PageHelper.startPage(page.getCurrentPage(), page.getShowCount());
		List<AsConsultationType> typeList = asConsultationTypeService.getTypes(asConsultationType);

//		page.setPage(typeList);
		map.put("typeList", typeList);
		map.put("keyWord", keyWord);
		return BASEURL+"typeList";
	}

	/**
	 * 新增页面
	 * @param map
	 * @return
	 */
	@RequestMapping(value="toAddType")
	public String toAddType(ModelMap map){
		List<Map<String,Object>> nodes = getTypes();
		map.put("typeList", JSONArray.fromObject(nodes));
		return BASEURL+"addType";
	}

	/**
	 * 保存
	 * @param
	 * @return
	 */
	@RequestMapping(value="saveType")
    @ResponseBody
	public Object saveType(AsConsultationType asConsultationType){
		int result =asConsultationTypeService.insertSelective(asConsultationType);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        return map;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "deleteType")
	@ResponseBody
	public int deleteType(ModelMap map,Integer id) {
		return asConsultationTypeService.deleteByPrimaryKey(id);
	}


    /**
     * 编辑页面
     * @param typeId
     * @param map
     * @return
     */
    @RequestMapping("toEditType")
    public String toEditBrand(Integer typeId,ModelMap map){
        AsConsultationType asConsultationType = asConsultationTypeService.selectByPrimaryKey(typeId);
        AsConsultationType  pAsConsultationType=asConsultationTypeService.selectByPrimaryKey(asConsultationType.getParentId());
        List<Map<String,Object>> nodes = getTypes();
        map.put("typeList", JSONArray.fromObject(nodes));
        map.put("asConsultationType", asConsultationType);
        map.put("pAsConsultationType", pAsConsultationType);
        return BASEURL+"editType";
    }

    /**
     * 更新
     * @param
     * @return
     */
    @RequestMapping(value="updateType")
    @ResponseBody
    public Map updateType(AsConsultationType asConsultationType){
        int result = asConsultationTypeService.updateByPrimaryKeySelective(asConsultationType);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        return map;
    }


	/**
	 * 类型
	 * @return
	 */
	private List<Map<String,Object>> getTypes(){
		List<AsConsultationType> typeList = asConsultationTypeService.getTypes(new AsConsultationType());
		List<Map<String,Object>> nodes = new ArrayList<Map<String,Object>>();
		if (typeList != null && typeList.size() > 0) {
			for (int i = 0; i < typeList.size(); i++) {
				Map<String,Object> node = new HashMap<>();
				node.put("id", typeList.get(i).getConsultationTypeId());
				node.put("pId", typeList.get(i).getParentId());
				node.put("name", typeList.get(i).getTypeName());
				nodes.add(node);
			}
		}
		return nodes;
	}
}
