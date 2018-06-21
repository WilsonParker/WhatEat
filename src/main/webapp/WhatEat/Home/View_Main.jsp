<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="WhatEat.Utils.ReadXml"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Data_source.*" %>
<%
	USER user = session.getAttribute("user")!= null?(USER) session.getAttribute("user"):null;
	String position = "";
	if(user != null)
		position = user.getINFO_POSITION();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>홧잇?</title>
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- <meta name="viewport" content="width=device-width, intial-scale=1 user-scalable=no" /> -->
    <link href="<%=request.getContextPath()%>/WhatEat/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/WhatEat/css/MainPage.css" rel="stylesheet" type="text/css" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>
    $(function(){
    	mkCategory();mklists();setLocationVal();  
             var ch = $(".search").children();
             for(var c=0;c<ch.length;c++){
            	 if(ch[c].tagName == "INPUT")
                 ch[c].addEventListener("keydown",wkey);
             }
    })
    function mkCategory(){
    	if(${param.View == null}){
			if(${sessionScope.clist != null} && true){
		    	location.href="<%=request.getContextPath()+ReadXml.getKeys("View_MainPath")%>Category.jsp";
			}else{
				location.href="<%=request.getContextPath()%>/WhatEat/Food_Category_ListAction.co";
			}    		
    	}
    }
    function mklists(){
    	if(${sessionScope.plist == null} && true)
    		$.ajax({ url:"<%=request.getContextPath()%>/WhatEat/Admin_Position_ListAction.co" });
    	if(${sessionScope.glist == null} && true)
    		$.ajax({ url:"<%=request.getContextPath()%>/WhatEat/Admin_Grade_ListAction.co" });
    }
    function setLocation(){
    		$.ajax({
    			url:"<%=request.getContextPath()%>/WhatEat/Store_LocationAction.co",
    			type:"POST",
    			dataType:"json",
    			data:{
    				"LOCATION1":$("input[name='LOCATION1']").val(),
    				"LOCATION2":$("input[name='LOCATION2']").val(),
    				"LOCATION3":$("input[name='LOCATION3']").val()
    			},
    			success(data){
    				if(data){
    					alert("주소가 저장 되었습니다");
    				}
    				else
    					alert("주소가 저장에 문제가 발생했습니다");
    			}
    			});
    }
    function setLocationVal(){
    	var L1 = "${sessionScope.LOCATION1}";
    	var L2 = "${sessionScope.LOCATION2}";
    	var L3 = "${sessionScope.LOCATION3}";
    	if(!(L1.trim() == "")){
    		$("input[name='LOCATION1']").attr("value",L1);
    	}
    	if(!(L2.trim() == "")){
    		$("input[name='LOCATION2']").attr("value",L2);
    	}
    	if(!(L3.trim() == "")){
    		$("input[name='LOCATION3']").attr("value",L3);
    	}
    }
    function alt(){ alert('권한이 제한 되었습니다');location.href= "<%=request.getContextPath()%>/WhatEat/Home/View_Main.jsp"; }
    function wkey(event){
        if(event.which == 13)
        	setLocation();
    }
    
     function Glogin(position){
		$.ajax({
			url:"<%=request.getContextPath()%>/WhatEat/Admin_LoginHelper.co",
			type:"POST",
			dataType: "json",
			data:{"Gposition":position},
			success(data){
				alert(data);
				location.href = "<%=request.getContextPath()%>/WhatEat/Home/View_Main.jsp";
			}
			});
	} 
    </script>
</head>
<body>
    <div id="wrap">  
        <div id="Header"><!-- PC Header Start-->
            <div class="containHeader">
                <div class="leftHeader"><b><a href="<%=request.getContextPath().concat("/WhatEat/Home/View_Main.jsp") %>">홧잇?</a></b></div>
               			<div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()%>/Board_ListAction.co?kind=5&page=1'" style="cursor:pointer">
                    		<p>커뮤니티</p>
		                </div>		
		                <div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_ServicePath")+ReadXml.getKeys("View_ServicePath2")%>Introduce.html'" style="cursor:pointer">
                    		<p>고객센터</p>
		                </div>		
                	<%if(user == null){ %>
                		<div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MainPath")%>Join.jsp'" style="cursor:pointer">
                    		<p>회원가입</p>
		                </div>
        		        <div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp'" style="cursor:pointer">
                	 	   <p>로그인</p>
                		</div>
                	<%} else{%>
                		<%if(position.equals(ReadXml.getKeys("position_member"))){%>
               		 	<div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_MemberPath2")%>Detail.jsp'" style="cursor:pointer">
                    		<p>마이 페이지</p>
		                </div>
                		<%}else if(position.equals(ReadXml.getKeys("position_admin"))){ %>
                		<div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()%>/Admin_DetailAction.co'" style="cursor:pointer">
                    		<p>마이 페이지</p>
		                </div>
                		<%}else if(position.equals(ReadXml.getKeys("position_seller"))){ %>
                		<div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_SellerPath2")%>Detail.jsp'" style="cursor:pointer">
                    		<p>마이 페이지</p>
		                </div>
                		<%} %>
                		<div class="rightHeader" onclick="javascript:location.href='<%=request.getContextPath()%>/Member_LogoutAction.co'" style="cursor:pointer">
                		    <p>로그아웃</p>
                		</div>
                		<div class="rightHeader2" >
                		안녕하세요 ${sessionScope.user.getINFO_NAME()} 님
                		</div>
                	<%}%>
            </div>
        </div><!-- PC Header End-->
        
        <div id="gps_barPC" style="background:url('<%=request.getContextPath()%>/WhatEat/images/main_gps.jpg') no-repeat center">
            <div class="containPC2">
                <h1>"어디서 먹을래?"</h1>
                <p><b>찾고 싶은 위치를 입력해 주세요 (개별검색 가능)</b></p>
                <div class="search">
                <input type="text" maxlength="6" style="width:100px;" name="LOCATION1" placeholder="광주광역시" />
                <input type="text" maxlength="6" style="width:60px;" name="LOCATION2" placeholder="북구" />
                <input type="text" maxlength="6" style="width:80px;" name="LOCATION3" placeholder="일곡동/로" />
                </div>
                <div class="bt"><h5 style="cursor:pointer" onclick="setLocation()">적용</h5></div>
            </div>
    	<%if(user == null){ %>
            <div class="containPC2_Login">
             	<div onclick="Glogin('member')">일반회원 로그인</div>
            	<div onclick="Glogin('seller')">판매자 로그인</div>
            	<div onclick="Glogin('admin')">관리자 로그인</div>
            </div>
                	<%} %>
        </div><!--gps_barPC--><!-- PC에서만 나옴-->

        <div id="gps_bar">
            <div id="contain1">
                <div class="tdL"><p>내위치 : 광주 북구 일곡동</p></div>
                <div class="tdR" style="background-color:#282522"><p>위치설정</p></div>
            </div>
        </div><!--gps_bar--><!--모바일에서만 나옴-->
        <div id="hearder">
            <div id="contain2">
                <div id="logo">
                    <b>홧잇?</b>
                </div>

                <div id="logo_bar">
                    <div class="menu_bt tdL">
                        메뉴
                    </div>
                    <div class="menu_bt tdR">
                        로그인
                    </div>
                </div>
            </div>
        </div><!--hearder--><!--모바일에서만 나옴-->
	</div><!--wrap-->
		<jsp:include page="${param.View}" />
	  <div id="wrap">
        <div id="footer"><!-- PC Footer Start-->
            <div id="containFooter">
                <div class="trFooter">
                    <div>
                        <b>홧잇?</b><br /><br />
                    </div>
                    <div style="color:#666666">
                        <h4>고객센터 010-1234-5678</h4><br />
                    </div>
                    <div style="font-size:0.8em; color:#999999; line-height:18px;">
                        광주 북구 용봉동 국제 직업 전문 학교 3층<br />
                        사업자등록번호 : 123-45-12345<br />
                        통신판매업신고 : 제 2016-광주-123456호<br />
                        개인정보담당자 : xogus0790@naver.com<br />
                        제휴문의 : xogus0790@naver.com <br />
                        공동대표 : 박윤기,노시원,박지수,정태현
                    </div>
                </div>
            </div>
        </div><!-- PC Footer End-->

    </div><!--wrap-->
</body>
</html>