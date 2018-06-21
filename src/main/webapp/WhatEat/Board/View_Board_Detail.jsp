<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="WhatEat.Data_source.*"%>
<%
	BOARD_Bean bean = (BOARD_Bean) request.getAttribute("bean");
	USER user = (USER) session.getAttribute("user") != null ? (USER) session.getAttribute("user") : null;
	boolean bI = user != null ? user.getINFO_INDEX() == bean.getBOARD_INDEX() : false;
	boolean bP = user != null ? user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")) : false;
%>

<html>
<head>
<title>게시판</title>
<style>
p {
	cursor: pointer;
}

@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

#wrapDF {
	width: 100%;
	min-height: 300px;
	background-color: #fafafa;
	margin:10px auto;
}

#wrapDF .topPadding {
	width: 90%;
	max-width: 600px;
	height: 20px;
}

#wrapDF #contain {
	width: 90%;
	max-width: 600px;
	background-color: #ffffff;
	border: 1px solid #000000;
	padding: 30px;
}
</style>
<script>
document.onload = getComments();
function onDownload() {
	var down = document.getElementById("ifm_filedown");	
		down.src = "./Board_DownAction.co?path=<%=bean.getBOARD_PATH()%>&file=<%=bean.getBOARD_FILE()%> "
	}
function getComments() {
	$.ajax({
		type : "POST",
		url : "./Board_Comments_ListAction.co",
		data: {
			"ComNum" : ${sessionScope.bnum},
			"ComKind" : "board"
		},
		success : function(data) {
			$(".comments").html(data);
		}
	});
}
function sort() {
	$.ajax({
		type : "POST",
		url : "./Board_Comments_ListAction.co",
		data : {
			"comments_sort" : $("#comments_sortF select").val(),
			"comments_seq" : $("#comments_seqF select").val(),
			"comments_page" : $("#comments_page").val()
		},
		success : function(data) {
			$(".comments").html(data);
		}
	});
}
</script>
</head>
<body>
	<div id="wrapDF">
		<div class="topPadding"></div>
		<div id="contain">
			<iframe id="ifm_filedown" style="position: absolute; z-index: 1; visibility: hidden;"></iframe>
			<table cellpadding="0" cellspabIng="0" style="margin: 10px auto;width:100%;">
				<tr>
					<td style="font-family: 돋음; font-size: 12" height="16">
						<div align="center">제 목</div>
					</td>

					<td style="font-family: 돋음; font-size: 12"><%=bean.getBOARD_SUBJECT()%>
					</td>
				</tr>

				<tr bgcolor="cccccc">
					<td colspan="2" style="height: 1px;"></td>
				</tr>
				<%
					if (bean.getBOARD_FILE() != null) {
						if (!bean.getBOARD_FILE().equals("null")) {
				%>
				<tr>
					<td></td>
					<td><div>
							<img style="width:100%" src="<%=request.getContextPath() + bean.getBOARD_PATH() + bean.getBOARD_FILE()%>" />
						</div>
					<td>
				<tr>
					<%
						}
						}
					%>
				
				<tr>
					<td style="font-family: 돋음; font-size: 12">
						<div align="center">내 용</div>
					</td>
					<td style="font-family: 돋음; font-size: 12">
						<div style="min-width: 200px; max-width: 500px; min-height: 200px"><%=bean.getBOARD_CONTENT().replace("\n", "<br/>")%></div>
					</td>
				</tr>
				<tr bgcolor="cccccc">
					<td colspan="2" style="height: 1px;"></td>
				</tr>
				<%
					if (bean.getBOARD_FILE() != null) {
						if (!bean.getBOARD_FILE().equals("null")) {
				%>
				<tr>
					<td style="font-family: 돋음; font-size: 12">
						<div align="center">첨부파일</div>
					</td>
					<td style="font-family: 돋음; font-size: 12">
						<div style="cursor: pointer" onclick="onDownload()">
							<%=bean.getBOARD_FILE()%>
						</div>
					</td>
				</tr>
				<%
					}
					}
				%>

				<tr bgcolor="cccccc">
					<td colspan="2" style="height: 1px;"></td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>

				<tr align="center" valign="middle">
					<%
						if (user != null) {
							if ((bI && user.getINFO_MODBOARD_RG().equals("TRUE")) || bP) {
					%>
					<td><p onclick="javascript:location.href='.<%=ReadXml.getKeys("View_ServicePath") + ReadXml.getKeys("View_BoardPath2") + "Modify.jsp"%>?num=<%=bean.getBOARD_NUM()%>'"> [수정]</p></td>
					<%
						} else if (bI && (!user.getINFO_MODBOARD_RG().equals("TRUE"))) {
					%>
					<td><p onclick="alt()">[수정]</p></td>
					<%
						}
							if ((bI && user.getINFO_DELBOARD_RG().equals("TRUE")) || bP) {
					%>
					<td><p onclick="javascript:{if(confirm('정말 삭제 하시겠습니까?'))location.href='./Board_DeleteAction.co?num=<%=bean.getBOARD_NUM()%>&index=<%=bean.getBOARD_INDEX()%>';}"> [삭제]</p></td>
					<%
						} else if (bI && (!user.getINFO_DELBOARD_RG().equals("TRUE"))) {
					%>
					<td><p onclick="alt()">[삭제]</p></td>
					<%
						}
						}
					%>
					<td><a href="./Board_ListAction.co">[목록]</a></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="comments"></div>
	<div style="text-align: center">
		<p onclick="javascript:location.href='./Board_DetailAction.co?View5=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Write.jsp?kind=1&boardnum=<%=bean.getBOARD_NUM()%>'"> [댓글 쓰기]</p>
	</div>
	<jsp:include page="${param.View5}" />

</body>
</html>