<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>

<select name="INFO_POSITION" id="sc">
	<c:forEach items="${sessionScope.plist}" var="bean">
		<option value="${bean.getINFO_POSITION_CODE()}">${bean.getINFO_POSITION_NAME()}</option>
	</c:forEach>
</select>