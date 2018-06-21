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
public class Board_SubComments_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		Main_DAO dao = Main_DAO.getDAO();
		List<?> list = new ArrayList();
		HttpSession session = request.getSession();
		int comments_page2 = Integer.parseInt(ReadXml.getKeys("limit2"));
		comments_page2 = session.getAttribute("comments_page2") != null?(int)session.getAttribute("comments_page2") : comments_page2;
		comments_page2 = request.getParameter("comments_page2") != null?Integer.parseInt(request.getParameter("comments_page2")) : comments_page2;
		int subnum = -1;
		subnum = session.getAttribute("Sub_Num") != null?(int)session.getAttribute("Sub_Num") : subnum;
		subnum = request.getParameter("Sub_Num") != null?Integer.parseInt(request.getParameter("Sub_Num")) : subnum;
		session.setAttribute("Sub_Num", subnum);
		String table = ReadXml.getKeys("usedTable6");
		HashMap<String,Object> whe = new HashMap<String, Object>();
		whe.put(ReadXml.getKeys("Comments_Condition5"),subnum);
		int listcount = dao.ListCountCommand(table,whe); // 총 리스트수를 받아옴
		list = dao.ListCommand(ReadXml.getKeys("Bean6"),whe,null, 0,comments_page2); // 리스트를 받아옴
		String tag = request.getParameter("tag_id");
		request.setAttribute("comments_listcount2", listcount); 
		request.setAttribute("comments_list2", list); 
		request.setAttribute("comments_page2", comments_page2); 
		request.setAttribute("tag_id", tag ); 
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_BoardPath2") + "Comments_Table2.jsp");
		if(request.getParameter("path") != null){
			if(request.getParameter("path").equals("store")){
				forward.setPath("."+ReadXml.getKeys("View_StorePath2") + "Comments_Table2.jsp");
			}
		}
		return forward;
	}
}