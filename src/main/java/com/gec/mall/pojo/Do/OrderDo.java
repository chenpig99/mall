package com.gec.mall.pojo.Do;

import com.gec.mall.pojo.Commodity;
import com.gec.mall.pojo.Orders;

public class OrderDo extends Orders {
    //买家名
    private String name;
    private String telephone;
    private String email;
    //商品名
    private String coName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCoName() {
        return coName;
    }

    public void setCoName(String coName) {
        this.coName = coName;
    }
}
