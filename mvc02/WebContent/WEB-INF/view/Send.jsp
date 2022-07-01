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
<title>Send.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>Spring MVC 데이터 송수신 실습1</h1>
	<hr />
</div>

<div>
	<form action="receive.do" method="post">
		이름 <input type="text" name="userName" />
		<button type="submit">submit</button>
	</form>
</div>

<!-- 
	얘는 ctrl+f11 해도 내용 볼 수 없음
	클라이언트가 직접 이 view 페이지 요청하면 안되니까 WEB-INF 에 넣어놨음
	외부 사용자는 이 view 페이지를 직접 요청하는게 아니고, 
	컨트롤러로 요청 들어오게 해야 한다.
	web.xml과 dispatcher-servlet.xml 작성하러 ㄱㄱ
--> 

</body>
</html>
