package WhatEat.Star;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Star_Path()
public class Star_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		PrintWriter out = response.getWriter();
		int dstar = Integer.parseInt(request.getParameter("dstar"));
		boolean result = false;
		String table = ReadXml.getKeys("usedTable10");
		List<Object> list = new ArrayList<Object>();
		HashMap<String, Object> whe = new HashMap<String, Object>();
		whe.put(ReadXml.getKeys("Star_Condition1"), user.getINFO_INDEX());
		whe.put(ReadXml.getKeys("Star_Condition3"), dstar);
		list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean10"), whe, null, 0, 0);
		int num = ((STAR_Bean) list.get(0)).getSTAR_NUM();
		result = Main_DAO.getDAO().DeleteCommand(table, num,ReadXml.getKeys("Star_Condition2"));
		if (result == false) {
			out.println("<script>");
			out.println("alert('즐겨찾기를 삭제하지 못했습니다');");
			out.println("location.href='./Star_ListAction.co';");
			out.println("</script>");
			out.close();
			return null;
		}
		out.println("<script>");
		out.println("alert('성공적으로 삭제 하였습니다');");
		out.println("location.href='./Star_ListAction.co';");
		out.println("</script>");
		out.close();
		forward.setRedirect(false);
		forward.setPath("./Star_ListAction.co");
		return forward;
	}
}
