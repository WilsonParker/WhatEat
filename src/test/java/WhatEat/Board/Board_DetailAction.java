package WhatEat.Board;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Utils.ReadXml;

@Board_Path()
public class Board_DetailAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Main_DAO dao = Main_DAO.getDAO();
		int num = request.getParameter("bnum")!=null?Integer.parseInt(request.getParameter("bnum")): (int)session.getAttribute("bnum");
		session.setAttribute("bnum", num);
		String table = ReadXml.getKeys("usedTable5");
		dao.CountUpdateCommand(table,ReadXml.getKeys("Board_Condition5"),ReadXml.getKeys("Board_Condition3"),1,num);
		BOARD_Bean obj = new BOARD_Bean();
		obj = (BOARD_Bean) dao.DetailCommand(obj, num);

		if (obj == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('상세보기 실패');");
			out.println("location.href='javascript:history.go(-1)';");
			out.println("</script>");
			out.close();
			return null;
		}
		request.setAttribute("bean", obj);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(ReadXml.getKeys("View_BoardPath") + "Detail.jsp");
		return forward;
	}
}