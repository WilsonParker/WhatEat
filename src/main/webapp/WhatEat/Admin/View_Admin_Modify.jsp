<%@page import="WhatEat.Utils.*"%>
<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@page import="WhatEat.Data_source.*" %>
<%@page import="WhatEat.Seller.*" %>
<%
USER user = (USER) Main_DAO.getDAO().DetailCommand(new SELLER_Bean(),Integer.parseInt(request.getParameter("aindex")));
USER isAdmin = (USER)session.getAttribute("user");
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
<meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" />
<link href="<%=request.getContextPath()%>/WhatEat/css/DetailForm.css" rel="stylesheet" type="text/css" />
<script>
document.onload = mk(1),mk(2);
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
function mk(val){
	var id = "";
	var path = "";
	switch(val){
	case 1:
		id = "plist";
		path="/Admin_Position_ListAction.co";
		break;
	case 2:
		id = "glist";
		path="/Admin_Grade_ListAction.co";
		break;
	}
		$.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>"+path,
			success : function(data) {
				$("#"+id+"").html(data);
			}
		});
	}
</script>
</head>
<body>
	<div id="wrapDF">
    <div class="topPadding"></div>
    <div id="contain">
        <h2>정보 수정</h2>
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
                <td><input type="text" name="INFO_PASSWORD" maxlength=30 value="<%=user.getINFO_PASSWORD() %>"/></td>
            </tr>
            <tr valign="middle" bordercolor="#333333">
                <td>
                    <h5 class="title">이름</h5>
                </td>
                <td><input type="text" name="INFO_NAME" maxlength=30 value="<%=user.getINFO_NAME() %>"/></td>
            </tr>
            <tr valign="middle" bordercolor="#333333">
                <td>
                    <h5 class="title">생년월일</h5>
                </td>
                <td><input type="text" name="INFO_NAME" maxlength=30 value="<%=user.getINFO_BIRTH() %>"/></td>
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
                    <h5 class="title">포지션</h5>
                </td>
                <td><div id="plist"></div></td>
            </tr>
            
            <tr valign="middle" bordercolor="#333333">
                <td>
                    <h5 class="title">등급</h5>
                </td>
                <td><div id="glist"></div></td>
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
                <td><input type="text" name="INFO_PERMIT" maxlength=30 value="<%=user.getINFO_PASSWORD() %>"/></td>
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
					<td style="width:10%"><input type=checkbox name="INFO_ADDBOARD_RG" value="<%=user.getINFO_ADDBOARD_RG()%>"  /></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODBOARD_RG" value="<%=user.getINFO_MODBOARD_RG()%>"  /></td>
					<td style="width:10%"><input type=checkbox name="INFO_DELBOARD_RG" value="<%=user.getINFO_DELBOARD_RG()%>"  /></td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">가게</td>
					<td style="width:10%"><input type=checkbox name="INFO_ADDSTORE_RG" value="<%=user.getINFO_ADDSTORE_RG()%>"  /></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODSTORE_RG" value="<%=user.getINFO_MODSTORE_RG()%>"  /></td>
					<td style="width:10%"><input type=checkbox name="INFO_DELSTORE_RG" value="<%=user.getINFO_DELSTORE_RG()%>"  /></td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">댓글</td>
					<td style="width:10%"><input type=checkbox name="INFO_ADDCOMMENT_RG" value="<%=user.getINFO_ADDCOMMENT_RG()%>"  /></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODCOMMENT_RG" value="<%=user.getINFO_MODCOMMENT_RG()%>"  /></td>
					<td style="width:10%"><input type=checkbox name="INFO_DELCOMMENT_RG" value="<%=user.getINFO_DELCOMMENT_RG()%>"  /></td>
				</tr>
				<tr valign="baseline" align="left" bordercolor="#333333">
					<td style="width:10%">회원정보</td>
					<td style="width:10%"></td>
					<td style="width:10%"><input type=checkbox name="INFO_MODINFO_RG" value="<%=user.getINFO_MODINFO_RG()%>"  /></td>
					<td style="width:10%"></td>
				</tr>
			</table>
        </form>
        <div class="buttonForm">
        <% if (isAdmin.getINFO_MODINFO_RG().equals("TRUE") && isAdmin.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) { %>
            <div class="button" onclick="javascript:modifyForm.submit()">수정 완료</div>
        <%}else{ %>
            <div class="button" onclick="alt()">수정 완료</div>
        <%} %>
            <div class="button" onclick="javascript:history.go(-1)">뒤로 가기</div>
        </div>
    </div>
    <div class="bottomPadding"></div>
</div>
</body>
</html>