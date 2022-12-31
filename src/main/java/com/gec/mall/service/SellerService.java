package com.gec.mall.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gec.mall.pojo.Seller;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author 1
* @description 针对表【seller】的数据库操作Service
* @createDate 2022-12-30 23:55:56
*/
public interface SellerService extends IService<Seller> {

    Page queryAllBuyer(Integer current);
}
