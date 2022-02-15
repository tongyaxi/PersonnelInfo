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
				<button class="btn btn-primary">Add</button>
				<button class="btn btn-danger">Delete</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Email</th>
						<th>Department</th>
						<th>Handle</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
					<tr>
						<th>${emp.empId }</th>
						<th>${emp.empName }</th>
						<th>${emp.gender }</th>
						<th>${emp.email }</th>
						<th>${emp.department.deptName }</th>
						<th>
							<button class="btn btn-info btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>Edit
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>Delete
							</button>
						</th>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				CurrentPage: ${pageInfo.pageNum },
				TotalPages: ${pageInfo.pages },
				TotalRecords: ${pageInfo.total }
			</div>
			
			<!-- 分页信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation example">
  				<ul class="pagination">
  					<li class="page-item"><a class="page-link" href="${APP_PATH }/emps?pageIndex=1">Top</a></li>
	    			<c:if test="${pageInfo.hasPreviousPage }">
	    				<li class="page-item">
	      					<a class="page-link" href="${APP_PATH }/emps?pageIndex=${pageInfo.pageNum - 1}" aria-label="Previous">
	        				<span aria-hidden="true">&laquo;</span>
	      					</a>
	    				</li>
	    			</c:if>
	    			<c:forEach items="${pageInfo.navigatepageNums }" var="pageIndex">
	    				<c:if test="${pageInfo.pageNum == pageIndex }">
	    					<li class="page-item active"><a class="page-link" href="#">${pageIndex }</a></li>
	    				</c:if>
	    				<c:if test="${pageInfo.pageNum != pageIndex }">
	    					<li class="page-item"><a class="page-link" href="${APP_PATH }/emps?pageIndex=${pageIndex }">${pageIndex }</a></li>
	    				</c:if>
	    			</c:forEach>
	    			<c:if test="${pageInfo.hasNextPage }">
	    				<li class="page-item">
		      				<a class="page-link" href="${APP_PATH }/emps?pageIndex=${pageInfo.pageNum + 1}" aria-label="Next">
		        			<span aria-hidden="true">&raquo;</span>
		      				</a>
	    				</li>
	    			</c:if>
	    			<li class="page-item"><a class="page-link" href="${APP_PATH }/emps?pageIndex=${pageInfo.pages}">End</a></li>
  				</ul>
				</nav>
			</div>
		</div>
	</div>

</body>
</html>