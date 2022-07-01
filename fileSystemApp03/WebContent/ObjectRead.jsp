<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* ObjectRead.jsp */
	
	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	
	File newFile = new File(appRoot, "objData/data.ser");
	
	// 파일이 존재하는지 검사
	if (newFile.exists())
	{
		FileInputStream fis = new FileInputStream(newFile);
		
		// File 에서 Object 를 읽어오기 위해 ObjectInputStream 객체 생성
		ObjectInputStream ois = new ObjectInputStream(fis);
		
		// ObjectInputStream 을 이용하여 파일로부터 Object 를 읽어오기
		// 읽어온 Object 를 원래의 타입으로 캐스팅
		Hashtable h = (Hashtable)ois.readObject();
		
		ois.close();
		fis.close();
		
		Enumeration e = h.keys();
		while (e.hasMoreElements())
		{
			String key = (String)e.nextElement();
			String value = (String)h.get(key);
			
			%>
			
			<%=key %>의 값은 <%=value %> 입니다.<br />
			
			<%
		}
	}
	else
	{
		out.println("해당 파일이 존재하지 않습니다~!!!");
	}
%>
<!--  
	key2의 값은 수박 입니다.
	key1의 값은 사과 입니다.
-->

<!-- 
	이제
	클라이언트가 서버에 전달하면서
	어떤 문제가 생기는지 살펴보자
-->