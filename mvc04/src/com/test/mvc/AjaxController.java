/*=================================
	#22. AjaxController.java
	- 사용자 정의 컨트롤러 클래스
==================================*/
/*
	EmployeeDAO.java 에 만들어놨던 내용 중에
	직위 아이디에 따른 최소 기본급 확인/검색해주는 메소드를 비즈니스 로직삼아서 일함 
	→ getMinBasicpay()
	그 값을 Ajax.jsp 에 두면 된다.

*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class AjaxController implements Controller
{
	// EmployeeDAO 주입받아야 한다.
	
	// 인터페이스 형태의 속성 구성
	private IEmployeeDAO dao;
	
	// setter 구성
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		// 데이터 수신 (→ EmployeeInsertForm.jsp 로 부터... positionId 수신)
		String positionId = request.getParameter("positionId");
		
		int result = 0;
		
		try
		{
			result = dao.getMinBasicPay(positionId);
			
			mav.addObject("result", result);
			
			mav.setViewName("/WEB-INF/view/Ajax.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}

}
