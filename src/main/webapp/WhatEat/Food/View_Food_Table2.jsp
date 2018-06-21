<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>

<select name="STORE_KIND" id="sc">
	<c:forEach items="${sessionScope.clist}" var="bean">
		<option value="${bean.getCATEGORY_INDEX()}">${bean.getCATEGORY_NAME()}</option>
	</c:forEach>
</select>