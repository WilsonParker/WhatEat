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
public class Board_ListAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Main_DAO dao = Main_DAO.getDAO();
		List<?> list = new ArrayList();
		String mk = request.getParameter("mk")!=null?  request.getParameter("mk") : "false";
		int kind = request.getParameter("kind")!=null?  Integer.parseInt(request.getParameter("kind")) : (int)session.getAttribute("kind");
		session.setAttribute("kind",kind);
		int limit = Integer.parseInt(ReadXml.getKeys("limit"));
		if (request.getParameter("limit") == null && session.getAttribute("limit") != null)
			limit = ((Integer) session.getAttribute("limit")).intValue();
		else if (request.getParameter("limit") != null)
			limit = Integer.parseInt(request.getParameter("limit"));
		session.setAttribute("limit", limit);
		int bNum = Integer.parseInt(ReadXml.getKeys("bNum"));
		int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : (int)session.getAttribute("page");
		session.setAttribute("page", page); // 현재 페이지수
		//System.out.println("page : "+page);
		int startrow = (page - 1) * limit; // 읽기 시작할 row 번호
		String seq = request.getParameter("seq")!=null?  request.getParameter("seq") : "desc";
		String sort = request.getParameter("sort")!=null?  request.getParameter("sort") : ReadXml.getKeys("Board_Condition2");
		String table = ReadXml.getKeys("usedTable5");
		String condition = ReadXml.getKeys("Board_Condition1");
		HashMap<String,Object> whe = new HashMap<String, Object>();
		whe.put(condition, kind);
		HashMap<String,Object> ord = new HashMap<String, Object>();
		ord.put(sort, seq);
		int listcount = dao.ListCountCommand(table,whe); // 총 리스트수를 받아옴
		list = dao.ListCommand(ReadXml.getKeys("Bean5"),whe,ord, startrow,limit); // 리스트를 받아옴

		//int maxpage = (int) Math.round((listcount/limit+0.95)); // 총 페이지 수 ** 이걸로 하면 한 페이지에 게시물이 다나와도 텅비어있는 다음페이지가 생성된다   
		int maxpage = (int) ((Math.round((((double)listcount/limit * 100)+94)*0.1) )*0.1);
		int startpage = (int) ((double) (page - 1) / bNum) * bNum + 1;
		int endpage = (startpage + bNum - 1) > maxpage ? maxpage : startpage + bNum - 1;
		// [이전] startpage ~~ endpage [다음]
		
		request.setAttribute("maxpage", maxpage); // 최대 페이지수
		request.setAttribute("startpage", startpage); // 현재 페이지에 표시할 첫 페이지수
		request.setAttribute("endpage", endpage); // 현재 페이지에 표시할 끝 페이지수
		request.setAttribute("listcount", listcount); // 글 수
		request.setAttribute("list", list); // 출력할 게시글
		//request.setAttribute("limit", limit); // 게시글 출력하는 갯수
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("./"+ReadXml.getKeys("View_ServicePath")+ReadXml.getKeys("View_BoardPath2") + "List.jsp");
		if(kind == 5)
			forward.setPath("."+ReadXml.getKeys("View_BoardPath") + "List.jsp");
		if(mk.equals("true"))
			forward.setPath("."+ReadXml.getKeys("View_BoardPath2") + "Table.jsp");
		return forward;
	}
}