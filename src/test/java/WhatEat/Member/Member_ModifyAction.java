package WhatEat.Member;

import java.io.PrintWriter;
import java.util.ArrayList;
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

@Member_Path()
public class Member_ModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		boolean result = false;
		String INFO_PHONENUM = (request.getParameter("INFO_PHONENUM1") + "-"
				+ request.getParameter("INFO_PHONENUM2") + "-" + request.getParameter("INFO_PHONENUM3"));
		Map<String, String[]> map = request.getParameterMap();
		Map<String, Object> cols = new HashMap<String, Object>();
		String cond = ReadXml.getKeys("User_Condition2");
		String cond2 = cond.substring(cond.indexOf("_") + 1);
		for (String key : map.keySet()) {
			if (!key.contains(cond2))
				cols.put(key, map.get(key)[0]);
		}
		cols.put(cond, INFO_PHONENUM);
		String table = ReadXml.getKeys("usedTable11");
		String path = "";
		if (((USER) session.getAttribute("user")).getINFO_POSITION().equals(ReadXml.getKeys("position_member"))) {
			path = request.getContextPath() + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_MemberPath2") + "Detail.jsp";
		} else if (((USER) session.getAttribute("user")).getINFO_POSITION()
				.equals(ReadXml.getKeys("position_seller"))) {
			path = request.getContextPath() + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_SellerPath2") + "Detail.jsp";
		} else if (((USER) session.getAttribute("user")).getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) {
			path = "./Admin_DetailAction.co?anum="+cols.get("INFO_INDEX")+"";
			cols = ModRight(ReadXml.getKeys("usedTable11"), cols);
		}

		result = Main_DAO.getDAO().ModifyCommand(cols, table,ReadXml.getKeys("User_Condition1"));
		PrintWriter out = response.getWriter();
		response.setContentType("text/html;charset=utf-8");
		try {
			if (result == false) {
				out.println("<script>");
				out.println("alert('정보 수정 실패');");
				out.println("location.href='" + path + "';");
				out.println("</script>");
				out.close();
				return null;
			}
			Main_DAO.getDAO().getInfo(((USER) session.getAttribute("user")).getINFO_ID(), session);
			out.println("<script>");
			out.println("alert('성공적으로 수정하였습니다');");
			out.println("location.href='" + path + "';");
			out.println("</script>");
			out.close();
			return null;
		} catch (Exception e) {
			System.out.println("Member_ModifyAction err : "+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	private Map<String, Object> ModRight(String table, Map<String, Object> map) {
		String cond = ReadXml.getKeys("MS_Condition9");
		String ke = "";
		ArrayList<String> cols = Main_DAO.getDAO().getColumns(table);
		for (String col : cols) {
			if (col.contains(cond)) {
				for (String key : map.keySet()) {
					if (key.contains(cond)) {
						// System.out.println("col : " + col + " @@ key : " +
						// key);
						if (col.equals(key)) {
							ke = key;
							break;
						}
					}
				}
				if (!col.equals(ke)) {
					// System.out.println("false col " + col);
					map.put(col, "FALSE");
				} else {
					// System.out.println("true col " + col);
					map.put(col, "TRUE");
				}
			}
		}
		return map;
	}
}