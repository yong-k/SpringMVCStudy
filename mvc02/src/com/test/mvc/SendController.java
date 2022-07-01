/*=================================
	SendController.java
	- 사용자 정의 컨트롤러 클래스
==================================*/
/*
컨트롤러 쓰는 방법 2가지
1) annotation 쓰거나,
2) Controller 인터페이스 implements
*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 의 『Controller』 인터페이스를 구현하는 방법을 통해
//    사용자 정의 컨트롤러 클래스를 구성한다.
public class SendController implements Controller
{
	
	// 예전에 servlet 할 때 doGetPost() 역할을 얘가 하고 있는 거
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		// 얘는 클라이언트한테 요청받았을 때, view 만 출동 시키면 된다.
		mav.setViewName("/WEB-INF/view/Send.jsp");
		//-- '너가 가서 손님 맞이해~'의 개념 → view 출동시킴	
		//-- Send.jsp 작성하러 가면 된다.
		//-- 위 주소를 어디서 받아오거나 로직적으로 처리한다면
		//   DB상으로 액션 처리해서 주소 얻어오겠다 하면
		//   컨트롤러가 모델한테 일 해달라고 의뢰할것이다.
		//   └→ 지금 한 거에서는 모델 필요 없음
		
		return mav;
	}

}