<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Utils.*"%>
<script>
	function search() {
		var i = ${sessionScope.spage};
		var page = Number(i) + <%=ReadXml.getKeys("limit2")%> ;	
		$.ajax({
			type : "POST",
			url : "./Seller_Store_ListAction.co",
			data : {
				"mk" : "true",
				"sort" : $("#sortF select").val(),
				"seq" : $("#seqF select").val(),
				"spage" : page
			},
			success : function(data) {
				$("#lists").html(data);
			}
		});
	}
</script>
<input type="hidden" id="page" value="${sessionScope.page }" />
<div id="wrap_list">
	<div id="body_list">
		<div id="box_wrap_list">
			<c:forEach items="${list}" var="bean">
				<div class="box_list"
					onclick="javascript:location.href = './Store_DetailAction.co?snum=${bean.getSTORE_NUM()}'"
					style="cursor: pointer">
					<div class="photo_list">
						<img src="<%=request.getContextPath()%>/${bean.getSTORE_PATH().concat(bean.getSTORE_PROFILE())}" style="height: 100px; width: 100px;">
						<p class="banner_list">${bean.getSTORE_PACKDELIVERY()}</p>
					</div>
					<p class="subject_list">
						<b>${bean.getSTORE_NAME()} </b>
					</p>
					<c:if test="${bean.getSTORE_REVIEWER() > 0}">
					<p class="star_list">평점 : ${Double.parseDouble(Math.round((bean.getSTORE_SCORE()/bean.getSTORE_REVIEWER()*100))*0.01)}</p>
					</c:if>
					<c:if test="${bean.getSTORE_REVIEWER() <= 0}">
					<p class="star_list">평점 : 0</p>
					</c:if>
					<p class="review_list">리뷰 수 : ${bean.getSTORE_REVIEWER()}</p>
					<p class="review_list">누적방문 수 : ${bean.getSTORE_READCOUNT() }</p>
					<p class="review_list">업로드 날짜 : <br/> ${bean.getSTORE_DATE() }</p>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<c:if test="${sessionScope.spage < listcount }">
	<div style="text-align: center;cursor: pointer;" onclick="search()">더 보기</div>
</c:if>