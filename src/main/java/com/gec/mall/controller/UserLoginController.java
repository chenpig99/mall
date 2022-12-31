package com.gec.mall.controller;

import com.gec.mall.pojo.Buyer;
import com.gec.mall.pojo.UserLogin;
import com.gec.mall.pojo.vo.RegisterVo;
import com.gec.mall.service.UserLoginService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@RestController
public class UserLoginController {
    @Resource
    private UserLoginService userLoginService;

    @PostMapping("/userLogin")
    public String login(@RequestBody UserLogin userLogin,  HttpSession session) {
        return userLoginService.login(userLogin,session);
    }

    @PostMapping("/userRegister")
    public String register(@RequestBody RegisterVo registerVo) {
        return userLoginService.register(registerVo);
    }
    @GetMapping("/queryLoginUser")
    public Buyer queryLoginUser(HttpSession session) {
        return userLoginService.queryLoginUser(session);
    }
    @GetMapping("/exit")
    public void exit(HttpSession session){
        userLoginService.exit(session);
    }
    @PostMapping("/updateUser")
    public void updateUser(@RequestBody Buyer buyer){
        userLoginService.updateUser(buyer);
    }
}
