package com.lyd.util;

import javax.servlet.http.HttpServletRequest;

public class RequestUtil {
    /*创建本地线程变量*/
    public static ThreadLocal<HttpServletRequest> local = new ThreadLocal<>();

    public static HttpServletRequest getRequest(){
        return local.get();
    }

    public static void setRequest(HttpServletRequest request){
        local.set(request);
    }
}
