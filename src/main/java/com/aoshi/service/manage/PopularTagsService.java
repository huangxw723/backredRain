package com.aoshi.service.manage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsPopularTagsMapper;
import com.aoshi.domain.AsPopularTags;
import com.aoshi.service.base.AsBaseService;

@Service
public class PopularTagsService extends AsBaseService {
	
	private final static String PAGE_PATH_TAGS="populartags/";
	
	@Autowired
	private AsPopularTagsMapper tagsMapper;
	
	/**
	 * 热门标签搜素列表
	 * @return
	 */
	public Object getList( BaseController c){
		initialized(c);
		pageQueryModule(tagsMapper, "listAll", true);
		return renderView(PAGE_PATH_TAGS+"tagsList");
	}
	/**
	 * 新增页面跳转
	 * @param tags
	 * @return
	 */
	public int addTags(AsPopularTags tags){
		List<AsPopularTags> lists=tagsMapper.selectAllByType(tags.getTagsType());	
		if(lists.size()<10){
			for(AsPopularTags t:lists){					
				if(t.getTagsName().trim().equals(tags.getTagsName().trim())){
					return 0;//该类型的标签名称已存在
				}
			}
            tagsMapper.insertSelective(tags);
            return 1;
		}else {
			return 2;//该类型搜索标签不能超过10个
		}
				
	}
	/**
	 * 删除操作
	 * @param id
	 * @return
	 */
	public int del(Integer id){
		return  tagsMapper.deleteByPrimaryKey(id);		
	}
	/**
	 * 编辑页面跳转
	 * @param id
	 * @return
	 */
	public AsPopularTags toEditTags(Integer id){
		AsPopularTags tags=new AsPopularTags();
		return tags=tagsMapper.selectByPrimaryKey(id);
	}
	/**
	 * 编辑操作
	 * @param tags
	 * @return
	 */
	public int updateTags(AsPopularTags tags){
		AsPopularTags popularTags=tagsMapper.selectByPrimaryKey(tags.getPopularTagsId());
		List<AsPopularTags> lists=tagsMapper.selectAllByType(tags.getTagsType());	
		if( popularTags.getTagsType() !=tags.getTagsType()){
			if(lists.size()<10){
				for(AsPopularTags t:lists){					
					if(t.getTagsName().trim().equals(tags.getTagsName().trim())){
						return 0;//该类型的标签名称已存在
					}
				}
			    tagsMapper.updateByPrimaryKeySelective(tags);
	            return 1;
			}else {
				return 2;//该类型搜索标签不能超过10个
			}
		}else if(!popularTags.getTagsName().equals(tags.getTagsName())){
			for(AsPopularTags t:lists){					
				if(t.getTagsName().trim().equals(tags.getTagsName().trim())){
					return 0;//该类型的标签名称已存在
				}
			}
		    tagsMapper.updateByPrimaryKeySelective(tags);
            return 1;
		}else {
			tagsMapper.updateByPrimaryKeySelective(tags);
			return 1;
		}
								
	}

}
