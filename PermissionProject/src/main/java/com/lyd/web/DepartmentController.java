package com.lyd.web;

import com.lyd.domain.Department;
import com.lyd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("departmentList")
    @ResponseBody/*返回json格式数据*/
    public List<Department> departmentList(){
        List<Department> departmentList = departmentService.getDepartmentList();
        return departmentList;

    }
}
