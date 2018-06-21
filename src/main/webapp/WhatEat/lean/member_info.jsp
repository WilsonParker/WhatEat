<%@page language="java" contentType="text/html" pageEncoding="euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>

<%
	String id = null;

	if((session.getAttribute("id")==null)||(!((String)session.getAttribute("id")).equals("admin"))){
		response.sendRedirect("loginForm.jsp");
	}
	
	String info_id=request.getParameter("id");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/siwon");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement("select * from member where id=?");
		pstmt.setString(1,info_id);
		rs=pstmt.executeQuery();
		rs.next();

	}catch(Exception e){
		e.printStackTrace();

	}
%>
<html>
<head>
<title>ȸ�� ���� �ý��� �����ڸ��(ȸ�� ���� ����)</title>
<style>
	div {text-align:center; margin: 0 auto; box-sizing:border-box;}
	.wrap {max-width:500px;}
	.tr {border:1px solid #000000; overflow:hidden; margin:2px 0;}
	.td {float:left; width:50%;}
</style>
</head>

<div class="wrap">
	<div class="tr">
		<div class="td">���̵�</div>
		<div class="td"><%=rs.getString("id")%></div>
	</div>
	<div class="tr">
		<div class="td">��й�ȣ</div>
		<div class="td"><%=rs.getString("password")%></div>
	</div>
	<div class="tr">
		<div class="td">�̸�</div>
		<div class="td"><%=rs.getString("name")%></div>
	</div>
	<div class="tr">
		<div class="td">����</div>
		<div class=td><%=rs.getInt("age")%></div>
	</div>
	<div class="tr">
		<div class="td">����</div>
		<div class="td"><%=rs.getString("gender")%></div>
	</div>
	<div class="tr">
		<div class="td">�̸����ּ�</div>
		<div class="td"><%=rs.getString("email")%></div>
	</div>
	<div class="tr">
		<div><a href="member_list.jsp">����Ʈ�� ���ư���</a></div>
	</div>
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