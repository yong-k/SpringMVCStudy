/*===================================================
	#17. EmployeeListController.java
	- 사용자 정의 컨트롤러 클래스
	- 리스트 페이지 요청에 대한 액션 처리
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
===================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeListController implements Controller
{
	// 주요 속성 구성
	// → 인터페이스 형태의 자료형을 속성으로 구성
	private IEmployeeDAO dao;
	
	// setter 구성
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		
		ModelAndView mav = new ModelAndView();
		
		// dao 통해서 list 얻어내게 해줘야 한다.
		// dao는 connection 필요로 하니까, dataSource 통해서 또 주입해줘야 한다.
		
		
		// 세션 처리과정 추가 -----------------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)			//-- 로그인이 되어 있지 않은 상황
		{
			// 로그인 폼으로 다시 돌려보냄
			// 로그인해야 여기 들어올 수 있어
			mav.setViewName("redirect:loginform.action"); 	
			return mav;
		}
		else if (session.getAttribute("admin")==null)	//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			// 로그인과 관련된 세션을 획득하긴 한 상황 (로그인은 한 상태)
			// 로그인 폼으로 다시 돌려보냄
			// 이 계정으로는 이 페이지 못들어오고 관리자로 다시 로그인하라고 해야함
			// → 로그아웃 시켜줘야 한다.
			mav.setViewName("redirect:logout.action");
			//-- 로그인은 되어있지만, 이 때 클라이언트는 
			//   일반 직원으로 로그인 되어 있는 상황이므로
			//   기존의 로그인 내용을 없애고 로그아웃 액션 처리하여
			//   다시 관리자로 로그인할 수 있도록 처리
			return mav;
			
		}
		
		// 이 코드 추가되면, 로그아웃 된 상태 & 일반직원 로그인상태면
		// http://localhost:8090/mvc04/employeelist.action
		// 그냥 입력하면 못 들어감!
			
		// ----------------------------------------------------------------- 세션 처리과정 추가 
		
		ArrayList<Employee> employeeList = new ArrayList<Employee>();
		
		try
		{
			employeeList = dao.list();
			
			mav.addObject("employeeList", employeeList);
			
			mav.setViewName("/WEB-INF/view/EmployeeList.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
	}

}
