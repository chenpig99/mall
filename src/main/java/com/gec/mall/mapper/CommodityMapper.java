package com.gec.mall.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gec.mall.pojo.Commodity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.gec.mall.pojo.Do.OrderDo;

import java.nio.charset.CoderResult;
import java.util.List;

/**
* @author 1
* @description 针对表【commodity】的数据库操作Mapper
* @createDate 2022-12-30 19:39:49
* @Entity com.gec.mall.pojo.Commodity
*/

public interface CommodityMapper extends BaseMapper<Commodity> {
    /**
     * 查询订单信息
     * @param page
     * @param account
     * @return
     */
    List queryCommodtityByUserId(Page<OrderDo> page);
}




