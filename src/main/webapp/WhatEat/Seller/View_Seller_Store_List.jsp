<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="WhatEat.Data_source.*"%>

<%
	USER user = (USER) session.getAttribute("user");
%>
<html>
<head>
<link href="<%=request.getContextPath()%>/WhatEat/css/list.css" rel="stylesheet" type="text/css" />
<title>매장 리스트</title>
<script>
	document.onload = search();
	function search() {
		var i = 0;
		if($("#page").val() != null)
			i = $("#page").val();
			var page = Number(i)+<%=ReadXml.getKeys("limit2")%>;
		$.ajax({
			type : "POST",
			url : "./Seller_Store_ListAction.co",
			data : {
				"mk" : "true",
				"sort" : $("#sortF select").val(),
				"seq" : $("#seqF select").val(),
				"page": page
			},
			success : function(data) {
				$("#lists").html(data);
			}
		});
	}
	$(document).ready(function(){
		if((!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))})&&(!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))})){
			alt();
			location.href= "./Home/View_Main.jsp";
		}
	})
</script>
</head>
<body>
	<div>
		<c:choose>
			<c:when test="${listcount > 0 }">
				<table width=60% border="0" cellpadding="0" cellspacing="0">
					<tr align="center" valign="middle">
						<td align="right"><font size=2px>검색된 결과 수 :
								${listcount}</font></td>
					</tr>
					<tr>
						<td align=right colspan="4">
							<form action="#" id=sortF>
								<select name=sort onchange="search()">
									<option value="<%=ReadXml.getKeys("Store_Condition6")%>">평점 순</option>
									<option value="<%=ReadXml.getKeys("Store_Condition5")%>">댓글갯수 순</option>
									<option value="<%=ReadXml.getKeys("Store_Condition4")%>">조회수 순</option>
									<option value="<%=ReadXml.getKeys("Store_Condition10")%>">등록 날짜 순</option>
									<option value="<%=ReadXml.getKeys("Store_Condition2")%>">기본 순서 순</option>
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
				<div id="lists"></div>
			</c:when>
			<c:otherwise>
			<div id="wrapN">
		<div class="topPadding"></div>
		<div id="contain">
			<div style="text-align: center; margin: 10px auto;">
				<font size=2>검색 결과가 없습니다</font>
			</div>
		</div>
	</div>
			</c:otherwise>
		</c:choose>
			<%if((user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller")) && user.getINFO_ADDSTORE_RG().equals("TRUE")) || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))){%>
			<div style="text-align:center"><a href="<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_SellerPath2")%>Store_Add.jsp">[가게추가]</a></div>
			<%} else if(user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller")) && (!user.getINFO_ADDSTORE_RG().equals("TRUE"))){%>
			<div style="text-align:center"><p onclick="alt()">[가게추가]</p></div>
			<%} %>
	</div>
</body>
</html>