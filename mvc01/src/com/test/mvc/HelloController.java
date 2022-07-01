/*=================================
	HelloController.java
	- 사용자 정의 컨트롤러 클래스
==================================*/
/*
컨트롤러 쓰는 방법 2가지
1) annotation 쓰거나,
2) Controller 인터페이스 implements
*/

/*
- 파일 흐름
무슨 파일달라고 요청들어오면
web.xml 에서 dispatcher-servlet 찾아가라고 안내해줘야 할 것이다.
1) web.xml 작성
2) dispatcher-servlet.xml
3) HelloController.java  <- /hello.action 에 의해서 여기로 옴
4) web-inf에 view 폴더 생성 (web00에서도 해주기)	
5) view 폴더 안에 > Hello.jsp 파일 생성
   			└→ HelloController.java로 부터 message 를 수신함
6) webcontent 안에 hello.action 파일 생성 후, 
   그 파일에서 ctrl+11
   
   
- 내용 설명
web.xml
    *.action 으로 요청들어오면 web.xml 에서 
    dispatcher인 servlet-name 찾아서 mapping
    DispatcherServlet 한테 요청 인계됨

dispatcher-servlet.xml
    *.action 이라고 하기는 했는데
    그게 자재부, 인사부, 영업부 중 어디로 향한 것인지 확인
    그리고 해당 요청에 대해서 분기 처리

HelloController.java
    그럼 해당 controller 일함
    실제 클라이언트 만나는 view는 어디에 있는 누구고,
    전달해야할 내용은 addObject() 로 전달

Hello.jsp
    그럼 view 페이지에서 그 내용 수신해서 클라이언트 만남
    
    
→ 지금 model 은 안 만듦

나중에는 model한테 물어볼예정
컨트롤러가 모델을 통해서 그거 얻어내서,그거 뷰에게 전달해줄거임    

ex.
모델은 action 처리해주는게 제일 큼
클라이언트가 게시물 번호 10 넘겨줬는데 어떻게 하느냐
클라이언트가 어떤 게시물 열람했으면 모델한테 그 사실 넘겨서
모델이 어떤 처리하게 하느냐
모델은 10번 게시물에 대해서 조회 1 올려야하면
컨트롤러한테 알림
너가 나한테 넘겨준 게시물 조회수1 증가시켰어
컨트롤러입장에서 자기가 원하는 거 됐으면
뷰한테 그거 1 증가햇는지 확인해봐 하는거
*/



package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 의 『Controller』 인터페이스를 구현하는 방법을 통해
//    사용자 정의 컨트롤러 클래스를 구성한다.
public class HelloController implements Controller
{
	
	// 예전에 servlet 할 때 doGetPost() 역할을 얘가 하고 있는 거
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 수행하는 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		String message = "Hello, SpringMVC World~!!!";
		
		mav.addObject("message", message);
		mav.setViewName("/WEB-INF/view/Hello.jsp");
		
		
		return mav;
	}

}
