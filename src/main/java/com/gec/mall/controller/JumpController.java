package com.gec.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class JumpController {
    /**
     * 动态跳转
     * @param index
     * @return
     */
    @RequestMapping("{index}")
    public String redirect(@PathVariable String index){
        return index;
    }

}
