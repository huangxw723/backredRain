package com.aoshi.dao;

import com.aoshi.domain.AsRobotConsult;

public interface AsRobotConsultMapper extends AsBaseMapper {
    int deleteByPrimaryKey(Integer robotConsultId);

    int insert(AsRobotConsult record);

    int insertSelective(AsRobotConsult record);

    AsRobotConsult selectByPrimaryKey(Integer robotConsultId);

    int updateByPrimaryKeySelective(AsRobotConsult record);

    int updateByPrimaryKey(AsRobotConsult record);
}