package com.gec.mall.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.gec.mall.pojo.Buyer;
import com.gec.mall.pojo.Seller;
import com.gec.mall.service.BuyerService;
import com.gec.mall.service.SellerService;
import com.gec.mall.mapper.SellerMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
* @author 1
* @description 针对表【seller】的数据库操作Service实现
* @createDate 2022-12-30 23:55:56
*/
@Service
public class SellerServiceImpl extends ServiceImpl<SellerMapper, Seller>
    implements SellerService{
    @Resource
    private BuyerService buyerService;
    @Override
    public Page queryAllBuyer(Integer current) {
        Page<Buyer> page = new Page<>(current, 10);
        return buyerService.page(page);
    }
}




