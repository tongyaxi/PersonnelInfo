package com.tongyaxi.personnelinfo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tongyaxi.personnelinfo.bean.Department;
import com.tongyaxi.personnelinfo.service.DepartmentService;
import com.tongyaxi.personnelinfo.utils.R;

@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public R getDepts() {
		List<Department> depts = departmentService.getDepts();
		return R.success().add("depts", depts);
	}
}
