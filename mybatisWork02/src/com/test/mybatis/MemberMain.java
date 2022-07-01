/*=======================
	MemberMain.java
	- 컨트롤러
========================*/

package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
//mybatis 보다 ibatis 라는 이름가진 애들이 훨~씬 많음
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberMain
{
	/*
	프레임워크는
	내가 만들 걸 규칙적으로 환경에서 제공해주는 특정 브라켓에 
	딸깍딸깍 끼워서 맞아진다는게 핵심!!
	*/

	// 주요 속성 구성
	// sqlSession 은 dispatcher-servlet 에 등록되어 있는걸로
	// mybatis 객체 자동으로 주입해달라고 말하기 위해 annotation
	@Autowired
	private SqlSession sqlSession;
	
	
	// 이 컨트롤러가 리스트 뿌리고, 인원수 확인하고, 입력도 해야하는 상황
	
	//public String memberList(Model model)
	// 모델객체 mapping 해준다고 해서 ModelMap 도 있음
	// Model, ModelMap 둘이 같은 거임
	@RequestMapping(value="/memberlist.action", method = RequestMethod.GET)
	public String memberList(ModelMap model)
	{
		//IMemberDAO dao = (IMemberDAO)new MemberDAO();
		//					-----------> 2개 타입다르니까 명시적으로
		// 이제는 이게 아니라
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		// 따라해야하는 인터페이스 속성 넘겨주면 된다.
		// 그럼 인터페이스 반환해준다.
		// → 그럼에도 실제 생성되는 객체는 인터페이스가 아니라, 
		//    memberDAO 객체이다.
		//    dao.count(), dao.list() 쓸 수 있다.
		
		
		model.addAttribute("count", dao.count());
		model.addAttribute("list", dao.list());
		
		return "WEB-INF/view/MemberList.jsp";
	}
	
	@RequestMapping(value="/memberinsert.action", method = RequestMethod.POST)
	public String memberInsert(MemberDTO m)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		dao.add(m);
		//-- 알아서 name값과 dto의 속성 이름 같으면 setter로 들어가서 설정되는 거
		//   흐름 파악해야한다.
		
		return "redirect:memberlist.action";
	}
	 
	
	// GET방식으로 바인딩되는 건 다 String 형태
	// 그걸 int타입에 바인딩해서 넘기겠다고 하면 
	// preparedStatement 내부적으로 setInt() 설정이된다.
	@RequestMapping(value="/memberdelete.action", method = RequestMethod.GET)
	/* String mid 대신 MemberDTO m 으로 넘겨도 동일한 결과 나온다 */
	public String memberDelete(int mid)
	{
		IMemberDAO dao = sqlSession.getMapper(IMemberDAO.class);
		
		dao.remove(mid);
		
		return "redirect:memberlist.action";
	}
	
}
