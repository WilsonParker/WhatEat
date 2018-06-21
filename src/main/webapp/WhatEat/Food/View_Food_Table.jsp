<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*" %>
<%@page import="WhatEat.Food.*" %>

<style>
	#mn b {display:block; width:100%; background-color:#948f88; margin:auto}
	#mn p {color:#C98500;border:0.5em solid #EAEAEA;}
</style>
<script>
$(function(){
	hide("#mn");
	$("#mn div").on("click",function(){
             var id = $(this).attr("id");
             var v = $(this).attr("val");
             //console.log(id +" @@ "+v)
             if (v == "none") {
                 show("#"+id);
             } else {
                 hide("#"+id);
             }
         });
	});
	
function hide(data) {
     $("" + data + " p").css("display", "none");
     $("" + data + "").attr("val", "none");
}
function show(data) {
     $("" + data + " p").css("display", "block");
     $("" + data + "").attr("val", "block");
}
</script>
<div id="mn">
<c:forEach items="${flist}" var="bean">
	<div id="menu${bean.getMENU_NUM()}">
	<b style="cursor:pointer">${bean.getMENU_NAME()}</b>
	<c:forEach items="${bean.outFOOD()}" var="bean2">
		<p id="food${bean2.getFOOD_NUM()}">${bean2.getFOOD_NAME()} : ${bean2.getFOOD_PRICE() } 원</p>
	</c:forEach>
	</div>
	<br/>		
</c:forEach>
</div>