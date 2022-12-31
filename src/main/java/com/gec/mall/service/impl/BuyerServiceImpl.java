package com.gec.mall.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.gec.mall.pojo.Buyer;
import com.gec.mall.pojo.vo.BuyerVo;
import com.gec.mall.service.BuyerService;
import com.gec.mall.mapper.BuyerMapper;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

/**
* @author 1
* @description 针对表【buyer】的数据库操作Service实现
* @createDate 2022-12-30 23:54:50
*/
@Service
public class BuyerServiceImpl extends ServiceImpl<BuyerMapper, Buyer>
    implements BuyerService{

    @Override
    public String updateInformation(Buyer buyer, HttpSession session) {
        boolean update = this.updateById(buyer);
        //0成功 1失败
        return update?"0":"1";
    }

    @Override
    public String topUp(BuyerVo buyer, HttpSession session) {
        //更新余额
        Buyer byId = this.getById(buyer.getId());
        byId.setBalance(buyer.getMoney()+byId.getBalance());
        this.updateById(byId);
        return byId.getBalance().toString();
    }
}




