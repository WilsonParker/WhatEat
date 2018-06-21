<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="java.util.List"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Data_source.*"%>
<%
	List comments_list = (List) request.getAttribute("comments_list");
	USER user = (USER) session.getAttribute("user") != null ? (USER) session.getAttribute("user") : null;
	boolean cI= false;
	boolean cP= false;
%>
<link href="<%=request.getContextPath()%>/WhatEat/css/detail.css" rel="stylesheet" type="text/css" />
<style>
	#tr1 td{border:1px solid black;}
	
	.customer_review_det span {margin:0 35px; font-size:11px; margin-bottom:8px; font-family:Dotum;font-size:11px;}
	.customer_review_det b {font-family:Dotum; margin-right:10px;font-size:11px;} 
</style>
<script>
	function search() {
		var page = $("#comments_page").val() + <%=ReadXml.getKeys("limit2")%> ;
		$.ajax({
			type : "POST",
			url : "./Board_Comments_ListAction.co",
			data : {
				"comments_sort" : $("#comments_sortF select").val(),
				"comments_seq" : $("#comments_seqF select").val(),
				"comments_page" : page,
				"ComKind" : "store"
			},
			success : function(data) {
				$(".comments").html(data);
			}
		});
	}
	function getSubComments(id,num) {
		$.ajax({
			type : "POST",
			url : "./Board_SubComments_ListAction.co",
			data: {
				"Sub_Num" : num,
				"tag_id" : id,
				"path" : "store"
			},
			success : function(data) {
				$("#"+id+"").html(data);
			}
		});
	}
</script>
	<c:choose>
		<c:when test="${comments_listcount <= 0}">
		<div style="text-align:center;border:1px solid blue;max-width:40%;">댓글이 없습니다<br>처음으로 댓글을 달아보세요!</div>
		</c:when>
		<c:otherwise>
		<table width=60% border="0" cellpadding="0" cellspabIng="0">
		<tr align="center" valign="middle">
			<td align="right" colspan=3><font size=1px>댓글 개수 : ${comments_listcount}</font></td>
		</tr>
		<tr>
			<td align=right colspan="3">
				<form action="#" id=comments_sortF>
					<select name=comments_sort onchange="sort()">
						<option value="COMMENTS_NUM">기본 순서 순</option>
						<option value="COMMENTS_SCORE">평점 순</option>
						<option value="COMMENTS_DATE">등록 날짜 순</option>
					</select>
				</form>
			</td>
			<td>
				<form action="#" id=comments_seqF>
					<select name=comments_seq onchange="sort()">
						<option value="desc">내림차순</option>
						<option value="asc">오름차순</option>
					</select>
				</form>
			</td>
			</tr>
			
			</table>
				<%
			for(int c=0;c<comments_list.size();c++){
				COMMENTS_Bean cbean = (COMMENTS_Bean) comments_list.get(c);
				cI = user != null?user.getINFO_INDEX() == cbean.getCOMMENTS_INDEX():false;
				cP = user != null?user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")):false;
			%>
			
			<div class="review_box_det">
					<div class="customer_review_det">
						<br/>
						<p><%=cbean.getCOMMENTS_CONTENT().replace("\n","<br/>")%></p>
						<p><b><%=cbean.getCOMMENTS_WRITER()%></b><%=cbean.getCOMMENTS_DATE()%></p>
						<p>평점 : <%=cbean.getCOMMENTS_SCORE()%></p>
						<p>댓글 수 : <%=cbean.getCOMMENTS_SUBTOTAL()%>&#32;
						<span onclick="javascript:location.href='./Store_DetailAction.co?View6=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Write.jsp?kind=2&subnum=<%=cbean.getCOMMENTS_NUM()%>'"><font style="color:blue;cursor:pointer">댓글 쓰기</font></span>
						<%if(cbean.getCOMMENTS_SUBTOTAL() > 0){ %>
						<span onclick="getSubComments('subcomments<%=cbean.getCOMMENTS_NUM()%>',<%=cbean.getCOMMENTS_NUM()%>)"><font style="color:blue;cursor:pointer">댓글 보기</font></span>
						<%} %>
			<%	if(user != null) {
				if((cI && user.getINFO_MODCOMMENT_RG().equals("TRUE")) || cP){ %>
			<span style="cursor:pointer" onclick="javascript:location.href='./Store_DetailAction.co?View6=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Modify.jsp?cnum=<%=cbean.getCOMMENTS_NUM()%>&path=store'">수정</span>
			<%}else if(cI && (!user.getINFO_MODCOMMENT_RG().equals("TRUE"))){ %>
				<span onclick="alt()" style="cursor:pointer">수정</span>
			<%} if((cI && user.getINFO_DELCOMMENT_RG().equals("TRUE")) || cP){ %>
				<span style="cursor:pointer" onclick="{if(confirm('삭제 하시겠습니까?')) location.href='./Board_Comments_DeleteAction.co?cnum=<%=cbean.getCOMMENTS_NUM()%>&cindex=<%=cbean.getCOMMENTS_INDEX()%>&kind=2&path=store'}">삭제</span>
			<%}else if(cI && (!user.getINFO_DELCOMMENT_RG().equals("TRUE"))){ %>
				<span onclick="alt()" style="cursor:pointer">삭제</span>
						</p>
						<br/>
			<%}}%>
						<div id="subcomments<%=cbean.getCOMMENTS_NUM()%>"></div>
			<%}%>
					</div>
				</div>
			
	</c:otherwise>	
	</c:choose>
	<input type="hidden" id="comments_page" value="${comments_page}" />
	<c:if test="${comments_page < comments_listcount }">
		<div style="text-align: center;cursor:pointer" onclick="search()">더 보기</div>
	</c:if>
