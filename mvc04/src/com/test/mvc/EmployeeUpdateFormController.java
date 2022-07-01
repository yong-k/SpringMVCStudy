/*======================================================
	EmployeeUpdateFormController.java
	- 사용자 정의 컨트롤러 클래스
	- 직원 데이터 수정 폼 요청에 대한 액션 처리
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비 필요
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 구성
=======================================================*/
/*
	insertformController에서는 employeeDAO 만 주입받아서 처리했었는데
	updateFormController에서는 그 방법으로 말고, 만약 employeeDAO에 지역,직위,부서 리스트가 없었을 때
	employeeDAO, regionDAO, positionDAO, departmentDAO 다 주입받아야 하는
	방식으로 처리해보자
*/
package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeUpdateFormController implements Controller
{
	// check~!!!
	// EmployeeInsertFormController 구성과는 다른 방식으로 처리~!!!
	// ----------------------------
	// → 필요한 모든 메소드를 EmployeeDAO 에 정의해 두었던 상태
	
	// insertformController에서는 
	// private IEmployeeDAO 만 썼어서 dao 라고 이름붙였지만,
	// 여기서는 4개 쓸거라 각각 이름 붙여줌
	// → 이 속성의 개수만큼 setter 필요함
	
	// 주요 속성 구성
	private IEmployeeDAO employeeDAO;
	private IRegionDAO regionDAO;
	private IDepartmentDAO departmentDAO;
	private IPositionDAO positionDAO;
	
	
	// setter 구성
	public void setEmployeeDAO(IEmployeeDAO employeeDAO)
	{
		this.employeeDAO = employeeDAO;
	}
	
	public void setRegionDAO(IRegionDAO regionDAO)
	{
		this.regionDAO = regionDAO;
	}
	
	public void setDepartmentDAO(IDepartmentDAO departmentDAO)
	{
		this.departmentDAO = departmentDAO;
	}
	
	public void setPositionDAO(IPositionDAO positionDAO)
	{
		this.positionDAO = positionDAO;
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
		
		// 뷰한테 전달해줄 내용들을 미리 구성해두어야 한다.
		ArrayList<Region> regionList = new ArrayList<Region>();
		ArrayList<Department> departmentList = new ArrayList<Department>();
		ArrayList<Position> positionList = new ArrayList<Position>();
		
		try
		{
			// 위의 list 값들을 각각의 dao 한테서 얻어내야 한다.
			// updateformController는 insertformController와는 달리
			// 일단 먼저 data를 일단 수신해야한다.
			
			// 데이터 수신 (EmployeeList.jsp 로 부터... employeeId 수신)
			// [수정] 버튼 눌렀을 때 넘어오는 employeeId를 Controller 가 수신
			String employeeId = request.getParameter("employeeId");
			
			Employee employee = new Employee();
			
			employee = employeeDAO.searchId(employeeId);
			
			// 주입받은 지역,부서,직위 dao로부터 list 들 얻어낸다.
			regionList = regionDAO.list();
			departmentList = departmentDAO.list();
			positionList = positionDAO.list();
			
			// 이렇게 얻어낸 거 뷰한테 전달해야 한다.
			mav.addObject("employee", employee);
			mav.addObject("regionList", regionList);
			mav.addObject("departmentList", departmentList);
			mav.addObject("positionList", positionList);
			
			// 이 때 지정하게 되는 뷰
			mav.setViewName("/WEB-INF/view/EmployeeUpdateForm.jsp");
			
			
		} catch (Exception e)
		{	
			System.out.println(e.toString());
		}
		
		
		return mav;
	}


}
