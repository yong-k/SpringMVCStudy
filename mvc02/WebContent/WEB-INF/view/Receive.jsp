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
<title>Receive.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>Spring MVC 데이터 송수신 실습</h1>
	<hr />
</div>

<div>
	<h2>안녕하세요, ${userName }님 반갑습니다.</h2>
</div>
<!-- 
	dispatcher-servlet에 
	/send.do 만 등록되어 있는 상태라 이렇게만 한다고 되는거 아님
	/receive.do 요청오면 ReceiveController에게 요청 보낸다고
	dispatcher-servlet에 등록하러 가자!
-->
</body>
</html>