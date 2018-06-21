<%@page import="WhatEat.Utils.*"%>
<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="WhatEat.Data_source.*"%>
<%@ page import="java.util.*"%>

<%
	USER user = (USER) session.getAttribute("user");
	HashMap map = (HashMap) session.getAttribute("pmap");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 정보 보기</title>
<!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
<link href="<%=request.getContextPath()%>/WhatEat/css/DetailForm.css"
	rel="stylesheet" type="text/css" />
<script>
	function del(){
		var i = confirm('회원탈퇴 하시겠습니까?');
		if(i == false) location.href='./Member_DetailAction.co';
		else location.href='./Member_DeleteAction.co';
	}
</script>
</head>
<body>
	<div id="wrapDF">
		<div class="topPadding"></div>
		<div id="contain">
			<h2>내 정보 보기</h2>
			<hr />
			<table id="tb" width=60% border="1" cellpadding="0" cellspacing="0">
			<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">포지션</h5>
					</td>
					<td><%= map.get(user.getINFO_POSITION())%></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">사업자 번호</h5>
					</td>
					<td><%=user.getINFO_PERMIT()%></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">아이디</h5>
					</td>
					<td><%=user.getINFO_ID()%></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">이름</h5>
					</td>
					<td><%=user.getINFO_NAME()%></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">생년월일</h5>
					</td>
					<td><%=user.getINFO_BIRTH()%></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">연락처</h5>
					</td>
					<td><%=user.getINFO_PHONENUM()%></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">기부금</h5>
					</td>
					<td><%=user.getINFO_DONATION()%></td>
				</tr>
			</table>
			<div class="buttonForm">
				<%
					if (user != null) {
						if (user.getINFO_MODINFO_RG().equals("TRUE")) {
				%>
				<div class="button" onclick="location.href='<%=request.getContextPath() + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_SellerPath2")%>Modify.jsp'">회원정보 수정</div>
				<% }else{%>
				<div class="button" onclick="alt()">회원정보 수정</div>
				<%} }%>
				<div class="button" onclick="del()">회원 탈퇴</div>
			</div>
		</div>
		<div class="bottomPadding"></div>
	</div>
</body>
</html>