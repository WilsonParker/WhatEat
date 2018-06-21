package WhatEat.Admin;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_Grade_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		PrintWriter out = response.getWriter();
		if (user != null) {
		if (user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
		int dgrade = Integer.parseInt(request.getParameter("dGrade"));
		boolean result = false;
		String table = ReadXml.getKeys("usedTable7");
		List<Object> list = new ArrayList<Object>();
		result = Main_DAO.getDAO().DeleteCommand(table, dgrade,ReadXml.getKeys("Grade_Condition1"));
		list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean7"), null, null, 0, 0);
		session.setAttribute("glist", list);
		response.setContentType("application/json");
		response.getWriter().write(new Gson().toJson(result));
			}
		}else{
			out.println("<script>");
			out.println("alert('권한이 제한 되었습니다');");
			out.println("location.href='./Home/View_Main.jsp';");
			out.println("</script>");
			out.close();
		}
		return null;
	}
}