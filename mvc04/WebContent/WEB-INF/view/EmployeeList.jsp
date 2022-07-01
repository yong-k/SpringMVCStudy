<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmployeeList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		// 테스트
		//alert("확인");
		
		// 수정 버튼 클릭 시 액션 처리
		$(".updateBtn").click(function()
		{
			//alert("수정 버튼 클릭");
			
			$(location).attr("href", "employeeupdateform.action?employeeId=" + $(this).val());
		});
		
		// 삭제 버튼 클릭 시 액션 처리
		$(".deleteBtn").click(function()
		{
			//alert("삭제 버튼 클릭");
			
			if (confirm("현재 선택한 데이터를 정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "employeedelete.action?employeeId=" + $(this).val());
			}
		});
	});

</script>
<!-- 스타일 적용이 안된다면 크롬 > 설정 > 개인정보 및 보안 > 인터넷 기록 삭제 -->
</head>
<body>

<!-- 
	basicpay, extrapay, pay 천의자리마다 『,』 찍어줄거라
	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
	등록해서 포맷사용할것이다 
--> 


<!---------------------------------------------------------------------------------
	#15. EmployeeList.jsp
	- 직원 리스트 출력 페이지
	- 관리자가 접근하는 직원 데이터 출력 페이지
	  (일반 직원이 접근하는 직원 데이터 출력 페이지는 EmpList.jsp 로 구성 예정)
----------------------------------------------------------------------------------->

<div>
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[ 직원 관리(관리자 전용) ]</h1>
		<hr>
		
		<div>
			<form action="">
				<input type="button" value="직원 추가" class="btn" 
				onclick="location.href='employeeinsertform.action'"/>
				<!-- onclick="location.href='EmployeeInsertForm.jsp'"/> -->
				<!-- 직원추가 클릭하면 입력폼이 보여져야 한다. 폼 페이지 url요청 -->
				<!-- .jsp로 직접 지정해서 요청하게 쓰면 안됨
					 나중에 다 하고 나서는 ~.action 으로 고칠 것이다. -->
			</form>
		</div>
		<br><br>
		
		<!-----------------------------------------------------
		EMPLOYEEID NAME SSN BIRTHDAY LUNAR LUNARNAME TELEPHONE    
		DEPARTMENTID DEPARTMENTNAME POSITIONID POSITIONNAME          
		REGIONID REGIONNAME BASICPAY EXTRAPAY GRADE  
		------------------------------------------------------->               
		<table id="customers" class="table">
			<tr>
				<!-- 항목 15EA -->
				<th>번호</th>	
				<th>이름</th>	
				<th>주민번호</th>	
				<th>생년월일</th>	
				<th>양음력</th>	
				<th>전화번호</th>	
				<th>지역</th>	
				<th>부서</th>	
				<th>직위</th>	
				<th>기본급</th>	
				<th>수당</th>	
				<th>급여</th>	
				<th>등급</th>	
				<th>수정</th>	
				<th>삭제</th>	
			</tr>
			
			<!-- 
			<tr>
				<td>1</td>
				<td>김상기</td>
				<td>620527</td>
				<td>1962-05-27</td>
				<td>양력</td>
				<td>010-9876-5432</td>
				<td>서울</td>
				<td>개발부</td>
				<td>사원</td>
				<td>1,500,000</td>
				<td>1,500,000</td>
				<td>3,000,000</td>
				<td>관리자</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td>  
			</tr>
			<tr>
				<td>2</td>
				<td>이상기</td>
				<td>620527</td>
				<td>1962-05-27</td>
				<td>양력</td>
				<td>010-9876-5432</td>
				<td>서울</td>
				<td>개발부</td>
				<td>사원</td>
				<td>1,500,000</td>
				<td>1,500,000</td>
				<td>3,000,000</td>
				<td>관리자</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td>  
			</tr> 
			<tr>
				<td>3</td>
				<td>박상기</td>
				<td>620527</td>
				<td>1962-05-27</td>
				<td>양력</td>
				<td>010-9876-5432</td>
				<td>서울</td>
				<td>개발부</td>
				<td>사원</td>
				<td>1,500,000</td>
				<td>1,500,000</td>
				<td>3,000,000</td>
				<td>관리자</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td>  
			</tr>
			-->
			
			<!-- controller가 밀어넣어준 employeeList 받아오면 된다 -->
			<c:forEach var="employee" items="${employeeList }">
				<tr>
					<td>${employee.employeeId }</td>	
					<td>${employee.name }</td>	
					<td>${employee.ssn }-*******</td>	
					<td>${employee.birthday }</td>	
					<td>${employee.lunarName }</td>	
					<td>${employee.telephone }</td>	
					<td>${employee.regionName }</td>	
					<td>${employee.departmentName }</td>	
					<td>${employee.positionName }</td>	
					
					<%-- <td>${employee.basicPay }</td> --%>
					<td>
					<!-- fmt 접두어 사용
						부여할 옵션은 goupingUsed → 천의자리마다 묶어서 표현해주겠다. -->
						<fmt:formatNumber value="${employee.basicPay }"
						groupingUsed="true"></fmt:formatNumber>
					</td>
					
					<%-- <td>${employee.extraPay }</td> --%>
					<td>
						<fmt:formatNumber value="${employee.extraPay }"
						groupingUsed="true"></fmt:formatNumber>
					</td>
					
					<%-- <td>${employee.pay }</td> --%>
					<td>
						<fmt:formatNumber value="${employee.pay }"
						groupingUsed="true"></fmt:formatNumber>
					</td>
					
					<td>${employee.grade==0 ? "관리자" : "일반사원" }</td>
					<td>
						<!-- 사원마다 버튼가지고 있음 -->
						<!-- 반복문 돌면서 생성하면 되기 때문에 employeeId 가지고 있으면 좋다. -->
						<!-- 버튼 누르면 controller 호출 -->
						<button type="button" class="btn updateBtn"
						value="${employee.employeeId }">수정</button>
					</td>  
					<td>
						<button type="button" class="btn deleteBtn"
						value="${employee.employeeId }">삭제</button>
					</td>
				</tr>
				</c:forEach>
			
		</table>
		
	</div>
	
	<!-- 회사 소개 및 어플리케이션 소개 영역 -->
	<div id="footer"></div>
</div>

</body>
</html>