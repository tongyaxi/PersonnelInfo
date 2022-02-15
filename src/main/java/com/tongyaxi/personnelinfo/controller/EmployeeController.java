package com.tongyaxi.personnelinfo.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.tongyaxi.personnelinfo.bean.Employee;
import com.tongyaxi.personnelinfo.service.EmployeeService;
import com.tongyaxi.personnelinfo.utils.R;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 查询员工列表（分页查询）
	 * 返回JSP
	 * @return
	 */
	@RequestMapping("/empsbk")
	public String getAllEmps(@RequestParam(value="pageIndex", defaultValue="1") Integer pageIndex, Model model) {
		
		// 分页查询--查询当前页page，3条内容，默认查询总数count
		PageHelper.startPage(pageIndex, 5);
		List<Employee> emps = employeeService.getAllEmps();
		
		// 用PageInfo对查询结果进行封装,封装了详细的分页信息，只需返回PageInfo(3:传入连续显示的页数)
		PageInfo pageInfo = new PageInfo(emps, 3);
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}
	
	/**
	 * 查询员工列表（分页查询）
	 * @ResponseBody:返回JSON字符串(需要导入jackson包)
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public R getAllEmpsWithJSON(@RequestParam(value="pageIndex", defaultValue="1") Integer pageIndex) {
		
		// 分页查询--查询当前页page，3条内容，默认查询总数count
		PageHelper.startPage(pageIndex, 5);
		List<Employee> emps = employeeService.getAllEmps();
		
		// 用PageInfo对查询结果进行封装,封装了详细的分页信息，只需返回PageInfo(3:传入连续显示的页数)
		PageInfo pageInfo = new PageInfo(emps, 3);
		return R.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 对姓名是否已存在进行校验
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkName")
	@ResponseBody
	public R checkName(@RequestParam(value="empName") String empName) {
		
		// 正则表达式校验
		String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8}$)";
		if(!Pattern.matches(regName, empName)) {
			return R.fail().add("validateMsg", "姓名须是6~16位英文数字或2~8位中文！");
		}
		// 姓名存在与否校验
		boolean bol = employeeService.checkName(empName);
		if(bol) {
			return R.success();
		}else {
			return R.fail().add("validateMsg", "姓名已存在！");
		}
	}
	
	/**
	 * 新增员工
	 *
	 * @return
	 */
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public R insertEmployee(@Valid Employee employee, BindingResult result) {
		if(result.hasErrors()) {
			Map<String,Object> map = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error :errors) {
				// getFiled表示错误的字段名
				// getDefaultMessage表示JavaBean定义的错误信息
				map.put(error.getField(), error.getDefaultMessage());
			}
			return R.fail().add("errorFields", map);
		}else {
			int rows = employeeService.insertEmployee(employee);
			return R.success();
		}
	}
	
	/**
	 * 根据ID查询人员信息
	 *
	 * @return
	 */
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	@ResponseBody
	public R getEmployee(@PathVariable("id") Integer id) {
		Employee emp = employeeService.getEmployeeById(id);
		return R.success().add("emp",emp);
	}
	
	/**
	 * 更新人员信息
	 * 需要配置HttpPutFormContentFilter，来支持PUT请求
	 * 作用：将请求体中的数据解析封装成map
	 * request被重新包装，request.getParameter被重写，就会从自己封装的map中取数据。
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	@ResponseBody
	public R updateEmployee(Employee emp) {
		System.out.println("更新数据："+emp.toString());
		int rows = employeeService.updateEmployee(emp);
		return R.success().add("rows",rows);
	}
	
	/**
	 * 删除人员信息
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}", method=RequestMethod.DELETE)
	@ResponseBody
	public R deleteEmployee(@PathVariable("ids") String ids) {
		int rows = 0;
		if(ids.contains("-")) {
			String[] str_ids = ids.split("-");
			List<Integer> list = new ArrayList<Integer>();
			for(String id : str_ids) {
				list.add(Integer.parseInt(id));
			}
			
			rows = employeeService.deleteBatch(list);
		}else {
			Integer id = Integer.parseInt(ids);
			 rows = employeeService.deleteEmployee(id);
			
		}
		return R.success().add("rows",rows);
	}
}
