<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* Write_ok.jsp */
	
	// 파일 업로드, 다운로드에서의 핵심은 multipart request
	// ① 주요 속성 값들 준비 (multipart request 한테 넘길 속성 값들을)
	String root = "/";
	root = pageContext.getServletContext().getRealPath(root);
	
	String savePath = root + "pds" + File.separator + "saveFile";
	//								 --------------
	//									  "\\"
	// 『\\』 대신에 『File.separator』 사용한 것
	
	
	String encType = "UTF-8";
	int maxFileSize = 5*1024*1024;
	
	
	// ② 경로상 디렉터리가 존재하지 않으면... 만든다.
	File dir = new File(savePath);
	if (!dir.exists())
		dir.mkdirs();
	
	
	// ③ MultipartRequest 구성
	MultipartRequest req = null;
	String urlFile = "";
	
	// fileNotFoundException 등등의 여러가지 예외 발생할 수 있어서 try~catch 구성
	try
	{
		// multipart request 구성
		// request, 파일저장경로, 파일최대크기, 인코딩방식, 중복파일명처리정책
		req = new MultipartRequest(request, savePath, maxFileSize
									, encType, new DefaultFileRenamePolicy());
		
		// ④ 구성한 MultipartRequest 로 부터 필요한 값 얻어내기
		//-- 다 get 하고 있다.
		out.println("작성자 : " + req.getParameter("userName") + "<br>");
		out.println("제목 : " + req.getParameter("subject") + "<br>");
		out.println("서버에 저장된 파일명 : " + req.getFilesystemName("uploadFile") + "<br>");
		out.println("업로드한 실제 파일명 : " + req.getOriginalFileName("uploadFile") + "<br>");
		out.println("파일 타입 : " + req.getContentType("uploadFile") + "<br>");
		
		File f = req.getFile("uploadFile");
		if (f != null)
		{
			out.println("파일 크기 : " + f.length() + "Bytes. <br>");
		}
		
		// ⑤ 다운로드 기능을 수행하기 위한 속성을 get 방식으로 처리
		urlFile = "Download.jsp?saveFileName=" + req.getFilesystemName("uploadFile");
		urlFile += "&originalFileName=" + req.getOriginalFileName("uploadFile");
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	
%>
<!-- 구성된 url을 넘겨줌 -->
<br /><a href="<%=urlFile%>">파일 다운로드</a>


<!-- Download.jsp 만들자 -->




