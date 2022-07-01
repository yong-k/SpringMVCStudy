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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<div>
	<h1>파일 입력 폼</h1>
	<hr />
</div>

<div>
	<!-- multipart/form-data로 넘긴것도 바이너리 형태로 꺼내려면 꺼낼 수 있다. -->
	<form action="Receive.jsp" method="post" enctype="multipart/form-data">
		
		file : <input type="file" name="file1" size="50" /><br />
		
		text : <input type="text" name="data" size="30" /><br />
		
		<input type="submit" value="upload" />
			
	</form>
</div>

</body>
</html>