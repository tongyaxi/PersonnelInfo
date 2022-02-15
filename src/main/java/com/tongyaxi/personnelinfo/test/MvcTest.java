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
 * 在SpringMVC中如何进行带请求的单元测试？
 * @author TONGYAXI
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {

	// 需要传入SpringMVC的IOC
	@Autowired
	WebApplicationContext webApplicationContext;
	
	// 虚拟MVC请求，获取返回值
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
	}
	
	@Test
	public void testPageInfo() {
		try {
			// 模拟请求，获取返回值
			MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("page","1")).andReturn();
			
			// 请求成功后，获取请求域中PageInfo进行验证
			MockHttpServletRequest request = result.getRequest();
			PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
			System.out.println("当前页：" + pageInfo.getPageNum());
			System.out.println("总页数：" + pageInfo.getPages());
			System.out.println("总记录数：" + pageInfo.getTotal());
			System.out.println("连续显示的页码：");
			int[] nums = pageInfo.getNavigatepageNums();
			for(int i:nums) {
				System.out.println("" + i);
			}
			
			// 获取员工数据
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
