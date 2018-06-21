<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Food.*"%>
<%@ page import="java.util.*"%>
<%@ page import="WhatEat.Utils.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function delCategory(data){
	$.ajax({
		type : "POST",
		url : "./Admin_Category_DeleteAction.co",
		dataType: "json",
		data : {
			"dcategory" : data,
		},
		success : function(data) {
			if(data){
				alert("성공적으로 삭제 하였습니다");
			}else{
				alert("삭제하는데 문제가 발생 하였습니다");
			}
			location.href="./Food_Category_ListAction.co?cond=adList";
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
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/WhatEat/css/Basic.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="body">
		<div id="contain3">
			<c:forEach items="${sessionScope.clist}" var="bean">
				<div class="td25_1">
					<div class="box" style="cursor: pointer" onclick="">
						<div class="section"
							style="background: url(<%=request.getContextPath()%>/${bean.getCATEGORY_PATH().concat(bean.getCATEGORY_FILE())}) no-repeat right">
							<b style="background-color: #808080; float: right; z-index: 10" onclick="if(confirm('카테고리를 삭제 하시겠습니까?'))delCategory(${bean.getCATEGORY_INDEX()})">&nbsp;삭제&nbsp;</b>
							<b style="background-color: #808080; float: right; z-index: 10" onclick="javascript:location.href='<%=request.getContextPath() + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_AdminPath2")%>Category.jsp?Viewc=/WhatEat/Admin/View_Admin_Category_Modify.jsp?cnum=${bean.getCATEGORY_INDEX()}'">&nbsp;수정&nbsp;</b>
							${bean.getCATEGORY_NAME()}<br /> ${bean.getCATEGORY_INDEX()}<br />
							${bean.getCATEGORY_PATH()}<br /> ${bean.getCATEGORY_FILE()}<br />
							<br />
						</div>
					</div>
				</div>
			</c:forEach>
			<br />
		</div>
	</div>
	<p class="" style="cursor: pointer; text-align: center;" onclick="javascript:location.href='<%=request.getContextPath() + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_AdminPath2")%>Category.jsp?Viewc=/WhatEat/Admin/View_Admin_Category_Add.jsp'">카테고리 추가</p>
	<jsp:include page="${param.Viewc}" />
</body>
</html>