<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="WhatEat.Board.*" %> 
<%@ page import="WhatEat.Utils.*" %>
<%@ page import="WhatEat.Data_source.*" %>

<%
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	boolean onUser = session.getAttribute("user") == null? true:false;
	boolean isAdmin = false;
	if(!onUser){
		isAdmin =((USER)session.getAttribute("user")).getINFO_POSITION().equals(ReadXml.getKeys("position_admin"));
	}
%>

<html>
<head>
	<title>회원 리스트</title>
	<script>
	document.onload=search(${sessionScope.apage});
	function search(va) {
		if(<%=onUser%>){
			alt();
			location.href="./Home/View_Main.jsp";
		}else if(!<%=isAdmin%>){
			alt();
			location.href="./Home/View_Main.jsp";
			}
		$.ajax({
			type : "POST",
			url : "./Admin_ListAction.co",
			data : {
				"mk" : "true",
				"sort" : $("#sortF select").val(),
				"sort2" : $("#sortF2 select").val(),
				"seq" : $("#seqF select").val(),
				"seq2" : $("#seqF2 select").val(),
				"limit" : $("#limitF select").val(),
				"apage": va
			},
			success : function(data) {
				$("#members").html(data);
			}
		});
	}
	</script>
</head>
<body>
<br/>
<table width=60% border="0" cellpadding="0" cellspacing="0">
<% if(listcount > 0){ %>
	<tr>
	<td align=right colspan="4">
	<form action="#" id=sortF>
	<select name=sort onchange="search(${sessionScope.apage})">
  		<option value="INFO_INDEX">기본 순서 순</option>
  		<option value="INFO_POSITION">포지션 순</option>
  		<option value="INFO_GRADE">등급 순</option>
  		<option value="INFO_ID">아이디 순</option>
  		<option value="INFO_NAME">이름 순</option>
  		<option value="INFO_BIRTH">생일 순</option>
  		<option value="INFO_MILEAGE">마일리지 순</option>
  		<option value="INFO_EMAIL">이메일 순</option>
  		<option value="INFO_JOINDATE">회원가입 순</option>
  		<option value="INFO_DONATION">기부금 순</option>
	</select>
	</form>
	</td>
	<td>
	<form action="#" id=seqF>
	<select name=seq onchange="search(${sessionScope.apage })">
  		<option value="desc">내림차순</option>
  		<option value="asc">오름차순</option>
	</select>
	</form>
	</td>
	<td>
	<form action="#" id=limitF>
	<select name=limit onchange="search(1)">
  		<option value="${sessionScope.limit }">표시할 정보 수</option>
  		<option value="5">5</option>
  		<option value="10">10</option>
  		<option value="30">30</option>
  		<option value="50">50</option>
  		<option value="100">100</option>
	</select>
	</form>
	</td>
	<tr>
	<td align=right colspan="4">
	<form action="#" id=sortF2>
	<select name=sort2 onchange="search(${sessionScope.apage })">
  		<option value="null">중복 정렬 기준</option>
  		<option value="INFO_INDEX">기본 순서 순</option>
  		<option value="INFO_POSITION">포지션 순</option>
  		<option value="INFO_GRADE">등급 순</option>
  		<option value="INFO_ID">아이디 순</option>
  		<option value="INFO_NAME">이름 순</option>
  		<option value="INFO_BIRTH">생일 순</option>
  		<option value="INFO_MILEAGE">마일리지 순</option>
  		<option value="INFO_EMAIL">이메일 순</option>
  		<option value="INFO_JOINDATE">회원가입 순</option>
  		<option value="INFO_DONATION">기부금 순</option>
	</select>
	</form>
	</td>
	<td>
	<form action="#" id=seqF2>
	<select name=seq2 onchange="search(${sessionScope.apage})">
  		<option value="desc">내림차순</option>
  		<option value="asc">오름차순</option>
	</select>
	</form>
	</td>
	</tr>
</table>
	<% } else { %>
	<div id="wrapN">
		<div class="topPadding"></div>
		<div id="contain">
			<hr />
			<div style="text-align: center; margin: 10px auto;">
				<font size=2>검색 결과가 없습니다</font>
			</div>
		</div>
	</div>
	<% } %>
<table id="members" width=60% border="0" cellpadding="0" cellspacing="0">
</table>
</body>
</html>