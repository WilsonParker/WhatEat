package WhatEat.Data_source;

import java.io.PrintWriter;

public class Mover {
	public static void isErr(PrintWriter out){
		out.println("<script>");
		out.println("alert('페이지에 문제가 발생하여서 메인페이지로 이동 합니다.');");
		out.println("location.href='./Home/View_Main.jsp';");
		out.println("</script>");
	}
}
