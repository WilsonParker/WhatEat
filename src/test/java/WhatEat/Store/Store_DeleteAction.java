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
public class Store_DeleteAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String table = ReadXml.getKeys("usedTable2");
		USER user = (USER) session.getAttribute("user");
		int dnum = request.getParameter("dnum") != null ? Integer.parseInt(request.getParameter("dnum")) : -1;
		String condition = ReadXml.getKeys("Store_Condition2");
		if ((user.getINFO_POSITION().equals(ReadXml.getKeys("position_admin"))) && (dnum > 0)) {
			Main_DAO.getDAO().DeleteCommand(table, dnum,condition);
			out.println("<script>");
			out.println("alert('정상적으로 삭제 되었습니다');");
			out.println("location.href='" + request.getContextPath() + "/Seller_Store_ListAction.co" + "';");
			out.println("</script>");
			out.close();
			return null;
		} else if(user.getINFO_POSITION().equals(ReadXml.getKeys("position_seller"))&&user.getINFO_DELSTORE_RG().equals("TRUE")){
			Main_DAO.getDAO().DeleteCommand(table, dnum,condition);
			out.println("<script>");
			out.println("alert('정상적으로 삭제 되었습니다');");
			out.println("location.href='" + request.getContextPath() + "/Seller_Store_ListAction.co" + "';");
			out.println("</script>");
			out.close();
			return null;
		} else {
			out.println("<script>");
			out.println("alert('삭제 권한이 없습니다');");
			out.println("location.href='" + request.getContextPath() + "/Home/View_Main.jsp" + "';");
			out.println("</script>");
			out.close();
			return null;
		}
	}
}