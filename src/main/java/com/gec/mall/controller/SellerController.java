package com.gec.mall.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gec.mall.service.SellerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
public class SellerController {
    @Resource
    private SellerService sellerService;
    @GetMapping("/queryBuyer")
    public Page queryBuyer(@RequestParam Integer current){
        return sellerService.queryAllBuyer(current);
    }
}
