<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="WhatEat.Board.*" %> 
<%@ page import="WhatEat.Utils.*" %>
<%@ page import="WhatEat.Data_source.*" %>

<%
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	int nowpage=((Integer)request.getAttribute("page")).intValue();
	int maxpage=((Integer)request.getAttribute("maxpage")).intValue();
	int startpage=((Integer)request.getAttribute("startpage")).intValue();
	int endpage=((Integer)request.getAttribute("endpage")).intValue();
	int bNum = Integer.parseInt(ReadXml.getKeys("bNum"));
	int cls = ((Integer)session.getAttribute("cls")).intValue();
	USER user = (USER) session.getAttribute("user");
%>

<html>
<head>
	<title>가게 리스트</title>
	<script>
	document.onload=search();
	function search(){
		$.ajax({type:"POST",url:"./Food_ListAction.co",data:{ "mk":1,"sort":$("#sortF select").val(), "seq":$("#seqF select").val()},success:function(data){
			$("#lists").html(data);
			}});
	}
	</script>
</head>
<body>
<table width=60% border="0" cellpadding="0" cellspacing="0">
<% if(listcount > 0){ %>
	<tr align="center" valign="middle">
		<td align="right"> <font size=1px>검색된 결과 수 : ${listcount}</font> </td>
	</tr>
	<tr>
	<td align=right colspan="4">
	<form action="#" id=sortF>
	<select name=sort onchange="search()">
  		<option value="BOARD_SEQUENCE">오늘뭐먹지 순</option>
  		<option value="BOARD_SCORE">평점 순</option>
  		<option value="BOARD_COMMENTTOTAL">댓글갯수 순</option>
  		<option value="BOARD_READCOUNT">조회수 순</option>
  		<option value="BOARD_DATE">등록 날짜 순</option>
  		<option value="BOARD_SEQUENCE">기본 순서 순</option>
	</select>
	</form>
	</td>
	<td>
	<form action="#" id=seqF>
	<select name=seq onchange="search()">
  		<option value="desc">내림차순</option>
  		<option value="asc">오름차순</option>
	</select>
	</form>
	</td>
	</tr>
</table>
<div id="lists">
</div>
	<% } else { %>
			<div id="wrapN">
		<div class="topPadding"></div>
		<div id="contain">
			<div style="text-align: center; margin: 10px auto;">
				<font size=2>검색 결과가 없습니다</font>
			</div>
		</div>
	</div>
	<% } %>
</body>
</html>