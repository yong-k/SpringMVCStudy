/*=============================================
	HelloController.java
	- 사용자 정의 컨트롤러 클래스
	- 『@Controller』 어노테이션 등록
	- 『@RequestMapping』 어노테이션 등록
==============================================*/


package com.test.mvc;

import org.springframework.stereotype.Controller;					//-- check~!!!
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;		//-- check~!!!

/*
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
*/

// ※ Annotation 표기법으로 만든 컨트롤러 객체 지정
//    → 더 이상 Controller interface를 implements 할 필요 없다.
//    → 당연히 그러면 그 안에서 handleRequest()를 overriding 할 필요도 없다.

@Controller						//-- 이거 쓴 것만으로 controller 역할 수행하게 된다.
public class HelloController //implements Controller
{
	/*
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();

		return mav;
	}
	*/

	
	/*
	이제 dispatcher-servlet 에 bean 직접 등록하는 거 사라짐
	→ client 가 요청하는 url도 같이 사라지게 된다.
	~~~.action 에 따라서 어떤 액션하고 property 는 뭘 주입한다는 거 사라짐
	어떤 클래스가 controller야 라는 것도 사라지지만
	어떤 요청이 왔을 때 어떤 controller로 넘길거라는 것도 사라진다.
	 */
	
	// 그럴 때 사용하는게 → RequestMapping
	// 이 컨트롤러 안에서 어떤 액션 수행할 지는 그냥 사용자가 정의하면 된다.
	
	// ※ 액션 처리를 위한 메소드는 사용자 지정
	/*
	@RequestMapping("URL매핑주소")
	public String 메소드이름(매개변수)
	{
		// ※ 비즈니스 로직 처리(모델 활용)
		// ...
		
		return "뷰 이름.jsp";
	}
	*/
	
	// 메소드의 매개변수에... 필요로하는 객체를 지정하면
	// 이것을 스프링에 전달해준다.
	// ┌→'/hello.action'이라는 요청 들어오면 얘가 동작하도록 할거야
	@RequestMapping("/hello.action")	
	public String hello(Model model)	//-- Model type의 model 넘겨줌
	{
		// ※ 비즈니스 로직 처리(모델 활용)
		// ...
		
		// 데이터 전달 명령
		model.addAttribute("hello", "Hello, SpringMVCAnnotation World!");
		
		return "/WEB-INF/view/Hello.jsp";
	}

}

// '/hello.action' 요청에 대해서 
// 클래스 이름, 메소드 이름, 매개변수 맘대로,  view도 문자열형태로 지정







