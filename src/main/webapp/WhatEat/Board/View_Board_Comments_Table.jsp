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
<style>
	#tr1 td{border:1px solid black;}
	
	.review_det>span {margin:0 35px; font-size:0.8em; margin-bottom:8px; font-family:Dotum;font-size:11px;}
	.review_det>b {font-family:Dotum; margin-right:10px;font-size:11px;} 
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
				"comments_page" : page
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
				"tag_id" : id
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
		<table width=40% border="0" cellpadding="0" cellspabIng="0">
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
				<%
			for(int c=0;c<comments_list.size();c++){
				COMMENTS_Bean cbean = (COMMENTS_Bean) comments_list.get(c);
				cI = user != null?user.getINFO_INDEX() == cbean.getCOMMENTS_INDEX():false;
				cP = user != null?user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")):false;
			%>
			<tr id=tr1>
				<td colspan="4" class="ftd">
				<div class="review_det" style="width: 98%; min-height: 50px; ">
				<%=cbean.getCOMMENTS_CONTENT().replace("\n","<br/>")%><br/>
				<b><%=cbean.getCOMMENTS_WRITER()%></b>&#32;
				<span><%=cbean.getCOMMENTS_DATE()%></span>&#32;
				<span>댓글 수 : <%=cbean.getCOMMENTS_SUBTOTAL()%></span>&#32;
				<span onclick="javascript:location.href='./Board_DetailAction.co?View5=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Write.jsp?kind=2&subnum=<%=cbean.getCOMMENTS_NUM()%>'"><font style="color:blue;cursor:pointer">댓글 쓰기</font></span>
				<%if(cbean.getCOMMENTS_SUBTOTAL() > 0){ %>
				<span onclick="getSubComments('subcomments<%=cbean.getCOMMENTS_NUM()%>',<%=cbean.getCOMMENTS_NUM()%>)"><font style="color:blue;cursor:pointer">댓글 보기</font></span>
				<%} %>
				</div></td>
			</tr>
			<tr>
			<%	
			if(user != null) {
				if((cI && user.getINFO_MODCOMMENT_RG().equals("TRUE")) || cP){ %>
				<td align="right" colspan="3"><p style="cursor:pointer" onclick="javascript:location.href='./Board_DetailAction.co?View5=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Modify.jsp?cnum=<%=cbean.getCOMMENTS_NUM()%>'">수정</p></td>
			<%}else if(cI && (!user.getINFO_MODCOMMENT_RG().equals("TRUE"))){ %>
				<td align="right" colspan="3"><p onclick="alt()" style="cursor:pointer">수정</p></td>
			<%} if((cI && user.getINFO_DELCOMMENT_RG().equals("TRUE")) || cP){ %>
				<td align="right" colspan=""><p style="cursor:pointer" onclick="{if(confirm('삭제 하시겠습니까?')) location.href='./Board_Comments_DeleteAction.co?cnum=<%=cbean.getCOMMENTS_NUM()%>&cindex=<%=cbean.getCOMMENTS_INDEX()%>&kind=1'}">삭제</p></td>
			<%}else if(cI && (!user.getINFO_DELCOMMENT_RG().equals("TRUE"))){ %>
				<td align="right" colspan=""><p onclick="alt()" style="cursor:pointer">삭제</p></td>
			</tr>
			<%}}%>
			<tr> <td> <div id="subcomments<%=cbean.getCOMMENTS_NUM()%>"></div> </td> </tr>
			<%}%>
	</table>
	</c:otherwise>	
	</c:choose>
	<input type="hidden" id="comments_page" value="${comments_page}" />
	<c:if test="${comments_page < comments_listcount }">
		<div style="text-align: center;cursor:pointer" onclick="search()">더 보기</div>
	</c:if>
