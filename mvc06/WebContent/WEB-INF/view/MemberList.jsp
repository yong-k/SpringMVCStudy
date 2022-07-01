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
<title>MemberList.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>회원 명단</h1>
	<hr />
	
	<h2><a href="memberinsertform.action">회원 등록</a></h2>
</div>

<div>
	<table>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>전화</th>
			<th>이메일</th>
		</tr>
		<!-- 		
		<tr>
			<th>abcd</th>
			<td>최문정</td>
			<td>010-1234-1234</td>
			<td>cmj@test.com</td>
		</tr>
		-->
		<!-- 
			리스트상에서 이 뷰페이지 보이게 하려면
			controller 필요함 → controller 만들러감
		-->
		<c:forEach var="dto" items="${list }">
		<tr>
			<th>${dto.id }</th>
			<th>${dto.name }</th>
			<th>${dto.tel }</th>
			<th>${dto.email }</th>
		</tr>
		</c:forEach>
	</table>
</div>

</body>
</html>


















