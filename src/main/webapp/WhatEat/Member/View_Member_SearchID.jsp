<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>아이디 찾기</title>
<!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
<link href="<%=request.getContextPath()%>/WhatEat/css/SearchForm.css"
	rel="stylesheet" type="text/css" />
<script>
    function Search(){
		$.ajax({
			url:"./Member_SearchAction.co",
			type:"POST",
			dataType: "json",
			data:
				$("#joinform").serialize(),
			success(data){
				var txt = data;
				if(txt == "none")
					txt = "해당 정보에 맞는 결과가 없습니다";
				$("#result").text(txt);
				}
			})
		};
    </script>
</head>

<body>
	<div id="wrapJ">
		<div class="topPadding"></div>
		<div id="contain">

			<h2>아이디 찾기</h2>

			<hr />

			<form action="#" method="post" id="joinform">
			<input type="hidden" name="dat" value="<%=ReadXml.getKeys("User_Condition4")%>"/>
				
				<div class="input">
				<h5 class="title">이름</h5> &nbsp;:&nbsp; <input type="text" name="INFO_NAME" maxlength=15; />
				</div>
				
				<div class="input">
				<h5 class="title">생년월일</h5> &nbsp;:&nbsp; <input type="text" name="INFO_BIRTH" maxlength=6; />
				</div>
				
				<div class="input">
				<h5 class="title">이메일</h5> &nbsp;:&nbsp; <input type="text" name="INFO_EMAIL" maxlength=22; />
				</div>
				
				<div class="input">
				<h5 class="title">결과</h5> &nbsp;:&nbsp; <p id="result"></p>
				</div>
				<div class="submit_Button" onclick="Search()" style="cursor: pointer">찾기</div>
				<div class="submit_Button" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp'" style="cursor: pointer">로그인</div>
			</form>
		</div>
		<div class="bottomPadding"></div>
	</div>
</body>
</html>