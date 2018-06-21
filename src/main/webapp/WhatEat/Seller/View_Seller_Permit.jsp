<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*" %>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>사업자 번호 인증</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
    <script>
    
    </script>
</head>

<body>
    <div id="wrapJ">
        <div class="topPadding"></div>
        <div id="contain">

            <h2>사업자 번호 인증</h2>
            <hr />

            <form action="<%=request.getContextPath()+ReadXml.getKeys("View_SellerPath") %>Join.jsp" method="post" id="joinform">
                <h5 class="title">사업자 번호</h5> 
                <div class="input"><input type="text" name="INFO_PERMIT"/></div>
                <div class="submit_Button" onclick="javascript:joinform.submit()" style="cursor:pointer">완료</div>
            </form> 
        </div>
        <div class="bottomPadding"></div>
    </div>
</body>
</html>