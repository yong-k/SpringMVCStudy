<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* ObjectWrite.jsp */
	
	String appRoot = "/";
	appRoot = pageContext.getServletContext().getRealPath(appRoot);
	
	// 테스트
	System.out.println(appRoot);
	//-- 콘솔에 경로 찍힘
	//   실행 후, 여기 들어가면
	//   objData 폴더 만들어지고, 그 안에 data.ser 파일 만들어져있다.
	
	// 파일 객체 생성
	File newFile = new File(appRoot, "objData/data.ser");	// 객체 직렬화
	
	// 파일이 존재할 디렉터리가 존재하지 않은 경우는
	// 파일이 위치할 경로까지의 디렉터리들을 생성해준다.
	if ( !newFile.getParentFile().exists() )
	{
		newFile.getParentFile().mkdirs();
	}
	
	// 파일에 넣기 위한 Hashtable 객체를 만들어 데이터에 넣는다.
	Hashtable<String, String> h = new Hashtable<String, String>();
	
	h.put("key1", "사과");
	h.put("key2", "수박");
	
	
	// 파일을 내보내기 위한 스트림 구성
	FileOutputStream fos = new FileOutputStream(newFile);
	
	// Object 를 파일에 쓰기 위해 ObjectOutputStream 생성
	ObjectOutputStream oos = new ObjectOutputStream(fos);
	
	// ObjectOutputStream 을 이용하여 파일에 Object 를 기록(써넣는다.)
	oos.writeObject(h);
	
	// 리소스 반납
	oos.close();
	fos.close();
%>
