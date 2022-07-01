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
	<h1>파일 시스템 및 파일 업로드</h1>
	<hr />
</div>

<div>
	<!-- 
		파일이 물리적으로 올라가게 하려면
		input type='file' 만 만든다고 되는게 아니다.
		
		실제로 얘를 전송하기 위해서는,
		form 에 enctype="multipart/form-data" 를 반드시 구성해줘야 한다!!!
	-->
	<!-- 
		전송하는 파일은 body에서 보내고, 읽는건 head 에서 읽기 때문에 
		전송방식도 post여야 한다!!
	-->
	<!-- 『enctype="multipart/form-data"』 : 물리적으로 업로드하기 위한 필수 속성 -->
	<!-- 『method="post"』 : 파일을 물리적으로 업로드하기 위한 요청 및 전송 방식 -->
	<form action="Receive.jsp" method="post" enctype="multipart/form-data">
		이름 : <input type="text" name="name" /><br />
		
		<!-- 파일 업로드 대화창 구성 -->
		<!-- 『input type="file"』 -->
		파일 : <input type="file" name="upload" /><br />
		<button type="submit">전송</button>
	</form>
</div>

<!--  

	『Send.jsp』의 form 엘리먼트 enctype 속성을
	『enctype="multipart/form-data"』와 같이 구성할 경우
	form 의 내용을 바이너리 값의 형태로 전송한다는 의미이며,
	이와 같이 전송할 경우 수신된 데이터는
	
	이름 : null
	파일 : null
	
	로 확인된다.
	
	==> 바이너리 값을 getParameter() 를 통해 수신할 수 없다는 의미이다.
	    원래는 잘 받아지던 이름값도 받아지지 않는다.
	
-->


</body>
</html>
