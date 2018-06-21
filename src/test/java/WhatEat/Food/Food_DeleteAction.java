package WhatEat.Food;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Food_Path()
public class Food_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		String table = ReadXml.getKeys("usedTable4");
		int dnum = request.getParameter("dnum") != null ? Integer.parseInt(request.getParameter("dnum")) : -1;
		if (user != null) {
			if (dnum < 0) {
				out.println("<script>");
				out.println("alert('음식 정보에 삭제에 문제가 생겼습니다');");
				out.println("location.href='javascript:history.go(-1)';");
				out.println("</script>");
				out.close();
			} else if ((user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))||user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) && (dnum > 0) && user.getINFO_MODSTORE_RG().equals("TRUE")) {
				Main_DAO.getDAO().DeleteCommand(table, dnum,ReadXml.getKeys("Food_Condition1"));
			}
			return null;
		} else {
			out.println("<script>");
			out.println("alert('삭제 권한이 없습니다');");
			out.println("</script>");
			out.close();
			return null;
		}
	}
}