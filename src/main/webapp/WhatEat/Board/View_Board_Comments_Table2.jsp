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
	#tr1 td{border:1px solid black;}
	
	.sub_det {background:#f4f2ee; padding:20px; border:1px solid #dfddda;}
	.sub_det>span {margin:0 35px; font-size:0.8em; margin-bottom:8px; font-family:Dotum;font-size:11px;margin:0 5px;top-paddin:5px;}
	.sub_det>b {font-family:Dotum; margin-right:10px;font-size:11px;} 
	
</style>
<script>
	function search2() {
		var page = $("#comments_page2").val() + <%=ReadXml.getKeys("limit2")%> ;
		$.ajax({
			type : "POST",
			url : "./Board_SubComments_ListAction.co",
			data : {
				"comments_page2" : page
			},
			success : function(data) {
				$("#${tag_id}").html(data);
			}
		});
}
</script>
<input type="hidden" id="comments_page2" value="${comments_page2}" />
	<table width=60% border="0" cellpadding="0" cellspabIng="0">
				<%
			for(int c=0;c<comments_list2.size();c++){
				COMMENTS_Bean cbean2 = (COMMENTS_Bean) comments_list2.get(c);
				cI = user != null?user.getINFO_INDEX() == cbean2.getCOMMENTS_INDEX():false;
				cP = user != null?user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")):false;
			%>
			<tr id=tr1>
				<td colspan="4" class="ftd">
				<div class="sub_det" style="width: 98%; min-height: 50px; ">
				<%=cbean2.getCOMMENTS_CONTENT().replace("\n","<br/>")%><br/>
				<b><%=cbean2.getCOMMENTS_WRITER()%></b>&#32;
				<span><%=cbean2.getCOMMENTS_DATE()%></span>&#32;
				</div></td>
			</tr>
			<tr>
			<%	
			if(user != null) {
				if((cI && user.getINFO_MODCOMMENT_RG().equals("TRUE")) || cP){ %>
				<td align="right" colspan="3"><p style="cursor:pointer" onclick="javascript:location.href='./Board_DetailAction.co?View5=<%=ReadXml.getKeys("View_BoardPath2")%>Comments_Modify.jsp?cnum=<%=cbean2.getCOMMENTS_NUM()%>'">수정</p></td>
			<%}else if(cI && (!user.getINFO_MODCOMMENT_RG().equals("TRUE"))){ %>
				<td align="right" colspan="3"><p onclick="alt()" style="cursor:pointer">수정</p></td>
			<%} if((cI && user.getINFO_DELCOMMENT_RG().equals("TRUE")) || cP){ %>
				<td align="right" colspan=""><p style="cursor:pointer" onclick="{if(confirm('삭제 하시겠습니까?')) location.href='./Board_Comments_DeleteAction.co?cnum=<%=cbean2.getCOMMENTS_NUM()%>&cindex=<%=cbean2.getCOMMENTS_INDEX()%>&kind=2'}">삭제</p></td>
			<%}else if(cI && (!user.getINFO_DELCOMMENT_RG().equals("TRUE"))){ %>
				<td align="right" colspan=""><p onclick="alt()" style="cursor:pointer">삭제</p></td>
			</tr>
			<%}}}%>
	</table>
	<c:if test="${comments_page2 < comments_listcount2 }">
		<div style="text-align:center;cursor:pointer;font-size:11px;" onclick="search2()">더 보기</div>
	</c:if>
