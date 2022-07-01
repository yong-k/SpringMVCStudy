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
<title>RegList.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
</head>
<body>

<div>
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[ 지역 목록 (일반직원 전용) ]</h1>
		<hr />
		
		<br /><br />
		
		<table class="table">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>직원수</th>
			</tr>
			
			<c:forEach var="region" items="${regionList }">
			<tr>
				<td>${region.regionId }</td>
				<td>${region.regionName }</td>
				<td>${region.delCheck }</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 회사 소개 및 어플리케이션 소개 영역 -->
	<div id="footer"></div>
</div>

</body>
</html>