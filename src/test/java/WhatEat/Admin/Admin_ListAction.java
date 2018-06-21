package WhatEat.Admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Utils.ReadXml;

@Admin_Path()
public class Admin_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Main_DAO dao = Main_DAO.getDAO();
		List<?> list = new ArrayList();
		String mk = request.getParameter("mk")!=null?  request.getParameter("mk") : "false";
		int limit = Integer.parseInt(ReadXml.getKeys("limit"));
		if (request.getParameter("limit") == null && session.getAttribute("limit") != null)
			limit = ((Integer) session.getAttribute("limit")).intValue();
		else if (request.getParameter("limit") != null)
			limit = Integer.parseInt(request.getParameter("limit"));
		session.setAttribute("limit", limit);
		int bNum = Integer.parseInt(ReadXml.getKeys("bNum"));
		int page = 1;
		if(request.getParameter("apage") != null ){
			page = Integer.parseInt(request.getParameter("apage"));
		}else if(session.getAttribute("apage") != null){
			page = (int) session.getAttribute("apage");
		}
		session.setAttribute("apage", page);
		int startrow = (page - 1) * limit; 
		String seq = request.getParameter("seq")!=null?  request.getParameter("seq") : "desc";
		String sort = request.getParameter("sort")!=null?  request.getParameter("sort") : ReadXml.getKeys("User_Condition1");
		String sort2 = request.getParameter("sort2")!=null?  request.getParameter("sort2") : "null";
		String seq2 = request.getParameter("seq2")!=null?  request.getParameter("seq2") : "desc";
		String table = ReadXml.getKeys("usedTable11");
		HashMap<String,Object> ord = new HashMap<String, Object>();
		ord.put(sort, seq);
		ord.put(sort2, seq2);
		int listcount = dao.ListCountCommand(table,null);
		list = dao.ListCommand(ReadXml.getKeys("Bean12"),null,ord, startrow,limit);

		int maxpage = (int) ((Math.round((((double)listcount/limit * 100)+94)*0.1) )*0.1);
		int startpage = (int) ((double) (page - 1) / bNum) * bNum + 1;
		int endpage = (startpage + bNum - 1) > maxpage ? maxpage : startpage + bNum - 1;
		
		request.setAttribute("maxpage", maxpage); 
		request.setAttribute("startpage", startpage);
		request.setAttribute("endpage", endpage);
		request.setAttribute("listcount", listcount);
		request.setAttribute("list", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_AdminPath2") + "List.jsp");
		if(mk.equals("true"))
			forward.setPath("."+ReadXml.getKeys("View_AdminPath2") + "Table.jsp");
		return forward;
	}
}