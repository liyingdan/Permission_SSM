package com.lyd.mapper;

import com.lyd.domain.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Long rid);

    int insert(Role record);

    Role selectByPrimaryKey(Long rid);

    List<Role> selectAll();

    int updateByPrimaryKey(Role record);

    /*保存角色与权限之间关系*/
    void insertRoleAndPermissionRel(@Param("rid") Long rid, @Param("pid") Long pid);

    /*打破之前的关系*/
    void deleRoleRel(Long rid);

    /*查询对应的角色*/
    List<Long> getRoleWithId(Long id);
}