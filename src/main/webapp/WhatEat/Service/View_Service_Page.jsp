<%@page import="WhatEat.Utils.ReadXml"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
    <title>Ah~ 민족 - 마이 페이지</title>
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <style>
    	#wrapMP {width:100%;}
		#wrapMP #Header {display:none;}

            /* Desktop Device */
/*             @media all and (min-width:1025px) { */
            @media all and (min-width:512px) {
		#wrapMP     #hearder {display:none;}

            /* PC Header Start*/
		#wrapMP     #Header {display:block; width:100%; background-color:#3f3f3f; height:80px;}
		#wrapMP     .containHeader {max-width:100%; margin-top:30px; padding:20px 20px; text-align:center;}
		#wrapMP     .menu {display:inline-block; width:100px; height:40px; border:1px solid #ffffff; line-height:40px; text-align:center; color:#ffffff; margin-right:10px;}
          /* PC Header End*/ }
    </style>
</head>
<body>
    <div id="wrapMP">
        <div id="Header"><!-- PC Header Start-->
            <div class="containHeader">
                <div class="menu" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_ServicePath")+ReadXml.getKeys("View_ServicePath2")%>Introduce.html'" style="cursor:pointer">
                	<p>서비스 소개</p>
		       	</div>		
        		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Board_ListAction.co?kind=1&page=1'" style="cursor:pointer">
                	<p>공지사항</p>
                </div>
        		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Board_ListAction.co?kind=2&page=1'" style="cursor:pointer">
                   <p>이벤트</p>
                </div>
        		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Board_ListAction.co?kind=3&page=1'" style="cursor:pointer">
                   <p>FAQ</p>
                </div>
        		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Board_ListAction.co?kind=4&page=1'" style="cursor:pointer">
                   <p>문의 게시판</p>
                </div>
            </div>
        </div><!-- PC Header End-->
    </div><!--wrap-->
        <c:choose>
			<c:when test="${param.View3 != null}">
				<jsp:include page="${param.View3}" />
			</c:when>
			
		</c:choose> 
</body>
</html>