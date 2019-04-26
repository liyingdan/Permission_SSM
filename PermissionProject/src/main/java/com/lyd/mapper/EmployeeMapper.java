package com.lyd.mapper;

import com.lyd.domain.Employee;
import com.lyd.domain.QueryVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Employee record);

    Employee selectByPrimaryKey(Long id);

    List<Employee> selectAll(QueryVo vo);

    int updateByPrimaryKey(Employee record);

    void updateState(Long id);

    /*保存角色--关系表*/
    void insertEmployeeAndRoleRel(@Param("id") Long id, @Param("rid") Long rid);

    /*打破与角色之间的关系*/
    void deleteRoleRel(Long id);

    /*根据用户名查询用户*/
    Employee getEmployeeWithUsername(String username);

    /*根据用户的id查角色编号名称*/
    List<String> getRolesById(Long id);

    /*根据用户的id查权限 资源名称*/
    List<String> getPermissionbyId(Long id);

    List<Employee> selectAllEmployee();
}