package com.lyd.web;

import com.lyd.domain.Permission;
import com.lyd.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class PermissionController {
    @Autowired
    private PermissionService permissionService;

    /*查询所有权限*/
    @RequestMapping("/permissionList")
    @ResponseBody
    public  List<Permission> permissionList(){
        List<Permission> permissions = permissionService.permissionList();
        return permissions;

    }

    /*根据rid(role)查询权限*/
    @RequestMapping("/getPermissionByRid")
    @ResponseBody
    public List<Permission> getPermissionByRid(Long rid){
        List<Permission> permissions =  permissionService.getPermissionByRid(rid);
        return permissions;
    }

}
