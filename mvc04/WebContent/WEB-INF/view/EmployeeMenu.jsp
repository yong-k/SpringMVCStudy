<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmployeeMenu.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/menuStyle.css">
</head>
<body>

<!-----------------------------
	#13. EmployeeMenu.jsp
	- 메인 메뉴 페이지 구성
	- 로그아웃 기능 포함
------------------------------->

<!-- 컨트롤러가 얘한테 뭐 싸주는건 전혀 없는 상황 -->
<%-- <span>${sessionScope.admin==null ? "normal" : "admin" }</span> --%>
<!-- 관리자로 로그인하면 admin, 일반직원으로 로그인하면 normal이라고 찍힘 -->

<div id="menu">
	<ul>
		<c:choose>
			<c:when test="${sessionScope.admin==null }">
		<li>
			<a href="emplist.action" class="menu">직원 정보</a>
		</li>
		
		<li>
			<a href="reglist.action" class="menu">지역 정보</a>
		</li>
		
		<li>
			<a href="deptlist.action" class="menu">부서 정보</a>
		</li>
		
		<li>
			<a href="poslist.action" class="menu">직위 정보</a>
		</li>
		
		<li>
			<a href="logout.action" class="menu">로그아웃</a>
		</li>
			</c:when>
			
			<c:otherwise>
		<li>
			<a href="employeelist.action" class="menu">직원 관리</a>
		</li>
		
		<li>
			<a href="regionlist.action" class="menu">지역 관리</a>
		</li>
		
		<li>
			<a href="departmentlist.action" class="menu">부서 관리</a>
		</li>
		
		<li>
			<a href="positionlist.action" class="menu">직위 관리</a>
		</li>
		
		<li>
			<a href="logout.action" class="menu">로그아웃</a>
		</li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>

</body>
</html>