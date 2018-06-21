package WhatEat.Seller;

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

@Seller_Path()
public class Seller_Store_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Main_DAO dao = Main_DAO.getDAO();
		List<?> list = new ArrayList();
		String mk = request.getParameter("mk") != null ? request.getParameter("mk") : "false";
		USER user = session.getAttribute("user") != null ? (USER) session.getAttribute("user") : null;
		if(user == null || ((!user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin")))&&(!user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))))){
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('권한이 없습니다');");
			out.println("location.href='javascript:history.go(-1)';");
			out.println("</script>");
			out.close();
			return null;
		}
		int page = Integer.parseInt(ReadXml.getKeys("limit2"));
		if(request.getParameter("spage") != null){
			page = Integer.parseInt(request.getParameter("spage"));
		}else if(session.getAttribute("spage") != null){
			page = (int) session.getAttribute("spage");
		}
		String seq = request.getParameter("seq") != null ? request.getParameter("seq") : "desc";
		String sort = request.getParameter("sort") != null ? request.getParameter("sort") : ReadXml.getKeys("Store_Condition2");
		String table = ReadXml.getKeys("usedTable2");
		String condition = ReadXml.getKeys("Store_Condition1"); // kind
		HashMap<String,Object> whe = new HashMap<String, Object>();
		whe.put(condition, user.getINFO_INDEX());
		HashMap<String,Object> ord = new HashMap<String, Object>();
		ord.put(sort, seq);
		int listcount = 0;
		if(user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))){
			list = dao.ListCommand(ReadXml.getKeys("Bean2"), null, ord, 0, page); // 리스트를 받아옴
			listcount = dao.ListCountCommand(table, null); // 총 리스트수를 받아옴
		}else{
			list = dao.ListCommand(ReadXml.getKeys("Bean2"), whe, ord, 0, page); // 리스트를 받아옴
			listcount = dao.ListCountCommand(table, whe); // 총 리스트수를 받아옴
		}
		session.setAttribute("spage", page); // 현재 페이지수
		request.setAttribute("listcount", listcount); // 글 수
		request.setAttribute("list", list); // 출력할 게시글
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("." + ReadXml.getKeys("View_MyPagePath") + ReadXml.getKeys("View_SellerPath2") + "Store_List.jsp");
		if (mk.equals("true"))
			forward.setPath("." + ReadXml.getKeys("View_StorePath2") + "Table2.jsp");
		return forward;
	}
}