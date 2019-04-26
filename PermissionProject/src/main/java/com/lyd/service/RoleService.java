package com.lyd.service;

import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;
import com.lyd.domain.Role;

import java.util.List;

public interface RoleService {
    /*获取全部角色*/
    public PageListRes getRoles(QueryVo vo);

    /*保存角色和权限*/
    void saveRole(Role role);

    /*更新角色*/
    void updateRole(Role role);

    /*删除角色*/
    void deleteRole(Long rid);

    List<Role> getAllList();

    /*查询对应的角色*/
    List<Long> getRoleByEid(Long id);
}
