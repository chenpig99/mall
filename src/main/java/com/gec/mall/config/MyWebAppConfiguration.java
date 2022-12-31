package com.gec.mall.config;

import com.gec.mall.utils.UploadUtils;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.io.File;

@Configuration
public class MyWebAppConfiguration extends WebMvcConfigurerAdapter {
    /**
     * 添加一些虚拟路径的映射
     * 静态资源路径和上传文件的路径
     *
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 存放上传图片的文件夹
        File fileDir = UploadUtils.getImgDirFile();
        // 输出文件夹绝对路径  -- 这里的绝对路径是相当于当前项目的路径而不是“容器”路径
        System.out.println(fileDir.getAbsolutePath());
            // 构建真实的文件路径
            File newFile = new File(fileDir.getAbsolutePath() + File.separator );
            System.out.println(newFile.getAbsolutePath());
            String f= fileDir.getAbsolutePath() + File.separator ;
            System.out.println("f = " + f);
            String k="file:"+f;
            // 上传图片到 -》 “绝对路径”



        /**
         * @Description: 对文件的路径进行配置, 创建一个虚拟路径/Path/** ，即只要在< img src="/Path/picName.jpg" />便可以直接引用图片
         *这是图片的物理路径  "file:/+本地图片的地址"
         */
        registry.addResourceHandler("/Path/**").addResourceLocations(k);
        super.addResourceHandlers(registry);
    }
}
