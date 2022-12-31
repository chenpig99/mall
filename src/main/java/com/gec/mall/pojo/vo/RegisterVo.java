package com.gec.mall.pojo.vo;

import com.gec.mall.pojo.Seller;

public class RegisterVo extends Seller {
    private Integer password;
    private Integer type;
    public Integer getPassword() {
        return password;
    }

    public void setPassword(Integer password) {
        this.password = password;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
