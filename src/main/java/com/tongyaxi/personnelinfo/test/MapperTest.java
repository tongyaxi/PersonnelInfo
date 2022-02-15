package com.tongyaxi.personnelinfo.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.tongyaxi.personnelinfo.bean.Department;
import com.tongyaxi.personnelinfo.bean.Employee;
import com.tongyaxi.personnelinfo.dao.DepartmentMapper;
import com.tongyaxi.personnelinfo.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCRUD() {
		// ԭ��
//		//1.����SpringIOC����
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.�������л�ȡMapper
//		DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		departmentMapper.insertSelective(new Department(null, "������Դ��"));
		departmentMapper.insertSelective(new Department(null, "������"));
		
		// �������룬ʹ�ÿ�������ִ�е�sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=4; i<=30; i++) {
//			String uuid = UUID.randomUUID().toString().substring(0,5);
			mapper.insertSelective(new Employee(null, "test0" + i, 1, "test0" + i + "@gmail.com",1));
		}
	}
}
