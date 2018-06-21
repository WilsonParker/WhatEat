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
public class Admin_Grade_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		List<?> list = new ArrayList();
		String re = request.getParameter("re") != null? request.getParameter("re"):"false";
		
		if(session.getAttribute("glist") ==  null || re.equals("true")){
			list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean7"), null, null, 0, 0);
			HashMap<Object,Object> gmap = new HashMap<Object,Object>();
			for(Object ob : list){
				GRADE_Bean bean  = (GRADE_Bean) ob;
				gmap.put(bean.getGRADE_NUM(),bean.getGRADE_VAL());
			}
			session.setAttribute("glist", list);
			session.setAttribute("gmap", gmap);
		}
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_AdminPath2")+"Table3.jsp");
		String cond = request.getParameter("cond") != null? request.getParameter("cond"):"";
		if(cond.equals("adList"))
			forward.setPath(ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_AdminPath2")+"Grade_List.jsp");
		return forward;
	}
}
