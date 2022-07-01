<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* Test_ok.jsp */
	
	//String root = request.getRealPath("/");		//-- 예전 방식
	//-- getRealPath 보면 초록동그라미에 / 그어져있음
	// 	 실무 나가서 이거 볼 수 있으니 알아두기~
	
	String root = pageContext.getServletContext().getRealPath("/");
	//String savePath = root + File.separator + "pds" + "\\" + "saveFile";
	//-- 『\\』2개 찍힘
	String savePath = root + "pds" + "\\" + "saveFile";
	File dir = new File(savePath);
	//-- 생성만 한거지 파일이 어디 따로 존재하는 건 아니다.
	
	// 테스트
	//System.out.println(savePath);
	//--==>> D:\SpringMVCStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\fileSystemApp06\pds\saveFile
	 
	if (!dir.exists())
		dir.mkdirs();
	
	String encType = "UTF-8";		//-- 인코딩 방식
	int maxFileSize = 5*1024*1024;	//-- 최대 업로드 크기(5MB)
	//				  - ----  ----
	//				 mb  byte  bit
	//-- 업로드 시스템 구축한다고 하면, 용량제한 한다. 
	//   용량제한 안해서... 서버에 몇 기가짜리 동영상 올리고 이러면 안된다...
	
	try
	{
		// com.oreilly.servlet.MultipartRequest
		//-- 이거 사용하려고 cos.jar 파일 등록한거임
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, savePath, maxFileSize
									, encType, new DefaultFileRenamePolicy());
		// 1) request.getParameter 썼던 내용들을 MultipartRequest 객체가 컨트롤할 수 있도록 첫번째 파라미터로 넘김
		//-- 우리가 직접 request 컨트롤 할 일 없기 때문에. 직접 컨트롤해서 얻는 값은 null 이니까
		//   바이너리 기반으로 핸들링하기 때문에, 넘겨준 request를 쓸 수 있는 형태로 변형
		// 2) savePath : 경로 (파일 객체 얻어내서 이 경로에 실제 업로드 시킴)
		// 3) maxFilesize : 파일업로드의 최대 용량
		// 4) encType : 인코딩 방식
		// 5) DefaultFileRenamePolicy() : 같은 내용으로 업로드 했을 때, 덮어씌울건지, 다른 이름으로 저장할건지, 그냥 숫자붙여서 저장할지
		//-- 기본으로 쓰게 되면, 숫자만 다르게 생성하게 된다. 
		
		out.println("작성자 : " + multi.getParameter("userName") + "<br>");
		out.println("제목 : " + multi.getParameter("subject") + "<br>");
		out.println("서버에 저장된 파일명 : " + multi.getFilesystemName("uploadFile") + "<br>");
		out.println("업로드한 파일명 : " + multi.getOriginalFileName("uploadFile") + "<br>");
		out.println("파일 타입 : " + multi.getContentType("uploadFile") + "<br>");
		
		File file = multi.getFile("uploadFile");
		if (file != null)
		{
			out.println("파일 크기 : " + file.length() + "<br>");
		}
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

</body>
</html>