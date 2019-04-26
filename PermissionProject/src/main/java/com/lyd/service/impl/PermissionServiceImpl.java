package com.lyd.service.impl;

import com.lyd.domain.Permission;
import com.lyd.mapper.PermissionMapper;
import com.lyd.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Permission> permissionList() {
        return permissionMapper.selectAll();
    }

    /*根据rid查询权限*/
    @Override
    public List<Permission> getPermissionByRid(Long rid) {
        List<Permission> permissionByRid = permissionMapper.getPermissionByRid(rid);
        return permissionByRid;
    }
}
