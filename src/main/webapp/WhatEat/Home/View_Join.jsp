<%@page import="WhatEat.Utils.ReadXml"%>
<%@page language="java" contentType="text/html" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>회원 가입 유형 선택</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <style>
        @import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

        #wrapMJ {width:100%;}

        #wrapMJ #body {width:100%; background:#fafafa;}
        #wrapMJ .contain1 {max-width:960px; padding:60px 0;}
        #wrapMJ .box {background:#ffffff; width:500px; height:160px; border:1px solid #cccccc; position:relative;}
        #wrapMJ .logo {text-align:center; padding:20px 0;}

        #wrapMJ .input div {text-align:center; border:1px solid #cccccc; width:250px; height:30px; margin-bottom:7px;}
        #wrapMJ .input .btn { width:250px; height:30px; padding-top:6px; font-size:0.8em; background:#3f3f3f; color:#ffffff;}
    </style>
</head>

<body>
    <div id="wrapMJ">
        <div id="body">
            <div class="contain1">

                <div class="box">
                    <div class="logo">
                        <b>가입 유형 선택</b>
                    </div>

                    <div class="input">
                        <div class="btn" style="cursor:pointer" onclick="javascript:location.href='<%= request.getContextPath().concat(ReadXml.getKeys("View_MemberPath")) %>Join.jsp'">일반인 회원가입</div>
                        <div class="btn" style="cursor:pointer" onclick="javascript:location.href='<%= request.getContextPath().concat(ReadXml.getKeys("View_SellerPath")) %>Permit.jsp'">판매자 회원가입</div>
                    </div>

                </div><!--box-->
            </div><!--contain1-->
        </div><!--body-->
    </div><!--wrap-->
</body>
</html>