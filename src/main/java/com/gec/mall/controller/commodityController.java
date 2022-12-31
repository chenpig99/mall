package com.gec.mall.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gec.mall.pojo.Commodity;
import com.gec.mall.service.CommodityService;
import com.gec.mall.utils.UploadUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
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
    public void releaseCommodity(@RequestBody Commodity commodity,HttpSession session) throws IOException {
         commodityService.releaseCommodity(commodity,session);
    }
    @GetMapping("/orderPage")
    public List queryOrder(@RequestParam Integer current){
        return commodityService.queryOrder(current);
    }
    @PostMapping("/upload")
    public void upload(@RequestParam("file") MultipartFile file, HttpSession session){
        MultipartFile imgFile=file;
        System.out.println("imgFile = " + imgFile.toString());
        // 拿到文件名
        String filename = imgFile.getOriginalFilename();

        // 存放上传图片的文件夹
        File fileDir = UploadUtils.getImgDirFile();
        // 输出文件夹绝对路径  -- 这里的绝对路径是相当于当前项目的路径而不是“容器”路径
        System.out.println(fileDir.getAbsolutePath());

        try {
            // 构建真实的文件路径
            File newFile = new File(fileDir.getAbsolutePath() + File.separator + filename);

            System.out.println(newFile.getAbsolutePath());
            String f= fileDir.getAbsolutePath() + File.separator;
            System.out.println("f = " + f);
            session.setAttribute("pic","/Path/"+filename);
            // 上传图片到 -》 “绝对路径”
            imgFile.transferTo(newFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("file = " + file);
    }
}
