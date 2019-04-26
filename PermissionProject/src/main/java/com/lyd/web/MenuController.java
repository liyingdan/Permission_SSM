package com.lyd.web;

import com.lyd.domain.AjaxRes;
import com.lyd.domain.Menu;
import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;
import com.lyd.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class MenuController {
    @Autowired
    private MenuService menuService;

    /*跳转到menu页面*/
    @RequestMapping("/menu")
    public String employee(){
        return "menu";
    }

    @RequestMapping("menuList")
    @ResponseBody
    public PageListRes menuList(QueryVo vo){
        PageListRes pageListRes = menuService.getMenuList(vo);
        return pageListRes;
    }

    /*加载父菜单*/
    @RequestMapping("/parentList")
    @ResponseBody
    public List<Menu> parentList(){
        return menuService.parentList();
    }

    /*保存菜单*/
    @RequestMapping("saveMenu")
    @ResponseBody
    public AjaxRes saveMenu(Menu menu){
        AjaxRes ajaxRes = new AjaxRes();
        try{
            menuService.insertMenu(menu);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("保存成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("保存失败");

        }
        return ajaxRes;
    }

    /*更新菜单*/
    @RequestMapping("updateMenu")
    @ResponseBody
    public AjaxRes updateMenu(Menu menu){
        return menuService.updateMenu(menu);
    }

    @RequestMapping("deleteMenu")
    @ResponseBody
    public AjaxRes deleteMenu(Long id){
        return menuService.deleteMenu(id);
    }

    /*获取树形菜单数据*/
    @RequestMapping("getTreeData")
    @ResponseBody
    public List<Menu> getTreeData(){
        return menuService.getTreeData();
    }
}
