<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// 파일을 읽어들이는 경우를 살펴보자
	
	/* FileRead.jsp */
	
	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	
	// 1. 파일을 읽기 위해 File 객체를 생성
	File newFile = new File(appRoot, "data/test.txt");
	//-- appRoot 기준으로 data 폴더 안에 test.txt 파일
	
	// 2. 파일이 존재하는지 여부 확인
	//    → 파일이 존재하는 경우에만 처리하여 FileNotFoundException 방지
	if (newFile.exists())
	{
		// 3-1. 파일을 읽기 위한 FileReader 객체 생성
		FileReader fr = new FileReader(newFile);
		
		// 3-2. FileReader 를 조금 더 효율적으로 읽어내기 위해 BufferedReader 로 감싸기
		BufferedReader br = new BufferedReader(fr);
		// buffer 가 달려있어서, 한 줄씩 얻어서 기억할 수 있다.
		// 아니면 한땀한땀 얻어내야 한다.
		// bufferedReader로 fileReader 감싼 형태이다.
		
		// 4. 실질적으로 파일의 내용을 읽어냄
		String readData;
		while( (readData=br.readLine())!=null )
		{
			out.println(readData + "<br>");
		}
		//-- 제일 먼저 실행되는 코드는 br.readLine()
		//   br.readLine()이 한 줄을 읽어와서 null이 아닐 때(값이 있으면)
		//   출력하는 걸 반복한다.
		
		// 5-1. BufferedReader 리소스 반납(닫아줌)
		br.close();
		
		// 5-2. FileReader 리소스 반납(닫아줌)
		fr.close();
	}
	//-- 존재하면 if문 수행하고,
	//   존재하지 않으면 아무것도 하지 않는다.
%>
<!-- 
	text를 쓰고 text를 읽은거고,
	이제는 객체를 처리해보자 
-->
<!--  
	리소스 생성
	A 생성
	
	B 생성
	
	C 생성
	
	리소스 반납
	
	C 리소스 반납
	
	B 리소스 반납
	
	A 리소스 반납
	
	→ 정말 특별한 경우 아니면 반납은 생성의 역순이다.
-->
