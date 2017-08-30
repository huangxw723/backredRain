package com.aoshi.service.manage;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aoshi.common.asenum.BeaconTypeEnum;
import com.aoshi.dao.AsBeaconLinkMapper;
import com.aoshi.dao.AsBeaconMapper;
import com.aoshi.dao.AsBeaconPrizeMapper;
import com.aoshi.dao.AsBeaconRelationMapper;
import com.aoshi.dao.AsShopMapper;
import com.aoshi.dao.DaoSupport;
import com.aoshi.domain.AsBeacon;
import com.aoshi.domain.AsBeaconLink;
import com.aoshi.domain.AsBeaconPrize;
import com.aoshi.domain.AsBeaconRelation;
import com.aoshi.domain.AsShop;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.DateUtil;
import com.aoshi.util.PageData;

/**
 * Created by xjl on 2017/2/21.
 */
@Service
public class BeaconService extends AsBaseService {
    
    @Autowired
    private AsBeaconLinkMapper asBeaconLinkMapper;
    @Autowired
    private AsBeaconPrizeMapper asBeaconPrizeMapper;
    @Autowired
    private AsBeaconMapper asBeaconMapper;
    @Autowired
    private AsBeaconRelationMapper asBeaconRelationMapper;
    @Autowired
	private DaoSupport dao;


    @Transactional
    public int save(AsBeaconLink beaconLink,  String[] prizechoosed,String []beaconchoosed) {
        ValidatorBreakException.NOT_TRUE(!(prizechoosed == null || prizechoosed.length == 0 || "".equals(prizechoosed)), "请选择礼品");
        StringBuffer str2 = new StringBuffer();
        List<String> tmp = new ArrayList<String>();//处理数组beaconchoosed空值
        for(String st:beaconchoosed){
             if(st!=null && st.length()!=0){
                    tmp.add(st);
                  }
        } 
        beaconchoosed= tmp.toArray(new String[0]);
        /*for (int i = 0; i < beaconchoosed.length; i++) {
            AsBeacon asBeacon = asBeaconMapper.selectByPrimaryKey(Integer.parseInt(beaconchoosed[i]));
            if(asBeacon!=null){
            	AsShop shop=asShopMapper.findByShopId(asBeacon.getShopId().toString());
                str2.append(shop.getName()).append(",");
            }
        }*/
        List<String> tmp2 = new ArrayList<String>();//处理数组prizechoosed空值
        for(String st2:prizechoosed){
             if(st2!=null && st2.length()!=0){
                    tmp2.add(st2);
                  }
        } 
        prizechoosed= tmp2.toArray(new String[0]);
        if(prizechoosed.length<=0 || beaconchoosed.length<=0){
            beaconLink.setStatus(0);
        }else {
            beaconLink.setStatus(1);
        }
        beaconLink.setBeaconDesc(str2.toString());
        int flag = asBeaconLinkMapper.insertSelective(beaconLink);
        for (int j = 0; j < prizechoosed.length; j++) {
            AsBeaconPrize beaconPrize = new AsBeaconPrize();
            beaconPrize.setBeaconLinkId(beaconLink.getBeaconLinkId());
            beaconPrize.setCreateTime(DateUtil.getTime());
            beaconPrize.setPrizeConfigId(Integer.parseInt(prizechoosed[j]));
            asBeaconPrizeMapper.insertSelective(beaconPrize);
        }

        for (int i = 0; i < beaconchoosed.length; i++) {
            AsBeaconRelation asBeaconRelation = new AsBeaconRelation();
            asBeaconRelation.setBeaconId(Integer.parseInt(beaconchoosed[i]));
            asBeaconRelation.setBeaconLinkId(beaconLink.getBeaconLinkId());
            asBeaconRelationMapper.insertSelective(asBeaconRelation);
        }

        return flag;
    }

    @Transactional
    public int deleteByPrimaryKey(Integer id) {
        asBeaconLinkMapper.deleteByPrimaryKey(id);
        asBeaconPrizeMapper.deleteByBeaconLinkId(id);
        asBeaconRelationMapper.deleteByBeaconLinkId(id);
        if (asBeaconLinkMapper.deleteByPrimaryKey(id) == 1 && asBeaconPrizeMapper.deleteByBeaconLinkId(id) == 1  &&asBeaconRelationMapper.deleteByBeaconLinkId(id)==1) {
            return 1;
        }
        return 0;
    }

    @Transactional
    public int deleteByIds(String[] ids) {
        asBeaconLinkMapper.deleteByIds(ids);
        asBeaconPrizeMapper.deleteByIds(ids);
        asBeaconRelationMapper.deleteByIds(ids);
        if (asBeaconLinkMapper.deleteByIds(ids) == 1 && asBeaconPrizeMapper.deleteByIds(ids) == 1&&asBeaconRelationMapper.deleteByIds(ids)==1) {
            return 1;
        }
        return 0;
    }

    private String getUUID() {
        UUID uuid = UUID.randomUUID();
        String str = uuid.toString();
        // 去掉"-"符号
        String temp = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);
        return temp;


    }

    @Transactional
    public int update(AsBeaconLink asBeaconLink, String[] prizechoosed,String []beaconchoosed) {
        StringBuffer str2 = new StringBuffer();
        List<String> tmp = new ArrayList<String>();//处理数组beaconchoosed空值
        for(String st:beaconchoosed){
             if(st!=null && st.length()!=0){
                    tmp.add(st);
                  }
        } 
        beaconchoosed= tmp.toArray(new String[0]);
        if(beaconchoosed.length!=0){
            /*for (int i = 0; i < beaconchoosed.length; i++) {
                AsBeacon asBeacon = asBeaconMapper.selectByPrimaryKey(Integer.parseInt(beaconchoosed[i]));
                if(asBeacon!=null){
                	AsShop shop=asShopMapper.findByShopId(asBeacon.getShopId().toString());
                    str2.append(shop.getName()).append(",");                  
                }
            }*/
            asBeaconLink.setBeaconDesc(str2.toString());
            asBeaconLinkMapper.updateByPrimaryKeySelective(asBeaconLink);
        }
        asBeaconRelationMapper.deleteByBeaconLinkId(asBeaconLink.getBeaconLinkId());
        for (int j = 0; j < beaconchoosed.length; j++) {
            AsBeaconRelation asBeaconRelation = new AsBeaconRelation();
            asBeaconRelation.setBeaconLinkId(asBeaconLink.getBeaconLinkId());
            asBeaconRelation.setBeaconId(Integer.parseInt(beaconchoosed[j]));
            asBeaconRelationMapper.insertSelective(asBeaconRelation);
        }

        //礼品的记录表删除后再新增
        asBeaconPrizeMapper.deleteByBeaconLinkId(asBeaconLink.getBeaconLinkId());
        List<String> tmp2 = new ArrayList<String>();//处理数组prizechoosed空值
        for(String st2:prizechoosed){
             if(st2!=null && st2.length()!=0){
                    tmp2.add(st2);
                  }
        } 
        prizechoosed= tmp2.toArray(new String[0]);
        for (int j = 0; j < prizechoosed.length; j++) {
            AsBeaconPrize beaconPrize = new AsBeaconPrize();
            beaconPrize.setBeaconLinkId(asBeaconLink.getBeaconLinkId());
            beaconPrize.setCreateTime(DateUtil.getTime());
            beaconPrize.setPrizeConfigId(Integer.parseInt(prizechoosed[j]));
            asBeaconPrizeMapper.insertSelective(beaconPrize);
        }
        return 1;
    }

    @Transactional
    public int deleteByBeaconId(Integer id) {
        //删除beacon
        asBeaconMapper.deleteByPrimaryKey(id);
        //查询引用了该beacon的beacon组 并且如果beacon组存在，设置状态为禁用
        List<AsBeaconRelation> relations = asBeaconRelationMapper.selectByBeaconId(id);
        if(!relations.isEmpty()){
            for(AsBeaconRelation asBeaconRelation :relations){
                AsBeaconLink asBeaconLink = asBeaconLinkMapper.selectByPrimaryKey(asBeaconRelation.getBeaconLinkId());
                if(asBeaconLink!=null){
                    asBeaconLink.setStatus(BeaconTypeEnum.OFF_USE.getId());
                    asBeaconLinkMapper.updateByPrimaryKeySelective(asBeaconLink);
                }
            }
        }
        //删除beacon组与beacon的关系
        asBeaconRelationMapper.deleteByBeaconId(id);
        if (asBeaconMapper.deleteByPrimaryKey(id) == 1 &&  asBeaconRelationMapper.deleteByBeaconId(id) == 1 ) {
            return 1;
        }
        return 0;
    }

    @Transactional
    public int deleteByBeaconIds(String[] ids) {
        //删除beacon
        asBeaconMapper.deleteByIds(ids);
        //查询引用了该beacon的beacon组 并且如果beacon组存在，设置状态为禁用
        List<AsBeaconRelation> relations = asBeaconRelationMapper.selectByBeaconIds(ids);
        if(!relations.isEmpty()){
            for(AsBeaconRelation asBeaconRelation :relations){
                AsBeaconLink asBeaconLink = asBeaconLinkMapper.selectByPrimaryKey(asBeaconRelation.getBeaconLinkId());
                if(asBeaconLink!=null){
                    asBeaconLink.setStatus(BeaconTypeEnum.OFF_USE.getId());
                    asBeaconLinkMapper.updateByPrimaryKeySelective(asBeaconLink);
                }
            }
        }

        //删除beacon组与beacon的关系
        asBeaconRelationMapper.deleteByBeaconIds(ids);
        if (asBeaconMapper.deleteByIds(ids) == 1 && asBeaconRelationMapper.deleteByBeaconIds(ids) == 1) {
            return 1;
        }
        return 0;
    }
    
    /*
	 * Excel导入保存becon信息
	 */
	public Object saveinfo(PageData pd) throws Exception {
		return asBeaconMapper.saveInfo(pd);
	}

}

