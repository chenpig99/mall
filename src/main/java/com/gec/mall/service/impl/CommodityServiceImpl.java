package com.gec.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.gec.mall.pojo.*;

import com.gec.mall.pojo.Do.OrderDo;
import com.gec.mall.service.BuyerService;
import com.gec.mall.service.CommodityService;
import com.gec.mall.mapper.CommodityMapper;

import com.gec.mall.service.OrdersService;
import com.gec.mall.service.SellerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Currency;
import java.util.Date;
import java.util.List;

/**
* @author 1
* @description 针对表【commodity】的数据库操作Service实现
* @createDate 2022-12-30 19:39:49
*/
@Service
public class CommodityServiceImpl extends ServiceImpl<CommodityMapper, Commodity>
    implements CommodityService{
    @Resource
    private BuyerService buyerService;
    @Resource
    private OrdersService orderService;
    @Resource
    private SellerService sellerService;
    @Resource
    private CommodityMapper commodityMapper;
    @Override
    public Page<Commodity> queryCommodity(Integer currentPage) {
        LambdaQueryWrapper<Commodity> wrapper = new LambdaQueryWrapper<>();
        wrapper.ge(Commodity::getInventory,0);
        Page<Commodity> page = new Page<>(currentPage, 10);
        return this.page(page,wrapper);
    }

    @Override
    @Transactional
    public String purchase(Integer number, Integer id, HttpSession session){
        LambdaQueryWrapper<Buyer> wrapper = new LambdaQueryWrapper<>();
        Commodity commodity = this.getById(id);
        //库存
        Integer inventory = commodity.getInventory();
        UserLogin user = (UserLogin)session.getAttribute("user");
        wrapper.eq(Buyer::getAccount,user.getAccount());
        Buyer buyer = buyerService.getOne(wrapper);
        if (number>inventory){
            return "库存不足！请重新输入";
        }
        if (buyer.getBalance()<number*commodity.getPrice()){
            return "余额不足！";
        }
        //购买ok,更新商品数据和用户数据
        commodity.setInventory(commodity.getInventory()-number);
        buyer.setBalance(buyer.getBalance()-number*commodity.getPrice());
        this.updateById(commodity);
        buyerService.updateById(buyer);
        //创建订单
        Orders order = new Orders();
        order.setAmount(number*commodity.getPrice());
        order.setCommodityNumber(number);
        order.setCreateTime(null);
        order.setCommodityId(commodity.getId());
        order.setBuyerId(buyer.getId());
        order.setCreateTime(new Date());
        System.out.println("order = " + order.toString());
        orderService.save(order);
        return "购买成功！";
    }

    /**
     * 发布商品
     * @param commodity
     * @param session
     */
    @Override
    @Transactional
    public void releaseCommodity(Commodity commodity, HttpSession session) {
        UserLogin user = (UserLogin)session.getAttribute("user");
        String account = user.getAccount();
        LambdaQueryWrapper<Seller> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Seller::getAccount,account);
        Seller one = sellerService.getOne(wrapper);
        Integer id = one.getId();
        commodity.setSellerId(id);
        this.save(commodity);
    }

    /**
     * 查看订单
     * @return
     */
    @Override
    public List queryOrder(Integer current){
        Page<OrderDo> page = new Page<>(current, 10);
        return commodityMapper.queryCommodtityByUserId(page);
    }
}




