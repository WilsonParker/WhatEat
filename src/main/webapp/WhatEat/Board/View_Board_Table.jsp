<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Utils.*" %>
<%
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	int nowpage=(int)session.getAttribute("page");
	int maxpage=((Integer)request.getAttribute("maxpage")).intValue();
	int startpage=((Integer)request.getAttribute("startpage")).intValue();
	int endpage=((Integer)request.getAttribute("endpage")).intValue();
	int bNum = Integer.parseInt(ReadXml.getKeys("bNum"));
%>
<table width=60% border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td align=right colspan="6">
	<form action="#" id=limitF>
	<select name=limit onchange="search(1)">
  		<option value="${sessionScope.limit }">표시할 게시글 수</option>
  		<option value="5">5</option>
  		<option value="10">10</option>
  		<option value="30">30</option>
  		<option value="50">50</option>
  		<option value="100">100</option>
	</select>
	</form>
	</td>
	</tr>
	<tr align="center" valign="middle">
		<td align="right" colspan="6"> <font size=2px>글 개수 : ${listcount}</font> </td>
	</tr>
	<tr><td align=right colspan="6"><font size=2px>총 페이지수 : ${maxpage}</font></td></tr>
	<tr align="center" valign="middle" bordercolor="#333333">
		<td style="font-family:Tahoma;font-size:8pt;" width="8%" height="26">
			<div align="center">번호</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="42%">
			<div align="center">제목</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="14%">
			<div align="center">작성자</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="15%">
			<div align="center">등록일</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="11%">
			<div align="center">조회수</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="20%">
			<div align="center">댓글수</div>
		</td> 
	</tr>
</table>

<input type="hidden" id="page" value="<%=nowpage%>"/>
<c:forEach items="${list}" var="bean">
	<tr align="center" valign="middle" bordercolor="#333333"
		onmouseover="this.style.backgroundColor='F8F8F8'"
		onmouseout="this.style.backgroundColor=''">
		<td height="23" style="font-family: Tahoma; font-size: 10pt;"
			width="7%">${bean.getBOARD_SEQUENCE()}</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="43%">☞ <a
			href="./Board_DetailAction.co?bnum=${bean.getBOARD_NUM()}">
				${bean.getBOARD_SUBJECT()} </span>
		</td>

		<td style="font-family: Tahoma; font-size: 10pt;" width="14%">
			<div align="center">${bean.getBOARD_WRITER() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="15%">
			<div align="center">${bean.getBOARD_DATE() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="11%">
			<div align="center">${bean.getBOARD_READCOUNT() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="20%">
			<div align="center">${bean.getBOARD_COMMENTTOTAL() }</div>
		</td>
	</tr>
</c:forEach>

<table width=60% border="0" cellpadding="0" cellspacing="0">
<tr align=center height=20>
		<td colspan=7 style=font-family:Tahoma;font-size:10pt;>
			<%if(startpage > bNum){ %> 
			<span onclick="search(1)">[1]..</span>&nbsp; 
			<%}%>
			<%if(nowpage>1 && startpage > bNum){ %> <span onclick="search(<%=startpage-bNum %>)">[◀]</span>&nbsp; 
			<%} else if(nowpage>1 && startpage <= bNum){ %> <span onclick="search(<%=startpage%>)">[◀]</span>&nbsp;
			<% } %>
			<%if(nowpage>1){ %> <span onclick="search(<%=nowpage-1%>)">[이전]</span>&nbsp; <%} %>
			<%for(int a=startpage;a<=endpage;a++){
				if(a==nowpage){%>
				<b>(<%=a %>)</b> 
				<%} else{ %> <span onclick="search(<%=a%>)">[<%=a %>]</span>&nbsp; <%} %> <%} %>
			<%if(nowpage<maxpage){ %> <span onclick="search(<%=nowpage+1%>)">[다음]</span> <%} %>
			<%if(nowpage<maxpage && (startpage+bNum) >= maxpage){ %> 
			<span onclick="search(<%=maxpage%>)">[▶]</span>&nbsp; 
			<%} else if(nowpage<maxpage && (startpage+bNum) < maxpage){ %> <span onclick="search(<%=startpage+bNum%>)">[▶]</span>&nbsp;
			<% } %>
			<% if(startpage <= maxpage-bNum){ %> <span onclick="search(<%=maxpage%>)">..[<%=maxpage%>]</span>&nbsp;
			<% } %>
		</td>
	</tr>
	<tr align="right">
	<c:choose>
	<c:when test="${sessionScope.user == null }">
		<td colspan="5">
	   		<p onclick="{alert('로그인이 필요한 서비스 입니다');javascript:location.href='<%=request.getContextPath()+ReadXml.getKeys("View_MemberPath")%>Login.jsp'}">[글쓰기]</p>
		</td>
	</c:when>
	<c:when test="${!sessionScope.user.getINFO_ADDBOARD_RG().equals('TRUE')}">
		<td colspan="5">
	   		<p onclick="alt()">[글쓰기]</p>
		</td>
	</c:when>
	<c:otherwise>
		<td colspan="5">
	   		<a href="<%=request.getContextPath()+ReadXml.getKeys("View_ServicePath")+ReadXml.getKeys("View_BoardPath2")%>Write.jsp">[글쓰기]</a>
		</td>
	</c:otherwise>
	</c:choose>
	</tr>
</table>
