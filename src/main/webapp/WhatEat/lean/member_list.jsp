<%@page language="java" contentType="text/html" pageEncoding="euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%
	String id = null;

	if((session.getAttribute("id")==null)||(!((String)session.getAttribute("id")).equals("admin"))){
		response.sendRedirect("loginForm.jsp");
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/siwon");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement("select * from member");
		rs=pstmt.executeQuery();
		
	}catch(Exception e){
		e.printStackTrace();

	}
%>

<html>
<head>
<title>회원 관리 시스템 관리자모드(회원목록보기)</title>
<style>
	div {text-align:center; margin: 0 auto; box-sizing:border-box;}
	span {text-align:center; border:1px solid #000000;}

	.wrap {max-width:500px;}

	.title {margin:2px 0; border:1px solid #000000;}
	.tr {border:1px solid #000000; overflow:hidden; margin:2px 0;}
	.td {float:left; width:50%;}
	.td2 {float:left; width:50%; border-left:1px solid #000000;}
</style>
</head>
	<div class=wrap>
		<div class=title>
			회원목록
		</div>
		<% while(rs.next()){ %>
		<div class=tr>
			<div class=td>
				<a href="member_info.jsp?id=<%=rs.getString("id") %>">
					<%=rs.getString("id") %>
				</a>
			</div>

			<div class=td2>
				<a href="member_delete.jsp?id=<%=rs.getString("id") %>">삭제</a>
			</div>
		</div>
		<%} %>
	</div>
</html>
<%
	if(rs!=null){
		rs.close();
	}
	if(pstmt!=null){
		pstmt.close();
	}
	if(conn!=null){
		conn.close();
	}
%>
