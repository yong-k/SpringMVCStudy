/*=================================
	MemberRecordController.java
	- 사용자 정의 컨트롤러 클래스
==================================*/

package com.test.mvc;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MemberRecordController
{
	// ※ 액션 처리를 위한 메소드는 사용자 지정
	
	// 반환자료형도 사용자 임의로 구성할 수 있음(지금은 편의상 String으로 함)
	// 지금은 뷰 이름 반환하니까 String으로
	/*
	@RequestMapping("URL매핑주소") → 이걸로 해당 컨트롤러와 연결해주는 듯	
	public String 메소드이름(매개변수)
	{
		// ※ 업무 로직 처리 (비즈니스 로직 처리 → 모델 활용)
		// ...
		
		return "뷰 이름.jsp";
	}
	*/
	
	// 데이터베이스의 리스트를 읽어오는 메소드 정의
	@RequestMapping("/memberlist.action")
	public String memberList(Model model)
	{
		String result = "";
		
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		
		// dao 직접 생성해서 넣음 → 주입과정 생략함
		// 제대로 하면, dao 인터페이스 만들어서 주입해줘야 함
		// 지금 세부적으로 안 한 것 뿐
		// 원래는 Connection 주입 받아야하고, Idao... 로 구멍뚫어야 한다.
		MemberDAO dao = new MemberDAO();
		
		try
		{
			dao.connection();
			list = dao.lists();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			try
			{
				dao.close();
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		
		model.addAttribute("list", list);
		
		result = "/WEB-INF/view/MemberList.jsp";
		
		return result;
	}
	
	
	// 데이터 입력(회원 등록)폼 요청 관련 액션 메소드 정의
	@RequestMapping("/memberinsertform.action")
	public String memberInserForm()
	{
		String result = "";
		
		result = "WEB-INF/view/MemberInsertForm.jsp";
		
		return result;
	}
	
	
	// 데이터 입력(회원 등록) 액션 메소드 정의
	/*
	submit 하는 속성의 name과 dto의 name 이 같으면 spring에서는 
	자동으로 jsp:setProperty 해주는 효과
	알아서 dto 등록된다.
	그래서 그냥 매개변수로 받은 dto 활용만하면 됨!
	
	name 속성 같으면 별도로 넘겨주고 할 필요 없음 → 아무것도 안해도 됨
	*/
	/*
	@RequestMapping("/memberinsert.action")
	public String memberInsert(@RequestParam(value="id") String id
							 , @RequestParam(value="pw") String pw
							 , @RequestParam(value="name")String name
							 , @RequestParam(value="tel") String tel
							 , @RequestParam(value="email") String email
							 , MemberDTO dto)
	*/
	@RequestMapping("/memberinsert.action")
	public String memberInsert(MemberDTO dto)
	{
		String result = "";
		/*
		dto.setId(id);
		dto.setPw(pw);
		dto.setName(name);
		dto.setTel(tel);
		dto.setEmail(email);
		*/
		MemberDAO dao = new MemberDAO();
		try
		{
			dao.connection();
			dao.insertQuery(dto);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		finally 
		{
			try
			{
				dao.close();
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		
		
		result = "/memberlist.action";
		
		return result;
		
	}
}
