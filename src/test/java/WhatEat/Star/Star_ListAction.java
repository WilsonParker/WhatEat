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
public class Star_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Main_DAO dao = Main_DAO.getDAO();
		List<Object> list = new ArrayList<Object>();
		String mk = request.getParameter("mk") != null ? request.getParameter("mk") : "false";
		USER user = session.getAttribute("user") != null ? (USER) session.getAttribute("user") : null;
		if (user == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인이 필요한 서비스 입니다');");
			out.println(
					"location.href='" + request.getContextPath() + ReadXml.getKeys("View_MemberPath") + "Login.jsp';");
			out.println("</script>");
			out.close();
			return null;
		} else {
			int page = Integer.parseInt(ReadXml.getKeys("limit2"));
			if (session.getAttribute("stpage") != null) {
				page = (int) session.getAttribute("stpage");
			}
			if (request.getParameter("stpage") != null) {
				page = Integer.parseInt(request.getParameter("stpage"));
			}
			String condition = ReadXml.getKeys("Star_Condition1");
			HashMap<String, Object> whe = new HashMap<String, Object>();
			whe.put(condition, user.getINFO_INDEX());
			list = dao.ListCommand(ReadXml.getKeys("Bean10"), whe, null, 0, 0);
			String sort = request.getParameter("sort") != null ? request.getParameter("sort")
					: ReadXml.getKeys("Store_Condition2");
			String seq = request.getParameter("seq") != null ? request.getParameter("seq") : "desc";
			int listcount = 0;
			HashMap<String, Object> ord = new HashMap<String, Object>();
			ord.put(sort, seq);
			HashMap<String, Object> whe2 = new HashMap<String, Object>();
			whe2.put("Operator", "in");
			whe2.put("Condition", ReadXml.getKeys("Store_Condition2"));
			if (list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					whe2.put("" + i, ((STAR_Bean) list.get(i)).getSTAR_STORE_NUM());
				}
				list = dao.ListCommand(ReadXml.getKeys("Bean2"), whe2, ord, 0, page);
				listcount = dao.ListCountCommand(ReadXml.getKeys("usedTable2"), whe2);
			}else{
				list = null;
				listcount = 0;
			}
			session.setAttribute("stpage", page); // 현재 페이지수
			request.setAttribute("listcount", listcount); // 글 수
			request.setAttribute("list", list); // 출력할 게시글
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("." + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_StarPath2") + "List.jsp");
			if (mk.equals("true"))
				forward.setPath("." + ReadXml.getKeys("View_StarPath2") + "Table.jsp");
			return forward;
		}
	}
}