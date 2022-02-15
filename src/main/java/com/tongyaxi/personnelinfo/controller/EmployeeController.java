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
	 * ��ѯԱ���б���ҳ��ѯ��
	 * ����JSP
	 * @return
	 */
	@RequestMapping("/empsbk")
	public String getAllEmps(@RequestParam(value="pageIndex", defaultValue="1") Integer pageIndex, Model model) {
		
		// ��ҳ��ѯ--��ѯ��ǰҳpage��3�����ݣ�Ĭ�ϲ�ѯ����count
		PageHelper.startPage(pageIndex, 5);
		List<Employee> emps = employeeService.getAllEmps();
		
		// ��PageInfo�Բ�ѯ������з�װ,��װ����ϸ�ķ�ҳ��Ϣ��ֻ�践��PageInfo(3:����������ʾ��ҳ��)
		PageInfo pageInfo = new PageInfo(emps, 3);
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}
	
	/**
	 * ��ѯԱ���б���ҳ��ѯ��
	 * @ResponseBody:����JSON�ַ���(��Ҫ����jackson��)
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public R getAllEmpsWithJSON(@RequestParam(value="pageIndex", defaultValue="1") Integer pageIndex) {
		
		// ��ҳ��ѯ--��ѯ��ǰҳpage��3�����ݣ�Ĭ�ϲ�ѯ����count
		PageHelper.startPage(pageIndex, 5);
		List<Employee> emps = employeeService.getAllEmps();
		
		// ��PageInfo�Բ�ѯ������з�װ,��װ����ϸ�ķ�ҳ��Ϣ��ֻ�践��PageInfo(3:����������ʾ��ҳ��)
		PageInfo pageInfo = new PageInfo(emps, 3);
		return R.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * �������Ƿ��Ѵ��ڽ���У��
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkName")
	@ResponseBody
	public R checkName(@RequestParam(value="empName") String empName) {
		
		// ������ʽУ��
		String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8}$)";
		if(!Pattern.matches(regName, empName)) {
			return R.fail().add("validateMsg", "��������6~16λӢ�����ֻ�2~8λ���ģ�");
		}
		// �����������У��
		boolean bol = employeeService.checkName(empName);
		if(bol) {
			return R.success();
		}else {
			return R.fail().add("validateMsg", "�����Ѵ��ڣ�");
		}
	}
	
	/**
	 * ����Ա��
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
				// getFiled��ʾ������ֶ���
				// getDefaultMessage��ʾJavaBean����Ĵ�����Ϣ
				map.put(error.getField(), error.getDefaultMessage());
			}
			return R.fail().add("errorFields", map);
		}else {
			int rows = employeeService.insertEmployee(employee);
			return R.success();
		}
	}
	
	/**
	 * ����ID��ѯ��Ա��Ϣ
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
	 * ������Ա��Ϣ
	 * ��Ҫ����HttpPutFormContentFilter����֧��PUT����
	 * ���ã����������е����ݽ�����װ��map
	 * request�����°�װ��request.getParameter����д���ͻ���Լ���װ��map��ȡ���ݡ�
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	@ResponseBody
	public R updateEmployee(Employee emp) {
		System.out.println("�������ݣ�"+emp.toString());
		int rows = employeeService.updateEmployee(emp);
		return R.success().add("rows",rows);
	}
	
	/**
	 * ɾ����Ա��Ϣ
	 * ����ɾ����1-2-3
	 * ����ɾ����1
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
