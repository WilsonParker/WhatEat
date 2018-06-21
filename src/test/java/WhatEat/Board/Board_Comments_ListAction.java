package WhatEat.Board;

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

@Board_Path()
public class Board_Comments_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		Main_DAO dao = Main_DAO.getDAO();
		List<?> list = new ArrayList();
		HttpSession session = request.getSession();
		int kind = request.getParameter("ComNum") != null?Integer.parseInt(request.getParameter("ComNum")): (int)session.getAttribute("ComNum");
		String kind_cond = request.getParameter("ComKind") != null?request.getParameter("ComKind") : "board";
		session.setAttribute("ComNum", kind);
		String comments_seq = request.getParameter("comments_seq")!=null?  request.getParameter("comments_seq") : "desc";
		String comments_sort = request.getParameter("comments_sort")!=null?  request.getParameter("comments_sort") : ReadXml.getKeys("Comments_Condition3");
		int comments_page = request.getParameter("comments_page")!=null?  Integer.parseInt(request.getParameter("comments_page")) : Integer.parseInt(ReadXml.getKeys("limit2"));
		String table = ReadXml.getKeys("usedTable6");
		HashMap<String,Object> whe = new HashMap<String, Object>();
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		if(kind_cond.equals("board")){
			forward.setPath("."+ReadXml.getKeys("View_BoardPath2") + "Comments_Table.jsp");
			whe.put(ReadXml.getKeys("Comments_Condition1"), kind);
		}
		else if(kind_cond.equals("store")){
			forward.setPath("."+ReadXml.getKeys("View_StorePath2") + "Comments_Table.jsp");
			whe.put(ReadXml.getKeys("Comments_Condition2"), kind);
		}
		HashMap<String,Object> ord = new HashMap<String, Object>();
		ord.put(comments_sort, comments_seq);
		int listcount = dao.ListCountCommand(table,whe); // 총 리스트수를 받아옴
		list = dao.ListCommand(ReadXml.getKeys("Bean6"),whe,ord, 0,comments_page); // 리스트를 받아옴

		request.setAttribute("comments_listcount", listcount); 
		request.setAttribute("comments_list", list); 
		request.setAttribute("comments_page", comments_page ); 
		return forward;
	}
}