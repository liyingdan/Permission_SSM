package com.lyd.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lyd.domain.*;
import com.lyd.mapper.MenuMapper;
import com.lyd.service.MenuService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Iterator;
import java.util.List;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;

    @Override
    public PageListRes getMenuList(QueryVo vo) {
        Page<Object> page = PageHelper.startPage(vo.getPage(), vo.getRows());
        List<Menu> menus = menuMapper.selectAll();
        /*封装成pageList*/
        PageListRes pageListRes = new PageListRes();
        pageListRes.setTotal(page.getTotal());
        pageListRes.setRows(menus);
        return pageListRes;

    }

    /*查询所有的菜单*/
    @Override
    public List<Menu> parentList() {
        return menuMapper.selectAll();
    }

    @Override
    public void insertMenu(Menu menu) {
        menuMapper.insert(menu);
    }

    /*更新菜单*/
    @Override
    public AjaxRes updateMenu(Menu menu) {
        AjaxRes ajaxRes = new AjaxRes();
        /*判断 选择的父菜单 是不是自己的子菜单*/
        /*先取出当前选择的父菜单id*/
        Long id = menu.getParent().getId();
        /*查询该id对应的menu*/
        Long parent_id = menuMapper.selectParentid(id);
        if(menu.getId() == parent_id){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("不能设置自己的子菜单为父菜单");
            return ajaxRes;
        }
        /*参数都没问题之后更新菜单*/
        try{
            menuMapper.updateByPrimaryKey(menu);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("更新成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("更新失败");

        }
        return ajaxRes;

    }

    @Override
    public AjaxRes deleteMenu(Long id) {
        AjaxRes ajaxRes = new AjaxRes();
        try{
            /*先删除关系*/
            menuMapper.updateMenuRel(id);
            /*删除菜单*/
            menuMapper.deleteByPrimaryKey(id);
            ajaxRes.setSuccess(true);
            ajaxRes.setMsg("删除成功");
        }catch (Exception e){
            ajaxRes.setSuccess(false);
            ajaxRes.setMsg("删除失败");

        }
        return ajaxRes;
    }

    /*获取树形菜单数据*/
    @Override
    public List<Menu> getTreeData() {
        List<Menu> treeData = menuMapper.getTreeData();
        /*判断当前用户有没有对应的权限，如果没有就从集合中移除*/
        /*获取用户，判断用户是否是管理员 是管理员就不需要做判断*/
        Subject subject = SecurityUtils.getSubject();
        /*当前的用户*/
        Employee employee = (Employee) subject.getPrincipal();
        if(!employee.getAdmin()){
            /*做检验权限*/
            checkPermission(treeData);
        }
        return treeData;
    }

    public void checkPermission(List<Menu> menus){
        //获取主体
        Subject subject = SecurityUtils.getSubject();

        //遍历所有的菜单及子菜单
        Iterator<Menu> iterator = menus.iterator();
        while (iterator.hasNext()){
            Menu menu = iterator.next();
            if(menu.getPermission() != null){
                //判断当前menu是否有权限对象，如果说没有 当前遍历的菜单从集合中移除
                String presource = menu.getPermission().getPresource();
                if(!subject.isPermitted(presource)){
                    //当前遍历的菜单从集合中移除
                    iterator.remove();
                    continue;
                }
            }
            /*判断是否有子菜单 有子菜单也要做权限检验*/
            if(menu.getChildren().size() > 0){
                checkPermission(menu.getChildren());
            }
        }
    }





}
