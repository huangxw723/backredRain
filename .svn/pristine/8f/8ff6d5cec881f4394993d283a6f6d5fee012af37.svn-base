    package com.aoshi.controller.manage.link;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsBeaconMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.domain.AsBeacon;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.BeaconService;
import com.github.pagehelper.PageHelper;

/**
 * Created by xjl on 2017/3/9.
 */
@Controller
@RequestMapping("link/beacon")
public class BeaconController extends BaseController {
    private static final String BASEURL="beacon/";
    @Autowired
    private AsBeaconMapper asBeaconMapper;
    @Autowired
    private BeaconService beaconService;
    @Autowired
    private AsShopMapper asShopMapper;
    @Autowired
    private AsYpBaseCategoryMapper baseCategoryMapper;
    
    /**
     * beacon列表
     * @param map
     * @return
     */
    @RequestMapping("beaconList")
    public String beaconList(ModelMap map, Page page,
                           @RequestParam(value="keyWord",required=false)String keyWord, AsBeacon asBeacon) {
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        PageHelper.startPage(pageNum, pageSize);
        if (!StringUtils.isEmpty(keyWord)) {
            asBeacon.setScreenName(keyWord);
        }
        List<?> list = asBeaconMapper.queryList(asBeacon);
    	
        page.setPage(list);
        map.put("keyWord", keyWord);
        map.put("list", list);
        map.put("page", page);
        return BASEURL + "beaconList";
    }

    /**
     * 去增页面
     * @param map
     * @return
     */
    @RequestMapping(value="toAddBeacon")
    public String toAddBeacon(ModelMap map,Page page){
    	List<AsYpBaseCategory> categoryList = baseCategoryMapper.selectNameAll();
    	map.put("categoryList", categoryList);
        return BASEURL+"addBeacon";
    }

    /**
     * 新增操作
     */
    @RequestMapping(value = "/addBeacon")
    @ResponseBody
    public Object addBeacon(AsBeacon asBeacon) {    
    	AsBeacon beacon = asBeaconMapper.selectLastOne();
        if(beacon!=null){       	        	
          asBeacon.setBeaconUid("FDA50693-A4E2-4FB1-AFCF-C6EB07647826");        	           
        }
    	List<AsBeacon> beacons = asBeaconMapper.selectAll();
    	Map<String, Object> map = new HashMap<>();
    	if(beacons.size()>0){
    		/*for (int i = 0; i < beacons.size(); i++) {		
    			if (asBeacon.getScreenCode().equals(beacons.get(i).getScreenCode())) {   				      
    			        map.put("status", "1");
    			        map.put("msg", "操作失败！,唯一终端号，不能重复");   
    			        return map;
    			}  	   	               			 	
    		}*/   		
    		asBeacon.setCreateTime(DateUtil.getTime());
            int result =asBeaconMapper.insertSelective(asBeacon);           
            map.put("result", result);
            map.put("status", "0");
            map.put("msg", "操作成功！");
           
    	}
    	 return map;
    }

    /**
     * 编辑页面
     * @param beaconId
     * @param map
     * @return
     */
    @RequestMapping("toEdit")
    public String toEdit(Integer beaconId,ModelMap map,Page page){
		List<AsYpBaseCategory> categoryList = baseCategoryMapper.selectNameAll();
        AsBeacon asBeacon =  asBeaconMapper.selectByPrimaryKey(beaconId);
        map.put("asBeacon", asBeacon);
		map.put("categoryList", categoryList);
        return BASEURL+"editBeacon";
    }


    /**
     * 更新
     * @param asBeacon
     * @return
     */
    @RequestMapping("update")
    @ResponseBody
    public Map update(AsBeacon asBeacon){
    	List<AsBeacon> beacons = asBeaconMapper.selectAll();
    	Map<String, Object> map = new HashMap<>();  		
    	if(beacons.size()>0){
    		/*for (int i = 0; i < beacons.size(); i++) {		
    			if (asBeacon.getScreenCode().equals(beacons.get(i).getScreenCode())) {   				      
    			        map.put("status", "1");
    			        map.put("msg", "操作失败！,唯一终端号，不能重复"); 
    			        return map;
    			}   		    	    	    		 	          	    	           	    	
    		}*/
    		int result = asBeaconMapper.updateByPrimaryKeySelective(asBeacon);       		
	        map.put("result", result);
	        map.put("status", "0");
	        map.put("msg", "操作成功！");	
    	}
    	return map;
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delById")
    @ResponseBody
    public int delById(Integer id) {
        return beaconService.deleteByBeaconId(id);
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll(String []ids) {
        return beaconService.deleteByBeaconIds(ids);
    }
    
    /**
	 * 打开上传EXCEL页面
	 */
	@RequestMapping(value = "/goUploadExcel")
	public ModelAndView goUploadExcel() throws Exception {
		List<AsYpBaseCategory> categoryList = baseCategoryMapper.selectNameAll();
		ModelAndView mv = this.getModelAndView();
		mv.addObject("categoryList", categoryList);
		mv.setViewName("beacon/uploadexcel");
		return mv;
	}

	/**
	 * 下载模版
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {

		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "Beacon.xls", "Beacon.xls");

	}

    
    /**
	 * 从EXCEL导入到数据库
	 */
	@RequestMapping(value = "/readExcel")
	@ResponseBody
	public ModelAndView readExcel(@RequestParam(value = "excel", required = false) MultipartFile file,@RequestParam(value="categoryId") Integer categoryId) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		System.out.print("++++++++++++++++++++++"+categoryId+"======================");
		if (null != file && !file.isEmpty()) {
			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
			String fileName = FileUpload.fileUp(file, filePath, "beaconexcel"); // 执行上传
			List<PageData> listPd = (List<PageData>) ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0); // 执行读EXCEL操作,读出的数据导入List
			// 1:从第2行开始；0:从第A列开始；0:第0个sheet
			/* 存入数据库操作====================================== */
			// var0 :名称范围  var1:mac地址   var2:beacon的UUID var3: 蓝牙名称     var4 :major var5 :minor
			// var6:终端名称     var7:上屏编码    var8:下屏编码      var9:上下屏系统   var10:上下屏型号    var11 :开机时间   var12:关机时间
			// var13:终端地址  var14:屏幕类型  var15:备注
			for (int i = 0; i < listPd.size(); i++) {
				if(listPd.get(i).getString("var0").isEmpty()){//范围名称 null时，跳过
					continue;
				}else { 										  
                        if(asBeaconMapper.selectBybeaconName(listPd.get(i).getString("var0")) != null){
                        	continue;                     	
					     }else {
					    	 pd.put("beaconName",listPd.get(i).getString("var0")); 
						}					
				}
				if(listPd.get(i).getString("var1").isEmpty()){//mac地址 null时，跳过
					continue;
				}else {					
					pd.put("beaconMac", listPd.get(i).getString("var1")); 
				}					 
				if((listPd.get(i).getString("var2").isEmpty())){
					pd.put("beaconUid","FDA50693-A4E2-4FB1-AFCF-C6EB07647826"); 
				}else {
					pd.put("beaconUid",listPd.get(i).getString("var2"));
				}
				if(listPd.get(i).getString("var3").isEmpty()){//蓝牙名称 null时，跳过
					continue;
				}else {
					pd.put("beaconBlue", listPd.get(i).getString("var3")); 
				}	
				if(listPd.get(i).getString("var4").isEmpty()){//major null时，跳过
					continue;
				}else {
					pd.put("major", listPd.get(i).getString("var4")); 
				}	
				if(listPd.get(i).getString("var5").isEmpty()){//minor null时，跳过
					continue;
				}else {
					pd.put("minor", listPd.get(i).getString("var5")); 
				}					
				pd.put("screenName", listPd.get(i).getString("var6")); 				
				pd.put("upScreenCode", listPd.get(i).getString("var7")); 
				pd.put("downScreenCode", listPd.get(i).getString("var8"));
				if(listPd.get(i).getString("var9").isEmpty()){//上下屏系统 null时，跳过
					continue;
				}else {
					pd.put("screenSystem", listPd.get(i).getString("var9"));  
				}
				if(listPd.get(i).getString("var10").isEmpty()){//上下屏型号 null时，跳过
					continue;
				}else {
					pd.put("screenModel",listPd.get(i).getString("var10"));   
				}				
				pd.put("startupTime", listPd.get(i).getString("var11")); 						
				pd.put("shutdownTime", listPd.get(i).getString("var12")); 
				if(listPd.get(i).getString("var13").isEmpty()){//终端地址 null时，跳过
					continue;
				}else {
					pd.put("screenAddress", listPd.get(i).getString("var13"));    
				}					
				pd.put("screenType", listPd.get(i).getString("var14")); 
				pd.put("beaconRemark", listPd.get(i).getString("var15")); 
				pd.put("createTime", DateUtil.getTime());
				pd.put("categoryId",categoryId);
				beaconService.saveinfo(pd);

			}
			mv.addObject("msg", "success");
		}
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * beacon分类管理
	 * @return
	 */
	@RequestMapping("/beaconClassIfyList")
	public String  beaconClassIfyList(ModelMap map, Page page,@RequestParam(value="keyWord",required=false)String keyWord,AsYpBaseCategory baseCategory){
		int pageNum = page.getCurrentPage();
		int pageSize = page.getShowCount();
		PageHelper.startPage(pageNum, pageSize);
		if (!StringUtils.isEmpty(keyWord)) {
			baseCategory.setName(keyWord);
		}
		List<AsYpBaseCategory> baseCategroyList=baseCategoryMapper.selectNameAll();
		page.setPage(baseCategroyList);
		map.put("baseCategroyList",baseCategroyList);
		map.put("keyWord", keyWord);
		map.put("page", page);
		return  BASEURL+"beaconClassIfyList";
	}

	/**
	 * go新增分类页
	 * @return
	 */
	@RequestMapping("/toAddBeaconClassIfy")
	public String toAddBeaconClassIfy(){
		return BASEURL+"addBeaconClassIfy";
	}

	/**
	 * 保存
	 * @return
	 */
	@RequestMapping("/saveBeaconClassIfy")
	@ResponseBody
	public Object saveBeaconClassIfy(AsYpBaseCategory baseCategory){
		Map<String, Object> map = new HashMap<>();
		if(baseCategory !=null){
			baseCategory.setCreateTime(DateUtil.getTime());
			baseCategory.setType(12);
			int result=baseCategoryMapper.insertSelective(baseCategory);
			if(result > 0){
				map.put("status", "0");
				map.put("msg", "操作成功！");
			}
		}
		return map;

	}

	/**
	 * 删除分类
	 * @return
	 */
	@RequestMapping("/delBybasecategoryId")
	public int delBybasecategoryId(Integer Id){
		return baseCategoryMapper.deleteByPrimaryKey(Id);
	}

	/**
	 * go编辑分类页
	 * @return
	 */
	@RequestMapping("/toEditBeaconClassIfy")
	public String toEditBeaconClassIfy(ModelMap map ,Integer Id){
		AsYpBaseCategory b = baseCategoryMapper.selectById(Id);
		map.put("baseCategory",b);
		return BASEURL+"editBeaconClassIfy";
	}

	@RequestMapping("/updateBeaconClassIfy")
	@ResponseBody
	public Object UpdateBeaconClassIfy(AsYpBaseCategory baseCategory){
		Map<String, Object> map = new HashMap<>();
		if(baseCategory !=null){
			int result=baseCategoryMapper.updateByPrimaryKeySelective(baseCategory);
			if(result > 0){
				map.put("status", "0");
				map.put("msg", "操作成功！");
			}
		}
		return map;

	}

}
