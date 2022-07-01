/*=================================
	HelloController.java
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
public class HelloController implements Controller
{
	
	// 예전에 servlet 할 때 doGetPost() 역할을 얘가 하고 있는 거
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 수행하는 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		
		
		return mav;
	}

}
