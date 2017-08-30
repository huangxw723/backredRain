package com.aoshi.service.manage.yp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aoshi.common.asenum.BaseCategoryTypeEnum;
import com.aoshi.controller.base.BaseController;
import com.aoshi.dao.AsYpBaseCategoryMapper;
import com.aoshi.dao.AsYpTypeStatisticsMapper;
import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.domain.AsYpTypeStatistics;
import com.aoshi.resolver.ValidatorBreakException;
import com.aoshi.service.base.AsBaseService;
import com.aoshi.util.CommonUtils;

/**
 * 基础功能Service
 * 
 * @author yangyanchao
 * @date 2016年10月27日
 */
@Service
public class YpPublicService extends AsBaseService {

	private final static String PAGE_PATH = "manage/yp/public/";

	@Autowired
	private AsYpTypeStatisticsMapper asYpTypeStatisticsMapper;

	@Autowired
	private AsYpBaseCategoryMapper asYpBaseCategoryMapper;

	/**
	 * 获取服务分类统计
	 * 
	 * @author yangyanchao
	 * @date 2016年10月26日
	 * @param c
	 * @return
	 */
	public Object getTypeList(BaseController c) {

		initialized(c);

		pd.put("type", BaseCategoryTypeEnum.YP_SHOP_TYPE.getId());
		pageQueryModule(asYpBaseCategoryMapper, "findByType", true);

		return renderView(PAGE_PATH + "shop_type_list");
	}

	/**
	 * 添加行业信息
	 * 
	 * @author yangyanchao
	 * @date 2016年10月27日
	 * @param c
	 * @return
	 */
	public Object addType(BaseController c) {

		initialized(c);

		String name = pd.getParaForString("name");

		// 查找相同类型是否存在
		boolean isExists = asYpBaseCategoryMapper.findByName(name,
				BaseCategoryTypeEnum.YP_SHOP_TYPE.getId()) > 0;
		ValidatorBreakException.NOT_TRUE(!isExists, "该分类已存在");

		// 添加记录
		AsYpBaseCategory asYpBaseCategory = new AsYpBaseCategory();
		asYpBaseCategory.setCreateTime(CommonUtils.getCurDate());
		asYpBaseCategory.setName(name);
		asYpBaseCategory.setType(BaseCategoryTypeEnum.YP_SHOP_TYPE.getId());
		operaFlag = asYpBaseCategoryMapper.insertSelective(asYpBaseCategory) == 1;
		ValidatorBreakException.NOT_TRUE(!isExists);

		return renderSuccess();
	}

	/**
	 * 获取服务内容分类
	 * 
	 * @author yangyanchao
	 * @date 2016年10月27日
	 * @param c
	 * @return
	 */
	public Object getServiceTypeList(BaseController c) {

		initialized(c);

		pd.put("type", BaseCategoryTypeEnum.YP_SERVICE_TYPE.getId());
		pageQueryModule(asYpTypeStatisticsMapper, "getYpServiceTypeList", true);

		return renderView(PAGE_PATH + "service_type_list");
	}

	/**
	 * 添加服务内容
	 * 
	 * @author yangyanchao
	 * @date 2016年10月27日
	 * @param c
	 * @return
	 */
	public Object addServiceType(BaseController c) {

		initialized(c);

		String name = pd.getParaForString("name");

		// 查找相同类型是否存在
		boolean isExists = asYpBaseCategoryMapper.findByName(name,
				BaseCategoryTypeEnum.YP_SERVICE_TYPE.getId()) > 0;
		ValidatorBreakException.NOT_TRUE(!isExists, "该分类已存在");

		// 添加记录
		AsYpBaseCategory asYpBaseCategory = new AsYpBaseCategory();
		asYpBaseCategory.setCreateTime(CommonUtils.getCurDate());
		asYpBaseCategory.setName(name);
		asYpBaseCategory.setType(BaseCategoryTypeEnum.YP_SERVICE_TYPE.getId());
		operaFlag = asYpBaseCategoryMapper.insertSelective(asYpBaseCategory) == 1;
		ValidatorBreakException.NOT_TRUE(!isExists);

		// 添加初始统计记录
		AsYpTypeStatistics asYpTypeStatistics = new AsYpTypeStatistics();
		asYpTypeStatistics.setCategoryId(asYpBaseCategory.getId());
		asYpTypeStatistics.setCounts(0);
		asYpTypeStatistics.setCreateTime(CommonUtils.getCurDate());
		operaFlag = asYpTypeStatisticsMapper
				.insertSelective(asYpTypeStatistics) == 1;
		ValidatorBreakException.NOT_TRUE(operaFlag);

		return renderSuccess();
	}
}
