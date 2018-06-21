<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Food.*"%>
<%@ page import="java.util.*"%>
<%@ page import="WhatEat.Utils.*"%>
<%
	int climit = Integer.parseInt(ReadXml.getKeys("limit2"));
	String path = request.getContextPath();
%>
<link href="<%=request.getContextPath()%>/WhatEat/css/Basic.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/WhatEat/css/MyPage.css"
	rel="stylesheet" type="text/css" />
	<c:choose>
		<c:when test="${param.View4 == null}">
			<div id="body">
				<div id="contain3">
		<c:forEach items="${sessionScope.clist}" var="bean">
					<div class="td25_1">
						<div class="box" style="cursor:pointer" onclick="javascript:location.href='<%=path%>/Store_ListAction.co?cls=${bean.getCATEGORY_INDEX()}&spage=<%=ReadXml.getKeys("limit2")%>'"> 
 							<div class="section" style="background: url(<%=request.getContextPath()%>/${bean.getCATEGORY_PATH().concat(bean.getCATEGORY_FILE())}) no-repeat right"> ${bean.getCATEGORY_NAME()}<br />View All
							</div>
						</div>
					</div>
			</c:forEach>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div id="wrapMP">
				<div id="Header">
					<!-- PC Header Start-->
					<div class="containHeader">
					<c:forEach items="${sessionScope.clist}" var="bean2">
						<div class="menu" style="cursor:pointer"
							onclick="javascript:location.href='<%=path%>/Store_ListAction.co?cls=${bean2.getCATEGORY_INDEX()}&spage=<%=climit %>'"
							style="cursor: pointer">
							<p>${bean2.getCATEGORY_NAME() }</p>
						</div>
					</c:forEach>	
					</div>
				</div>
				<!-- PC Header End-->
			</div>
			<!--wrap-->
			<jsp:include page="${param.View4}" />
		</c:otherwise>
	</c:choose>
