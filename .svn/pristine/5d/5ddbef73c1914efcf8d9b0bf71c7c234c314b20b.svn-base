package com.aoshi.dao;

import com.aoshi.domain.AsYpBaseCategory;
import com.aoshi.util.Conditions;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * 基础分类管理mapper
 *
 * @author tgb 创建时间：2016年10月26日
 * @version 1.0
 */
public interface AsYpBaseCategoryMapper extends AsBaseMapper {

    int deleteByPrimaryKey(Integer id);

    int insertCategory(AsYpBaseCategory category);

    int insertSelective(AsYpBaseCategory category);

    AsYpBaseCategory selectByPrimaryKey(Integer id);

    Object findById(Integer id);

    /**
     * 查找所有礼品分类
     *
     * @param type =3
     * @return
     * @author tgb
     * 创建时间：2016年11月7日
     * @version 1.0
     */
    List<AsYpBaseCategory> queryPrizeListAll(Integer type);

    /**
     * 查找优惠券标签
     *
     * @param conditions
     * @return
     * @author tgb 创建时间：2016年11月7日
     * @version 1.0
     */
    List<Object> queryCouponsListAll(Object conditions);

    List<AsYpBaseCategory> getCouponsListAll();

    /**
     * 查找指定分类
     *
     * @param type
     * @return
     * @author tgb 创建时间：2016年11月9日
     * @version 1.0
     */
    List<AsYpBaseCategory> queryCategoryList(Integer type);

    /**
     * 查找所有的分类
     *
     * @param conditions
     * @return
     * @author tgb 创建时间：2016年11月7日
     * @version 1.0
     */
    List<Conditions> queryListAll(Object conditions);

    /**
     * 修改分类的信息
     *
     * @param category 修改的分类
     * @return
     * @author tgb
     * 创建时间：2016年11月7日
     * @version 1.0
     */
    @Update(value = "UPDATE as_yp_base_category SET `name` = #{name} , type = #{type} WHERE id = #{id}")
    int updateCategory(AsYpBaseCategory category);

    /**
     * 检查是否重名
     *
     * @param name 检查的名称
     * @param type 分类类型
     * @return
     * @author tgb
     * 创建时间：2016年11月7日
     * @version 1.0
     */
    @Select(value = "SELECT COUNT(*) FROM as_yp_base_category WHERE `name` = #{name} and type = #{type} and status = 0")
    int findByName(@Param(value = "name") String name, @Param(value = "type") Integer type);

    /**
     * 修改 分类的状态  0 启用 ， 1 禁用
     *
     * @param id
     * @return
     * @author tgb
     * 创建时间：2016年11月7日
     * @version 1.0
     */
    @Update(value = "UPDATE as_yp_base_category SET status = 1 WHERE id = #{id}")
    int updateCategoryStatus(@Param(value = "id") Integer id);

    /**
     * 查询所属类型分类列表
     *
     * @param conditions
     * @return
     * @author yangyanchao
     * @date 2016年10月27日
     */
    List<Object> findByType(Object conditions);


    @Select("select * from as_yp_base_category where type = 3 and status = 0")
    List<AsYpBaseCategory> selectAllPrize();

    @Select(value = "select * from as_yp_base_category where type = 2 and status = 0")
    List<AsYpBaseCategory> getYpCategories();

    /**
     * 查询全部美食品类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 6 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getfoodCategories();

    /**
     * 查询可显示的美食品类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 6 and status = 0")
    List<AsYpBaseCategory> getfoodCategoriesShow();

    /**
     * 查询可显示品类列表(包括美食品类、逛街、商场、店铺、店铺美食)
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type IN(6,7,8,9,10) and status = 0 order by type asc")
    List<AsYpBaseCategory> getCategoriesShow();

    /**
     * 查询逛街分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 7 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getshoppingCategories();


    /**
     * 查询可显示的逛街分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 7 and status = 0")
    List<AsYpBaseCategory> getshoppingCategoriesShow();

    /**
     * 查询商场分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 8 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getmarketCategories();

    /**
     * 查询可显示的商场分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 8 and status = 0 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getmarketCategoriesShow();

    /**
     * 查询店铺分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 9 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getshopCategories();

    /**
     * 查询可显示的店铺分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 9 and status = 0")
    List<AsYpBaseCategory> getshopCategoriesShow();

    /**
     * 菜式分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 10 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getDishesList();

    /**
     * 酒店品牌分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 11 order by sort_order asc,create_time desc")
    List<AsYpBaseCategory> getHotelList();

    /**
     * 查询可显示的菜式分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 10 and status = 0")
    List<AsYpBaseCategory> getDishesListShow();

    /**
     * 查询可显示的酒店品牌分类列表
     *
     * @return
     */
    @Select(value = "select * from as_yp_base_category where type = 11 and status = 0")
    List<AsYpBaseCategory> getHotelListShow();

    /**
     * 查询全部状态下的美食品类
     *
     * @param id
     * @return
     */
    AsYpBaseCategory selectById(Integer id);

    @Select(value = "select * from as_yp_base_category where type = #{type} AND status = 0")
    List<AsYpBaseCategory> selectCaterory(@Param(value = "type") int type);

    List<AsYpBaseCategory> queryNameList(AsYpBaseCategory record);

    @Select("select * from as_yp_base_category where type=12")
    List<AsYpBaseCategory> selectNameAll();


}