package WhatEat.Food;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Utils.ReadXml;

@Food_Path()
public class Food_Category_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		List<?> list = new ArrayList();
		String condition = request.getParameter("cond") != null? request.getParameter("cond"):"";
		String re = request.getParameter("re") != null? request.getParameter("re"):"false";
		if(session.getAttribute("clist") ==  null){
			list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean1"), null, null, 0, 0);
			session.setAttribute("clist", list);
		}
		if(re.equals("true")){
			list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean1"), null, null, 0, 0);
			session.setAttribute("clist", list);
		}
		int isSelect = request.getParameter("isSelect") != null? Integer.parseInt(request.getParameter("isSelect")) : -1 ;
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(ReadXml.getKeys("View_MainPath")+"Category.jsp");
		if(isSelect > 0){
			list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean1"), null, null, 1, 0);
			forward.setPath(ReadXml.getKeys("View_FoodPath2")+"Table2.jsp");
		}
		if(condition.equals("adList")){ 
			forward.setPath(ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_AdminPath2")+"Category.jsp");
		}
		return forward;
		
		/*
		 * 
		 * forward.setPath("../"+ReadXml.getKeys("View_MainPath")+"Category.jsp");
		if(isSelect > 0){
			list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean1"), null, null, 1, 0);
			forward.setPath("."+ReadXml.getKeys("View_FoodPath2")+"Table2.jsp");
		}
		if(condition.equals("adList")){ 
			forward.setPath(ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_AdminPath2")+"Category.jsp");
		}
		return forward;
		*/
	}
}
