/*=====================================================================
	EmployeeUpdateController.java
	- 사용자 정의 컨트롤러 클래스
	- 직원 데이터 수정 액션 수행 
	  → employeelist.action 을 다시 요청할 수 있도록 안내 (redirect)
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
======================================================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeUpdateController implements Controller
{
	// dao 주입시켜야 하니까
	// → 인터페이스 형태로 속성 만들고, setter 구성해야 한다.
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

		// 세션 처리과정 추가 -----------------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)			//-- 로그인이 되어 있지 않은 상황
		{
			mav.setViewName("redirect:loginform.action"); 	
			return mav;
		}
		else if (session.getAttribute("admin")==null)	//-- 로그인은 되었지만 관리자가 아닌 상황
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
			
		// ----------------------------------------------------------------- 세션 처리과정 추가
		
		// 데이터 수신 (EmployeeUpdateForm.jsp(수정폼) 로 부터 넘겨받은 데이터)
		String employeeId = request.getParameter("employeeId");
		String name = request.getParameter("name");
		String ssn1 = request.getParameter("ssn1");
		String ssn2 = request.getParameter("ssn2");
		String birthday = request.getParameter("birthday");
		String lunar = request.getParameter("lunar");
		String telephone = request.getParameter("telephone");
		String regionId = request.getParameter("regionId");
		String departmentId = request.getParameter("departmentId");
		String positionId = request.getParameter("positionId");
		String basicPay = request.getParameter("basicPay");
		String extraPay = request.getParameter("extraPay");
		
		try
		{	
			Employee employee = new Employee();
			
			employee.setEmployeeId(employeeId);
			employee.setName(name);
			employee.setSsn1(ssn1);
			employee.setSsn2(ssn2);
			employee.setBirthday(birthday);
			employee.setLunar(Integer.parseInt(lunar));
			employee.setTelephone(telephone);
			employee.setRegionId(regionId);
			employee.setDepartmentId(departmentId);
			employee.setPositionId(positionId);
			employee.setBasicPay(Integer.parseInt(basicPay));
			employee.setExtraPay(Integer.parseInt(extraPay));
			
			dao.modify(employee);
			
			//mav.setViewName("/WEB-INF/view/EmployeeList.jsp");
			mav.setViewName("redirect:employeelist.action");
			/*
			employeelist.action 만 해도 불러지기는 한다.
			스프링컨테이너 안에서 이 일이 일어남
			스프링컨테이너한테 '클라이언트가 다시 요청하도록 너가 처리해줘'라는 
			의미로 붙이는 접두어가 『redirect:』 이다.
			『redirect:』 스프링컨테이너한테 보내는 메세지다. 안붙여도 상관없다.
			단지 스프링컨테이너한테 '이건 포워딩으로 처리하는 내용아니고 
			리다이렉트로 처리하는 내용이야'라고 전달하는 것이다.
			
			mvc 패턴이 아닌 상황에서는 클라이언트가 직접 view 잡고 끌고나감
			그렇게 끌려나가다보니까 내가 있는 내 page에서 나를 다시 부르는게 가능함
			mvc에서는 내가 a라는 view에 머물고 있는데 a라는 view 또 요청하는거 불가능
			view를 직접 요청하는 건 불가능하다. controller 를 요청하는 것이다.
			*/ 
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		
		return mav;
	}

}
