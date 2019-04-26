package com.lyd.mapper;

import com.lyd.domain.Permission;
import java.util.List;

public interface PermissionMapper {
    int deleteByPrimaryKey(Long pid);

    int insert(Permission record);

    Permission selectByPrimaryKey(Long pid);

    List<Permission> selectAll();

    int updateByPrimaryKey(Permission record);

    /*根据rid查询权限*/
    List<Permission> getPermissionByRid(Long rid);
}