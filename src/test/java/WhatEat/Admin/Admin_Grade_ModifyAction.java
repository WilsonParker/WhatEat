package WhatEat.Admin;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_Grade_ModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		boolean result = false;
		HttpSession session = request.getSession();
		USER user = (USER) session.getAttribute("user");
		String path = "./Admin_Grade_ListAction.co?cond=adList&re=true";
		String table = ReadXml.getKeys("usedTable7");
		Map<String, String[]> map = request.getParameterMap();
		Map<String, Object> cols = new HashMap<String, Object>();
		for (String key : map.keySet()) {
			cols.put(key, map.get(key)[0]);
		}
		out.println("<script>");
		if (user != null) {
			if (user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
				result = Main_DAO.getDAO().ModifyCommand(cols, table, ReadXml.getKeys("Grade_Condition1"));
				if (result == false) {
					out.println("alert('Modification failure');");
				} else {
					out.println("alert('성공적으로 수정 하였습니다');");
				}
			} else {
				out.println("alert('권한이 제한 되었습니다');");
			}
		} else {
			out.println("alert('권한이 제한 되었습니다');");
		}
		out.println("location.href='" + path + "';");
		out.println("</script>");
		out.close();
		return null;
	}
}