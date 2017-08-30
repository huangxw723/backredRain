package com.aoshi.controller.manage.link;

import com.aoshi.common.asenum.BeaconTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.*;
import com.aoshi.domain.*;
import com.aoshi.entity.Page;
import com.aoshi.service.manage.BeaconService;
import com.aoshi.util.Conditions;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;
import com.github.pagehelper.PageHelper;

import net.sf.json.JSONArray;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by xjl on 2017/2/18.
 */
@Controller
@RequestMapping("link/beaconGroup")
public class BeaconGroupController extends BaseController {
    private static final String BASEURL="beaconGroup/";
    @Autowired
    private AsBeaconPrizeMapper asBeaconPrizeMapper;
    @Autowired
    private AsBeaconLinkMapper asBeaconLinkMapper;
    @Autowired
    private AsShopMapper asShopMapper;
    @Autowired
    private AsPrizeConfigMapper asPrizeConfigMapper;
    @Autowired
    private BeaconService beaconService;
    @Autowired
    private AsBeaconMapper asBeaconMapper;
    @Autowired
    private AsBeaconRelationMapper asBeaconRelationMapper;
    @Autowired
    private  AsYpBaseCategoryMapper baseCategoryMapper;

    /**
     * beacon列表
     * @param map
     * @return
     */
    @RequestMapping("beaconList")
    public String beaconList(ModelMap map, Page page,
                           @RequestParam(value="keyWord",required=false)String keyWord,
                           AsBeaconLink asBeaconLink) {
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();      
        if (!StringUtils.isEmpty(keyWord)) {
            asBeaconLink.setBeaconName(keyWord);
        }
        PageHelper.startPage(pageNum, pageSize);
        List<AsBeaconLink> list = asBeaconLinkMapper.queryList(asBeaconLink);
        if(!list.isEmpty()){
            for(AsBeaconLink asBeaconLink1:list){
                List<AsBeaconPrize> prizes = asBeaconPrizeMapper.listByBeaconLinkId(asBeaconLink1.getBeaconLinkId());
                List<AsBeaconRelation> asBeaconRelations = asBeaconRelationMapper.listByBeaconLinkId(asBeaconLink1.getBeaconLinkId());
                if(prizes.size()>0){
                    asBeaconLink1.setPrizeChoosed(true);
                }else {
                    asBeaconLink1.setPrizeChoosed(false);
                }
                if(asBeaconRelations.size()>0){
                    asBeaconLink1.setBeaconChoosed(true);
                }else {
                    asBeaconLink1.setBeaconChoosed(false);
                }
            }
        }
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

        List<?> beaconList = asBeaconMapper.queryList(null);
        List<AsPrizeConfig> asPrizeConfigs = asPrizeConfigMapper.queryList(null);
         map.put("beaconList",beaconList);
        map.put("asPrizeConfigs", asPrizeConfigs);
        return BASEURL+"addBeacon";
    }

    /**
     * 新增操作
     */
    @RequestMapping(value = "/addBeacon")
    @ResponseBody
    public Object addBeacon(AsBeaconLink beaconLink,String []prizechoosed,String []beaconchoosed) {    	
        int result =beaconService.save(beaconLink,prizechoosed,beaconchoosed);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll(String []ids) {
        return beaconService.deleteByIds(ids);
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delById")
    @ResponseBody
    public int delById(Integer id) {
        return beaconService.deleteByPrimaryKey(id);
    }

    /**
     * 启用
     */
    @RequestMapping(value = "/onUse")
    @ResponseBody
    public int onUse(Integer id) {
        AsBeaconLink asBeaconLink = asBeaconLinkMapper.selectByPrimaryKey(id);
        if(asBeaconLink!=null){
            asBeaconLink.setStatus(BeaconTypeEnum.ON_USE.getId());
        }
        return asBeaconLinkMapper.updateByPrimaryKeySelective(asBeaconLink);
    }

    /**
     * 禁用
     */
    @RequestMapping(value = "/offUse")
    @ResponseBody
    public int offUse(Integer id) {
        AsBeaconLink asBeaconLink = asBeaconLinkMapper.selectByPrimaryKey(id);
        if(asBeaconLink!=null){
            asBeaconLink.setStatus(BeaconTypeEnum.OFF_USE.getId());
        }
        return asBeaconLinkMapper.updateByPrimaryKeySelective(asBeaconLink);
    }

    /**
     * 跳转编辑页面
     * @param beaconLinkId
     * @param map
     * @return
     */
    @RequestMapping("toEdit")
    public String toEdit(Integer beaconLinkId,ModelMap map,Page page){
        AsBeaconLink asBeaconLink = asBeaconLinkMapper.selectByPrimaryKey(beaconLinkId);
        StringBuffer stringBuffer = new StringBuffer();
        StringBuffer stringBuffer1 = new StringBuffer();
        List<AsBeaconPrize> mapperList = asBeaconPrizeMapper.listByBeaconLinkId(beaconLinkId);
        List<AsBeaconRelation> beaconRelationList = asBeaconRelationMapper.listByBeaconLinkId(beaconLinkId);
        if(!beaconRelationList.isEmpty() && beaconRelationList !=null){
            for(AsBeaconRelation asBeacoRelation:beaconRelationList){
                stringBuffer1.append(asBeacoRelation.getBeaconId()).append(",");
            }
            map.put("beaconchoosed", stringBuffer1.substring(0,stringBuffer1.lastIndexOf(",")));//回显之后，不操作保存的时候，返回原数据
                      
        }
        if(!mapperList.isEmpty() && mapperList != null){
            for(AsBeaconPrize asBeaconPrize:mapperList){
                stringBuffer.append(asBeaconPrize.getPrizeConfigId()).append(",");
            }
            map.put("prizechoosed", stringBuffer.substring(0,stringBuffer.lastIndexOf(",")));//回显之后，不操作保存的时候，返回原数据
        }
        List<?> beaconList = asBeaconMapper.queryList(null);
        List<AsPrizeConfig> asPrizeConfigs = asPrizeConfigMapper.queryList(null);
        map.put("asBeaconLink", asBeaconLink);
        map.put("asPrizeConfigs", asPrizeConfigs);
        map.put("mapperList", mapperList);
        map.put("beaconRelationList", beaconRelationList);
        map.put("beaconList",beaconList);      
        map.put("beaconDesc", asBeaconLink.getBeaconDesc().equals("")? "":asBeaconLink.getBeaconDesc().substring(0,asBeaconLink.getBeaconDesc().lastIndexOf(",")));
        return BASEURL+"editBeacon";
    }


    /**
     * 新增选择礼品列表
     * @param
     * @param map
     * @return
     */
    @RequestMapping("choosePrize")
    public String choosePrize(ModelMap map,Page page,Integer id,@RequestParam(value="keyWord",required=false)String keyWord,AsPrizeConfig asPrizeConfig){
    	initialized();
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        String [] prizeids=null;
        if(!pd.get("idse").toString().equals("0")){
        	prizeids =pd.get("idse").toString().split(",");
        }
        PageHelper.startPage(pageNum, pageSize);
        if (!StringUtils.isEmpty(keyWord)) {
            asPrizeConfig.setName(keyWord);
        }
        List<AsPrizeConfig> asPrizeConfigs = asPrizeConfigMapper.queryList(asPrizeConfig);
        page.setPage(asPrizeConfigs);
        map.put("asPrizeConfigs", asPrizeConfigs);
        map.put("keyWord", keyWord);
        map.put("page", page);
        map.put("idse", JSONArray.fromObject(prizeids));
        map.put("idseSize", prizeids);
        return BASEURL+"choosePrizeList";
    }


    /**
     * 新增选择beacon列表
     * @param
     * @param map
     * @return
     */
    @RequestMapping("chooseBeacon")
    public String chooseBeacon(ModelMap map,Page page,Integer id,@RequestParam(value="keyWord",required=false)String keyWord,AsBeacon asBeacon){
    	initialized();
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        String [] prizeids=null;
        if(!pd.get("idse").toString().equals("0")){
        	prizeids =pd.get("idse").toString().split(",");
        }
         if (!StringUtils.isEmpty(keyWord)) {
             asBeacon.setScreenName(keyWord);
         }

        PageHelper.startPage(pageNum, pageSize);
        List<?> asBeacons = asBeaconMapper.queryList(asBeacon);
        page.setPage(asBeacons);
        PageData pd=this.getPageData();
        List list=new ArrayList<String>();
        if(asBeacon.getCategoryId() != null){
            for(Object a : asBeacons){
                Map ojb = (Map)a;
                String  categoryId = ojb.get("categoryId").toString();
                String  beaconId = ojb.get("beaconId").toString();
                list.add(beaconId);

            }
            prizeids=(String[]) list.toArray(new String[]{});
            //prizeids = new String[] {"92","93","94","95"};
        }
        List<AsYpBaseCategory> categoryList = baseCategoryMapper.selectNameAll();
        map.put("categoryList", categoryList);
        map.put("asBeacons", asBeacons);        
        map.put("keyWord", keyWord);
        map.put("page", page);
        map.put("pd",pd);
        map.put("idse", JSONArray.fromObject(prizeids));
        map.put("idseSize", prizeids);
        return BASEURL+"chooseBeaconList";
    }


    /**
     * 编辑选择礼品
     * @param
     * @param map
     * @return
     */
    @RequestMapping("editPrize")
    public String editPrize(ModelMap map,Page page,Integer id,Integer action,@RequestParam(value="keyWord",required=false)String keyWord,AsPrizeConfig asPrizeConfig){
    	initialized();
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
        if(action == 4){
        	 List<AsBeaconPrize> mapperList = asBeaconPrizeMapper.listByBeaconLinkId(id);
        	 PageHelper.startPage(pageNum, pageSize);
        	 List<AsPrizeConfig> asPrizeConfigs = new ArrayList<AsPrizeConfig>();
             if(mapperList !=null && !mapperList.isEmpty()){
                 for(AsBeaconPrize asBeaconPrize:mapperList){
                	 AsPrizeConfig prize= asPrizeConfigMapper.queryById(asBeaconPrize.getPrizeConfigId());
                	 asPrizeConfigs.add(prize);
                 }
                 page.setPage(asPrizeConfigs);
                 map.put("asPrizeConfigs", asPrizeConfigs);
                 map.put("page", page); 
                 map.put("action", action);
                 map.put("beaconLinkId", id);
             }
        }else {
        	 if (!StringUtils.isEmpty(keyWord)) {
                 asPrizeConfig.setName(keyWord);
             }
             String [] prizeids=null;
             List<String> ids = new ArrayList<String>();
             if(!pd.get("idse").toString().equals("0")){
             	prizeids =pd.get("idse").toString().split(",");
             }  
             StringBuffer stringBuffer = new StringBuffer();
             List<AsBeaconPrize> mapperList = asBeaconPrizeMapper.listByBeaconLinkId(id);
             if(!mapperList.isEmpty()){
                 for(AsBeaconPrize asBeaconPrize:mapperList){
                     stringBuffer.append(asBeaconPrize.getPrizeConfigId()).append(",");
                     ids.add(asBeaconPrize.getPrizeConfigId().toString());
                 }
             }
             String [] prizeid = (String[])ids.toArray(new String[ids.size()]);
             if(StringUtils.isEmpty(prizeids)&&prizeid.length>0)
             prizeids =prizeid;
             PageHelper.startPage(pageNum, pageSize);
             List<AsPrizeConfig> asPrizeConfigs = asPrizeConfigMapper.queryList(asPrizeConfig);
             page.setPage(asPrizeConfigs);
             map.put("asPrizeConfigs", asPrizeConfigs);
             map.put("keyWord", keyWord);
             map.put("page", page); 
             map.put("idse", JSONArray.fromObject(prizeids));
             map.put("idseSize", prizeids);
            // map.put("prizeStr", stringBuffer);//用于回显（勾选）
             map.put("action", action);
             map.put("beaconLinkId", id);//回传beaconLinkId
		}
       
        return BASEURL+"editPrize";
    }


    /**
     * 编辑选择beacon
     * @param
     * @param map
     * @return
     */
    @RequestMapping("editBeacon")
    public String editBeacon(ModelMap map,Page page,Integer id,Integer action, @RequestParam(value="keyWord",required=false)String keyWord,AsBeacon asBeacon){
    	initialized();
        int pageNum = page.getCurrentPage();
        int pageSize = page.getShowCount();
      
        if(action ==4 ){
        	 List<AsBeaconRelation> asBeaconRelationList = asBeaconRelationMapper.listByBeaconLinkId(id);
        	 PageHelper.startPage(pageNum, pageSize);
        	 List<AsBeacon> asBeacons = new ArrayList<AsBeacon>();
        	 if(!asBeaconRelationList.isEmpty()){
                 for(AsBeaconRelation asBeaconRelation:asBeaconRelationList){
                    AsBeacon a= asBeaconMapper.selectByPrimaryKey(asBeaconRelation.getBeaconId());
                    asBeacons.add(a);
                 }
             }       	
        	 page.setPage(asBeacons);
             map.put("asPrizeConfigs", asBeacons);
             map.put("page", page);
             map.put("beaconLinkId", id);
             map.put("action", action);
                       
        }else{
        	if (!StringUtils.isEmpty(keyWord)) {
                  asBeacon.setScreenName(keyWord);
            }
            List list=new ArrayList<String>();
        	String [] prizeids=null;
            List<String> beanIds = new ArrayList<String>();
            if(!pd.get("idse").toString().equals("0")){
            	prizeids =pd.get("idse").toString().split(",");
            }               
            StringBuffer stringBuffer = new StringBuffer();
            List<AsBeaconRelation> asBeaconRelationList = asBeaconRelationMapper.listByBeaconLinkId(id);
            if(!asBeaconRelationList.isEmpty()){
                for(AsBeaconRelation asBeaconRelation:asBeaconRelationList){
                    stringBuffer.append(asBeaconRelation.getBeaconId()).append(",");
                    beanIds.add(asBeaconRelation.getBeaconId().toString());
                }
            }
            String [] prizeid = (String[])beanIds.toArray(new String[beanIds.size()]);
            if(StringUtils.isEmpty(prizeids)&&prizeid.length>0)
            prizeids =prizeid;
            PageHelper.startPage(pageNum, pageSize);
            List<Conditions> asBeacons =asBeaconMapper.queryList(asBeacon);
            if(asBeacon.getCategoryId() != null){
                for(Object a : asBeacons){
                    Map ojb = (Map)a;
                    String  categoryId = ojb.get("categoryId").toString();
                    String  beaconId = ojb.get("beaconId").toString();
                    list.add(beaconId);

                }
                if(asBeaconRelationList !=null){
                    for(int i=0;i<asBeaconRelationList.size();i++){
                        list.add(asBeaconRelationList.get(i).getBeaconId().toString());
                    }

                }
                prizeids=(String[]) list.toArray(new String[]{});
            }
            page.setPage(asBeacons);
            PageData pd=this.getPageData();
            List<AsYpBaseCategory> categoryList = baseCategoryMapper.selectNameAll();
            map.put("categoryList", categoryList);
            map.put("asPrizeConfigs", asBeacons);
            map.put("page", page);
            map.put("pd",pd);
            map.put("keyWord", keyWord);
            map.put("idse", JSONArray.fromObject(prizeids));
            map.put("idseSize", prizeids);
            map.put("action", action);
            // map.put("prizeStr", stringBuffer);//用于回显（勾选）
            map.put("beaconLinkId", id);//回传beaconLinkId
        }
        
        return BASEURL+"editBeaconList";
    }

    /**
     * 更新
     * @param asBeaconLink
     * @return
     */
    @RequestMapping("update")
    @ResponseBody
    public Map update(AsBeaconLink asBeaconLink ,String []prizechoosed,String []beaconchoosed){
        int result = beaconService.update(asBeaconLink,prizechoosed,beaconchoosed);
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        map.put("status", "0");
        map.put("msg", "操作成功！");
        return map;
    }

}
