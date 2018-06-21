<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*" %>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>회원가입(일반회원)</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
    <script>
   /*  $(function(){
    	function setter (path,data){ document.getElementById(path).innerHTML = data;}
    	var err = "<b style='color:red'>필수 입력 칸 입니다</b>";
    	function checker(va) {
    		if(va.val == "" || va.trim() == "") { setter(va,err);return false }
        	return true;}
        	
    		$(".submit_Button").on("click",function(){
    			var i = $("input [name == "INFO_EMAIL"]");
    			console.log(i);
    			if(i.val == "" || i.trim() == ""){
    				setter(i,err);
    			}
    				
    	});
    });  */
    function join(){
		$.ajax({
			url:"./Member_AddAction.co",
			type:"POST",
			dataType: "json",
			data:$("#joinform").serialize(),
			success(data){
				if(data){
					alert("회원가입이 되었습니다");
					location.href="<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp";
				}else{
					alert("회원가입이 되지 않았습니다");
				}
			}
		});
	}
    </script>
</head>

<body>
    <div id="wrapJ">
        <div class="topPadding"></div>
        <div id="contain">

            <h2>회원가입(일반회원)</h2>

            <hr />
            <h5 class="title">이메일</h5> <!--###이메일 title###-->
            <form action="#" method="post" id="joinform">
            <input type="hidden" name="INFO_POSITION" value="<%=ReadXml.getKeys("position_seller")%>"/>
			<input type="hidden" name=INFO_PERMIT value="${param.INFO_PERMIT}" />
			<input type="hidden" name=INFO_JOINDATE value="2000-01-01" />
                <div class="input"><input type="text" name="INFO_EMAIL" placeholder="sidongblog@naver.com"/></div><!--이메일 input-->
                <div class="tr">
                    <div class="td_Button">중복확인</div><div class="tdR_Button">수신동의</div> <!--중복확인/수신동의 Button-->
                </div>
 
                <h5 class="title">이름</h5> <!--###이름 title###-->
                <div class="input"><input type="text" name=INFO_NAME /></div><!--이름 input-->
				
                <h5 class="title">아이디</h5> <!--###아이디 title###-->
                <div class="input"><input type="text" maxlength=20 name="INFO_ID" /></div><!--아이디 input-->
				
                <h5 class="title">비밀번호</h5> <!--###비밀번호1 title###-->
                <div class="input"><input type="password" maxlength=30 name="INFO_PASSWORD" placeholder="4~20자로 입력해주세요."/></div><!--비밀번호1 input-->

                <h5 class="title">비밀번호 확인</h5> <!--###비밀번호2 title###-->
                <div class="input"><input type="password" maxlength=30 name="INFO_PASSWORD2" placeholder="비밀번호를 재입력 해주세요."/></div><!--비밀번호2 input-->
                
                <h5 class="title">휴대폰</h5> <!--###휴대폰 title###-->
                	<input type="text" maxlength=3 name="INFO_PHONENUM1" style="border:1px solid #cccccc; width:30px;"/> - 
          			<input type="text" maxlength=4 name="INFO_PHONENUM2" style="border:1px solid #cccccc; width:40px;"/> - 
          			<input type="text" maxlength=4 name="INFO_PHONENUM3" style="border:1px solid #cccccc; width:40px;"/>
                <!--휴대폰 input-->
 
                <h5 class="title">생년월일 </h5> <!--###생년월일 title###-->
           		 <div class="input"><input type="text"maxlength=6 name="INFO_BIRTH" placeholder="생년월일을 입력해 주세요 ex)901225" /></div>
                
                <!--###완료 title###-->
                <div class="submit_Button" onclick="join()" style="cursor:pointer">완료</div>
            </form> 
        </div>
        <div class="bottomPadding"></div>
    </div>
</body>
</html>