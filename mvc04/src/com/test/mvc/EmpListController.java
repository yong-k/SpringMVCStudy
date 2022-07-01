/*===========================================================
	EmpListController.java
	- 사용자 정의 컨트롤러 클래스
	- 리스트 페이지 요청에 대한 액션 처리
	  (일반 사원 전용)
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
============================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmpListController implements Controller
{
	private IEmployeeDAO dao;
	
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		// 로그인 여부만 확인 → 관리자인지 확인할 필요 없음
		// 세션 처리과정 추가 -----------------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)			//-- 로그인이 되어 있지 않은 상황
		{
			// 로그인 폼으로 다시 돌려보냄
			// 로그인해야 여기 들어올 수 있어
			mav.setViewName("redirect:loginform.action"); 	
			return mav;
		}
		
		
		// 이 코드 추가되면, 로그아웃 된 상태에서
		// http://localhost:8090/mvc04/emplist.action
		// 그냥 입력하면 못 들어감!
			
		// ----------------------------------------------------------------- 세션 처리과정 추가 
		
		
		ArrayList<Employee> employeeList = new ArrayList<Employee>();
		
		try
		{
			employeeList = dao.list();
			
			mav.addObject("employeeList", employeeList);
			
			mav.setViewName("/WEB-INF/view/EmpList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}

}
