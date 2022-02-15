package com.tongyaxi.personnelinfo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tongyaxi.personnelinfo.bean.Employee;
import com.tongyaxi.personnelinfo.bean.EmployeeExample;
import com.tongyaxi.personnelinfo.bean.EmployeeExample.Criteria;
import com.tongyaxi.personnelinfo.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * ��ѯ����Ա��
	 * @return
	 */
	public List<Employee> getAllEmps() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	/**
	 * �������Ƿ��Ѵ��ڽ���У��
	 * @param empName
	 * @return
	 */
	public boolean checkName(String empName) {
		// TODO Auto-generated method stub
		//ָ�������Ĳ�ѯ
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
	
	/**
	 * ����Ա��
	 * @return
	 */
	public int insertEmployee(Employee employee) {
		return employeeMapper.insertSelective(employee);
	}
	
	/**
	 * ����ID��ѯ��Ա��Ϣ
	 * @param id
	 * @return
	 */
	public Employee getEmployeeById(Integer id) {
		Employee emp = employeeMapper.selectByPrimaryKey(id);
		return emp;
	}

	/**
	 * ������Ա��Ϣ
	 * @param emp
	 */
	public int updateEmployee(Employee emp) {
		// TODO Auto-generated method stub
		int rows = employeeMapper.updateByPrimaryKeySelective(emp);
		return rows;
	}

	/**
	 * ɾ����Ա��Ϣ
	 * @param id
	 * @return
	 */
	public int deleteEmployee(Integer id) {
		// TODO Auto-generated method stub
		int rows = employeeMapper.deleteByPrimaryKey(id);
		return rows;
	}

	/**
	 * ����ɾ����Ա��Ϣ
	 * @param str_ids
	 * @return
	 */
	public int deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample emp = new EmployeeExample();
		Criteria c = emp.createCriteria();
		// delete from xx where emp_id in (1,2,3)
		c.andEmpIdIn(ids);
		int rows = employeeMapper.deleteByExample(emp);
		return rows;
	}

	
}
