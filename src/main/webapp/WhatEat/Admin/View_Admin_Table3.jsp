<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>

<select name="INFO_GRADE" id="sc">
	<c:forEach items="${sessionScope.glist}" var="bean">
		<option value="${bean.getGRADE_NUM()}" >${bean.getGRADE_VAL()}</option>
	</c:forEach>
</select>