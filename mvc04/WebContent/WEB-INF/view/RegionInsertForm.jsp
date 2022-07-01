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
<title>RegionInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript">
	$(function()
	{
		$("#submitBtn").click(function()
		{
			// 테스트
			//alert("버튼 클릭");
			
			if ($("#regionName").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;
			}
			
			$("#regionForm").submit();
		});
	});
</script>
</head>
<body>

<div>
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[ 지역 추가 ]</h1>
		<hr />
		
		<form action="regioninsert.action" method="post" id="regionForm">
			<table>
				<tr>
					<th>현재 있는 지역 목록</th>
					<td>
						<select name="regionList" id="regionList">
						<c:forEach var="region" items="${regionList }">
							<option value="${region.regionId }">${region.regionName }</option>
						</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>지역이름</th>
					<td>
						<input type="text" id="regionName" name="regionName" placeholder="지역 이름" />
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<br /><br />
						<button type="button" class="btn" id="submitBtn"
						style="width: 40%; height: 50px;">지역 추가</button>
						<button type="button" class="btn" id="listBtn"
						style="width:40%; height: 50px;"
						onclick="location.href='regionlist.action'">지역 리스트</button>
						<br /><br />
						
						<span id="err" style="color: red; font-weight: bold; display: none;"></span>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- 회사 소개 및 어플리케이션 소개 영역 -->
	<div id="footer"></div>
</div>

</body>
</html>