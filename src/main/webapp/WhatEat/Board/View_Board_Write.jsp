<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="WhatEat.Data_source.*" %>
<%@ page import="WhatEat.Utils.*" %>

<%
	int kind = (int)session.getAttribute("kind");
%>
<html>
<head>
<script>
	
</script>
<title>게시판 등록</title>
</head>
<body>
	<!-- 게시판 등록 -->
	<form action="<%=request.getContextPath()%>/Board_AddAction.co" method="post" enctype="multipart/form-data" name="boardform">
				<input name="BOARD_SEQUENCE" type="hidden" value="<%=Main_DAO.getDAO().ListSequenceCommand("BOARD",kind) %>" />
				<input name="BOARD_INDEX" type="hidden" value="${sessionScope.user.getINFO_INDEX()}" />
				<input name="BOARD_KIND" type="hidden" value="<%=kind%>" />
				<input name="BOARD_PATH" type="hidden" value="<%=ReadXml.getKeys("upLoadPath1")%>" />
		<table cellpadding="0" cellspacing="0">
			<tr align="center" valign="middle">
				<td colspan="5">게시판 등록</td>
			</tr>
			<tr>
				<td style="font-family: 돋움; font-size: 12" height="16">
					<div align="center">글쓴이</div>
				</td>
				<td><input name="BOARD_WRITER" type="text" size="10" maxlength="10" value="${sessionScope.user.getINFO_NAME()}" readonly/></td>
			</tr>
			<tr>
				<td style="font-family: 돋움; font-size: 12" height="16">
					<div align="center">제 목</div>
				</td>
				<td><input name="BOARD_SUBJECT" type="text" size="50"
					maxlength="100" value="" /></td>
			</tr>
			<tr>
				<td style="font-family: 돋움; font-size: 12">
					<div align="center">내 용</div>
				</td>
				<td><textarea name="BOARD_CONTENT" cols="67" rows="15"></textarea>
				</td>
			</tr>
			<tr>
				<td style="font-family: 돋움; font-size: 12">
					<div align="center">파일 첨부</div>
				</td>
				<td><input name="BOARD_FILE" type="file"/></td>
			</tr>
			<tr bgcolor="cccccc">
				<td colspan="2" style="height: 1px;"></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr align="center" valign="middle">
			<%if(((USER) session.getAttribute("user")).getINFO_ADDBOARD_RG().equals("TRUE")){ %>
				<td colspan="5"><a href="javascript:boardform.submit()">[등록]</a>&nbsp;&nbsp;</td>
			<%}else{ %>
				<td colspan="5"><p onclick="alt()" style="cursor:pointer">[등록]</p>&nbsp;&nbsp;</td>
			<%} %>
				<td><a href="javascript:history.go(-1)">[뒤로]</a></td>
			</tr>
		</table>
	</form>
	<!-- 게시판 등록 -->
</body>
</html>