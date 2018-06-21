package WhatEat.Board;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Board_Path()
public class Board_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		PrintWriter out = response.getWriter();;
		int index = Integer.parseInt(request.getParameter("index"));
		if ((user.getINFO_INDEX() == index && user.getINFO_DELBOARD_RG().equals("TRUE")) || user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
			boolean result = false;
			int num = Integer.parseInt(request.getParameter("num"));
				String table = ReadXml.getKeys("usedTable5");
				result = Main_DAO.getDAO().DeleteCommand(table, num,ReadXml.getKeys("Board_Condition3"));
				if (result == false) {
					out.println("<script>");
					out.println("alert('Fail to delete to the bulliten');");
					out.println("location.href='./Board_ListAction.co';");
					out.println("</script>");
					out.close();
					return null;
				}
		} else {
			out.println("<script>");
			out.println("alert('권한이 제한 되었습니다');");
			out.println("location.href='./Board_ListAction.co';");
			out.println("</script>");
			out.close();
			return null;
		}
		forward.setRedirect(false);
		forward.setPath("./Board_ListAction.co");
		return forward;
	}}