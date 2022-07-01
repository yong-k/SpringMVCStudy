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

public class HelloController implements Controller
{
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		
		
		return mav;
	}

}
