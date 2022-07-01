<%@page import="java.io.DataInputStream"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* Receive.jsp */
	
	String contentType = request.getContentType();
	Enumeration e = request.getHeaderNames();
	
	out.println("[[ 브라우저로부터 날아오는 헤더 정보들 ]]<br>");
	
	while(e.hasMoreElements())
	{
		String key = (String)e.nextElement();
		String value = request.getHeader(key);
		
		out.println(key + " " + value + "<br>");
	}
	
	out.println("[[ request 로 넘어오는 데이터들 ]]<br>");
	DataInputStream di = new DataInputStream(request.getInputStream());
	String line = null;
	while( (line=di.readLine()) != null )
	{
		//out.println(new String(line.getBytes("UTF-8"), "UTF-8") + "<br>");
		out.println(new String(line.getBytes("ISO-8859-1"), "UTF-8") + "<br>");
	}
%>
