package com.gec.mall.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gec.mall.pojo.Commodity;
import com.baomidou.mybatisplus.extension.service.IService;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
* @author 1
* @description 针对表【commodity】的数据库操作Service
* @createDate 2022-12-30 19:39:49
*/
public interface CommodityService extends IService<Commodity> {
    Page<Commodity> queryCommodity(Integer currentPage);

    String purchase(Integer number, Integer id, HttpSession session);

    void releaseCommodity(Commodity commodity, HttpSession session) throws IOException;


    List queryOrder(Integer current);
}
