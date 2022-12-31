package com.gec.mall.service;

import com.gec.mall.pojo.Buyer;
import com.gec.mall.pojo.UserLogin;
import com.baomidou.mybatisplus.extension.service.IService;
import com.gec.mall.pojo.vo.RegisterVo;

import javax.servlet.http.HttpSession;

/**
* @author 1
* @description 针对表【user_login】的数据库操作Service
* @createDate 2022-12-30 19:40:00
*/
public interface UserLoginService extends IService<UserLogin> {

    public String login(UserLogin userLogin,  HttpSession session);
    public String register(RegisterVo registerVo);
    public Buyer queryLoginUser(HttpSession session);

    void exit(HttpSession session);

    void updateUser(Buyer buyer);
}
