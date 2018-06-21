<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Store.*"%>
<%@ page import="WhatEat.Food.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="java.util.*"%>
<%@ page import="WhatEat.Data_source.*"%>
<%
	STORE_Bean bean = (STORE_Bean) request.getAttribute("bean");
	List list = (List) session.getAttribute("clist");
%>

<html>
<head>
<meta charset="UTF-8">
<title>매장 정보</title>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<link href="<%=request.getContextPath()%>/WhatEat/css/detail.css" rel="stylesheet" type="text/css" />
<script>
	$(function(){
		$("#MapV").css("height",1);
		ViewMap();
		mk();
		getComments();
		if(${param.View6 != null})
			show_review();
		
	});
	function mk(){
		$.ajax({
			type : "POST",
			url : "./Food_ListAction.co",
			data : {
				"index": <%=bean.getSTORE_NUM()%>
			},
			success : function(data) {
				$("#menus").html(""+data+"");
			}
		});
	} 
	function addStar(){
		$.ajax({
			url:"./Star_AddAction.co",
			type:"POST",
			dataType: "json",
			data:{
				"snum":<%=bean.getSTORE_NUM()%>,
				"STAR_INDEX":$("#INDEX").val(),
				"STAR_STORE_NUM":$("#NUM").val()
			},
			success(data){
				switch(data){
				case 0:
					alert("Star add err");
					break;
				case 1:
					alert("즐겨찾기에 추가 되었습니다");
					break;
				case 2:
					alert("이미 즐겨찾기에 추가 되어있습니다");
					break;
				case 3:
					alert("즐겨찾기에 추가되지 않았습니다");
					break;
				case 4:
					alert("로그인이 필요한 서비스 입니다");
					location.href="<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp";
					break;
				}
			}
		});
	}
	function show_owner(){
		$(".owner_wrap").attr("style","display:block");
		$(".menu_wrap").attr("style","display:none");
		$(".review_wrap").attr("style","display:none");
		$(".road_wrap").attr("style","display:none");
		$("#MapV").attr("style","display:none");
	}
	function show_menu(){
		$(".menu_wrap").attr("style","display:block");
		$(".owner_wrap").attr("style","display:none");
		$(".review_wrap").attr("style","display:none");
		$(".road_wrap").attr("style","display:none");
		$("#MapV").attr("style","display:none");
	}
	function show_review(){
		$(".review_wrap").attr("style","display:block");
		$(".menu_wrap").attr("style","display:none");
		$(".owner_wrap").attr("style","display:none");
		$(".road_wrap").attr("style","display:none");
		$("#MapV").attr("style","display:none");
	}
	function show_road(){
		$(".road_wrap").attr("style","display:block");
		$(".menu_wrap").attr("style","display:none");
		$(".owner_wrap").attr("style","display:none");
		$(".review_wrap").attr("style","display:none");
		$("#MapV").attr("style","display:block;height:400px;");
	}
	function getComments() {
		$.ajax({
			type : "POST",
			url : "./Board_Comments_ListAction.co",
			data: {
				"ComNum" : ${sessionScope.snum},
				"ComKind" : "store"
			},
			success : function(data) {
				$(".comments").html(data);
			}
		});
	}
	function sort() {
		$.ajax({
			type : "POST",
			url : "./Board_Comments_ListAction.co",
			data : {
				"comments_sort" : $("#comments_sortF select").val(),
				"comments_seq" : $("#comments_seqF select").val(),
				"comments_page" : $("#comments_page").val(),
				"ComKind" : "store"
			},
			success : function(data) {
				$(".comments").html(data);
			}
		});
	}
	function ViewMap(){
		$.ajax({
			url:"./WhatEat/Store/View_Store_Location.jsp",
			data:{
				"path":"<%=bean.getSTORE_LOCATION1()%>+<%=bean.getSTORE_LOCATION2()%>+<%=bean.getSTORE_LOCATION3()%>+<%=bean.getSTORE_LOCATION4()%>",
				"name":"<%=bean.getSTORE_NAME()%>",
				"tel":"<%=bean.getSTORE_PHONE()%>",
			},
			success(data){
				$("#MapV").html(data);
			}
		});
	}
</script>
</head>
<body>

<input type="hidden" id="INDEX" value="${sessionScope.user.getINFO_INDEX() }"/>
<input type="hidden" id="NUM" value="<%=bean.getSTORE_NUM()%>"/>
<div id="wrap_det">
	<div id="body_det">
		<div id="adress_det">
			<%=bean.getSTORE_LOCATION3() %> > 
			<span> <%for(int c=0;c<list.size();c++){
				CATEGORY_Bean cbean = (CATEGORY_Bean) list.get(c);
				if(cbean.getCATEGORY_INDEX() == bean.getSTORE_KIND()){%>
			<%=cbean.getCATEGORY_NAME() %>
				<%}}%>
				</span>
			> <%=bean.getSTORE_NAME()%>
		</div>

		<div id="box1_wrap_det">
			<div class="title_det">
				<b><%=bean.getSTORE_NAME() %></b> 
			</div>

			<div class="star_det">
			<c:if test="${bean.getSTORE_REVIEWER() > 0}">
					<p class="star_list">평점 :  ${Double.parseDouble(Math.round((bean.getSTORE_SCORE()/bean.getSTORE_REVIEWER()*100))*0.01)}</p>
					</c:if>
					<c:if test="${bean.getSTORE_REVIEWER() <= 0}">
					<p class="star_list">평점 : 0 </p>
					</c:if>
			</div>
			<div class="review_count_det">
				<b><%=bean.getSTORE_REVIEWER() %> 명 참여</b>
			</div>
			<div class="banner_det">
			<%=bean.getSTORE_PACKDELIVERY() %> 
			</div>
		</div>

		<div id="box2_wrap_det">
			<div class="nav_det">
			<div class="owner_wrap" style="display:block">
				<ul>
					<li style="border-right:1px solid #c5beb2;" onclick="show_owner()" ><b>사장님 한마디</b></li>
					<li style="background:#ddd7c7; border-right:1px solid #c5beb2; border-bottom:1px solid #c5beb2" onclick="show_menu()"><b>메뉴</b></li>
					<li style="background:#ddd7c7; border-bottom:1px solid #c5beb2" onclick="show_review()"><b>리뷰</b></li>
					<li style="background:#ddd7c7; border-bottom:1px solid #c5beb2" onclick="show_road()"><b>오시는 길</b></li>
				</ul>
				
				<div class="owner_comment_det">
					<div class="comment_det">
						<p><b>[사장님 한마디]</b></p>
						<p>
						<%if(bean.getSTORE_CONTENT().contains("\n")){ %>
							<%=bean.getSTORE_CONTENT().replace("\n","<br/>") %>
						<%} else{%>
							<%=bean.getSTORE_CONTENT().replace("\n","<br/>") %>
						<%} %>
						</p>
					</div>
					<%if(bean.getSTORE_FILE() != null) {%>
						<img src="<%=request.getContextPath()+"/"+bean.getSTORE_PATH()+bean.getSTORE_FILE()%>" style="height:550px; width:500px;margin:10 auto;"/>
					<%} %>
				</div>
			</div>
			
			<div class="menu_wrap" style="display:none">
				<ul>
					<li style="background:#ddd7c7; border:1px solid #c5beb2; border-left:0px" onclick="show_owner()"><b>사장님 한마디</b></li>
					<li style="border-top:1px solid #c5beb2;" onclick="show_menu()"><b>메뉴</b></li>
					<li style="background:#ddd7c7; border:1px solid #c5beb2; border-right:0px" onclick="show_review()"><b>리뷰</b></li>
					<li style="background:#ddd7c7; border-bottom:1px solid #c5beb2" onclick="show_road()"><b>오시는 길</b></li>
				</ul>
				
				<div id="menus" style="margin:0 20px;">
				</div>
				</div>
				
				<div class="review_wrap" style="display:none">
				<ul>
					<li style="background:#ddd7c7; border:1px solid #c5beb2; border-left:0px" onclick="show_owner()"><b>사장님 한마디</b></li>
					<li style="background:#ddd7c7; border:1px solid #c5beb2; border-left:0px" onclick="show_menu()"><b>메뉴</b></li>
					<li style="border-top:1px solid #c5beb2;" onclick="show_review()"><b>리뷰</b></li>
					<li style="background:#ddd7c7; border-bottom:1px solid #c5beb2" onclick="show_road()"><b>오시는 길</b></li>
				</ul>
				
				<div class="review_box_det">
						<div class="comments"> </div>
						<br/>
						<div style="text-align:center">
						<p style="cursor:pointer;" onclick="javascript:location.href = './Store_DetailAction.co?View6=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Write.jsp?kind=3&storenum=<%=bean.getSTORE_NUM()%>&isScore=true'"> [댓글 쓰기] </p>
						</div>
						<jsp:include page="${param.View6}"/>
					</div>
				</div>
				
				<div class="road_wrap" style="display:none">
				<ul>
					<li style="background:#ddd7c7; border:1px solid #c5beb2; border-left:0px" onclick="show_owner()"><b>사장님 한마디</b></li>
					<li style="background:#ddd7c7; border:1px solid #c5beb2; border-left:0px" onclick="show_menu()"><b>메뉴</b></li>
					<li style="background:#ddd7c7; border-bottom:1px solid #c5beb2" onclick="show_review()"><b>리뷰</b></li>
					<li style="border-top:1px solid #c5beb2;" onclick="show_road()"><b>오시는 길</b></li>
				</ul>
				
				<div class="road_comment_det">
				<div class="comment_det">
						<p><b>[찾아 오시는 길]</b></p>
						<p><%=bean.getSTORE_LOCATION1()+" "+bean.getSTORE_LOCATION2()+" "+bean.getSTORE_LOCATION3()+" "+bean.getSTORE_LOCATION4() %></p>
				</div>
				</div>
				</div>
					<div id="MapV"> </div>
				
				</div>
			</div>

				<div class="wrap_sidebar_det">
					<div class="info_box_det">
						<div class="title_sidebar_det">
							<b>업소상세정보</b>
						</div>

						<div class="detail_sidebar_det">
							<div class="tr_det">
								<div class="td_det" style="width:30%">주인장</div>
								<div class="td_det" style="width:70%"><%=bean.getSTORE_SUBSCRIBER()%></div>
							</div>
							<div class="tr_det">
								<div class="td_det" style="width:30%">전화번호</div>
								<div class="td_det" style="color:#ff0000; width:70%"><%=bean.getSTORE_PHONE() %></div>
							</div>
							<div class="tr_det" style="width:100%;">
								<div class="td_det" style="width:30%">영업시간</div>
								<div class="td_det" style="width:70%"><%=bean.getSTORE_OPENTIME() %> ~ <%=bean.getSTORE_CLOSETIME() %></div>
							</div>
							<div class="tr_det">
								<div class="td_det" style="width:30%">주소</div>
								<div class="td_det" style="width:70%"><%=bean.getSTORE_LOCATION1() %> <%=bean.getSTORE_LOCATION2() %> <%=bean.getSTORE_LOCATION3() %> <%=bean.getSTORE_LOCATION4() %> </div>
							</div>
						</div>
					</div><!--info_box_det-->

					<div class="bookmark_det" style="cursor:pointer" onclick="addStar()">
						<b>즐겨찾기 추가</b>
					</div><!--bookmark_det--><br/>
					<div class="bookmark_det" style="cursor:pointer" onclick="javascript:location.href='./Store_ListAction.co'">
						<b>목록으로</b>
					</div><br/>
					<div class="bookmark_det" style="cursor:pointer" onclick="javascript:history.go(-1)">
						<b>뒤로</b>
					</div><br/>
				</div><!--wrap_sidebar_det-->
		</div>
	</div>
</body>
</html>