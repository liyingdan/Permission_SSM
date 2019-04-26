package com.lyd.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lyd.domain.Employee;
import com.lyd.domain.PageListRes;
import com.lyd.domain.QueryVo;
import com.lyd.domain.Role;
import com.lyd.mapper.EmployeeMapper;
import com.lyd.service.EmployeeService;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public PageListRes getEmployee(QueryVo vo) {
        /*调用mapper 查询员工*/
        Page<Object> page = PageHelper.startPage(vo.getPage(), vo.getRows());
        List<Employee> employees = employeeMapper.selectAll(vo);
        /*封装成pageList*/
        PageListRes pageListRes = new PageListRes();
        pageListRes.setTotal(page.getTotal());
        pageListRes.setRows(employees);
        return pageListRes;


    }

    /*保存员工*/
    @Override
    public void insertEmployee(Employee employee) {
        /*把密码进行加密  把用户名当成盐*/
        Md5Hash md5Hash = new Md5Hash(employee.getPassword(), employee.getUsername(), 2);
        employee.setPassword(md5Hash.toString());

        /*保存员工*/
        employeeMapper.insert(employee);
        /*保存角色--关系表*/
        for (Role role : employee.getRoles()) {
            employeeMapper.insertEmployeeAndRoleRel(employee.getId(),role.getRid());
        }
    }

    @Override
    public void updateEmployee(Employee employee) {
        /*打破与角色之间的关系*/
        employeeMapper.deleteRoleRel(employee.getId());
        /*更新员工*/
        employeeMapper.updateByPrimaryKey(employee);
        /*重新建立与角色的关系*/
        for (Role role : employee.getRoles()) {
            employeeMapper.insertEmployeeAndRoleRel(employee.getId(),role.getRid());
        }

    }

    @Override
    public void updateState(Long id) {
        employeeMapper.updateState(id);
    }


    /*根据用户名和密码查询用户*/
    @Override
    public Employee getEmployeeWithUsername(String username) {
        Employee employee= employeeMapper.getEmployeeWithUsername(username);
        return employee;
    }

    /*根据用户的id查角色编号名称*/
    @Override
    public List<String> getRolesById(Long id) {
        return employeeMapper.getRolesById(id);
    }

    /*根据用户的id查权限 资源名称*/
    @Override
    public List<String> getPermissionbyId(Long id) {
        return employeeMapper.getPermissionbyId(id);
    }

    @Override
    public List<Employee> getAllEmployee() {
        return employeeMapper.selectAllEmployee();
    }


}
