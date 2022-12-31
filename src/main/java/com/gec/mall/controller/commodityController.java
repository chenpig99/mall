package com.gec.mall.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gec.mall.pojo.Commodity;
import com.gec.mall.pojo.Do.OrderDo;
import com.gec.mall.service.CommodityService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@RestController()
public class commodityController {
    @Resource
    private CommodityService commodityService;
    @GetMapping("/queryCommodity")
    public Page queryCommodity(@RequestParam Integer currentPage){
        return commodityService.queryCommodity(currentPage);
    }
    @GetMapping("/purchase")
    public String purchase(@RequestParam Integer id, @RequestParam Integer number, HttpSession session){
        return commodityService.purchase(number,id,session);
    }
    @PostMapping("/releaseCommodity")
    public void releaseCommodity(@RequestBody Commodity commodity,HttpSession session){
         commodityService.releaseCommodity(commodity,session);
    }
    @GetMapping("/orderPage")
    public List queryOrder(@RequestParam Integer current){
        return commodityService.queryOrder(current);
    }
}
