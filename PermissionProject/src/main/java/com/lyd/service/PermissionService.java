package com.lyd.service;

import com.lyd.domain.Permission;

import java.util.List;

public interface PermissionService {
    public List<Permission> permissionList();

    /*根据rid查询权限*/
    List<Permission> getPermissionByRid(Long rid);
}
