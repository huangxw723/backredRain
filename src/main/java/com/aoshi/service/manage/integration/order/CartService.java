package com.aoshi.service.manage.integration.order;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.dao.AsCartMapper;
import com.aoshi.dao.DaoSupport;
import com.aoshi.domain.AsCart;
import com.aoshi.util.PageData;

@Service
public class CartService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	@Autowired
	private AsCartMapper mapper;

	/*
	 * 删除
	 */
	public int delete(int cartId) throws Exception {
		return mapper.deleteByPrimaryKey(cartId);
	}

	/*
	 * 批量删除
	 */
	public int deleteAll(String[] cartId) {
		return mapper.deleteByPrimaryKeys(cartId);
	}

	/*
	 * 列表
	 */
	public List<AsCart> list(PageData pd) {
		return mapper.selectByAttr(pd);
	}

	/*
	 * 列表
	 */
	public List<AsCart> listUser(PageData pd) {
		return mapper.selectCartUser(pd);
	}

	/*
	 * 列表
	 */
	public List<AsCart> listGoods(PageData pd) {
		return mapper.selectCartGoods(pd);
	}

	/*
	 * 列表
	 */
	public List<AsCart> listShop(PageData pd) {
		return mapper.selectCartShop(pd);
	}

}
