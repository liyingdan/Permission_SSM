package com.lyd.service.impl;

import com.lyd.domain.Department;
import com.lyd.mapper.DepartmentMapper;
import com.lyd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepartmentList() {
        return departmentMapper.selectAll();

    }
}
