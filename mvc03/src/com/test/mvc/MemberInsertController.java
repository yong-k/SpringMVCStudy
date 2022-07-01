/*==================================================================
	MemberInsertController.java
	- 사용자 정의 컨트롤러 클래스
	- 회원 데이터 추가 액션 처리 클래스
	  ---------------------
		insert 쿼리문을 포함해야된다는거고,
		얘가 직접 쿼리문을 갖고 있지는 않음(controller니까)
		쿼리문은 dao가 가지고 있음
	- DAO 객체에 대한 의존성 주입
	  준비 → 인터페이스 형태의 속성 구성
	  	   → setter 메소드 추가
===================================================================*/
/*
IoC/DI 핵심개념 : annotation 이나 xml 활용해서 스프링 컨테이너 내부에서 의존객체 주입

대상 객체가 의존하고 있는 객체를 끼워넣게끔 만들어야하고
의존객체의 인터페이스 형태로 구멍이 뚫려있어야 한다.
*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


// ※ 『implements Controller』 혹은 『extends AbstractController』 
//     Controller 인터페이스를 implements 하는 것도 가능하지만
//     AbstractController 라는 클래스를 extends 하는 것도 가능하다.
//-- 서블릿에서 HttpServlet 을 상속받은 서블릿 객체 역할
// ★ servlet 역할을 controller 가 한다!!



// ※ Spring 의 『Controller』 인터페이스를 구현하는 방법을 통해
//    사용자 정의 컨트롤러 클래스를 구성한다.
public class MemberInsertController implements Controller
{
	// DAO 객체의 의존객체 준비
	
	//private MemberDao dao;
	// 하고 dao에 대한 setter() 구성하면 MemberDao 의 dao 밖에 못들어와서
	// spring의 유연성의 핵심철학과 맞지 않음!!!
	// ↓
	// dao 관련 속성 구성 → 인터페이스 형태
	private IMemberDAO dao;
	
	// 주입하는 방법 2가지 있음 → 생성자, setter() 
	// setter 메소드 구성
	public void setDao(IMemberDAO dao)
	{
		this.dao = dao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 액션 코드 
		
		ModelAndView mav = new ModelAndView();
		
		// 캐릭터 인코딩 설정
		request.setCharacterEncoding("UTF-8");
		
		// 이전 페이지로부터 넘어온 데이터 수신
		String name = request.getParameter("name");
		String tel = request.getParameter("telephone");
		
		try
		{
			MemberDTO member = new MemberDTO();
			member.setName(name);
			member.setTelephone(tel);
			
			dao.add(member);
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
	
		// 우리가 여기서 모델 만들지 않았지만, 위에 코드 수행하는거 다 모델임
		
		
		// 지금 뷰한테 넘겨줄 거 없음
		
		// jsp/servlet 에서는 
		// 여기서 sendRedirect() 했었음
		// view에서 리스트 출력하면 저거 나오기 때문에 저 내용 따로 또 넘겨줄 필요 없음
		// 'sendRedirect() → memberlist.do 요청해라' 라는 코드 작성했음
		
		// [회원추가]버튼 누르면 
		// insertController 요청(insert 액션처리) 
		// → listController 요청(select 액션처리)
		// 그래서 제자리인 것이다!

		
		// sendRedirect() → memberlist.do 와 같은 의미로 코드 작성
		//mav.setViewName("/WEB-INF/view/MemberList.jsp");	// (Ⅹ)
		//								----------------
		//								이 view 는 인원수, list 다 못받음
		
		mav.setViewName("redirect:memberlist.do");
		//-- 앞에 『redirect:』 접두어 붙인건 
		//   spring container한테 너 다시 돌아가야한다고 전달한 것 뿐
		//--그래서 controller를 다시 요청하라는 뜻임
		//  mvc 의 요청진입지점은 항상 controller 여야 함
		
		return mav;
	}

}
