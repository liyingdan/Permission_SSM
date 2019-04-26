package com.lyd.interceptor;

import com.lyd.util.RequestUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequestInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        System.out.println("来到了拦截器....");
        //把当前请求保存到数据库当中
        RequestUtil.setRequest(request);
        return true;
    }
}
