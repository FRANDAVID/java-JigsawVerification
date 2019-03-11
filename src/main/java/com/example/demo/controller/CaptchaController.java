package com.example.demo.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @version 0.1
 * @use 访问滑动验证码相关页面
 */
@Controller
public class CaptchaController {

    @GetMapping("/captcha")
    public String login(HttpServletResponse response, HttpServletRequest request){
        String userAgent = request.getHeader("user-agent");
        System.out.println(userAgent);
        Cookie cookie = new Cookie("cid","2");
        response.addCookie(cookie);
        return "login";

    }

    @GetMapping("/slider")
    public String slider(){
       return "slider";
    }
}
