<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Personnel List</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- Jquery cdn -->
<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
</head>
<body>

	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>Personnel Info Management</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 offset-md-8">
				<button class="btn btn-primary" id="emp_add_modal_btn" data-bs-toggle="modal" data-bs-target="#empAddModal" data-bs-whatever="@mdo">Add</button>
				<button class="btn btn-danger" id="emp_del_all_btn">Delete</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
						<th>
							<input type="checkbox" id="check_all" />
						</th>
						<th>#</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Department</th>
						<th>Handle</th>
					</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info"></div>
			
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>
	
	<!-- Add按钮模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="myModalLabel">Employee Add</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Name</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="Name">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <br/>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@gmail.com">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <br/>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Gender</label>
				    <div class="col-sm-10">
				    	<label class="radio-inline">
						  <input type="radio" name="gender" id="gender1_add_input" value="1" checked="checked"> Male
					  	</label>
						<label class="radio-inline">
						  <input type="radio" name="gender" id="gender2_add_input" value="2"> Female
						</label>
				    </div>
				  </div>
				  <br/>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Department</label>
				    <div class="col-sm-8">
				      <select class="form-control" name="dId"></select>
				    </div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id="emp_add">Save</button>
		      </div>
		    </div>
		  </div>
	</div>
	
	<!-- Edit按钮模态框 -->
	<div class="modal fade" id="empEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="myModalLabel">Employee Edit</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Name</label>
				    <div class="col-sm-10">
				      <p class="form-control-static" id="empName_update_p" />
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <br/>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_edit_input" placeholder="email@gmail.com">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <br/>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Gender</label>
				    <div class="col-sm-10">
				    	<label class="radio-inline">
						  <input type="radio" name="gender" id="gender1_edit_input" value="1" checked="checked"> Male
					  	</label>
						<label class="radio-inline">
						  <input type="radio" name="gender" id="gender2_edit_input" value="2"> Female
						</label>
				    </div>
				  </div>
				  <br/>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Department</label>
				    <div class="col-sm-8">
				      <select class="form-control" name="dId"></select>
				    </div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id="emp_edit">Update</button>
		      </div>
		    </div>
		  </div>
	</div>
	
	<script>
		var totalRecord,currentPage;
		
		$(function(){
			page_to(1);
		});
		
		function page_to(page){
			$.ajax({
				url: "${APP_PATH}/emps",
				data: "pageIndex="+page,
				type: "GET",
				success: function(result){
					console.log(result);
					// 解析员工数据(JSON)
					parse_emps_table(result);
					// 解析分页文字信息
					parse_page_info(result);
					// 解析分页条
					parse_page_nav(result);
				}
			});
		}
		
		function parse_emps_table(result){
			// 清空数据
			$("#emps_table tbody").empty();
			
			var emps = result.map.pageInfo.list;
			$.each(emps, function(index, item){
				console.log(index+"=="+item.empName)
				var checkBoxId = $("<td><input type='checkbox' class='check_item' /></td>");
				var empId = $("<td></td>").append(item.empId);
				var empName = $("<td></td>").append(item.empName);
				var gender = $("<td></td>").append(item.gender==1?"M":"F");
				var email = $("<td></td>").append(item.email);
				var department = $("<td></td>").append(item.department.deptName);
				/* <button class="btn btn-info btn-sm">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>Edit
				</button> */
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).attr("data-bs-target","#empEditModal").attr("data-bs-toggle","modal").append("Edit");
				// 将人员ID绑定在自定义的属性上，方便根据ID获取信息
				editBtn.attr("edit-id",item.empId);
				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("Delete");
				deleteBtn.attr("delete-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append("&nbsp;").append(deleteBtn);
				$("<tr></tr>").append(checkBoxId).append(empId).append(empName).append(gender).append(email).append(department).append(btnTd).appendTo("#emps_table tbody");
			});
		}
		
		function parse_page_info(result){
			$("#page_info").empty();
			$("#page_info").append("CurrentPage: "+ result.map.pageInfo.pageNum + ",TotalPages: " + result.map.pageInfo.pages + ",TotalRecords: " + result.map.pageInfo.total);
			
			totalRecord = result.map.pageInfo.total;
			currentPage = result.map.pageInfo.pageNum;
		}
		
		function parse_page_nav(result){
			$("#page_nav").empty();
			
			var ul = $("<ul></ul>").addClass("pagination");
			
			var top = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("Top"));
			var prePage = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&laquo;").attr("aria-label","Previous"));
			if(result.map.pageInfo.hasPreviousPage == false){
				top.addClass("disabled");
				prePage.addClass("disabled");
			}else{
				top.click(function(){
					page_to(1);
				});
				prePage.click(function(){
					page_to(result.map.pageInfo.pageNum - 1);
				})
			}
			
			var nextPage = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("&raquo;").attr("aria-label","Next"));
			var end = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append("End"));
			if(result.map.pageInfo.hasNextPage == false){
				nextPage.addClass("disabled");
				end.addClass("disabled");
			}else{
				nextPage.click(function(){
					page_to(result.map.pageInfo.pageNum + 1);
				});
				end.click(function(){
					page_to(result.map.pageInfo.pages);
				})
			}
			
			ul.append(top).append(prePage);
			
			$.each(result.map.pageInfo.navigatepageNums, function(index,item){
				var numLi = $("<li></li>").addClass("page-item").append($("<a></a>").addClass("page-link").append(item));
				if(result.map.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					page_to(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPage).append(end);
			var nav = $("<nav></nav>").attr("aria-label","Page navigation example ").append(ul);
			nav.appendTo("#page_nav");
		}
		
		/*=============== 新增 ===============*/
		// Modal Dialog
		$("#emp_add_modal_btn").click(function(){
			
			// 清除表单数据
			reset_form("#empAddModal form");
			
			// 查询部门下拉列表信息
			getDepts("#empAddModal select");
		});
		
		function getDepts(element){
			// 清空下拉列表
			$(element).empty();
			$.ajax({
				url: "${APP_PATH}/depts",
				type: "GET",
				success: function(result){
					console.log(result);
					$.each(result.map.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(element);
					});
				}
			});
		}
		
		// 检查名字是否重复
		$("#empName_add_input").change(function(){
			
			var empName = this.value;
			
			$.ajax({
				url: "${APP_PATH}/checkName",
				data: "empName="+empName,
				type: "POST",
				success:function(result){
					if(result.code == 200){
						// 提示信息
						show_validate_msg("#empName_add_input", "success", "用户名可使用!");
						//如果用户名可用，才让其保存，为保存按钮添加属性
						$("#emp_add").attr("ajax-validate","success");
					}else{
						show_validate_msg("#empName_add_input", "error", result.map.validateMsg);
						$("#emp_add").attr("ajax-validate","error");
					}
				}
			});
		});
		
		// 保存
		$("#emp_add").click(function(){
			// 表单验证(正则)
			/* if(!validate_add_form()){
				return false;
			} */
			// 表单验证(是否有重复姓名)
			if($(this).attr("ajax-validate") == "error"){
				return false;
			}
			
			// $("#empAddModal form").serialize() jQuery用法，直接序列化表单数据位字符串，用于提交Ajax请求。
			console.log($("#empAddModal form").serialize());
			$.ajax({
				url: "${APP_PATH}/emp",
				type: "POST",
				data: $("#empAddModal form").serialize(),
				success: function(result){
					console.log(result);
					// 如果JSR303后端校验成功，保存员工
					if(result.code == 200){
						// 关闭模态框
						$("#empAddModal").modal("hide");
						// 跳转到尾页
						page_to(totalRecord);
					}else{
						if(undefined != result.map.errorFields.empName){
							show_validate_msg("#empName_add_input", "error", result.map.errorFields.empName);
						}
						if(undefined != result.map.errorFields.email){
							show_validate_msg("#email_add_input", "error", result.map.errorFields.email);
						}
					}
				}
			});
		});
		
		// 新增表单验证
		function validate_add_form(){
			
			var name = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8}$)/;
			if(!regName.test(name)){
				show_validate_msg("#empName_add_input", "error", "Please enter the correct name!");
				return false;
			}else{
				show_validate_msg("#empName_add_input", "success", "");
			}
			
			var email = $("#email_add_input").val();
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input", "error", "Please enter the correct email!");
				return false;
			}else{
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		// 封装校验结果提示
		function show_validate_msg(element, status, msg){
			// 清除之前叠加的样式
			$(element).removeClass("is-valid is-invalid");
			$(element).next("span").removeClass("valid-feedback invalid-feedback");
			$(element).next("span").text("");
			
			if("success"==status){
				$(element).addClass("is-valid");
				$(element).next("span").addClass("valid-feedback").text(msg);
			}else if("error"==status){
				$(element).addClass("is-invalid");
				$(element).next("span").addClass("invalid-feedback").text(msg);
			}
		}
		
		// 封装清除表单(数据及样式)
		function reset_form(element){
			// 数据
			$(element)[0].reset();
			// 样式
			$(element).find("*").removeClass("is-valid is-invalid valid-feedback invalid-feedback");
			$(element).find(".help-block").text("");
		}
		
		/*============== 修改 ================*/
		// 给后来创建的元素做绑定事件的话，需要用on方法。
		$(document).on("click",".edit_btn",function(){
			// 查询人员信息
			getEmp($(this).attr("edit-id"));
			
			// 给更新按钮绑定人员ID
			$("#emp_edit").attr("edit_id",$(this).attr("edit-id"));
			// 查询部门下拉列表信息
			getDepts("#empEditModal select");
		});
		
		function getEmp(id){
			$.ajax({
				url: "${APP_PATH}/emp/"+id,
				type: "GET",
				success: function(result){
					console.log(result);
					if(result.code == 200){
						var emp = result.map.emp;
						$("#empName_update_p").text(emp.empName);
						$("#email_edit_input").val(emp.email);
						$("#empEditModal input[name=gender]").val([emp.gender]);
						$("#empEditModal select[name=dId]").val([emp.dId]);
					}
				}
			});
		}
		
		// 修改按钮
		$("#emp_edit").click(function(){
			// 邮箱验证
			var email = $("#email_edit_input").val();
			var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_edit_input", "error", "Please enter the correct email!");
				return false;
			}else{
				show_validate_msg("#email_edit_input", "success", "");
			}
			
			$.ajax({
				url: "${APP_PATH}/emp/"+$(this).attr("edit_id"),
				//web.xml中已添加过滤器，可直接发送PUT请求
				type: "PUT",
				/* data: $("#empEditModal form").serialize()+"&_method=PUT", */
				data: $("#empEditModal form").serialize(),
				success: function(result){
					if(result.map.rows == 1){
						// 关闭模态框
						$("#empEditModal").modal("hide");
						// 跳转到尾页
						page_to(currentPage);
					}
				}
			});
		});
		
		/*============== 删除 ================*/
		$(document).on("click",".delete_btn",function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确认删除"+empName+"吗？")){
				$.ajax({
					url: "${APP_PATH}/emp/"+$(this).attr("delete-id"),
					type: "DELETE",
					success: function(result){
						if(result.map.rows > 0){
							page_to(currentPage);
						}
					}
				});
			}
		});
		
		/*============== 批量删除 ================*/
		// 全选
		$("#check_all").click(function(){
			// prop:修改和读取dom原生的值
			// attr:获取自定义属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		// 列表中checkbox全部选中时，全选checkbox也被选中
		$(document).on("click",".check_item",function(){
			var flg = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flg);
		});
		// 批量删除按钮emp_del_all_btn
		$("#emp_del_all_btn").click(function(){
			var empNames="";
			var del_ids = "";
			var comma="";
			$.each($(".check_item:checked"),function(){
				empNames += comma + $(this).parents("tr").find("td:eq(2)").text();
				del_ids += comma + $(this).parents("tr").find("td:eq(1)").text();
				comma = "-";
			});
			if(confirm("确认删除"+empNames+"吗？")){
				// ajax请求
				$.ajax({
					url: "${APP_PATH}/emp/"+del_ids,
					type: "DELETE",
					success: function(result){
						if(result.map.rows > 0){
							page_to(currentPage);
							$("#check_all").prop("checked",false);
						}
					}
				});
			}
		});
	</script>

</body>
</html>