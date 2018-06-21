<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Food.*"%>
<%@ page import="java.util.*"%>
<%@ page import="WhatEat.Utils.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>등급 목록</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
<%-- <link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" /> --%>
<style>
#wrapG {
	width: 100%;
	background-color: #fafafa;
	padding-bottom:25px;
}

#wrapG #blocks{
	width: 80%;
	margin:25px auto;
	overflow:hidden;
	
}

#wrapG .contain {
	width:200px;
	background-color: #ffffff;
	border: 1px solid #000000;
	padding: 30px;
	margin: 10px;
	float: left;
}

</style>
<script>
function delGrade(data){
	$.ajax({
		type : "POST",
		url : "./Admin_Grade_DeleteAction.co",
		dataType: "json",
		data : {
			"dGrade" : data
		},
		success : function(data) {
			if(data){
				alert("성공적으로 삭제 하였습니다");
			}else{
				alert("삭제하는데 문제가 발생 하였습니다");
			}
			location.href="./Admin_Grade_ListAction.co?cond=adList";
		}
	});
}
$(document).ready(function(){
	if(!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))}){
		alt();
		location.href= "./Home/View_Main.jsp";
	}
})
</script>
</head>
<body>
	<div id="wrapG">
	<div id="blocks">
			<c:forEach items="${sessionScope.glist}" var="bean">
				<div class="contain">
					${bean.getGRADE_NUM()} . 등급 이름
					<div class="input">
						<input type="text" value="${bean.getGRADE_VAL() }" readonly />
					</div>
					마일리지 적립률
					<div class="input">
						<input type="text" value="${bean.getGRADE_ACM() }" readonly />
					</div>
					<br /> <b
						style="background-color: #808080; float: right; z-index: 10; cursor: pointer;"
						onclick="if(confirm('등급을 삭제 하시겠습니까?'))delGrade(${bean.getGRADE_NUM()});">&nbsp;삭제&nbsp;</b>
					<b
						style="background-color: #808080; float: right; z-index: 10; cursor: pointer;"
						onclick="javascript:location.href='<%=request.getContextPath() + ReadXml.getKeys("View_MyPagePath")
						+ ReadXml.getKeys("View_AdminPath2")%>Grade_List.jsp?Viewc=/WhatEat/Admin/View_Admin_Grade_Modify.jsp?gnum=${bean.getGRADE_NUM() }'">&nbsp;수정&nbsp;</b>
					<br />
				</div>
			</c:forEach>
		<br/>
		</div>
	</div>

	<br />
	<p class="" style="cursor: pointer; text-align: center;" onclick="javascript:location.href='<%=request.getContextPath() + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_AdminPath2")%>Grade_List.jsp?Viewc=<%=ReadXml.getKeys("View_AdminPath2")%>Grade_Add.jsp'">
	[등급 추가]</p><br/>
	<jsp:include page="${param.Viewc}" />
</body>
</html>