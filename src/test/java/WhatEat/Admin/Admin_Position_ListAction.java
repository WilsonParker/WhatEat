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
public class Admin_Position_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		List<?> list = new ArrayList();
		String re = request.getParameter("re") != null? request.getParameter("re"):"false";
		
		if(session.getAttribute("plist") ==  null || re.equals("true")){
			list = Main_DAO.getDAO().ListCommand(ReadXml.getKeys("Bean13"), null, null, 0, 0);
			HashMap<Object,Object> pmap = new HashMap<Object,Object>();
			for(Object ob : list){
				INFO_POSITION_Bean bean = (INFO_POSITION_Bean) ob;
				pmap.put(bean.getINFO_POSITION_CODE(),bean.getINFO_POSITION_NAME());
			}
			session.setAttribute("plist", list);
			session.setAttribute("pmap", pmap);
		}
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_AdminPath2")+"Table2.jsp");
		/*String cond = request.getParameter("cond") != null? request.getParameter("cond"):"";
		if(cond.equals("adList"))
			forward.setPath("."+ReadXml.getKeys("View_AdminPath2")+"Position_List.jsp");*/
		return forward;
	}
}
