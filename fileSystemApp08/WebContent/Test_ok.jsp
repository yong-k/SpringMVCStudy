<%@page import="java.util.Enumeration"%>
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
	/* Test_ok.jsp */
	
	String root = "/";
	root = pageContext.getServletContext().getRealPath(root);
	
	String savePath = root + "pad" + File.separator + "saveFile";
	
	//서버에 제대로 업로드됐는지 확인하기 위해서
	System.out.println(savePath);
	//-- 콘솔에 찍히는 경로 따서 들어가서 확인해보면 된다.
	//   이 경로 따서 <img> 태그로 감싸주면 이미지 얻어낼 수 있다.
	
	File dir = new File(savePath);
	if (!dir.exists())
		dir.mkdirs();
	
	String encType = "UTF-8";
	int maxFileSize = 5*1024*1024;
	
	MultipartRequest req = null;
	
	try
	{
		req = new MultipartRequest(request, savePath, maxFileSize, encType, new DefaultFileRenamePolicy());
		
		out.println("작성자 : " + req.getParameter("userName") + "<br>");
		out.println("제목 : " + req.getParameter("subject") + "<br>");
		out.println("******************************************<br>");
		
		out.println("업로드된 파일<br>");
		
		// check~!!! ★★★
		// 다중 파일 업로드 구조에서 체크해야 할 사항
		// MultipartRequest 객체의 『getFileNames()』
		// → 요청으로 넘어온 파일들의 이름을 Enumeration 타입으로 반환 
		Enumeration files = req.getFileNames();
		while(files.hasMoreElements())
		{
			String name = (String)files.nextElement();
			if (req.getFilesystemName(name) != null)
			{
				out.println("서버에 저장된 파일명 : " + req.getFilesystemName(name) + "<br>");
				out.println("업로드한 실제 파일명 : " + req.getOriginalFileName(name) + "<br>");
				out.println("파일 타입 : " + req.getContentType(name) + "<br>");
				
				File f = req.getFile(name);
				if (f != null)
					out.println("파일 크기 : " + f.length() + " Bytes. <br>");
			}
			
		}
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
%>
