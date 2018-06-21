package WhatEat.Member;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;

@Member_Path()
public class Member_LogoutAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		session.removeAttribute("user");
		if (session.getAttribute("user") == null) {
			out.println("<script>");
			out.println("alert('다음에 또 방문 해주세요');");
			out.println("location.href='" + request.getContextPath() + "/WhatEat/Home/View_Main.jsp" + "';");
			out.println("</script>");
			out.close();
			return null;
		}
		// Login success
		forward.setRedirect(true);
		forward.setPath(request.getContextPath() + "/Home/View_Main.jsp");
		return forward;
	}
}