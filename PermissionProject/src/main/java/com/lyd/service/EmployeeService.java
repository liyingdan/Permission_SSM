package com.lyd.service;

import com.lyd.domain.Employee;
import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;

import java.util.List;

public interface EmployeeService {
    /*查询员工*/
    public PageListRes getEmployee(QueryVo vo);

    void insertEmployee(Employee employee);

    void updateEmployee(Employee employee);
/*设置员工离职状态*/
    void updateState(Long id);

    /*根据用户名和密码查询用户*/
    Employee getEmployeeWithUsername(String username);

    /*根据用户的id查角色*/
    List<String> getRolesById(Long id);

    /*根据用户的id查权限 资源名称*/
    List<String> getPermissionbyId(Long id);

    List<Employee> getAllEmployee();
}
