package WhatEat.Store;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import WhatEat.Data_source.Action;
import WhatEat.Data_source.ActionForward;
import WhatEat.Data_source.Main_DAO;
import WhatEat.Data_source.USER;
import WhatEat.Utils.ReadXml;

@Store_Path()
public class Store_DetailAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		USER user = session.getAttribute("user")!=null?(USER) session.getAttribute("user"):null;
		Main_DAO dao = Main_DAO.getDAO();
		int num = -1;
		if(request.getParameter("snum")!=null)
			num = Integer.parseInt(request.getParameter("snum"));
		else if(session.getAttribute("snum")!=null)
			num = (int) session.getAttribute("snum");
		session.setAttribute("snum", num);
		String table = ReadXml.getKeys("usedTable2");
		dao.CountUpdateCommand(table,ReadXml.getKeys("Store_Condition4"),ReadXml.getKeys("Store_Condition2"),1,num);
		STORE_Bean obj = (STORE_Bean) dao.DetailCommand(new STORE_Bean(), num);

		if (obj == null) {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('상세보기 실패');");
			out.println("location.href='javascript:history.go(-1)';");
			out.println("</script>");
			out.close();
			return null;
		}
		request.setAttribute("bean", obj);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("."+ReadXml.getKeys("View_CategoryPath")+ReadXml.getKeys("View_StorePath2")+"Detail.jsp");
		if(user!=null){
			if (user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))||user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))){
				forward.setPath("."+ReadXml.getKeys("View_MyPagePath")+ReadXml.getKeys("View_SellerPath2")+"Store_Detail.jsp");
			}
		}
		return forward;
	}
}