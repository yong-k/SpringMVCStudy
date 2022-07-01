/*=============================================
	#21.EmployeeInsertFormController.java
	- 사용자 정의 컨트롤러 클래스
==============================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeInsertFormController implements Controller
{
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
		
		// 지정하는 뷰 → EmployeeInsertForm.jsp
		// 지정한 뷰가 클라이언트 만날꺼고, 뷰에게 employeeDAO 주입시킨다.
		
		// 뷰가 컨트롤러가 건네준 값을 갖고 있어야 하고, 
		// ajax도 가능해야하고, 달력도 가능해야한다.
		// 그냥 클라이언트 만나면 되는거 아니고, 다 챙겨가지고 만나야 한다!
		// 'selectbox 다 채워진 상태로 만나라' 가 되어야 한다.
		
		// 지역,부서,직위 리스트 건네줄 테니까 이거 가지고 클라이언트 만나라
		ArrayList<Region> regionList = new ArrayList<Region>();
	    ArrayList<Department> departmentList = new ArrayList<Department>();
	    ArrayList<Position> positionList = new ArrayList<Position>();

		
		try
		{
			// 각 리스트 값은 dao 통해서 얻어낸다.
			regionList = dao.regionList();
			departmentList = dao.departmentList();
			positionList = dao.positionList();
			
			// 이거 손에 쥐어줄테니까, 이거 들고 클라이언트 만나~
			mav.addObject("regionList", regionList);
			mav.addObject("departmentList", departmentList);
			mav.addObject("positionList", positionList);
			
			mav.setViewName("/WEB-INF/view/EmployeeInsertForm.jsp");
			
			// EmployeeInsertForm.jsp 이 뷰 페이지는
			// 옵션 구성 수정하러가자
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return mav;
	}

}
