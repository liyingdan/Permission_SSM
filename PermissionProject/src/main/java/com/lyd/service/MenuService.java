package com.lyd.service;

import com.lyd.domain.AjaxRes;
import com.lyd.domain.Menu;
import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;

import java.util.List;

public interface MenuService {
    PageListRes getMenuList(QueryVo vo);

    /*查询所有的菜单*/
    List<Menu> parentList();

    /*保存菜单*/
    void insertMenu(Menu menu);

    /*更新菜单*/
    AjaxRes updateMenu(Menu menu);

    AjaxRes deleteMenu(Long id);

    List<Menu> getTreeData();

}
