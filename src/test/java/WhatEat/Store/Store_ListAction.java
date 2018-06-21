package WhatEat.Store;

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
import WhatEat.Utils.ReadXml;

@Store_Path()
public class Store_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession();
		Main_DAO dao = Main_DAO.getDAO();
		List<?> list = new ArrayList();
		ActionForward forward = new ActionForward();
		
		PrintWriter out = null;
		try{
		request.setCharacterEncoding("utf-8");
		out = response.getWriter();
		String mk = request.getParameter("mk") != null ? request.getParameter("mk") : "false";
		int cls = 1;
		if( session.getAttribute("cls") != null)
			cls = (int) session.getAttribute("cls");
		cls = request.getParameter("cls") != null ? Integer.parseInt(request.getParameter("cls")) : cls;
		session.setAttribute("cls", cls);
		int page = Integer.parseInt(ReadXml.getKeys("limit2"));
		if(session.getAttribute("spage") != null)
			page = (int)session.getAttribute("spage");
		page = request.getParameter("spage") != null ? Integer.parseInt(request.getParameter("spage")) : page ;
		session.setAttribute("spage", page); // 현재 페이지수
		String seq = request.getParameter("seq") != null ? request.getParameter("seq") : "desc";
		String sort = request.getParameter("sort") != null ? request.getParameter("sort") : ReadXml.getKeys("Store_Condition2");
		String table = ReadXml.getKeys("usedTable2");
		String condition = ReadXml.getKeys("Store_Condition3");	// kind
		int listcount =0; 
		boolean exist = false;
		HashMap<String,Object> whe = new HashMap<String, Object>();
		if(!(session.getAttribute("LOCATION1")==null || ((String) session.getAttribute("LOCATION1")).trim().equals(""))){
			whe.put(ReadXml.getKeys("Store_Condition7"), (String) session.getAttribute("LOCATION1"));
			exist = true;
		}
		else
			session.removeAttribute("LOCATION1");
		if(!(session.getAttribute("LOCATION2")==null || ((String) session.getAttribute("LOCATION2")).trim().equals(""))){
			whe.put(ReadXml.getKeys("Store_Condition8"), (String) session.getAttribute("LOCATION2"));
			exist = true;
		}
		else
			session.removeAttribute("LOCATION2");
		if(!(session.getAttribute("LOCATION3")==null || ((String)session.getAttribute("LOCATION3")).trim().equals(""))){
			whe.put(ReadXml.getKeys("Store_Condition9"), (String) session.getAttribute("LOCATION3"));
			exist = true;
		}
		else
			session.removeAttribute("LOCATION3");
		HashMap<String,Object> ord = new HashMap<String, Object>();
		ord.put(sort, seq);
		
		if(cls == 1){
			if(exist){
				list = dao.ListCommand(ReadXml.getKeys("Bean2"), whe, ord, 0, page); // 리스트를  받아옴
				listcount = dao.ListCountCommand(table,whe); // 총 리스트수를 받아옴
			}
			else{
				list = dao.ListCommand(ReadXml.getKeys("Bean2"), null, ord, 0, page); // 리스트를  받아옴
				listcount = dao.ListCountCommand(table,null); // 총 리스트수를 받아옴
			}
		}else{
			whe.put(condition, cls);
			list = dao.ListCommand(ReadXml.getKeys("Bean2"), whe, ord, 0, page); // 리스트를  받아옴
			listcount = dao.ListCountCommand(table,whe); // 총 리스트수를 받아옴
		}
		
		request.setAttribute("listcount", listcount); // 글 수
		request.setAttribute("list", list); // 출력할 게시글
		forward.setRedirect(false);
		forward.setPath("." + ReadXml.getKeys("View_CategoryPath") + ReadXml.getKeys("View_StorePath2") + "List.jsp");
		if (mk.equals("true"))
			forward.setPath("." + ReadXml.getKeys("View_StorePath2") + "Table.jsp");
		}catch(Exception e){
			System.out.println("Store_ListAction err : " + e.getMessage());
			e.printStackTrace();
			out.println("<script>");
			out.println("alert('"+e.getMessage()+"');");
			out.println("location.href='history.go(-1)';");
			out.println("</script>");
			out.close();
		}
		return forward;
	}
}