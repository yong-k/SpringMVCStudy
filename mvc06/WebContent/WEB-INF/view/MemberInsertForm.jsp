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
<title>MemberInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>정보 입력</h1>
	<hr />
</div>

<div>
	<form action="memberinsert.action" method="GET">
		아이디 <input type="text" name="id"/><br />
		비밀번호 <input type="password" name="pw"/><br />
		비밀번호 확인 <input type="password"/><br />
		이름 <input type="text" name="name"/><br />
		전화 <input type="text" name="tel"/><br />
		이메일 <input type="text" name="email"/><br />
		<button>입력</button>
	</form>
</div>

<!-- 
	spring에서는 submit할 때 name 속성과 dto의 name 같으면 자동으로 넣어줌!
-->
 
</body>
</html>