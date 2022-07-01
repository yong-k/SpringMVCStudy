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

<!-- 뷰(View) 페이지 -->
<!-- - HelloController 로 부터 Model 객체의 정보를 수신하여 -->
<!--   출력하는 처리 -->

<div>
	<h1>결과 출력</h1>
	<hr />
</div>

<div>
	<!-- HelloController.java에서 addAttribute로 'hello'라는 이름으로 넘겨준거 받음 -->
	<h2>${hello }</h2>
</div>

<!-- dispatcher-servlet에 작업하러 감 -->
<!-- component-scan의 base-package 지정해주러 -->
<!-- 	
	com.test.mvc 검토함
	HelloController.java 가 @Controller 니까 등록해줌
	@RequestMapping으로 /hello.action 이라는 요청들어오면 아래 메소드 액션 수행
	그럼 Hello.jsp 는 HelloController로부터 모델을 수신하게 된다.
	그래서 넘어온 hello값을 화면에 출력해준다. 
-->
</body>
</html>