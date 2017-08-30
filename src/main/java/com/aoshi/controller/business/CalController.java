package com.aoshi.controller.business;

import com.aoshi.dao.CalNumRecordMapper;
import com.aoshi.dao.CalNumSetMapper;
import com.aoshi.dao.CalPrizeLevelMapper;
import com.aoshi.dao.CalPrizeMapper;
import com.aoshi.domain.*;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CalController
 *
 * @author zf
 * @date 10/27/16
 */
@CrossOrigin(methods = {RequestMethod.GET,RequestMethod.POST})
@Controller()
@RequestMapping("app")
public class CalController {
    @Autowired
    CalNumSetMapper calNumSetMapper;

    @Autowired
    CalNumRecordMapper calNumRecordMapper;

    @Autowired
    CalPrizeMapper calPrizeMapper;

    @Autowired
    CalPrizeLevelMapper calPrizeLevelMapper;

    @CrossOrigin(methods = {RequestMethod.GET,RequestMethod.POST})
    @RequestMapping("getRandomCode")
    @ResponseBody
    @Transactional
    public Object getRandomCode(Integer calNumId, Integer prizeId){
        CalNumSet calNumSet = calNumSetMapper.selectByPrimaryKey(calNumId);
        List<CalNumRecord> calNumRecords = calNumRecordMapper.selectAll(calNumId);
        List<Integer> allRecords = new ArrayList<>();
        for (int i = calNumSet.getMinNum(); i <= calNumSet.getMaxNum(); i++) {
            allRecords.add(i);
        }
        for (CalNumRecord calNumRecord : calNumRecords){
            if (allRecords.contains(calNumRecord.getRecordNum()) ){
                allRecords.remove(calNumRecord.getRecordNum());
            }
        }
        if (allRecords.size() == 0 ){
            Map<String, Object> data = new HashMap<>();
            data.put("errorCode", 1001);
            data.put("errorMsg", "活动已经结束");
            return data;
        }
        CalPrize calPrize = calPrizeMapper.selectByPrimaryKey(prizeId);
        if (calPrize.getRemainTime() <= 0){
            Map<String, Object> data = new HashMap<>();
            data.put("errorCode", 1001);
            data.put("errorMsg", "该奖品已经被抽完");
            return data;
        }

        int code;
        if (prizeId == 12 && calPrize.getRemainTime() == 1 ){
            code = 581;
            CalNumRecord record = new CalNumRecord();
            record.setRecordNum(code);
            record.setPrizeId(prizeId);
            record.setNumSetId(calNumId);
            calNumRecordMapper.insert(record);
        }else if(prizeId == 13 && calPrize.getRemainTime() == 1) {
            code = 824;
            CalNumRecord record = new CalNumRecord();
            record.setRecordNum(code);
            record.setPrizeId(prizeId);
            record.setNumSetId(calNumId);
            calNumRecordMapper.insert(record);
        }else{
            if (allRecords.indexOf(581) != -1) {
                allRecords.remove(allRecords.indexOf(581));
            }
            if (allRecords.indexOf(824) != -1) {
                allRecords.remove(allRecords.indexOf(824));
            }
            code = RandomUtils.nextInt(allRecords.size());
            code = allRecords.get(code);
            CalNumRecord record = new CalNumRecord();
            record.setRecordNum(code);
            record.setPrizeId(prizeId);
            record.setNumSetId(calNumId);
            calNumRecordMapper.insert(record);
        }
        calPrize.setRemainTime(calPrize.getRemainTime()-1);
        calPrizeMapper.updateByPrimaryKeySelective(calPrize);
        Map<String, Object> data = new HashMap<>();
        data.put("errorCode", 200);
        data.put("errorMsg", String.format("%03d", code));
        return data;
    }

    @RequestMapping("goToSetCalNum")
     public String goToSetCalNum(ModelMap map){
        List<CalNumSet> cals = calNumSetMapper.selectAll();
        map.put("data", cals);
        return "cal/setCalNum";
    }

    @Transactional
    @RequestMapping("numSave")
    public String numSave(ModelMap map, Integer maxNum0, Integer minNum0,Integer maxNum1, Integer minNum1) {
        CalNumSet calNumSet = new CalNumSet();
        calNumSet.setNumSetId(1);
        calNumSet.setMaxNum(maxNum0);
        calNumSet.setMinNum(minNum0);

        CalNumSet calNumSet2 = new CalNumSet();
        calNumSet2.setNumSetId(2);
        calNumSet2.setMaxNum(maxNum1);
        calNumSet2.setMinNum(minNum1);

        calNumSetMapper.updateByPrimaryKey(calNumSet2);
        calNumSetMapper.updateByPrimaryKey(calNumSet);
        map.put("data", calNumSetMapper.selectAll());
        map.put("alert1", "alert('保存成功')");
        return "cal/setCalNum";
    }

    /**
     * 获取所有的奖品等级
     * @return
     */
    @CrossOrigin(methods = {RequestMethod.GET,RequestMethod.POST})
    @RequestMapping("getPrizeLevel")
    @ResponseBody
    public Map<String, Object> getPrizeLevel() {
        List<CalPrizeLevel> calPrizeLevels = calPrizeLevelMapper.selectAll();
        Map<String, Object> data = new HashMap<>();
        data.put("errorCode", 200);
        data.put("data", calPrizeLevels);
        return data;
    }


    /**
     * 根据奖品等级获取奖品
     * @param prizeLevelId
     * @return
     */
    @CrossOrigin(methods = {RequestMethod.GET,RequestMethod.POST})
    @RequestMapping("getPrizeByLevelId")
    @ResponseBody
    public Map<String, Object> getPrizeByLevelId(Integer prizeLevelId) {
        List<CalPrize> calPrizes = calPrizeMapper.selectByLevelId(prizeLevelId);
        Map<String, Object> data = new HashMap<>();
        data.put("errorCode", 200);
        data.put("data", calPrizes);
        return data;
    }


    /**
     * 获取中奖列表
     * @param
     * @return
     */
    @CrossOrigin(methods = {RequestMethod.GET,RequestMethod.POST})
    @RequestMapping("getPrizeList")
    public String getPrizeList(ModelMap map) {
        List<Map<String,Object>> records = calNumRecordMapper.selectRecordsAll();
        map.put("data",records);
//        Map<String, Object> data = new HashMap<>();
//        data.put("errorCode", 200);
//        data.put("data", records);
        return "cal/getPrizeRecord";
    }

    /**
     * 重置
     * @param
     * @return
     */
    @CrossOrigin(methods = {RequestMethod.GET,RequestMethod.POST})
    @RequestMapping("resetData")
    @ResponseBody
    public Map<String, Object> resetData() {
        calNumRecordMapper.cleanTable();

        CalNumRecord calNumRecord = new CalNumRecord();
        calNumRecord.setPrizeId(0);
        calNumRecord.setRecordNum(4);
        calNumRecord.setNumSetId(0);
        calNumRecordMapper.insert(calNumRecord);

        CalNumRecord calNumRecord1 = new CalNumRecord();
        calNumRecord1.setPrizeId(0);
        calNumRecord1.setRecordNum(14);
        calNumRecord1.setNumSetId(0);
        calNumRecordMapper.insert(calNumRecord1);

        CalNumRecord calNumRecord2 = new CalNumRecord();
        calNumRecord2.setPrizeId(0);
        calNumRecord2.setRecordNum(24);
        calNumRecord2.setNumSetId(0);
        calNumRecordMapper.insert(calNumRecord2);

        CalNumRecord calNumRecord3 = new CalNumRecord();
        calNumRecord3.setPrizeId(0);
        calNumRecord3.setRecordNum(34);
        calNumRecord3.setNumSetId(0);
        calNumRecordMapper.insert(calNumRecord3);

        calPrizeMapper.updateAllData();
        Map<String, Object> data = new HashMap<>();
        data.put("errorCode", 200);
//        data.put("data", records);
        return data;
    }

}
