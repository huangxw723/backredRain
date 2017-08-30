package com.aoshi.service.manage.consultation.type;

import com.aoshi.dao.AsConsultationTypeMapper;
import com.aoshi.domain.AsConsultationType;
import com.aoshi.service.base.AsBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AsConsultationTypeService extends AsBaseService {
    @Autowired
    AsConsultationTypeMapper asConsultationTypeMapper;

    public int deleteByPrimaryKey(Integer consultationInfoId){
        return asConsultationTypeMapper.deleteByPrimaryKey(consultationInfoId);
    }

    public AsConsultationType selectByPrimaryKey(Integer id){
        return asConsultationTypeMapper.selectByPrimaryKey(id);
    }

    public int updateByPrimaryKeySelective(AsConsultationType asConsultationType){
        asConsultationType.setTypeImg("");//图片（字段暂时没用）
        AsConsultationType  pAsConsultationType=asConsultationTypeMapper.selectByPrimaryKey(asConsultationType.getParentId());
        asConsultationType.setTypeLevel(pAsConsultationType.getTypeLevel()+1);
        return asConsultationTypeMapper.updateByPrimaryKeySelective(asConsultationType);
    }

    public int insertSelective(AsConsultationType asConsultationType){
        asConsultationType.setTypeImg("");//图片（字段暂时没用）
        asConsultationType.setTypeLevel(asConsultationType.getTypeLevel()+1);
        return asConsultationTypeMapper.insertSelective(asConsultationType);
    }

    public List<AsConsultationType> getTypes(AsConsultationType asConsultationType) {
        return asConsultationTypeMapper.selectAll(asConsultationType);
    }
}
