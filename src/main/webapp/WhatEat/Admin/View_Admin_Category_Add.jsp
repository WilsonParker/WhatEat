<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*" %>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>카테고리 추가</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <link href="<%=request.getContextPath()%>/WhatEat/css/JoinForm.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <div id="wrapJ">
        <div class="topPadding"></div>
        <div id="contain">

            <h2>카테고리 추가</h2>

            <hr />
            <form action="./Admin_Category_AddAction.co" method="post" id="joinform" enctype="multipart/form-data" >
                <h5 class="title">NAME</h5>
                <input type="hidden" name="CATEGORY_PATH" value="<%=ReadXml.getKeys("upLoadPath3")%>"/>
                <div class="input"><input type="text" name="CATEGORY_NAME"/></div>
                <input type="FILE" name="CATEGORY_FILE"/>
				
                <div class="submit_Button" onclick="javascript:joinform.submit()" style="cursor:pointer">완료</div>
                <div class="submit_Button" onclick="javascript:history.go(-1)" style="cursor:pointer">뒤로</div>
            </form> 
        </div>
        <div class="bottomPadding"></div>
    </div>
</body>
</html>