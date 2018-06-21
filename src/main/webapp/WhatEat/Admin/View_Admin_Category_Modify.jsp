<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Data_source.*"%>
<%@ page import="WhatEat.Food.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%
	CATEGORY_Bean cbean = new CATEGORY_Bean();
	cbean = (CATEGORY_Bean) Main_DAO.getDAO().DetailCommand(cbean, Integer.parseInt(request.getParameter("cnum")));
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
			<h2>카테고리 수정</h2>
			<form name="modForm" action="./Admin_Category_ModifyAction.co" method="post" enctype="multipart/form-data">
				<input type="hidden" name="CATEGORY_PATH" value="<%=ReadXml.getKeys("upLoadPath3")%>"/>
				<input type="hidden" name="CATEGORY_INDEX" value="<%=cbean.getCATEGORY_INDEX()%>"/>
				<hr />
				카테고리 이름 : <br />
				<div class="input">
					<input type="text" name="CATEGORY_NAME" value="<%=cbean.getCATEGORY_NAME()%>" />
				</div>
				카테고리 이미지 : <Br />
				<div class="input">
					<input type="file" name="CATEGORY_FILE" value="<%=cbean.getCATEGORY_FILE()%>" />
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