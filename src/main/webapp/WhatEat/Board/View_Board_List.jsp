<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="WhatEat.Board.*" %> 
<%@ page import="WhatEat.Utils.*" %>
<%@ page import="WhatEat.Data_source.*" %>

<%
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	int fpage = request.getParameter("page") != null?Integer.parseInt(request.getParameter("page")) : (int)session.getAttribute("page");
%>

<html>
<head>
	<title>게시판</title>
	<script>
	document.onload=search(<%=fpage%>);
	function search(va) {
		var page = va;
		//console.log(page);
		$.ajax({
			type : "POST",
			url : "./Board_ListAction.co",
			data : {
				"mk" : "true",
				"sort" : $("#sortF select").val(),
				"seq" : $("#seqF select").val(),
				"limit" : $("#limitF select").val(),
				"page": page
			},
			success : function(data) {
				$("#lists").html(data);
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
	<select name=sort onchange="search(${page })">
  		<option value="BOARD_SEQUENCE">오늘뭐먹지 순</option>
  		<!-- <option value="BOARD_SCORE">평점 순</option> -->
  		<option value="BOARD_COMMENTTOTAL">댓글갯수 순</option>
  		<option value="BOARD_READCOUNT">조회수 순</option>
  		<option value="BOARD_DATE">등록 날짜 순</option>
  		<option value="BOARD_SEQUENCE">기본 순서 순</option>
	</select>
	</form>
	</td>
	<td>
	<form action="#" id=seqF>
	<select name=seq onchange="search(${page })">
  		<option value="desc">내림차순</option>
  		<option value="asc">오름차순</option>
	</select>
	</form>
	</td>
	<td>
	</table>
	<table id="lists" width=60% border="0" cellpadding="0" cellspacing="0"> </table>
	<% } else { %>
	<div id="wrapN">
		<div class="topPadding"></div>
		<div id="contain">
			<hr />
			<div style="text-align: center; margin: 10px auto;">
				<font size=2>등록된 글이 없습니다.</font>
			</div>
		</div>
	</div>
	<% } %>
</body>
</html>