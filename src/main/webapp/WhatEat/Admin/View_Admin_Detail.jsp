<%@page import="WhatEat.Utils.*"%>
<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="WhatEat.Data_source.*"%>
<%@ page import="WhatEat.Admin.*"%>
<%@ page import="java.util.*"%>

<%
	USER user = (USER)request.getAttribute("user");
	HashMap map = (HashMap) session.getAttribute("pmap");
	HashMap map2 = (HashMap) session.getAttribute("gmap");
	USER isAdmin = (USER)session.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 정보 보기</title>
<!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
<link href="<%=request.getContextPath()%>/WhatEat/css/DetailForm.css"
	rel="stylesheet" type="text/css" />
<script>
$(function () {
    var ch = $("#tb2").children();
    var ch2;
    var ch3;
    var ch4;
    var ch5;
    for (var c = 0; c < ch.length; c++) {
        ch2 = ch[c].children;
        for (var c2 = 0; c2 < ch2.length; c2++) {
            if (ch2[c].tagName == "TR") {
                ch3 = ch2[c2].children;
                for (var c3 = 0; c3 < ch3.length; c3++) {
                    ch4 = ch3[c3].children;
                    for (var c4 = 0; c4 < ch4.length; c4++) {
                        ch5 = ch4[c4];
                        if(ch5.name.match("INFO")){
                            if(ch5.value === "TRUE"){
                                ch5.setAttribute("checked",true);
                            }
                        }
                    }
                }
            }
        }
    }
})
$(document).ready(function(){
	if(!${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))}){
		alt();
	}
})
</script>
</head>
<body>
	<div id="wrapDF">
		<div class="topPadding"></div>
		<div id="contain">
			<h2>내 정보 보기</h2>
			<hr />
			<table id="tb" width=60% border="1" cellpadding="0" cellspacing="0">
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">아이디</h5>
					</td>
					<td><%=user.getINFO_ID() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">비밀번호</h5>
					</td>
					<td><%=user.getINFO_PASSWORD() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">이름</h5>
					</td>
					<td><%=user.getINFO_NAME() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">생년월일</h5>
					</td>
					<td><%=user.getINFO_BIRTH() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">연락처</h5>
					</td>
					<td><%=user.getINFO_PHONENUM() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">포지션</h5>
					</td>
					<td>
					<%= map.get(user.getINFO_POSITION())%>
					</td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">등급</h5>
					</td>
					<td>
					<%= map2.get(user.getINFO_GRADE())%>
					</td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">기부금</h5>
					</td>
					<td><%=user.getINFO_DONATION() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">사업자 번호</h5>
					</td>
					<td><%=user.getINFO_PERMIT() %></td>
				</tr>
				<tr valign="middle" bordercolor="#333333">
					<td>
						<h5 class="title">가입일</h5>
					</td>
					<td><%=user.getINFO_JOINDATE() %></td>
				</tr>
				</table>
				<table id="tb2" width=60% border="1" cellpadding="0" cellspacing="0">
				<tr valign="baseline" align="left" bordercolor="#333333">
					<h5 style="text-align:center" class="title">권한</h5>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%"></td>
					<td style="width:10%">쓰기</td>
					<td style="width:10%">수정</td>
					<td style="width:10%">삭제</td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">게시판</td>
					<td style="width:10%"><input type=checkbox name="INFO_ADDBOARD_RG" value="${user.getINFO_ADDBOARD_RG()}" disabled /></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODBOARD_RG" value="${user.getINFO_MODBOARD_RG()}" disabled /></td>
					<td style="width:10%"><input type=checkbox name="INFO_DELBOARD_RG" value="${user.getINFO_DELBOARD_RG()}" disabled /></td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">가게</td>
					<td style="width:10%"><input type=checkbox name="INFO_ADDSTORE_RG" value="${user.getINFO_ADDSTORE_RG()}" disabled /></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODSTORE_RG" value="${user.getINFO_MODSTORE_RG()}" disabled /></td>
					<td style="width:10%"><input type=checkbox name="INFO_DELSTORE_RG" value="${user.getINFO_DELSTORE_RG()}" disabled /></td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">댓글</td>
					<td style="width:10%"><input type=checkbox name="INFO_ADDCOMMENT_RG" value="${user.getINFO_ADDCOMMENT_RG()}" disabled /></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODCOMMENT_RG" value="${user.getINFO_MODCOMMENT_RG()}" disabled /></td>
					<td style="width:10%"><input type=checkbox name="INFO_DELCOMMENT_RG" value="${user.getINFO_DELCOMMENT_RG()}" disabled /></td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">회원정보</td>
					<td style="width:10%"></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODINFO_RG" value="${user.getINFO_MODINFO_RG()}" disabled /></td>
					<td style="width:10%"></td>
				</tr>
			</table>
			<div class="buttonForm">
				<%
					if (isAdmin != null && isAdmin.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
						if (isAdmin.getINFO_MODINFO_RG().equals("TRUE")) {
				%>
				<div class="button" onclick="location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_AdminPath2")%>Modify.jsp?aindex=<%=user.getINFO_INDEX()%>'">회원정보 수정</div>
				<% }else{%>
				<div class="button" onclick="alt()">회원정보 수정</div>
				<%} %>
				<div class="button" onclick="javascript:{if(confirm('정말 탈퇴 하시겠습니까?'))location.href='./Member_DeleteAction.co?dnum=<%=user.getINFO_INDEX()%>'}">회원 탈퇴</div>
				<% }%>
				<a href="./Admin_ListAction.co">목록으로</a>
			</div>
		</div>
		<div class="bottomPadding"></div>
	</div>
</body>
</html>