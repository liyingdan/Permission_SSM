package com.lyd.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lyd.domain.PageListRes;
import com.lyd.domain.Permission;
import com.lyd.domain.QueryVo;
import com.lyd.domain.Role;
import com.lyd.mapper.RoleMapper;
import com.lyd.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public PageListRes getRoles(QueryVo vo) {
        Page<Object> page = PageHelper.startPage(vo.getPage(), vo.getRows());
        List<Role> roles = roleMapper.selectAll();
        /*封装成pageList*/
        PageListRes pageListRes = new PageListRes();
        pageListRes.setTotal(page.getTotal());
        pageListRes.setRows(roles);
        return pageListRes;

    }

    @Override
    public void saveRole(Role role) {
        /*1.保存角色*/
        roleMapper.insert(role);
        /*2.保存角色与权限之间关系*/
        for (Permission permission : role.getPermissions()) {
            roleMapper.insertRoleAndPermissionRel(role.getRid(),permission.getPid());
        }
    }

    /*更新角色*/
    @Override
    public void updateRole(Role role) {
        /*打破之前的关系*/
        roleMapper.deleRoleRel(role.getRid());
        /*更新角色*/
        roleMapper.updateByPrimaryKey(role);
        /*重新保存角色与权限的关系*/
        for (Permission permission : role.getPermissions()) {
            roleMapper.insertRoleAndPermissionRel(role.getRid(),permission.getPid());
        }
    }

    /*删除角色*/
    @Override
    public void deleteRole(Long rid) {
        /*先删除角色与功能对应关系*/
        roleMapper.deleRoleRel(rid);
        /*再删除角色*/
        roleMapper.deleteByPrimaryKey(rid);
    }

    @Override
    public List<Role> getAllList() {
        return roleMapper.selectAll();
    }

    @Override
    /*查询对应的角色*/
    public List<Long> getRoleByEid(Long id) {
        return roleMapper.getRoleWithId(id);
    }
}
