package com.gec.mall.service;

import com.gec.mall.pojo.Buyer;
import com.baomidou.mybatisplus.extension.service.IService;
import com.gec.mall.pojo.vo.BuyerVo;

import javax.servlet.http.HttpSession;

/**
* @author 1
* @description 针对表【buyer】的数据库操作Service
* @createDate 2022-12-30 23:54:50
*/
public interface BuyerService extends IService<Buyer> {

    String updateInformation(Buyer buyer, HttpSession session);

    String topUp(BuyerVo buyer, HttpSession session);
}
