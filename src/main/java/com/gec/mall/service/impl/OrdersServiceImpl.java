package com.gec.mall.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.gec.mall.pojo.Orders;
import com.gec.mall.service.OrdersService;
import com.gec.mall.mapper.OrdersMapper;
import org.springframework.stereotype.Service;

/**
* @author 1
* @description 针对表【orders】的数据库操作Service实现
* @createDate 2022-12-31 19:39:02
*/
@Service
public class OrdersServiceImpl extends ServiceImpl<OrdersMapper, Orders>
    implements OrdersService{

}




