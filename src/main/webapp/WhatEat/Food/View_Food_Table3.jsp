<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="WhatEat.Food.*" %>

<c:forEach items="${flist}" var="bean">
		메뉴<ul id="menu${bean.getMENU_NUM()}">${bean.getMENU_NAME()}
	<c:forEach items="${bean.outFOOD()}" var="bean2">
		<li id="food${bean2.getFOOD_NUM()}"> ★ ${bean2.getFOOD_NAME()} : ${bean2.getFOOD_PRICE() } 원</li>
	</c:forEach>
		</ul>
	<br>		
</c:forEach>
