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
	<h1>파일 업로드 - 다중 파일 업로드</h1>
	<hr />
</div>

<div>
	<!-- 
		파일만 잘 수신되는지 확인하면 되는게 아니라,
		다른 내용들도 잘 submit 되는지 확인해봐야 하기 때문에,
		다른 요소들도 입력받아서 제출한다.
	-->
	<!-- 
		이 페이지가 등장하는 것도 컨트롤러에 의해서
		Test_ok.jsp 도 컨트롤러가 될 것이다.
		servlet으로 작성한 건 컨트롤러로 작성하면서 servlet으로 작성해주면 된다.
	-->
	<form action="Test_ok.jsp" method="post" enctype="multipart/form-data">
		작성자 : <input type="text" name="userName" /><br />
		제목 : <input type="text" name="subject" /><br />
		<!-- 파일의 이름(name 속성)은 서로 달라야 한다. -->
		파일명 : <input type="file" name="uploadFile1" /><br />
		파일명 : <input type="file" name="uploadFile2" /><br />
		<br />
		
		<input type="submit" value="파일업로드" />
	</form>
	<!-- get 방식과 post 방식으로 나눠서 받아야 되면 form 나누면된다. -->
	<!-- enctype 은 반드시 multipart/form-data여야 한다. -->
	
</div>

</body>
</html>