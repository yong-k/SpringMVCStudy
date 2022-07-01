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
<title>Hello.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<!-- HelloController.java 로부터 message를 수신함 -->
<div>
	<h1>${message }</h1>
</div>

<!-- 
	여기서 ctrl+f11 누른다고 실행? NO
	그럼 클라이언트랑 만나게 구성해주려면 어떻게?
	webContent에 빈 파일 하나 만듦 (name: hello.action) 
-->
</body>
</html>