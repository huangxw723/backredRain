package com.aoshi.service.manage.ownActivity;

import org.springframework.transaction.annotation.Transactional;

import com.aoshi.dao.AsOwnActivityDiscMapper;
import com.aoshi.domain.AsOwnActivityDisc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class OwnActivityDiscService {
	
	@Autowired
	private AsOwnActivityDiscMapper asOwnActivityDiscMapper;
	
	/**
	 * 根据id查询礼品池
	 * @param ownActivityId
	 * @return
	 */
	public List<AsOwnActivityDisc> queryById(Integer ownActivityId) {
		return asOwnActivityDiscMapper.queryById(ownActivityId);
	}
	
	/**
	 * 删除礼品池里面的奖品
	 * @param giftId
	 * @return
	 */
	public void deleteByGift(String giftId) {
		String[] ids = giftId.split(",");
		for (int i = 0; i < ids.length; i++) {
			asOwnActivityDiscMapper.deleteByPrimaryKey(Integer.parseInt(ids[i]));
		}
		
	}

}
