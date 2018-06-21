<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="WhatEat.Utils.*" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>로그인</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <style>
        @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

        #wrapLF {width:100%;}

        #wrapLF #body {width:100%; background:#fafafa;}
        #wrapLF .containPC2 {max-width:960px; padding:60px 0;}
        #wrapLF .box {background:#ffffff; width:500px; height:200px; border:1px solid #cccccc; position:relative;}
        #wrapLF .logo {text-align:center; padding:20px 0;}
        #wrapLF .logo b a {color:#000000;}

        #wrapLF .input {padding-right:93px;}
        #wrapLF .input div {text-align:center; border:1px solid #cccccc; width:300px; height:40px; margin-bottom:7px;}
        #wrapLF .input div input {border:0; width:100%; line-height:30px; height:30px; padding:0 15px; margin-top:4px;}
        #wrapLF .login_bt {width:90px; height:88px; line-height:88px; background:#3f3f3f; text-align:center; color:#ffffff; position:absolute; left:50%; top:57px; margin-left:110px; }
        #wrapLF .findIDPW {font-size:0.8em; text-align:center; padding:5px 0;}
        #wrapLF .findIDPW a {color:#000000;}
    </style>
    <script>
    $(function(){
    	 var ch = $("#loginform").children();
         for(var c=0;c<ch.length;c++){
        	 if(ch[c].tagName == "INPUT")
             ch[c].addEventListener("keydown",wkey);
         }
    })
    	function login(){
    		$.ajax({
    			url:"<c:url value='/Member_LoginAction.co'/>",
    			type:"POST",
    			dataType: "json",
    			data:$("#loginform").serialize(),
    			success(data){
    				result(data);
    			}
    			});
    	}
    	function result(i){
    		switch (i) {
    		case 0:
    			alert("좋은 시간 되세요~");
    			location.href="<%=request.getContextPath()%>/WhatEat/Home/View_Main.jsp";
    			break;
    		case 1:
    			alert("일치하는 아이디가 없습니다");
    			break;
    		case 2:
    			alert("입력한 아이디와 비밀번호가 일치하지 않습니다");
    			break;
    		}
    	}
    	function wkey(event){
    		if(event.which == 13)
    			 login();
    	}
    </script>
</head>
<body>
    <div id="wrapLF">
        <div id="body">
            <div class="containPC2">

                <div class="box">
                    <div class="logo">
                        <b><a href="<%=request.getContextPath().concat("/Home/View_Main.jsp") %>">홧잇?</a></b>
                    </div>
			<c:choose>
			<c:when test="${sessionScope.name == null}">
                    <div class="input">
                        <form action="" method="post" id=loginform>
                            <div><input type="text" id="id" name="INFO_ID" onkeydown=wkey(event) /></div>
                            <div><input type="password" id="password" name="INFO_PASSWORD" onkeydown=wkey(event) /></div>
                        </form>
                    </div>
                    
                    <div class="login_bt" onclick="login()" style="cursor:pointer">로그인</div>
                    
                    <div class="findIDPW">
                        <a href="<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>SearchID.jsp">아이디 찾기</a> | <a href="<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>SearchPass.jsp">비밀번호 찾기</a>
                    </div>
			</c:when> 
			</c:choose>

                </div><!--box-->
            </div><!--containPC2-->

        </div><!--body-->

    </div><!--wrap-->
</body>
</html>