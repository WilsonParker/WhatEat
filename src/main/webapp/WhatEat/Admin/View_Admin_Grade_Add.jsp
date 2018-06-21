<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@page import="WhatEat.Utils.*" %>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>등급 추가</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
</head>

<body>
    <div id="wrapJ">
        <div class="topPadding"></div>
        <div id="contain">

            <h2>등급 추가</h2>

            <hr />
            <form action="./Admin_Grade_AddAction.co" method="post" id="joinform">
                등급 이름 : <br/>
            <div class="input"> <input type="text" name="GRADE_VAL"/></div>
                마일리지 적립률 : <Br/>
             <div class="input"><input type="text" name="GRADE_ACM"/></div>
				
                <div class="submit_Button" onclick="javascript:joinform.submit()" style="cursor:pointer">완료</div>
                <div class="submit_Button" onclick="javascript:history.go(-1)" style="cursor:pointer">뒤로</div>
            </form> 
        </div>
        <div class="bottomPadding"></div>
    </div>
</body>
</html>