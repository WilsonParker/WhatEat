<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="java.util.List"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Data_source.*"%>
<%
	USER user = (USER) session.getAttribute("user") != null ? (USER) session.getAttribute("user") : null;
	int kind = Integer.parseInt(request.getParameter("kind"));
	String det = "";
	if(kind == 1 || kind == 3)
		det = "댓글 쓰기";
	else if(kind == 2)
		det = "서브 댓글 쓰기";
	String s = request.getParameter("isScore") != null?request.getParameter("isScore"):"false";
	boolean isScore = s.equals("true")?true:false;
%>
<form action="./Board_Comments_AddAction.co" method="post" name="comments_form">
		<table style="vertical-align:middle;align:center;width:40%;border:1px solid black">
			<%
				if (user == null) {
			%>
    	    <tr>
        	    <td class="ftd">로그인이 필요한 서비스 입니다</td>
           		 <td><p style="background-color:#282522;color:white;text-align:center" onclick="{alert('로그인이 필요한 서비스 입니다');javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp'}"> 등록<br>하기</p></td>
        	</tr>
			<%
				} else if (user.getINFO_ADDCOMMENT_RG().equals("TRUE")) {
			%>
     	   <tr>
        	    <%if(isScore) {%>
           		 <td>평점
           		 	<select name="COMMENTS_SCORE">
           		 	<option>1</option>
           		 	<option>2</option>
           		 	<option>3</option>
           		 	<option>4</option>
           		 	<option>5</option>
           		 	</select>
           		 </td>
        	    <%} %>
        	    <td class="ftd"><textarea placeholder="<%=det %>" name="COMMENTS_CONTENT" id="cmct" style="width:99%;min-height:40px;resize:none"></textarea></td>
           		 <td><p style="background-color:#282522;color:white;text-align:center;cursor:pointer;" onclick="{javascript:comments_form.submit();$('#cmct').val('');return;}">등록<br>하기 </p></td>
        	</tr>
			<%
				}else{
			%>
			<tr>
        	    <%if(isScore) {%>
        	    <td>평점
           		 	<select name="COMMENTS_SCORE">
           		 	<option>1</option>
           		 	<option>2</option>
           		 	<option>3</option>
           		 	<option>4</option>
           		 	<option>5</option>
           		 	</select>
           		 </td>
        	    <%} %>
        	    <td class="ftd"><textarea placeholder="<%=det %>" style="width:98%;min-height:50px;resize:none"></textarea></td>
           		 <td><p style="background-color:#282522;color:white;text-align:center" onclick="alt()">등록<br>하기 </p></td>
        	</tr>
			<%} %>
    	</table>
			<%if(user != null) {%>
			<input type="hidden" name="COMMENTS_INDEX" value="<%=user.getINFO_INDEX()%>"/>
			<input type="hidden" name="COMMENTS_WRITER" value="<%=user.getINFO_NAME()%>"/>
			<input type="hidden" name="kind" value="${param.kind}"/>
			<%} %>
			<c:choose>
			<c:when test="${param.kind == 1 }">
			<input type="hidden" name="COMMENTS_KIND_BOARD" value="${param.boardnum}"/>
			</c:when>
			<c:when test="${param.kind == 2 }">
			<input type="hidden" name="COMMENTS_SUBNUM" value="${param.subnum}"/>
			</c:when>
			<c:when test="${param.kind == 3 }">
			<input type="hidden" name="COMMENTS_KIND_STORE" value="${param.storenum}"/>
			</c:when>
			</c:choose>
</form>