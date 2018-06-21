<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>비밀번호 찾기</title>
<!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
<link href="<%=request.getContextPath()%>/WhatEat/css/SearchForm.css"
	rel="stylesheet" type="text/css" />
<script>
    function Search(){
		$.ajax({
			url:"./Member_Search_SetAction.co",
			type:"POST",
			dataType: "json",
			data:
				$("#joinform").serialize(),
			success(data){
				if(data)
					alert("비밀번호를 0000 으로 바꿔드렸습니다.\n로그인 후 비밀번호를 변경해주세요");
				else
					alert("해당 정보에 맞는 결과를 찾을 수 없습니다.");
				}
			})
		};
    </script>
</head>

<body>
	<div id="wrapJ">
		<div class="topPadding"></div>
		<div id="contain">

			<h2>비밀번호 찾기</h2>

			<hr />

			<form action="#" method="post" id="joinform">
			<input type="hidden" name="dat" value="<%=ReadXml.getKeys("User_Condition3")%>"/>
				<div class="input">
					<h5 class="title">아이디</h5> &nbsp;:&nbsp; <input type="text" name="INFO_ID" maxlength=12;/>
				</div>
				
				<div class="input">
				<h5 class="title">생년월일</h5> &nbsp;:&nbsp; <input type="text" name="INFO_BIRTH" maxlength=6; />
				</div>
				
				<div class="input">
				<h5 class="title">이름</h5> &nbsp;:&nbsp; <input type="text" name="INFO_NAME" maxlength=15; />
				</div>
				
				<div class="submit_Button" onclick="Search()" style="cursor: pointer">찾기</div>
				<div class="submit_Button" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp'" style="cursor: pointer">로그인</div>
			</form>
		</div>
		<div class="bottomPadding"></div>
	</div>
</body>
</html>