<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Data_source.*"%>
<%@ page import="WhatEat.Admin.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%
	GRADE_Bean gbean = new GRADE_Bean();
	gbean = (GRADE_Bean) Main_DAO.getDAO().DetailCommand(gbean, Integer.parseInt(request.getParameter("gnum")));
	USER user = (USER) session.getAttribute("user");
	boolean cP = user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"));
%>

<html>
<head>
</head>
<body>
	<br />
	<div id="wrapJ">
		<div class="topPadding"></div>
		<div id="contain">
			<h2>등급 수정</h2>
			<form name="modForm" action="./Admin_Grade_ModifyAction.co" method="post">
				<input type="hidden" name="GRADE_NUM"
					value=<%=gbean.getGRADE_NUM()%>>
				<hr />
				등급 이름 : <br />
				<div class="input">
					<input type="text" name="GRADE_VAL" value="<%=gbean.getGRADE_VAL()%>" />
				</div>
				마일리지 적립률 : <Br />
				<div class="input">
					<input type="text" name="GRADE_ACM" value="<%=gbean.getGRADE_ACM()%>" />
				</div>
			</form>

			<div class="submit_Button" onclick="javascript:modForm.submit()" style="cursor: pointer">완료</div>
			<div class="submit_Button" onclick="javascript:history.go(-1)"
				style="cursor: pointer">취소</div>
		</div>
		<div class="bottomPadding"></div>
	</div>
</body>
</html>