<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="WhatEat.Data_source.*"%>

<html>
<head>
<title>즐겨찾기 리스트</title>
<link href="<%=request.getContextPath()%>/WhatEat/css/list.css" rel="stylesheet" type="text/css" />
<script>
document.onload = loadPage();
	function loadPage() {
		var page = ${sessionScope.stpage} > 0 ? ${sessionScope.stpage}:<%=ReadXml.getKeys("limit2")%>;
		$.ajax({
			type : "POST",
			url : "./Star_ListAction.co",
			data : {
				"mk" : "true",
				"sort" : $("#sortF select").val(),
				"seq" : $("#seqF select").val(),
				"stpage": page
			},
			success : function(data) {
				$("#lists").html(data);
			}
		});
	}
</script>
</head>
<body>
	<div>
		<c:choose>
			<c:when test="${listcount > 0 }">
				<table width=60% border="0" cellpadding="0" cellspacing="0">
					<tr align="center" valign="middle">
					<td align="right"><div id="adress_list"> <font size=1px>검색된 결과 수 : ${listcount}</font></div></td>
					</tr>
					<tr>
						<td align=right colspan="4">
							<form action="#" id=sortF>
								<select name=sort onchange="loadPage()">
									<option value="STORE_NUM">오늘뭐먹지 순</option>
									<option value="STORE_SCORE">평점 순</option>
									<option value="STORE_COMMENTTOTAL">댓글갯수 순</option>
									<option value="STORE_READCOUNT">조회수 순</option>
									<option value="STORE_DATE">등록 날짜 순</option>
									<option value="STORE_NUM">기본 순서 순</option>
								</select>
							</form>
						</td>
						<td>
							<form action="#" id=seqF>
								<select name=seq onchange="loadPage()">
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
			<hr />
			<div style="text-align: center; margin: 10px auto;">
					<font size=2>추가된 즐겨찾기가  없습니다.</font>
			</div>
		</div>
	</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>