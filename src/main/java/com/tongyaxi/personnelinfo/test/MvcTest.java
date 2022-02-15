package com.tongyaxi.personnelinfo.test;

import java.util.Arrays;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.tongyaxi.personnelinfo.bean.Employee;

/**
 * ��SpringMVC����ν��д�����ĵ�Ԫ���ԣ�
 * @author TONGYAXI
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {

	// ��Ҫ����SpringMVC��IOC
	@Autowired
	WebApplicationContext webApplicationContext;
	
	// ����MVC���󣬻�ȡ����ֵ
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}
	
	@Test
	public void testPageInfo() {
		try {
			// ģ�����󣬻�ȡ����ֵ
			MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("page","1")).andReturn();
			
			// ����ɹ��󣬻�ȡ��������PageInfo������֤
			MockHttpServletRequest request = result.getRequest();
			PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
			System.out.println("��ǰҳ��" + pageInfo.getPageNum());
			System.out.println("��ҳ����" + pageInfo.getPages());
			System.out.println("�ܼ�¼����" + pageInfo.getTotal());
			System.out.println("������ʾ��ҳ�룺");
			int[] nums = pageInfo.getNavigatepageNums();
			for(int i:nums) {
				System.out.println("" + i);
			}
			
			// ��ȡԱ������
			List<Employee> list = pageInfo.getList();
			for(Employee emp : list) {
				System.out.println("Name:" + emp.getEmpName());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
