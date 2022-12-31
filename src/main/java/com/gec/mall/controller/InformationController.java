package com.gec.mall.controller;

import com.gec.mall.pojo.Buyer;
import com.gec.mall.pojo.vo.BuyerVo;
import com.gec.mall.service.BuyerService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@RestController
public class InformationController {
        @Resource
        private BuyerService buyerService;
        @PostMapping("/updateInformation")
        public String updateInformation(@RequestBody Buyer buyer, HttpSession session){
            return buyerService.updateInformation(buyer,session);
        }

    @PostMapping("/topUp")
    public String topUp(@RequestBody BuyerVo buyer, HttpSession session){
        return buyerService.topUp(buyer,session);
    }
}
