package com.lyd.web;

import com.lyd.domain.AjaxRes;
import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;
import com.lyd.domain.Role;
import com.lyd.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class RoleController {
    @Autowired
    private RoleService roleService;

    @RequestMapping("/role")
    public String employee(){
        return "role";
    }

    /*获取全部角色*/
    @RequestMapping("getRoles")
    @ResponseBody
    public PageListRes getRoles(QueryVo vo){
        PageListRes roles = roleService.getRoles(vo);
        return roles;
    }

    /*接收保存角色*/
    @RequestMapping("saveRole")
    @ResponseBody
    public AjaxRes saveRole(Role role){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            /*调用业务层，保存角色和权限*/
            roleService.saveRole(role);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("保存成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("保存失败");

        }
        return ajaxRes;

    }

    /*更新角色*/
    @RequestMapping("/updateRole")
    @ResponseBody
    public AjaxRes updateRole(Role role){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            roleService.updateRole(role);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("更新角色成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("更新角色失败");

        }
        return ajaxRes;
    }

    /*删除角色*/
    @RequestMapping("deleteRole")
    @ResponseBody
    public AjaxRes deleteRole(Long rid){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            roleService.deleteRole(rid);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("删除角色成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除角色失败");

        }
        return ajaxRes;
    }

    /*获取全部角色-不分页*/
    @RequestMapping("roleList")
    @ResponseBody
    public List<Role> roleList(){
        return roleService.getAllList();
    }

    /*根据用户id查询对应的角色*/
    @RequestMapping("getRoleByEid")
    @ResponseBody
    public List<Long> getRoleByEid(Long id){
        /*查询对应的角色*/
        return roleService.getRoleByEid(id);
    }

}
