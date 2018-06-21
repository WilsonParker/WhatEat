<%@page import="WhatEat.Utils.*"%>
<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@page import="WhatEat.Data_source.*" %>
<%
	USER user = (USER) session.getAttribute("user");
		String phone[] = {"0","0","0"};
	if(user.getINFO_PHONENUM() != null){
		String p[] = user.getINFO_PHONENUM().split("-");
		for(int c=0;c<phone.length;c++){
		phone[c] = p[c];		
		}
	}
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내 정보 수정하기</title>
<!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
<link href="<%=request.getContextPath()%>/WhatEat/css/DetailForm.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="wrapDF">
    <div class="topPadding"></div>
    <div id="contain">
        <h2>내 정보 수정</h2>
        <hr/>
        <form action="<%=request.getContextPath()%>/Member_ModifyAction.co" method="post" name="modifyForm">
        	<input type="hidden" name="INFO_INDEX" value="<%=user.getINFO_INDEX() %>"/>
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
                <td><input type="text" name="INFO_PASSWORD" maxlength=30 /></td>
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
                <td>
                <input type="text" maxlength=3 name="INFO_PHONENUM1" style="width:30px;" value="<%=phone[0]%>"/>-
                <input type="text" maxlength=4 name="INFO_PHONENUM2" style="width:40px;" value="<%=phone[1]%>"/>-
                <input type="text" maxlength=4 name="INFO_PHONENUM3" style="width:40px;" value="<%=phone[2]%>"/>
                </td>
            </tr>
            <tr valign="middle" bordercolor="#333333">
                <td>
                    <h5 class="title">기부금</h5>
                </td>
                <td><%=user.getINFO_DONATION() %></td>
            </tr>
        </table>
        </form>
        <div class="buttonForm">
        <% if (user.getINFO_MODINFO_RG().equals("TRUE")) { %>
            <div class="button" onclick="javascript:modifyForm.submit()">수정 완료</div>
        <%} else{%>
            <div class="button" onclick="alt()">수정 완료</div>
        <%} %>
            <div class="button" onclick="javascript:history.go(-1)">뒤로 가기</div>
        </div>
    </div>
    <div class="bottomPadding"></div>
</div>
</body>
</html>