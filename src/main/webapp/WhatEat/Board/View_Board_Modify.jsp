<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Data_source.*"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%
BOARD_Bean bean = new BOARD_Bean(); 
bean = (BOARD_Bean) Main_DAO.getDAO().DetailCommand(bean,Integer.parseInt(request.getParameter("num")));
USER user = (USER) session.getAttribute("user");
boolean bI = user.getINFO_INDEX() == bean.getBOARD_INDEX();
boolean bP = user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"));
%>

<html>
<head>
<title>게시판 수정</title>
</head>

<body>
	<!-- 게시판 수정 -->
	<form action="<%=request.getContextPath()%>/Board_ModifyAction.co" method="post" name="modifyform" enctype="multipart/form-data">
		<input type="hidden" name="BOARD_NUM" value=<%=bean.getBOARD_NUM()%>>
		<input type="hidden" name="BOARD_INDEX" value=<%=bean.getBOARD_INDEX()%>>
		<table cellpadding="0" cellspabIng="0">
			<tr>
				<td height="16" style="font-family: 돋음; font-size: 12">
					<div align="center">제 목</div>
				</td>
				<td><input name="BOARD_SUBJECT" size="50" maxlength="100"
					value="<%=bean.getBOARD_SUBJECT()%>"></td>
			</tr>
			<tr>
				<td style="font-family: 돋음; font-size: 12">
					<div align="center">내 용</div>
				</td>
				<td>
				<textarea name="BOARD_CONTENT" style="min-width:500px;min-height:500px;resize:none"><%=bean.getBOARD_CONTENT()%></textarea>
				</td>
			</tr>
			<tr>
				<td style="font-family: 돋음; font-size: 12">
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
			<%
			if(user != null){
			if((bI && user.getINFO_MODBOARD_RG().equals("TRUE")) || bP){ %>
				<td colspan="5"><font size=2> <a href="javascript:modifyform.submit()">[수정]</a>&nbsp;&nbsp; </font>
			<%} else if(bI && (!user.getINFO_MODBOARD_RG().equals("TRUE"))){%>
			<td><p onclick="alt()" style="cursor:pointer"> [수정] </p>&nbsp;&nbsp;</td>
			<%}} %>
				<td>
				<font size=2>
				<a href="javascript:history.go(-1)">[뒤로]</a>&nbsp;&nbsp;
				</font></td>
			</tr>
		</table>
	</form>
	<!-- 게시판 수정 -->
</body>
</html>