package com.gec.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.gec.mall.pojo.Buyer;
import com.gec.mall.pojo.Seller;
import com.gec.mall.pojo.UserLogin;
import com.gec.mall.pojo.vo.RegisterVo;
import com.gec.mall.service.BuyerService;
import com.gec.mall.service.SellerService;
import com.gec.mall.service.UserLoginService;
import com.gec.mall.mapper.UserLoginMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
* @author 1
* @description 针对表【user_login】的数据库操作Service实现
* @createDate 2022-12-30 19:40:00
*/
@Service
public class UserLoginServiceImpl extends ServiceImpl<UserLoginMapper, UserLogin>
    implements UserLoginService{
    @Resource
    private BuyerService buyerService;
    @Resource
    private SellerService sellerService;
    @Override
    public String login(UserLogin userLogin, HttpSession session) {
        LambdaQueryWrapper<UserLogin> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserLogin::getAccount,userLogin.getAccount())
                .eq(UserLogin::getPassword,userLogin.getPassword());
        UserLogin one = this.getOne(wrapper);
        if (one==null){
            //密码错误状态码
            return "2";
        }
        //存储登录用户
        session.setAttribute("user",one);
        //返回是买家还是卖家状态码
        return one.getType().toString();
    }

    @Override
    @Transactional
    public String register(RegisterVo registerVo) {
        LambdaQueryWrapper<UserLogin> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserLogin::getAccount, registerVo.getAccount());
        UserLogin one = this.getOne(wrapper);
        if (one!=null){
            //此时账号已存在，不可注册
            return "1";
        }
        UserLogin userLogin = new UserLogin();
        userLogin.setAccount(registerVo.getAccount());
        userLogin.setPassword(registerVo.getPassword());
        userLogin.setType(registerVo.getType());
        boolean save = this.save(userLogin);
        //卖家
        if (registerVo.getType()==0){
            Seller seller = new Seller();
            seller.setAccount(registerVo.getAccount());
            seller.setEmail(registerVo.getEmail());
            seller.setSex(registerVo.getSex());
            seller.setName(registerVo.getName());
            seller.setTelephone(registerVo.getTelephone());
            sellerService.save(seller);
        }else if(registerVo.getType()==1){
            //买家
            Buyer buyer = new Buyer();
            buyer.setAccount(registerVo.getAccount());
            buyer.setEmail(registerVo.getEmail());
            buyer.setSex(registerVo.getSex());
            buyer.setName(registerVo.getName());
            buyer.setTelephone(registerVo.getTelephone());
            buyerService.save(buyer);
        }
        return "0";
    }

    @Override
    public Buyer queryLoginUser(HttpSession session) {
        UserLogin user = (UserLogin)session.getAttribute("user");
        LambdaQueryWrapper<Buyer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Buyer::getAccount, user.getAccount());
        Buyer one = buyerService.getOne(wrapper);
        return one;
    }

    /**退出登录
     * @param session
     */
    @Override
    public void exit(HttpSession session) {
        session.invalidate();
    }

    @Override
    public void updateUser(Buyer buyer) {
        buyerService.updateById(buyer);
    }

}




