<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Utils.*"%>
<%@ page import="java.util.List"%>
<%@ page import="WhatEat.Board.*"%>
<%@ page import="WhatEat.Data_source.*"%>
<%
	List comments_list2 = (List) request.getAttribute("comments_list2");
	USER user = (USER) session.getAttribute("user") != null ? (USER) session.getAttribute("user") : null;
	boolean cI= false;
	boolean cP= false;
%>
<style>
	.owner_review_det {margin-left:50px; background:#f4f2ee; padding:20px; border:1px solid #dfddda;}
	.owner_review_det span {font-family:Dotum; font-size:0.8em; margin-bottom:8px;}
	.owner_review_det p b {font-family:Dotum; margin-right:10px;}
	
</style>
<script>
	function search2() {
		var page = $("#comments_page2").val() + <%=ReadXml.getKeys("limit2")%> ;
		$.ajax({
			type : "POST",
			url : "./Board_SubComments_ListAction.co",
			data : {
				"comments_page2" : page,
				"path" : "store"
			},
			success : function(data) {
				$("#${tag_id}").html(data);
			}
		});
}
</script>
<input type="hidden" id="comments_page2" value="${comments_page2}" />
				<%
			for(int c=0;c<comments_list2.size();c++){
				COMMENTS_Bean cbean2 = (COMMENTS_Bean) comments_list2.get(c);
				cI = user != null?user.getINFO_INDEX() == cbean2.getCOMMENTS_INDEX():false;
				cP = user != null?user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")):false;
			%>
			<div class="owner_review_det">
				<%=cbean2.getCOMMENTS_CONTENT().replace("\n","<br/>")%><br/>
				<b><%=cbean2.getCOMMENTS_WRITER()%></b>&#32;
				<span><%=cbean2.getCOMMENTS_DATE()%></span>&#32;
			<%	
			if(user != null) {
				if((cI && user.getINFO_MODCOMMENT_RG().equals("TRUE")) || cP){ %>
				<span style="cursor:pointer" onclick="javascrispant:location.href='./Store_DetailAction.co?View6=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Modify.jsp?cnum=<%=cbean2.getCOMMENTS_NUM()%>&path=store'">수정</span>
			<%}else if(cI && (!user.getINFO_MODCOMMENT_RG().equals("TRUE"))){ %>
				<span onclick="alt()" style="cursor:pointer">수정</span>
			<%} if((cI && user.getINFO_DELCOMMENT_RG().equals("TRUE")) || cP){ %>
				<span style="cursor:pointer" onclick="{if(confirm('삭제 하시겠습니까?'))location.href='./Board_Comments_DeleteAction.co?cnum=<%=cbean2.getCOMMENTS_NUM()%>&cindex=<%=cbean2.getCOMMENTS_INDEX()%>&kind=2&path=store'}">삭제</span>
			<%}else if(cI && (!user.getINFO_DELCOMMENT_RG().equals("TRUE"))){ %>
				<span onclick="alt()" style="cursor:pointer">삭제</span>
			<%}}%>
			</div>
			<%}%>
	<c:if test="${comments_page2 < comments_listcount2 }">
		<div style="text-align:center;cursor:pointer;font-size:11px;" onclick="search2()">더 보기</div>
	</c:if>