package WhatEat.Member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Member_Path()
public class Member_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String table = ReadXml.getKeys("usedTable11");
		int dnum = request.getParameter("dnum") != null ? Integer.parseInt(request.getParameter("dnum")) : -1;
		int index = -1;
		String condition = ReadXml.getKeys("User_Condition1");
		if(dnum<0)
			index = session.getAttribute("user") != null ? ((USER) session.getAttribute("user")).getINFO_INDEX() : -1;
		if (dnum<0 && index < 0) {
			out.println("<script>");
			out.println("alert('로그인 정보에 문제가 있습니다');");
			out.println("location.href='" + request.getContextPath() + "/Home/View_Main.jsp" + "';");
			out.println("</script>");
			out.close();
			return null;
		}
		if (index > 0) {
			Main_DAO.getDAO().DeleteCommand(table, index,condition);
			out.println("<script>");
			out.println("alert('정상적으로 탈퇴 되었습니다');");
			out.println("location.href='" + request.getContextPath() + "/Member_LogoutAction.co" + "';");
			out.println("</script>");
			out.close();
			return null;
		} else if ((((USER) session.getAttribute("user")).getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) && (dnum > 0)) {
			Main_DAO.getDAO().DeleteCommand(table, dnum,condition);
			out.println("<script>");
			out.println("alert('정상적으로 탈퇴 되었습니다');");
			out.println("location.href='" + request.getContextPath() + "/Admin_ListAction.co" + "';");
			out.println("</script>");
			out.close();
			return null;
		} else {
			out.println("<script>");
			out.println("alert('삭제 권한이 없습니다');");
			out.println("location.href='" + request.getContextPath() + "/Home/View_Main.jsp" + "';");
			out.println("</script>");
			out.close();
			return null;
		}
	}
}