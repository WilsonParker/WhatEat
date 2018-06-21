package WhatEat.Admin;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Seller.SELLER_Bean;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_DetailAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		int num = request.getParameter("anum")!=null?Integer.parseInt(request.getParameter("anum")):((USER)session.getAttribute("user")).getINFO_INDEX();
		USER user  = (USER) Main_DAO.getDAO().DetailCommand(new SELLER_Bean(), num);
		if (user == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('상세보기 실패');");
			out.println("location.href='javascript:history.go(-1)';");
			out.println("</script>");
			out.close();
			return null;
		}
		request.setAttribute("user", user);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_AdminPath2")+"Detail.jsp");
		return forward;
	}
}