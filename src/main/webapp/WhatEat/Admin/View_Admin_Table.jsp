<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="WhatEat.Utils.*" %>
<%
	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	int nowpage=(int)session.getAttribute("apage");
	int maxpage=((Integer)request.getAttribute("maxpage")).intValue();
	int startpage=((Integer)request.getAttribute("startpage")).intValue();
	int endpage=((Integer)request.getAttribute("endpage")).intValue();
	int bNum = Integer.parseInt(ReadXml.getKeys("bNum"));
%>
<table width=60% border="0" cellpadding="0" cellspacing="0">
	<tr align="center" valign="middle">
		<td align="right" colspan="6"> <font size=2px>글 개수 : ${listcount}</font> </td>
	</tr>
	<tr><td align=right colspan="6"><font size=2px>총 페이지수 : ${maxpage}</font></td></tr>
	<tr align="center" valign="middle" bordercolor="#333333">
		<td style="font-family:Tahoma;font-size:8pt;" width="8%" height="26">
			<div align="center">INDEX</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="14%">
			<div align="center">ID</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="14%">
			<div align="center">NAME</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="14%">
			<div align="center">MILEAGE</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="14%">
			<div align="center">DONATION</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="15%">
			<div align="center">JOIN_DATE</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="11%">
			<div align="center">POSITION</div>
		</td>
		<td style="font-family:Tahoma;font-size:8pt;" width="12%">
			<div align="center">GRADE</div>
		</td> 
	</tr>
</table>
<input type="hidden" id="page" value="<%=nowpage%>"/>
<c:forEach items="${list}" var="user">
	<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.backgroundColor='F8F8F8'" onmouseout="this.style.backgroundColor=''">
		<td height="23" style="font-family: Tahoma; font-size: 10pt;"
			width="7%">${user.getINFO_INDEX()}</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="8%">☞ <a href="./Admin_DetailAction.co?anum=${user.getINFO_INDEX()}"> ${user.getINFO_ID()} </span> </td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="14%">
			<div align="center">${user.getINFO_NAME() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="14%">
			<div align="center">${user.getINFO_MILEAGE() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="14%">
			<div align="center">${user.getINFO_DONATION() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="15%">
			<div align="center">${user.getINFO_JOINDATE() }</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="20%">
			<div align="center">
			${sessionScope.pmap.get(user.getINFO_POSITION())}
			</div>
		</td>
		<td style="font-family: Tahoma; font-size: 10pt;" width="20%">
			<div align="center">
			${sessionScope.gmap.get(user.getINFO_GRADE())}
			</div>
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
</table>
