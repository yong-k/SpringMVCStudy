<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmployeeInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>

<script type="text/javascript">
	
	// $();
	// jquery();
	$(document).ready(function()
	{
		// Ajax 요청 및 응답 처리
		ajaxRequest();
		//-- 지금은 페이지 최초 요청되었을 때만 minBasicPay 뿌려주는 형태
		//   그게 아니라 selectbox 바뀔 때마다 뿌려줘야 한다. (Line 51에 작성)
		
		// 테스트
		//alert("확인");
		
		// jQuery-UI 캘린더를 불러오는 함수 처리(datepicker())
		//-- id가 birthday인 걸 클릭하면 달력 나오게 하고 싶은 거
		$("#birthday").datepicker(
		{
			//-- 여기까지하고 확인해보면 생년월일 클릭하면 달력나오고
			//   날짜 선택하면 달력 사라지고 텍스트박스에 해당 날짜 들어감
			//   날짜 05/01/2022 로 들어가고 있음
			//   jquery-ui.js 의 dateFormat: "mm/dd/yy" 에 구문에 의해서
			// 아래와 같이 해당 속성 이름 쓰고 변경해줄 수 있다~
			
			dateFormat: "yy-mm-dd"
			, changeMonth: true
			, changeYear: true
		});
		
		
		// 먼저, 아래에서 ajax요청과 관련된 함수 만들고 오자
		
		// 직위(select)의 선택된 내용이 변경되었을 경우 수행해야 할 코드 처리
		$("#positionId").change(function()
		{	
			// 테스트
			//alert("변경~!!!");
			
			// Ajax 요청 및 응답 처리
			ajaxRequest(); 
			//-- 직위 바뀐거에 맞춰서 최소기본급 바껴야 하니까
		});
		
		
		// 직원 변경 버튼이 클릭되었을 때 수행해야 할 코드 처리
		$("#submitBtn").click(function()
		{
			// 테스트
			//alert("버튼 클릭~!!!");
			
			// 테스트
			//alert($("#minBasicPay").val());		//--(Ⅹ)
			// └→ 아무것도 안나옴. 이렇게 얻어낼 수 없다.
			//alert($("#minBasicPay").text());		//--(○)
			
			
			// 데이터 검사(누락된 입력값이 있는지 없는지에 대한 여부 확인)
			if ($("#name").val()=="" || $("#ssn1").val()=="" || $("#ssn2").val()==""
					|| $("#birthday").val()=="" || $("#telephone").val()==""
					|| $("#basicPay").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;								//-- submit 액션 처리 중단
			}
			
			
			// 최소 기본급에 대한 유효성 검사
			// if (직급별최소기본급 > 사용자가입력한기본급) {return;}
			// $("#minBasicPay").text() > $("#basicPay").val() 그냥 이대로 산술비교 불가
			// 정수형태로 변환해줘야 한다.
			if ( parseInt($("#minBasicPay").text()) > parseInt($("#basicPay").val()) )
			{
				$("#err").html("입력하신 기본급이 최소 기본급보다 작습니다.");
				$("#err").css("display", "inline");
				return;								//-- submit 액션 처리 중단
			}
			
			
			// 폼 submit 액션 처리 수행
			$("#employeeForm").submit();
				
		});
		
	});
	
	
	// ajax요청과 관련된 함수
	function ajaxRequest()
	{	
		//alert("Ajax 요청 및 응답 처리");
	
		// 『$.post()』	/ 『$.get()』
		//-- jQuery 에서 Ajax 를 써야 할 경우 지원해주는 함수
		//   (서버 측에서 요청한 데이터를 받아오는 기능의 함수)
		
		// ※ 이 함수(『$.post()』)의 사용 방법(방식)
		//-- 『$.post(요청주소, 전송데이터, 응답액션처리)』
		//   ·요청주소(url)
		//     → 데이터를 요청할 파일에 대한 정보
		//   ·전송데이터(data)
		//     → 서버 측에 요청하는 과정에서 내가 전달할 파라미터
		//   ·응답액션처리(function)
		//     → 응답을 받을 수 있는 함수
		//        기능 처리
		
		// ※ 참고로... data 는 파라미터의 데이터타입을 그대로 취하게 되므로
		//    html 이든... 문자열이든... 상관이 없다.
		
		$.post("ajax.action", {positionId: $("#positionId").val()}, function(data)
		{
			$("#minBasicPay").html(data);
		});
		//--① ~~.action 이라는 약속은 지켜서 구성해야 한다.
		//  ② 직위의 selectBox 에 선택된 Id를 넘겨주면 된다.
		//  ③ position 넘겨주고 받은거 파라미터로 받는 함수
		//     id가 minBasicPay인 거에 그 값 넣어서 출력되게 해주면 된다.
		
		// 그러면 ajax.action 에 응답하는 뭔가가 있어야 한다.
		// → dispatcher-servlet 건드려야 한다.
		
	}

</script>
</head>
<body>

<!--------------------------------
	#. EmployeeUpdateForm.jsp
	- 직원 데이터 수정 페이지
---------------------------------->

<!-- 
	입력폼에 데이터 입력된 형태로 수정폼 구성할거임
	그 정보는 Controller 한테 받아오는 거 
	사용자가 [수정]버튼 누르면, 아래와 같은 폼 
	[수정] 됐을 때 url 요청 
	employeeupdateform.action
	employeeupdateformController → employeeupdateForm.jsp 출동
	employeeupdate.action
	employeeupdateController
-->
<div>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
	
		<h1> [ 직원 변경 ] </h1>
		<hr />
		
		<form action="employeeupdate.action" method="post" id="employeeForm">
			<table>
			
				<!-- 기존 입력폼에서 추가되는 항목 -->
				<tr>
					<th>사원번호</th>
					<td>
						<!-- 사원번호는 바꿀거 아니라서 readonly 속성 부여함 -->
						<input type="text" id="employeeId" name="employeeId" readonly="readonly" 
						value="${employee.employeeId }"/>
					</td>
				</tr>
			
				<tr>
					<th>이름</th>
					<td>
						<input type="text" id="name" name="name" value="${employee.name }" />
					</td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td>
						<input type="text" id="ssn1" name="ssn1" style="width: 100px;" 
						value="${employee.ssn1 }" /> -
						<input type="password" id="ssn2" name="ssn2" style="width: 110px;" 
						placeholder="뒤 7자리" />
						<!-- 그냥 원래 가지고 있는 값 넣어주는거 보다는 -->
						<!-- 주민번호 뒷자리는 입력하는 과정에서 다시 입력하게 하는게 바람직하다. -->
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" id="birthday" name="birthday" value="${employee.birthday }" />
					</td>
				</tr>
				<tr>
					<th>양/음력</th>
					<td>
						<!-- 어떤 때 양력으로 찍히는지, 음력으로 찍히는지 확인하고 해줘야한다. -->
						<!-- 바인딩한 데이터가 양력으로 들어있으면 양력 radio button 에 checked -->
						<!-- 바인딩한 데이터가 음력으로 들어있으면 음력 radio button 에 checked -->
						<!-- ┌→ 0면 checked, 아니라면 checked 안한다는 뜻 -->
						<input type="radio" value="0" name="lunar" id="lunar0"
                 		 ${employee.lunar==0 ? "checked=\"cheked\"" : "" }>
                  		<label for="lunar0">양력</label>
                 		<input type="radio" value="1" name="lunar" id="lunar1"
                 		${employee.lunar==1 ? "checked=\"cheked\"" : "" }>
                  		<label for="lunar1">음력</label>
               		</td>
            	</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="tel" id="telephone" name="telephone" 
						value="${employee.telephone }" />
					</td>
				</tr>
				
				<tr>
					<th>지역</th>	
					<td>
						<select id="regionId" name="regionId">
							<!-- 
							<option value="1">강북</option>
							<option value="2">강남</option>
							<option value="3">마포</option>
							<option value="4">서대문</option>
							<option value="5">은평</option>
							-->
							<c:forEach var="region" items="${regionList }">
								<!-- employee로부터 얻어온 regionId 와 region의 regionId가 같으면 selected -->
								<option value="${region.regionId }"
								${employee.regionId == region.regionId ? "selected=\"selected\"" : "" 
								}>${region.regionName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<select id="departmentId" name="departmentId">
							<!-- 
							<option value="1">독서부</option>
							<option value="2">원예부</option>
							<option value="3">축구부</option>
							<option value="4">야구부</option>
							-->
							<c:forEach var="department" items="${departmentList }">
								<option value="${department.departmentId }"
								${employee.departmentId == department.departmentId ? "selected=\"selected\"" : "" 
								}>${department.departmentName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>직위</th>
					<td>
						<select id="positionId" name="positionId">
							<!-- 
							<option value="1">팀장</option>
							<option value="2">기술고문</option>
							<option value="3">팀원</option>
							<option value="4">엑스맨</option>
							-->
							<c:forEach var="position" items="${positionList }">
								<option value="${position.positionId }"
								${employee.positionId == position.positionId ? "selected=\"selected\"" : "" 
								}>${position.positionName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>기본급</th>
					<td>
						<input type="text" id="basicPay" name="basicPay" 
						value="${employee.basicPay }"/>
						(최소 기본급 <span id="minBasicPay"
						style="color: red; font-weight: bold;">0</span>원)
					</td>
				</tr>
				<tr>
					<th>수당</th>
					<td>
						<input type="text" id="extraPay" name="extraPay" 
						value="${employee.extraPay }"/>
					</td>
				</tr>
				
				<tr>
					 <td colspan="2" align="center">
					 	<br /><br />
					 	
					 	<button type="button" class="btn" id="submitBtn"
					 	style="width: 40%; height: 50px;">직원 변경</button>
					 	<button type="button" class="btn" id="listBtn"
					 	style="width: 40%; height: 50px;"
					 	onclick="location.href='employeelist.action'">직원 리스트</button>
					 	<br /><br />
					 	
					 	<span id="err" style="color: red; font-weight: bold; display: none;"></span>
					 </td>
				</tr>
				
			</table>
		</form>
	
	</div>
	
	<!-- 회사 소개 및 어플리케이션 소개 영역 -->
	<div id="footer">
	</div>

</div>

</body>
</html>









