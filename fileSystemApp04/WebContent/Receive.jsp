<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	String name = request.getParameter("name");
	String upload = request.getParameter("upload");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	이름 : <%=name %> <br />
	파일 : <%=upload %> <br />
</div>
<!-- 
	이름 : null
	파일 : null
	
	이렇게만 받으면 제대로 받아지지 않는다.
	둘 다 null 뜬다.
-->
</body>
</html>