package com.aoshi.controller.manage;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.aoshi.controller.base.BaseController;
import com.aoshi.domain.AsPopularTags;
import com.aoshi.service.manage.PopularTagsService;
import com.aoshi.util.DateUtil;

@Controller
@RequestMapping("/popularTags")
public class PopularTagsController extends BaseController {

	/**
	 * 热门搜索配置Controller
	 * @author chenwz
	 * @date   2017/5/11
	 */
	private final static String PAGE_PATH_TAGS="populartags/";
	
	@Autowired private PopularTagsService popularTagsService;
	
	/**
	 * 热门标签搜素列表
	 * @return
	 */
	@RequestMapping("/list")
	public Object  getList(){
		return popularTagsService.getList(this);
	}
	
	/**
	 * 跳转新增页面
	 * @return
	 */
	@RequestMapping("/toAddTagsPage")
	public String toTagsPage(){
		return PAGE_PATH_TAGS + "addTags";
	}
	
	/**
	 * 新增操作
	 * @param tags
	 * @return
	 */
	@RequestMapping("/addTags")
	@ResponseBody
	public Object addTags(AsPopularTags tags){
		Map<String, Object> map= new HashMap<String, Object>();
		if(tags !=null){
			tags.setCreateTime(DateUtil.getTime());
			int result=popularTagsService.addTags(tags);			
			if(result == 1){
				map.put("status", "1");
				map.put("msg", "操作成功！");					
			}else if(result == 0){
				map.put("status", "0");
				map.put("msg", "该类型的标签名称已存在");
			}else if(result == 2){
				map.put("status", "2");
				map.put("msg", "该类型搜索标签不能超过10个");
			}			
		}
		
		return map;
	}
	
	/**
	 * 删除操作
	 * @param id
	 * @return
	 */
	@RequestMapping("/delTags")
	@ResponseBody
	public Object delTags(Integer id){
		int result=popularTagsService.del(id);
		if(result > 0){
			return "0";
		}
		return "1";
	}
	
	/**
	 * 跳转编辑页面
	 * @return
	 */
	@RequestMapping("/toEditTagsPage")
	public String toEditTagsPage(ModelMap map,Integer id){
		AsPopularTags tags=popularTagsService.toEditTags(id);
		map.put("tags", tags);
		return PAGE_PATH_TAGS + "editTags";
	}
	
	/**
	 * 编辑操作
	 * @param tags
	 * @return
	 */
	@RequestMapping("/updateTags")
	@ResponseBody
	public Object updateTags(AsPopularTags tags){
		Map<String, Object> map= new HashMap<String, Object>();
		if(tags !=null){			
			int result=popularTagsService.updateTags(tags);
			if(result == 1){
				map.put("status", "1");
				map.put("msg", "操作成功！");					
			}else if(result == 0){
				map.put("status", "0");
				map.put("msg", "该类型的标签名称已存在");
			}else if(result == 2){
				map.put("status", "2");
				map.put("msg", "该类型搜索标签不能超过10个");
			}					
		}
		
		return map;
	}
	
}

