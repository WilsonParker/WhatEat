<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Data_source.*"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%
COMMENTS_Bean cbean = new COMMENTS_Bean(); 
cbean = (COMMENTS_Bean) Main_DAO.getDAO().DetailCommand(cbean,Integer.parseInt(request.getParameter("cnum")));
USER user = (USER) session.getAttribute("user");
session.setAttribute("ModPath",request.getParameter("path"));
boolean cI = user.getINFO_INDEX() == cbean.getCOMMENTS_INDEX();
boolean cP = user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"));
%>

<html>
<head>
</head>

<body>
	<form action="<%=request.getContextPath()%>/Board_Comments_ModifyAction.co" method="post" name="cmodifyform">
		<input type="hidden" name="COMMENTS_NUM" value=<%=cbean.getCOMMENTS_NUM()%>>
		<input type="hidden" name="COMMENTS_INDEX" value=<%=cbean.getCOMMENTS_INDEX()%>>
		<br/>
		<table cellpadding="0" cellspacing="0" border=1 style="min-width:150px;width:40%;">
			<tr align="center" valign="middle" bordercolor="#333333"
				onmouseover="this.style.backgroundColor='F8F8F8'"
				onmouseout="this.style.backgroundColor=''">
				<td style="cursor:pointer" colspan=2>댓글 수정하기</td>
			</tr>
			<tr>
				<td colspan="2" class="ftd" style="width:98%;"><textarea name="COMMENTS_CONTENT" style="resize:none;width:98%"><%=cbean.getCOMMENTS_CONTENT()%></textarea></td>
			</tr>
			<tr align="center" valign="middle">
			<%
			if(user != null){
			if((cI && user.getINFO_MODCOMMENT_RG().equals("TRUE")) || cP){ %>
				<td colspan="1"><font size=2> <a href="javascript:cmodifyform.submit()">[수정]</a>&nbsp;&nbsp; </font>
			<%} else if(cI && (!user.getINFO_MODCOMMENT_RG().equals("TRUE"))){%>
			<td><p onclick="alt()" style="cursor:pointer"> [수정] </p>&nbsp;&nbsp;</td>
			<%}} %>
				<td> <font size=2> <a href="javascript:history.go(-1)">[뒤로]</a>&nbsp;&nbsp; </font></td>
			</tr>
		</table>
	</form>
	<!-- 게시판 수정 -->
</body>
</html>