<%@page import="WhatEat.Utils.ReadXml"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>홧잇?</title>
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <link href="<%=request.getContextPath()%>/WhatEat/css/MyPage.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div id="wrapMP">
        <div id="Header"><!-- PC Header Start-->
            <div class="containHeader">
               	<c:choose>
                	<c:when test="${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys('position_member'))}">
                		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_MemberPath2")%>Detail.jsp'" style="cursor:pointer">
                    		<p>내 정보 보기</p>
		                </div>		
                		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")%>/WhatEat/Home/checking.jsp'" style="cursor:pointer">
                	 	   <p>마일리지</p>
                		</div>
                		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Star_ListAction.co'" style="cursor:pointer">
                	 	   <p>즐겨찾기</p>
                		</div>
                	</c:when>
                	<c:when test="${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys('position_admin'))}">
                		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Admin_DetailAction.co'" style="cursor:pointer">
                    		<p>내 정보 보기</p>
		                </div>	
        		        <div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Seller_Store_ListAction.co'" style="cursor:pointer">
                	 	   <p>매장 관리</p>
                		</div>
                		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")%>/WhatEat/Home/checking.jsp'" style="cursor:pointer">
                	 	   <p>마일리지</p>
                		</div>
						<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Admin_ListAction.co'" style="cursor:pointer">
                	 	   <p>회원 관리</p>
                		</div>                	
						<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Admin_Grade_ListAction.co?cond=adList'" style="cursor:pointer">
                	 	   <p>등급 관리</p>
                		</div>             
						<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Food_Category_ListAction.co?cond=adList'" style="cursor:pointer">
                	 	   <p>카테고리</p>
                		</div>             
                		<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Star_ListAction.co'" style="cursor:pointer">
                	 	   <p>즐겨찾기</p>
                		</div>   	
                	</c:when>
                	<c:when test="${sessionScope.user.getINFO_POSITION().equals(ReadXml.getKeys('position_seller'))}">
               		 	<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_SellerPath2")%>Detail.jsp'" style="cursor:pointer">
                    		<p>내 정보 보기</p>
		                </div>	
						<div class="menu" onclick="javascript:location.href='<%=request.getContextPath()%>/Seller_Store_ListAction.co'" style="cursor:pointer">
                	 	   <p>매장 관리</p>
                		</div>                	
                	</c:when>
                </c:choose>
            </div>
        </div><!-- PC Header End-->
    </div><!--wrap-->
    <div>
        <c:choose>
			<c:when test="${param.View2 != null}">
				<jsp:include page="${param.View2}" />
			</c:when>
		</c:choose> 
    </div>
</body>
</html>